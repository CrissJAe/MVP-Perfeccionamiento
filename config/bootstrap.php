<?php

require_once __DIR__ . '/../vendor/autoload.php';
require_once __DIR__ . '/../local/lib/DatabasePDO.php'; // copia local: el repo del módulo no incluye la clase

use UBB\Intranet\DatabasePDO;


$sessionDir = __DIR__ . '/../storage/sessions/';
if (!is_dir($sessionDir)) {
    mkdir($sessionDir, 0777, true);
}
session_save_path($sessionDir);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

ini_set('default_charset', 'UTF-8');
if (!headers_sent()) {
    header('Content-Type: text/html; charset=utf-8');
}

class MockWeb
{
    private array $data;

    public function __construct(array $data = [])
    {
        $this->data = $data;
    }

    public function get(string $key)
    {
        return $this->data[$key] ?? null;
    }

    public function set(string $key, $value): void
    {
        $this->data[$key] = $value;
    }
}

$usuariosPrueba = require __DIR__ . '/usuarios_prueba.php';

$rutActivo = $_SESSION['mock_rut'] ?? array_key_first($usuariosPrueba);
if (!isset($usuariosPrueba[$rutActivo])) {
    $rutActivo = array_key_first($usuariosPrueba);
}

$datosUsuario = $usuariosPrueba[$rutActivo];
$tipoUsuario  = $datosUsuario['_tipo'] ?? 'academico';
unset($datosUsuario['_etiqueta'], $datosUsuario['_tipo']);

$web = new MockWeb($datosUsuario);


$db = new DatabasePDO([
    'driver'   => 'Driver={ODBC Driver 18 for SQL Server}',
    'host'     => getenv('DB_HOST') ?: 'localhost',
    'port'     => getenv('DB_PORT') ?: 1433,
    'database' => getenv('DB_NAME') ?: 'Perfeccionamiento',
    'username' => getenv('DB_USER') ?: 'sa',
    'password' => getenv('DB_PASS') ?: 'Ubb.Perfec2026',
    'options'  => [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ],
]);


$smartyTemplatesC = __DIR__ . '/../storage/templates_c/';
$smartyCache      = __DIR__ . '/../storage/cache/';

if (!is_dir($smartyTemplatesC)) {
    mkdir($smartyTemplatesC, 0755, true);
}
if (!is_dir($smartyCache)) {
    mkdir($smartyCache, 0755, true);
}

class MockSmarty extends Smarty
{
    public array $layoutTokens = [];
    public string $tipoUsuario = 'academico'; // 'academico' | 'revisor'

    public function display($template = null, $cache_id = null, $compile_id = null, $parent = null)
    {
        $layout = __DIR__ . '/../local/layout/';
        $esAjax = (($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '') === 'XMLHttpRequest');
        if (!$esAjax && is_file($layout . 'header.html')) {
            $html = file_get_contents($layout . 'header.html');

            $otro = $this->tipoUsuario === 'revisor' ? 'ACADEMICO' : 'REVISOR';
            $html = preg_replace(
                '/<!--\s*SIDEBAR:' . $otro . '\s*-->.*?<!--\s*\/SIDEBAR:' . $otro . '\s*-->/s',
                '',
                $html
            );

            echo strtr($html, $this->layoutTokens);
        }
        parent::display($template, $cache_id, $compile_id, $parent);
        if (!$esAjax && is_file($layout . 'footer.html')) {
            readfile($layout . 'footer.html');
        }
    }
}

$smarty = new MockSmarty();
$smarty->tipoUsuario  = $tipoUsuario;
$smarty->layoutTokens = [
    '{{USUARIO_NOMBRE}}'  => mb_strtoupper($datosUsuario['nombres'] ?? 'USUARIO'),
    '{{USUARIO_INICIAL}}' => mb_substr($datosUsuario['nombres'] ?? 'U', 0, 1),
];
$smarty->setTemplateDir(__DIR__ . '/../templates/');
$smarty->setCompileDir($smartyTemplatesC);
$smarty->setCacheDir($smartyCache);


if (!defined('PATH_JS_RECURSOS_DEV')) {
    define('PATH_JS_RECURSOS_DEV', 'local/recursos/');
}
$smarty->assign('PATH_JS_RECURSOS_DEV', PATH_JS_RECURSOS_DEV);
