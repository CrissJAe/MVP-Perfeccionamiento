<?php

namespace UBB\Intranet;

use Exception;
use PDO;

class DatabasePDO
{
    private $username;
    private $password;
    private $options;
    private $dsn;
    private $connection;
    private $default_fetch = [];
    private $query_options = [];
    private $params = [];
    private $debugBackground;
    private $query;
    private $statement;

    public function __construct(array $settings = [])
    {
        $driver = $settings['driver'];
        $host = $settings['host'];
        $port = $settings['port'];
        $dbname = $settings['database'];
        $this->username = $settings['username'];
        $this->password = $settings['password'];
        $this->options = $settings['options'];
        $this->dsn = "$driver;Server=$host,$port;Database=$dbname;TrustServerCertificate=yes";
        $this->debugBackground = 'monokai';
        $this->default_fetch = [
            "params" => [],
            "assoc" => false, //Devuelve los resultados como un vector, devuelve solo el primer indice
            "assocClass" => false, //Devuelve los resultados como una Clase, devuelve solo el primer indice
            "fetchAll" => true, //Devuelve los agrupados, es dependiente del assoc y assocClass
            "jsonEncode" => false, // Devuelve los resultados en json_encode
            "resultEncode" => false, // Devuelve los resultados codificados en utf8_encode,utf8_decode
            "debug" => false, // Muestra la query SQL que se esta ejecutando
            "debugAll" => false, // Muestra la query SQL que se esta ejecutando y el resultado que esta trae
            "files" => false, //Permite la ejecucion en odbc temporal para recuperar archivos almacenados en la BD
            "campo_archivo" => "archivo",
            //Define el campo que sera el archivo a convertir, debe estar definido en la salida de la query o sp;
            //select campo_archivo=ca_archivo
            "campo_extension_archivo" => "extension",
            //Define la extension que tendra el archivo, debe estar definido en la salida de la query o sp;
            //select campo_extension_archivo=ca_extension
        ];

        $this->connect();
    }

    public function connect()
    {
        if (!isset($this->connection)) {
            try {
                // sqlsrv no acepta opciones en el constructor ni PDO::ATTR_PERSISTENT
                $database = new PDO("odbc:" . $this->dsn, $this->username, $this->password);
                $supported = [PDO::ATTR_ERRMODE, PDO::ATTR_DEFAULT_FETCH_MODE];
                foreach ($supported as $attr) {
                    if (isset($this->options[$attr])) {
                        $database->setAttribute($attr, $this->options[$attr]);
                    }
                }
            } catch (\PDOException $e) {
                print "<b>¡Error!: </b>" . $e->getMessage() . "<br/>";
                die();
            }
            $this->connection = $database;
        }

        return $this->connection;
    }

    public function prepare($query)
    {
        $this->statement  = $this->connection->prepare($query);
    }

    public function execute()
    {
        try {
            if (!empty($this->params)) {
                $this->statement->execute();
            } else {
                $this->statement->execute($this->query_options['params']);
            }
            $this->params = [];
        } catch (\PDOException $e) {
            $error = [
                "message" => $e->getMessage(),
                "query" => $this->query,
                "error" => $this->statement->errorInfo(),
                "query_params" => $this->statement->debugDumpParams()
            ];
            dump($error);
            die();
        }
    }

    public function bindParam($parameter, $value, $type = false)
    {
        $this->params[$parameter]['value'] = $value;
        $this->params[$parameter]['type'] = $type;

        //$this->params[$parameter] = $value;
    }

    public function bindParamStatement()
    {
        if (empty($this->params))
            return false;

        if (!isset($this->statement))
            return false;
        foreach ($this->params as $name => &$data) {
            if ($data['type']) {
                $this->statement->bindParam($name, $data['value'],  $data['type']);
            } else {
                $this->statement->bindParam($name, $data['value']);
            }
        }
    }

    public function ejecutar($query, $options = false)
    {
        $this->query         = $query;
        $this->query_options = $options;
        $this->validateArraySetting();
        $this->prepare($query);
        $this->bindParamStatement();
        $this->execute();

        if (is_array($this->query_options)) {
            if ($this->query_options['fetchAll']) {
                return $this->results($this->statement);
            } elseif ($this->query_options['debug'] or $this->query_options['debugAll']) {
                $this->debug();
            }
        }
        return $this->statement;
    }

