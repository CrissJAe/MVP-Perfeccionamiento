<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */
/** @var object $web */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Solicitud;
use UBB\Intranet\Perfeccionamiento\SolicitudDocumento;

$solicitudClass = new Solicitud($db);
$documentoClass = new SolicitudDocumento($db);

$idSolicitud = isset($_POST['id_solicitud']) ? (int) $_POST['id_solicitud'] : 0;
$accion      = isset($_POST['accion'])       ? trim($_POST['accion'])        : null;
$rut         = $web->get('rut');
$rol         = isset($_POST['rol_usuario']) ? trim($_POST['rol_usuario']) : 'DDA';
$mensaje     = '';
$error       = '';

$mapaRoles = [
    'ACADEMICO' => 'Académico/a',
    'DIRECTOR'  => 'Director/a de Departamento',
    'DECANO'    => 'Decano/a de Facultad',
    'COMITE'    => 'Comité de Perfeccionamiento',
    'DDA'       => 'Director/a de Departamento',
];

if ($accion && $idSolicitud) {

    $avancePorRol = [
        'DDA'      => 'REVISION_FACULTAD',
        'DIRECTOR' => 'REVISION_FACULTAD',
        'DECANO'   => 'REVISION_COMITE',
        'COMITE'   => 'APROBADO',
    ];

    $mapaEstados = [
        'aprobar'   => $avancePorRol[$rol] ?? 'APROBADO',
        'rechazar'  => 'RECHAZADO',
        'observar'  => 'OBSERVADO',
    ];

    if (isset($mapaEstados[$accion])) {
        $observacion = isset($_POST['observacion']) ? trim($_POST['observacion']) : null;

        if (($accion === 'rechazar' || $accion === 'observar') && empty($observacion)) {
            $error = 'Debe ingresar el motivo para ' .
                ($accion === 'rechazar' ? 'rechazar' : 'observar') . ' la solicitud.';
        } else {
            if ($accion === 'aprobar' && empty($observacion)) {
                $observacion = 'Solicitud aprobada por ' . ($mapaRoles[$rol] ?? $rol) . '.';
            }

            $ok = $solicitudClass->cambiarEstado(
                $idSolicitud,
                $mapaEstados[$accion],
                $rut,
                $rol,
                $observacion ?: null
            );

            if ($ok) {
                $mensajes = [
                    'aprobar'  => 'Solicitud aprobada y derivada a la siguiente etapa.',
                    'rechazar' => 'Solicitud rechazada. Se notificó el motivo en el historial.',
                    'observar' => 'Observación registrada. El académico/a podrá corregir y reenviar.',
                ];
                $mensaje = $mensajes[$accion] ?? 'Acción realizada.';
            } else {
                $error = 'No se pudo procesar la acción. Intente nuevamente.';
            }
        }
    }
}

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

$smarty->assign('solicitud',   $solicitud);
$smarty->assign('documentos',  $documentos);
$smarty->assign('rol_usuario', $rol);
$smarty->assign('mensaje',     $mensaje);
$smarty->assign('error',       $error);
$smarty->display('modal/revisar.tpl');
