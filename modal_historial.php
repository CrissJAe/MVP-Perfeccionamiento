<?php

/** @var \UBB\Intranet\DatabasePDO $db */
/** @var \UBB\Intranet\Smarty $smarty */

require_once __DIR__ . '/config/bootstrap.php';

use UBB\Intranet\Perfeccionamiento\Historial;
use UBB\Intranet\Perfeccionamiento\Solicitud;

$historialClass = new Historial($db);
$solicitudClass = new Solicitud($db);

$idProceso   = isset($_POST['id_proceso'])    ? (int)  $_POST['id_proceso']    : 0;
$tipoProceso = isset($_POST['tipo_proceso'])  ? trim($_POST['tipo_proceso'])    : 'S';

$solicitud = $solicitudClass->obtenerPorId($idProceso);
$historial = $historialClass->obtenerPorProceso($tipoProceso, $idProceso);

$mapaRoles = [
    'ACADEMICO' => 'Académico/a',
    'DIRECTOR'  => 'Director/a de Departamento',
    'DECANO'    => 'Decano/a de Facultad',
    'COMITE'    => 'Comité de Perfeccionamiento',
    'DDA'       => 'Director/a de Departamento',
];
foreach ($historial as &$evento) {
    $rolEvento = $evento['rol_usuario'] ?? '';
    $evento['rol_label'] = $mapaRoles[$rolEvento] ?? ($rolEvento ?: '—');

    if (!empty($evento['fecha_evento'])) {
        $evento['fecha_evento'] = substr($evento['fecha_evento'], 0, 19); 
    }
}
unset($evento);

$etapasSolicitud = [
    'EN_TRAMITE'        => 'Solicitud en trámite',
    'REVISION_DEPTO'    => 'Revisión Departamento',
    'REVISION_FACULTAD' => 'Revisión Facultad',
    'REVISION_COMITE'   => 'Revisión Comité',
    'SIAPER'            => 'SIAPER',
    'DECRETACION'       => 'Decretación',
    'DECRETADO'         => 'Decretado',
];

$estadoActual = $solicitud['codigo_estado'] ?? '';

$ordenLinea = array_flip(array_keys($etapasSolicitud));

$pasoActual = 1;
foreach ($historial as $evento) {
    if (isset($ordenLinea[$evento['codigo_estado']])) {
        $pasoActual = max($pasoActual, $ordenLinea[$evento['codigo_estado']] + 1);
    }
}

$lateral = in_array($estadoActual, ['OBSERVADO', 'RECHAZADO'], true) ? $estadoActual : null;

if ($estadoActual === 'APROBADO' && $pasoActual < count($etapasSolicitud)) {
    $pasoActual++;
}

$etapaActual = $pasoActual;
$etapas      = [];
$i           = 1;

foreach ($etapasSolicitud as $codigo => $label) {
    $etapas[] = [
        'numero'      => $i,
        'codigo'      => $codigo,
        'label'       => $label,
        'completado'  => $i < $pasoActual,
        'en_curso'    => $i === $pasoActual && $lateral === null,
        'alerta'      => $i === $pasoActual && $lateral !== null,
        'tipo_alerta' => $lateral,
    ];
    $i++;
}

$ultimoEvento = !empty($historial) ? end($historial) : null;

$smarty->assign('solicitud',     $solicitud);
$smarty->assign('historial',     $historial);
$smarty->assign('etapas',        $etapas);
$smarty->assign('ultimo_evento', $ultimoEvento);
$smarty->display('modal/historial.tpl');