    public function results()
    {
        $list = [];

        if (isset($this->query_options['files']) and $this->query_options['files']) {
            return $this->resultsFile($this->statement);
        }
        //Validar que el vector exista
        if (is_array($this->query_options)) {
            //Ejecucion de Query
            //Recorrer y traer resultados
            if (
                $this->query_options['fetchAll'] and
                ($this->query_options['jsonEncode'] or $this->query_options['resultEncode'])
            ) {
                if ($this->query_options['assocClass']) {
                    $list = $this->statement->fetch();
                } else {
                    $list = $this->statement->fetchAll();
                }
                $list = $this->sanitize($list);
                //Codificacion jsonEncode
                if ($this->query_options['jsonEncode']) {
                    $list = $this->convertJsonEncodeArray($list);
                }
                //Codificacion resultados
                if ($this->query_options['resultEncode']) {
                    $list = $this->returnsDetailResultEncoded($list);
                }
                if (($this->query_options['debugAll'])) {
                    $this->debug($list);
                } elseif ($this->query_options['debug']) {
                    $this->debug();
                }
                return $list;
            } elseif ($this->query_options['fetchAll'] && $this->query_options['assocClass']) {
                $list = $this->statement->fetch(PDO::FETCH_OBJ);
                $list = $this->sanitize($list);
                if (($this->query_options['debugAll'])) {
                    $this->debug($list);
                } elseif ($this->query_options['debug']) {
                    $this->debug();
                }
                return $list;
            } elseif ($this->query_options['fetchAll'] && $this->query_options['assoc']) {
                if ($this->query_options['debug']) {
                    $this->debug();
                }
                $list = $this->statement->fetch();
                return $this->sanitize($list);
            } elseif ($this->query_options['assoc']) {
                if ($this->query_options['debug']) {
                    $this->debug();
                }
                $list = $this->statement->fetch();
                return $this->sanitize($list);
            } else {
                if ($this->query_options['debug']) {
                    $this->debug();
                }
                // Para insert, delete o update
                if ($this->statement->columnCount() == 0)
                    return true;

                $list = $this->statement->fetchAll();
                return $this->sanitize($list);
            }
        } else {
            $list = $this->statement->fetchAll();
            return $this->sanitize($list);
        }
    }

    public function resultsFile($statement)
    {
        $list = [];
        if ($this->query_options['fetchAll']) {
            if ($this->query_options['assocClass']) {
                $results = $statement->fetchObject();
                foreach ($results as $lists) {
                    $object = new \stdClass();
                    // Asigno valores al objeto
                    foreach ($lists as $key => $value) {
                        $object->$key = $value;
                    }
                    // Tratamiento de archivo
                    $img = $object->{$this->query_options['campo_archivo']};
                    $tipo_archivo = $object->{$this->query_options['campo_extension_archivo']};
                    if (!empty($img)) {
                        $nombre_archivo = md5(microtime(true)) . '.' . $tipo_archivo;

                        // CORRECCIÓN: Validar si ya es binario o si es un Hexadecimal válido
                        if (str_starts_with($img, '%PDF') || !ctype_xdigit($img)) {
                            $binaryPdf = $img;
                        } else {
                            $binaryPdf = hex2bin($img);
                            if ($binaryPdf === false) {
                                throw new \RuntimeException('El campo PDF no es una cadena hexadecimal válida.');
                            }
                        }

                        $filename = PATH_ARCHIVOS_TEMPORAL . trim($nombre_archivo);
                        if (file_exists($filename)) {
                            unlink($filename);
                        }

                        // Guardar el PDF en disco en modo binario
                        file_put_contents($filename, $binaryPdf, LOCK_EX);

                        // Actualizar la ruta que se devuelve
                        $object->{$this->query_options['campo_archivo']} = PATH_DESCARGA_ARCHIVOS_TMP . $nombre_archivo;
                    }
                    array_push($list, $object);
                    unset($object);
                }
            } else {
                $results = $statement->fetchAll();
                foreach ($results as $value) {
                    // Tratamiento de archivo
                    $img = $value['' . $this->query_options['campo_archivo'] . ''];
                    $tipo_archivo = $value['' . $this->query_options['campo_extension_archivo'] . ''];
                    if (!empty($img)) {
                        $nombre_archivo = md5(microtime(true)) . '.' . $tipo_archivo;

                        // CORRECCIÓN: Validar si ya es binario o si es un Hexadecimal válido
                        if (str_starts_with($img, '%PDF') || !ctype_xdigit($img)) {
                            $binaryPdf = $img;
                        } else {
                            $binaryPdf = hex2bin($img);
                            if ($binaryPdf === false) {
                                throw new \RuntimeException('El campo PDF no es una cadena hexadecimal válida.');
                            }
                        }

                        $filename = PATH_ARCHIVOS_TEMPORAL . trim($nombre_archivo);
                        if (file_exists($filename)) {
                            unlink($filename);
                        }

                        // Guardar el PDF en disco en modo binario
                        file_put_contents($filename, $binaryPdf, LOCK_EX);

                        // Actualizar la ruta que se devuelve
                        $value[$this->query_options['campo_archivo']] = PATH_DESCARGA_ARCHIVOS_TMP . $nombre_archivo;
                    }
                    array_push($list, $value);
                    unset($img);
                }
            }
            //retorno en json
            if ($this->query_options['jsonEncode']) {
                $list = $this->convertJsonEncodeArray($list, $this->query_options);
            }
            //Debug
            if ($this->query_options['debugAll']) {
                $this->debug($list);
            } elseif ($this->query_options['debug']) {
                $this->debug();
            }

            return $list;
        } else {
            if ($this->query_options['debug']) {
                $this->debug();
            }
            if ($this->query_options['assocClass']) {
                return $statement->fetchObject();
            } else {
                return $statement->fetchAll();
            }
        }
    }
    public function validateArraySetting()
    {
        if (empty($this->query_options)) {
            $this->query_options = $this->default_fetch;
            return true;
        }

        // Valida opciones de la query ingresadas por el usuario vs las opciones definida en la clase
        foreach (array_keys($this->query_options) as $key) {
            if (!array_key_exists("$key", $this->default_fetch)) {
                unset($this->query_options[$key]);
            }
        }

        // Une opciones del usuario con las opciones de clase
        foreach (array_keys($this->default_fetch) as $key) {
            if (!array_key_exists("$key", $this->query_options)) {
                $this->query_options[$key] = $this->default_fetch[$key];
            }
        }
    }

