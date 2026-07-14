<?php

namespace UBB\Intranet\Perfeccionamiento;

use UBB\Intranet\Perfeccionamiento\Folio;
use UBB\Intranet\Perfeccionamiento\Historial;
use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;

class Solicitud
{
    private $db;
    private $folio;
    private $historial;
    private $documento;

    public function __construct($db)
    {
        $this->db        = $db;
        $this->folio     = new Folio($db);
        $this->historial = new Historial($db);
        $this->documento = new SolicitudDocumento($db);
    }

    public function crear(array $datos, string $usuario): int
    {
        $idEstado = $this->obtenerIdEstado('BORRADOR');

        $query = "
            INSERT INTO SOLICITUD (
                aca_rut,
                tes_codigo,
                tpe_codigo,
                tgr_codigo,
                sol_nombre_programa,
                sol_institucion_destino,
                sol_pais,
                sol_fecha_inicio,
                sol_fecha_termino,
                sol_fecha_salida_ubb,
                sol_financiamiento_externo,
                sol_razones_patrocinio,
                sol_fecha_registro,
                sol_login_registro
            ) VALUES (
                :rut_academico,
                :id_estado,
                :id_tipo_perfeccionamiento,
                :id_tipo_grado,
                :nombre_programa,
                :institucion_destino,
                :pais,
                :fecha_inicio,
                :fecha_termino,
                :fecha_salida_ubb,
                :financiamiento_externo,
                :razones_patrocinio,
                GETDATE(),
                :usuario_creacion
            )
        ";

        $this->db->bindParam(':rut_academico',             $datos['rut_academico']);
        $this->db->bindParam(':id_estado',                 $idEstado);
        $this->db->bindParam(':id_tipo_perfeccionamiento', $datos['id_tipo_perfeccionamiento']);
        $this->db->bindParam(':id_tipo_grado',             $this->valorONulo($datos['id_tipo_grado'] ?? null));
        $this->db->bindParam(':nombre_programa',           $datos['nombre_programa']);
        $this->db->bindParam(':institucion_destino',       $datos['institucion_destino']);
        $this->db->bindParam(':pais',                      $datos['pais']);
        $this->db->bindParam(':fecha_inicio',              $this->fechaSql($datos['fecha_inicio']));
        $this->db->bindParam(':fecha_termino',             $this->fechaSql($datos['fecha_termino']));
        $this->db->bindParam(':fecha_salida_ubb',          $this->fechaSql($datos['fecha_salida_ubb'] ?? null));
        $this->db->bindParam(':financiamiento_externo',    $this->valorONulo($datos['financiamiento_externo'] ?? null));
        $this->db->bindParam(':razones_patrocinio',        $this->valorONulo($datos['razones_patrocinio'] ?? null));
        $this->db->bindParam(':usuario_creacion',          $usuario);
        $this->db->ejecutar($query);

        $idSolicitud = $this->obtenerUltimoId();

        $this->documento->inicializar($idSolicitud);

        $this->historial->registrar('S', $idSolicitud, 'BORRADOR', $usuario, 'ACADEMICO');

        return $idSolicitud;
    }

    public function actualizar(int $idSolicitud, array $datos, string $usuario): bool
    {
        $solicitud = $this->obtenerPorId($idSolicitud);

        if (!$solicitud) {
            return false;
        }

        $estadosEditables = ['BORRADOR', 'OBSERVADO'];
        if (!in_array($solicitud['codigo_estado'], $estadosEditables)) {
            return false;
        }

        $query = "
            UPDATE SOLICITUD SET
                tpe_codigo                 = :id_tipo_perfeccionamiento,
                tgr_codigo                 = :id_tipo_grado,
                sol_nombre_programa        = :nombre_programa,
                sol_institucion_destino    = :institucion_destino,
                sol_pais                   = :pais,
                sol_fecha_inicio           = :fecha_inicio,
                sol_fecha_termino          = :fecha_termino,
                sol_fecha_salida_ubb       = :fecha_salida_ubb,
                sol_financiamiento_externo = :financiamiento_externo,
                sol_razones_patrocinio     = :razones_patrocinio,
                sol_fecha_actualizacion    = GETDATE(),
                sol_login_actualizacion    = :usuario
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_tipo_perfeccionamiento', $datos['id_tipo_perfeccionamiento']);
        $this->db->bindParam(':id_tipo_grado',             $this->valorONulo($datos['id_tipo_grado'] ?? null));
        $this->db->bindParam(':nombre_programa',           $datos['nombre_programa']);
        $this->db->bindParam(':institucion_destino',       $datos['institucion_destino']);
        $this->db->bindParam(':pais',                      $datos['pais']);
        $this->db->bindParam(':fecha_inicio',              $this->fechaSql($datos['fecha_inicio']));
        $this->db->bindParam(':fecha_termino',             $this->fechaSql($datos['fecha_termino']));
        $this->db->bindParam(':fecha_salida_ubb',          $this->fechaSql($datos['fecha_salida_ubb'] ?? null));
        $this->db->bindParam(':financiamiento_externo',    $this->valorONulo($datos['financiamiento_externo'] ?? null));
        $this->db->bindParam(':razones_patrocinio',        $this->valorONulo($datos['razones_patrocinio'] ?? null));
        $this->db->bindParam(':usuario',                   $usuario);
        $this->db->bindParam(':id_solicitud',              $idSolicitud);
        $this->db->ejecutar($query);

        return true;
    }

