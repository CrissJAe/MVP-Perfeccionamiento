<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;

$documento = new SolicitudDocumento($db);

$idDocumento = isset($_POST['id_documento']) ? (int) $_POST['id_documento'] : 0;

// Sin documento o sin archivo: volver al formulario
if ($idDocumento <= 0 || empty($_FILES['archivo']) || $_FILES['archivo']['error'] !== UPLOAD_ERR_OK) {
    $idSolicitud = $idDocumento > 0 ? $documento->obtenerIdSolicitudPorDocumento($idDocumento) : 0;
    header('Location: solicitud_nueva.php' . ($idSolicitud ? '?id=' . $idSolicitud . '&subida=error' : ''));
    exit;
}

$idSolicitud = $documento->obtenerIdSolicitudPorDocumento($idDocumento);

$ok = $documento->subir($idDocumento, $_FILES['archivo']);

header('Location: solicitud_nueva.php?id=' . $idSolicitud . '&subida=' . ($ok ? 'ok' : 'error'));
exit;
