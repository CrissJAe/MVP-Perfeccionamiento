<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Solicitud;
use UBB\Intranet\Perfeccionamiento\Academico;

$solicitudClass = new Solicitud($db);
$academicoClass = new Academico($db);

$filtros = [
    'nombre'       => isset($_POST['nombre'])       ? trim($_POST['nombre'])       : '',
    'departamento' => isset($_POST['departamento']) ? trim($_POST['departamento']) : '',
    'estado'       => isset($_POST['estado'])       ? trim($_POST['estado'])       : '',
];

$solicitudes   = $solicitudClass->obtenerBandeja($filtros);
$departamentos = $academicoClass->obtenerDepartamentos();

$smarty->assign('solicitudes',          $solicitudes);
$smarty->assign('departamentos',        $departamentos);
$smarty->assign('filtros',              $filtros);
$rolUsuario = isset($_POST['rol_usuario']) ? trim($_POST['rol_usuario']) : 'DDA';
$smarty->assign('rol_usuario', $rolUsuario);
$smarty->assign('PATH_JS_RECURSOS_DEV', PATH_JS_RECURSOS_DEV);
$smarty->display('bandeja/postulacion.tpl');
