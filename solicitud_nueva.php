<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Solicitud;
use UBB\Intranet\Perfeccionamiento\SolicitudBeneficio;
use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;
use UBB\Intranet\Perfeccionamiento\Academico;
use UBB\Intranet\Perfeccionamiento\Historial;
use UBB\Intranet\Perfeccionamiento\FichaPostulacionPdf;

$solicitud      = new Solicitud($db);
$beneficio      = new SolicitudBeneficio($db);
$documentoClass = new SolicitudDocumento($db);
$academico      = new Academico($db);

$rut = $web->get('rut');

$datosAcademico = $academico->obtenerPorRut($rut);

$datosSolicitud = null;
$idSolicitud    = isset($_POST['id_solicitud']) ? (int) $_POST['id_solicitud'] : null;
$accion         = isset($_POST['accion'])       ? trim($_POST['accion'])        : null;
$errores        = [];
$mensaje        = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $accion) {

    $datos = [
        'rut_academico'             => $rut,
        'id_tipo_perfeccionamiento' => (int) ($_POST['id_tipo_perfeccionamiento'] ?? 0),
        'id_tipo_grado'             => !empty($_POST['id_tipo_grado']) ? (int) $_POST['id_tipo_grado'] : null,
        'nombre_programa'           => trim($_POST['nombre_programa']           ?? ''),
        'institucion_destino'       => trim($_POST['institucion_destino']       ?? ''),
        'pais'                      => trim($_POST['pais']                      ?? ''),
        'fecha_inicio'              => trim($_POST['fecha_inicio']              ?? ''),
        'fecha_termino'             => trim($_POST['fecha_termino']             ?? ''),
        'fecha_salida_ubb'          => !empty($_POST['fecha_salida_ubb']) ? trim($_POST['fecha_salida_ubb']) : null,
        'financiamiento_externo'    => trim($_POST['financiamiento_externo']    ?? ''),
        'razones_patrocinio'        => trim($_POST['razones_patrocinio']        ?? ''),
    ];

    $beneficiosPost = [];
    if (!empty($_POST['beneficios_check']) && is_array($_POST['beneficios_check'])) {
        foreach (array_keys($_POST['beneficios_check']) as $idTipoBeneficio) {
            $montos = $_POST['beneficios'][$idTipoBeneficio] ?? [];
            $beneficiosPost[] = array_merge(
                ['id_tipo_beneficio' => (int) $idTipoBeneficio],
                $montos
            );
        }
    }

    if ($accion === 'borrador') {
        if ($idSolicitud) {
            $solicitud->actualizar($idSolicitud, $datos, $rut);
        } else {
            $idSolicitud = $solicitud->crear($datos, $rut);
        }

        if (!empty($beneficiosPost)) {
            $beneficio->guardar($idSolicitud, $beneficiosPost);
        }

        $mensaje        = 'Borrador guardado correctamente.';
        $datosSolicitud = $solicitud->obtenerPorId($idSolicitud);
    }

    if ($accion === 'enviar') {
        if (!$idSolicitud) {
            $idSolicitud = $solicitud->crear($datos, $rut);
        } else {
            $solicitud->actualizar($idSolicitud, $datos, $rut);
        }

        if (!empty($beneficiosPost)) {
            $beneficio->guardar($idSolicitud, $beneficiosPost);
        }

        $resultado = $solicitud->enviar($idSolicitud, $rut);

        if ($resultado['ok']) {
            $rutaFicha = (new FichaPostulacionPdf($db))->generar($idSolicitud);
            if ($rutaFicha) {
                $solicitud->guardarRutaPdf($idSolicitud, $rutaFicha);
            }
            $mensaje        = 'Solicitud enviada correctamente. Folio: ' . $resultado['folio'];
            $datosSolicitud = $solicitud->obtenerPorId($idSolicitud);
        } else {
            $errores[]      = $resultado['mensaje'];
            $datosSolicitud = $solicitud->obtenerPorId($idSolicitud);
        }
    }
}

if (!$idSolicitud && isset($_GET['id'])) {
    $idSolicitud    = (int) $_GET['id'];
    $datosSolicitud = $solicitud->obtenerPorId($idSolicitud);
}

$avisoObservacion = null;
if (($datosSolicitud['codigo_estado'] ?? '') === 'OBSERVADO') {
    $ultimo = (new Historial($db))->obtenerUltimoEstado('S', $idSolicitud);
    if (!empty($ultimo['observacion'])) {
        $avisoObservacion = 'Solicitud observada por ' . ($ultimo['rol_usuario'] ?? 'revisor') . ': ' . $ultimo['observacion'];
    }
}

$tiposPerfeccionamiento = $solicitud->obtenerTiposPerfeccionamiento();
$tiposGrado             = $solicitud->obtenerTiposGrado();
$tiposBeneficio         = $beneficio->obtenerTipos();
$beneficiosGuardados    = $idSolicitud ? $beneficio->obtenerPorSolicitud($idSolicitud) : [];
$documentos             = $idSolicitud ? $documentoClass->obtenerPorSolicitud($idSolicitud) : [];

if ($idSolicitud && !empty($datosSolicitud['ruta_pdf'])) {
    array_unshift($documentos, [
        'id_sol_documento' => 0,
        'es_ficha'         => true,
        'nombre_tipo'      => 'Ficha de Postulación',
        'estado_doc'       => 'CARGADO',
        'bloqueado'        => 1,
    ]);
}

$smarty->assign('academico',               $datosAcademico);
$smarty->assign('solicitud',               $datosSolicitud);
$smarty->assign('id_solicitud',            $idSolicitud);
$smarty->assign('tipos_perfeccionamiento', $tiposPerfeccionamiento);
$smarty->assign('tipos_grado',             $tiposGrado);
$smarty->assign('tipos_beneficio',         $tiposBeneficio);
$smarty->assign('beneficios_guardados',    $beneficiosGuardados);
$smarty->assign('documentos',              $documentos);
$smarty->assign('errores',                 $errores);
$smarty->assign('aviso_observacion', $avisoObservacion);
$smarty->assign('mensaje',                 $mensaje);
$smarty->assign('PATH_JS_RECURSOS_DEV',    PATH_JS_RECURSOS_DEV);
$smarty->display('solicitud/nueva.tpl');
