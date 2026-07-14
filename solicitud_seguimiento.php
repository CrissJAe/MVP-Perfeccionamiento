<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Solicitud;
use UBB\Intranet\Perfeccionamiento\Historial;

$solicitudClass = new Solicitud($db);
$historialClass = new Historial($db);

$rut = $web->get('rut');

$solicitudes = $solicitudClass->obtenerPorAcademico($rut);

$smarty->assign('solicitudes',          $solicitudes);
$smarty->assign('PATH_JS_RECURSOS_DEV', PATH_JS_RECURSOS_DEV);
$smarty->display('solicitud/seguimiento.tpl');