    public function convertJsonEncodeArray($list)
    {
        return json_encode($this->returnsDetailResultEncoded($list));
    }

    public function returnsDetailResultEncoded($list)
    {
        if ($this->query_options['assocClass']) {
            $object = new \stdClass();
            foreach ($list as $key => $value) {
                $value = $this->encodeResult($value);
                $object->$key = $value;
            }
            return $object;
        } else {
            foreach ($list as $key => $value) {
                foreach ($list[$key] as $key2 => $value2) {
                    $value2 = $this->encodeResult($value2);
                    $list[$key][$key2] = $value2;
                }
            }
            return $list;
        }
    }

    public function encodeResult($value)
    {
        if ($this->query_options['resultEncode'] == 'utf8_encode') {
            $value = mb_convert_encoding($value, "UTF-8", mb_detect_encoding($value));
        } elseif ($this->query_options['resultEncode'] == 'utf8_decode') {
            $value = mb_convert_encoding($value, "ISO-8859-1", "UTF-8");
        } elseif ($this->query_options['jsonEncode']) {
            $value = mb_convert_encoding($value, "UTF-8", mb_detect_encoding($value));
        }
        return $value;
    }

    public function sanitize($value)
    {
        if (is_array($value)) {
            return array_map([$this, 'sanitize'], $value);
        }

        if ($value === null) {
            return null;
        }

        if (is_string($value)) {
            // quitar bytes nulos y caracteres de control
            $value = preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', '', $value) ?? '';
            // decodificar/recodificar entidades
            $value = htmlspecialchars_decode($value, ENT_QUOTES);
            $value = htmlspecialchars($value, ENT_QUOTES, 'UTF-8');
        }

        return $value;
    }

    public function debug($vector = false)
    {
        $fondo_texto = "font-size:16px; background-color:rgb(46, 46, 46);";
        $color_query = "color:#66D9EF;";
        $color_array = "color:#A6E22E;";
        if ($this->debugBackground == 'monokai') {
            $fondo_texto = "font-size:16px; background-color:rgb(46, 46, 46);";
            $color_query = "color:#66D9EF;";
            $color_array = "color:#A6E22E;";
        } elseif ($this->debugBackground == 'light') {
            $fondo_texto = "font-size:16px;";
            $color_query = "color:#2679b5;";
            $color_array = "color:black;";
        } elseif ($this->debugBackground == 'powershell') {
            $fondo_texto = "font-size:16px;background-color:#3C607B;";
            $color_query = "color:white;";
            $color_array = "color:yellow;";
        }
        echo "<pre class='col-xs-12'  style='" . $fondo_texto . "'>";
        echo "<strong class='pink h4'>DEBUG</strong><BR>";
        print_r("<p style='" . $color_query . "'>" . $this->query . "</p>");
        if ($vector) {
            echo "<div style='" . $color_array . "'>";
            print_r($vector);
            echo "</div>";
        }
        echo "</pre>";
    }
}
