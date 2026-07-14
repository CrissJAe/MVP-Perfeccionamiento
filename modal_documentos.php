<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;
use UBB\Intranet\Perfeccionamiento\Solicitud;

$documentoClass = new SolicitudDocumento($db);
$solicitudClass = new Solicitud($db);

$idSolicitud = isset($_POST['id_solicitud']) ? (int) $_POST['id_solicitud'] : 0;

$solicitud  = $solicitudClass->obtenerPorId($idSolicitud);
$documentos = $documentoClass->obtenerPorSolicitud($idSolicitud);

if (!empty($solicitud['ruta_pdf'])) {
    array_unshift($documentos, [
        'id_sol_documento' => 0,
        'es_ficha'         => true,
        'nombre_tipo'      => 'Ficha de Postulación',
        'estado_doc'       => 'CARGADO',
    ]);
}

$smarty->assign('solicitud',  $solicitud);
$smarty->assign('documentos', $documentos);
$smarty->display('modal/documentos.tpl');
