<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Solicitud;
use UBB\Intranet\Perfeccionamiento\SolicitudBeneficio;
use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;

$solicitudClass = new Solicitud($db);
$beneficioClass = new SolicitudBeneficio($db);
$documentoClass = new SolicitudDocumento($db);

$rut         = $web->get('rut');
$idSolicitud = isset($_POST['id_solicitud']) ? (int) $_POST['id_solicitud'] : 0;
$accion      = isset($_POST['accion'])       ? trim($_POST['accion'])        : null;
$errores     = [];
$mensaje     = '';

if (!$idSolicitud && isset($_GET['id'])) {
    $idSolicitud = (int) $_GET['id'];
}

if (isset($_GET['msg']) && trim($_GET['msg']) !== '') {
    $mensaje = trim($_GET['msg']);
}

if ($accion === 'subir_documento' && $idSolicitud) {
    $idDocumento = isset($_POST['id_documento']) ? (int) $_POST['id_documento'] : 0;

    if ($idDocumento && isset($_FILES['archivo']) && $_FILES['archivo']['error'] === UPLOAD_ERR_OK) {
        $ok      = $documentoClass->subir($idDocumento, $_FILES['archivo']);
        $mensaje = $ok
            ? 'Documento cargado correctamente.'
            : 'Error al cargar el documento. Verifique que sea un archivo PDF válido.';
    } else {
        $errores[] = 'No se recibió ningún archivo o hubo un error en la subida.';
    }
}

$solicitud  = $solicitudClass->obtenerPorId($idSolicitud);
$beneficios = $beneficioClass->obtenerPorSolicitud($idSolicitud);
$documentos = $documentoClass->obtenerPorSolicitud($idSolicitud);

$smarty->assign('solicitud',            $solicitud);
$smarty->assign('beneficios',           $beneficios);
$smarty->assign('documentos',           $documentos);
$smarty->assign('id_solicitud',         $idSolicitud);
$smarty->assign('mensaje',              $mensaje);
$smarty->assign('errores',              $errores);
$smarty->assign('PATH_JS_RECURSOS_DEV', PATH_JS_RECURSOS_DEV);
$smarty->display('solicitud/detalle.tpl');