    public function enviar(int $idSolicitud, string $usuario): array
    {
        $solicitud = $this->obtenerPorId($idSolicitud);

        if (!$solicitud) {
            return ['ok' => false, 'mensaje' => 'Solicitud no encontrada.'];
        }

        $esReenvio = ($solicitud['codigo_estado'] === 'OBSERVADO');

        if (!in_array($solicitud['codigo_estado'], ['BORRADOR', 'OBSERVADO'], true)) {
            return ['ok' => false, 'mensaje' => 'Solo se puede enviar una solicitud en estado Borrador u Observada.'];
        }

        if ($this->documento->tienePendientesObligatorios($idSolicitud)) {
            return ['ok' => false, 'mensaje' => 'Debe adjuntar todos los documentos obligatorios antes de enviar.'];
        }

        $folio    = $solicitud['folio'] ?: $this->folio->generar('S');
        $idEstado = $this->obtenerIdEstado('EN_TRAMITE');

        $query = "
            UPDATE SOLICITUD SET
                sol_folio               = :folio,
                tes_codigo              = :id_estado,
                sol_fecha_envio         = GETDATE(),
                sol_fecha_actualizacion = GETDATE(),
                sol_login_actualizacion = :usuario
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':folio',        $folio);
        $this->db->bindParam(':id_estado',    $idEstado);
        $this->db->bindParam(':usuario',      $usuario);
        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);

        $this->documento->bloquear($idSolicitud);

        $this->historial->registrar(
            'S',
            $idSolicitud,
            'EN_TRAMITE',
            $usuario,
            'ACADEMICO',
            $esReenvio ? 'Solicitud corregida y reenviada por el académico.' : 'Solicitud enviada por el académico.'
        );

        return ['ok' => true, 'folio' => $folio];
    }

    public function cambiarEstado(
        int    $idSolicitud,
        string $codigoEstado,
        string $usuario,
        string $rolUsuario,
        string $observacion = null
    ): bool {
        $idEstado = $this->obtenerIdEstado($codigoEstado);
        if (!$idEstado) {
            return false;
        }

        $query = "
            UPDATE SOLICITUD SET
                tes_codigo              = :id_estado,
                sol_fecha_actualizacion = GETDATE(),
                sol_login_actualizacion = :usuario
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_estado',    $idEstado);
        $this->db->bindParam(':usuario',      $usuario);
        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);

        if ($codigoEstado === 'OBSERVADO') {
            $this->documento->desbloquear($idSolicitud);
        }

        $this->historial->registrar('S', $idSolicitud, $codigoEstado, $usuario, $rolUsuario, $observacion);

        return true;
    }

    public function obtenerPorId(int $idSolicitud): array
    {
        $query = "
            SELECT
                s.sol_codigo                  AS id_solicitud,
                s.sol_folio                   AS folio,
                s.aca_rut                     AS rut_academico,
                a.aca_nombres + ' ' + a.aca_apellido_paterno + ' ' + a.aca_apellido_materno AS nombre_academico,
                a.aca_facultad                AS facultad,
                a.aca_departamento            AS departamento,
                s.sol_nombre_programa         AS nombre_programa,
                s.sol_institucion_destino     AS institucion_destino,
                s.sol_pais                    AS pais,
                s.sol_fecha_inicio            AS fecha_inicio,
                s.sol_fecha_termino           AS fecha_termino,
                s.sol_fecha_salida_ubb        AS fecha_salida_ubb,
                s.sol_financiamiento_externo  AS financiamiento_externo,
                s.sol_razones_patrocinio      AS razones_patrocinio,
                s.sol_informacion_adicional   AS informacion_adicional,
                s.sol_ruta_pdf                AS ruta_pdf,
                s.sol_fecha_registro          AS fecha_creacion,
                s.sol_fecha_envio             AS fecha_envio,
                s.sol_fecha_actualizacion     AS fecha_modificacion,
                s.sol_login_registro          AS usuario_creacion,
                e.tes_codigo_interno          AS codigo_estado,
                e.tes_descripcion             AS estado,
                tp.tpe_descripcion            AS tipo_perfeccionamiento,
                tg.tgr_descripcion            AS tipo_grado,
                s.tpe_codigo                  AS id_tipo_perfeccionamiento,
                s.tgr_codigo                  AS id_tipo_grado
            FROM SOLICITUD s
            JOIN ACADEMICO a
                ON s.aca_rut = a.aca_rut
            JOIN TIPO_ESTADO e
                ON s.tes_codigo = e.tes_codigo
            JOIN TIPO_PERFECCIONAMIENTO tp
                ON s.tpe_codigo = tp.tpe_codigo
            LEFT JOIN TIPO_GRADO tg
                ON s.tgr_codigo = tg.tgr_codigo
            WHERE s.sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        return $this->db->ejecutar($query, ['assoc' => true]) ?: [];
    }

    public function obtenerPorAcademico(string $rut): array
    {
        $query = "
            SELECT
                s.sol_codigo              AS id_solicitud,
                s.sol_folio               AS folio,
                s.sol_nombre_programa     AS nombre_programa,
                s.sol_institucion_destino AS institucion_destino,
                s.sol_fecha_envio         AS fecha_envio,
                e.tes_codigo_interno      AS codigo_estado,
                e.tes_descripcion         AS estado,
                tp.tpe_descripcion        AS tipo_perfeccionamiento
            FROM SOLICITUD s
            JOIN TIPO_ESTADO e
                ON s.tes_codigo = e.tes_codigo
            JOIN TIPO_PERFECCIONAMIENTO tp
                ON s.tpe_codigo = tp.tpe_codigo
            WHERE s.aca_rut = :rut
              AND s.sol_fecha_envio IS NOT NULL
            ORDER BY s.sol_fecha_registro DESC
        ";

        $this->db->bindParam(':rut', $rut);
        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerBandeja(array $filtros = []): array
    {
        $where  = "WHERE s.sol_fecha_envio IS NOT NULL";
        $params = [];

        if (!empty($filtros['nombre'])) {
            $where .= " AND (a.aca_nombres + ' ' + a.aca_apellido_paterno + ' ' + a.aca_apellido_materno) LIKE :nombre";
            $params[':nombre'] = '%' . $filtros['nombre'] . '%';
        }

        if (!empty($filtros['departamento'])) {
            $where .= " AND a.aca_departamento = :departamento";
            $params[':departamento'] = $filtros['departamento'];
        }

        if (!empty($filtros['estado'])) {
            $where .= " AND e.tes_codigo_interno = :estado";
            $params[':estado'] = $filtros['estado'];
        }

        $query = "
            SELECT
                s.sol_codigo              AS id_solicitud,
                s.sol_folio               AS folio,
                s.aca_rut                 AS rut_academico,
                a.aca_nombres + ' ' + a.aca_apellido_paterno + ' ' + a.aca_apellido_materno AS nombre_academico,
                a.aca_departamento        AS departamento,
                s.sol_nombre_programa     AS nombre_programa,
                s.sol_institucion_destino AS institucion_destino,
                s.sol_fecha_envio         AS fecha_envio,
                e.tes_codigo_interno      AS codigo_estado,
                e.tes_descripcion         AS estado,
                tp.tpe_descripcion        AS tipo_perfeccionamiento
            FROM SOLICITUD s
            JOIN ACADEMICO a
                ON s.aca_rut = a.aca_rut
            JOIN TIPO_ESTADO e
                ON s.tes_codigo = e.tes_codigo
            JOIN TIPO_PERFECCIONAMIENTO tp
                ON s.tpe_codigo = tp.tpe_codigo
            {$where}
            ORDER BY s.sol_fecha_envio DESC
        ";

        foreach ($params as $key => $value) {
            $this->db->bindParam($key, $value);
        }

        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerTiposPerfeccionamiento(): array
    {
        $query = "
            SELECT tpe_codigo AS id_tipo, tpe_descripcion AS descripcion
            FROM TIPO_PERFECCIONAMIENTO
            WHERE tpe_ind_activo = 1
            ORDER BY tpe_codigo ASC
        ";

        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerTiposGrado(): array
    {
        $query = "
            SELECT tgr_codigo AS id_tipo_grado, tgr_descripcion AS descripcion
            FROM TIPO_GRADO
            WHERE tgr_ind_activo = 1
            ORDER BY tgr_codigo ASC
        ";

        return $this->db->ejecutar($query) ?: [];
    }

    public function guardarRutaPdf(int $idSolicitud, string $ruta): void
    {
        $query = "
            UPDATE SOLICITUD
            SET sol_ruta_pdf = :ruta
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':ruta',         $ruta);
        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);
    }

    private function obtenerIdEstado(string $codigo): ?int
    {
        $query = "
            SELECT tes_codigo AS id_estado
            FROM TIPO_ESTADO
            WHERE tes_codigo_interno = :codigo
        ";

        $this->db->bindParam(':codigo', $codigo);
        $result = $this->db->ejecutar($query, ['assoc' => true]);

        return $result ? (int) $result['id_estado'] : null;
    }

    private function fechaSql($fecha): ?string
    {
        $fecha = trim((string) $fecha);
        if ($fecha === '') {
            return null;
        }
        $dt = \DateTime::createFromFormat('d/m/Y', $fecha);
        if ($dt !== false) {
            return $dt->format('Y-m-d');
        }
        return $fecha;
    }

    private function valorONulo($valor)
    {
        if (is_string($valor)) {
            $valor = trim($valor);
        }
        return ($valor === '' || $valor === null) ? null : $valor;
    }

    private function obtenerUltimoId(): int
    {
        $query  = "SELECT CAST(@@IDENTITY AS INT) AS id";
        $result = $this->db->ejecutar($query, ['assoc' => true]);
        return (int) $result['id'];
    }
}
