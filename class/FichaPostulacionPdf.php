<?php

namespace UBB\Intranet\Perfeccionamiento;

use Mpdf\Mpdf;

class FichaPostulacionPdf
{
    private $db;

    private const DIR_BASE = '/var/www/documentos/perfeccionamiento_academico/solicitudes/';

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function generar(int $idSolicitud): ?string
    {
        $solicitud = (new Solicitud($this->db))->obtenerPorId($idSolicitud);
        if (!$solicitud) {
            return null;
        }

        $academico  = (new Academico($this->db))->obtenerPorRut($solicitud['rut_academico']);
        $beneficios = (new SolicitudBeneficio($this->db))->obtenerPorSolicitud($idSolicitud);
        $documentos = (new SolicitudDocumento($this->db))->obtenerPorSolicitud($idSolicitud);

        $dir = self::DIR_BASE . $idSolicitud . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }

        $ruta = $dir . 'ficha_postulacion_' . preg_replace('/[^A-Za-z0-9\-]/', '', $solicitud['folio'] ?? $idSolicitud) . '.pdf';

        $mpdf = new Mpdf([
            'format'        => 'Letter',
            'margin_top'    => 10,
            'margin_bottom' => 10,
            'margin_left'   => 12,
            'margin_right'  => 12,
            'tempDir'       => sys_get_temp_dir(),
        ]);

        $mpdf->SetTitle('Ficha de Postulación ' . ($solicitud['folio'] ?? ''));
        $mpdf->WriteHTML($this->html($solicitud, $academico, $beneficios, $documentos));
        $mpdf->Output($ruta, \Mpdf\Output\Destination::FILE);

        return is_file($ruta) ? $ruta : null;
    }

    private function html(array $sol, array $aca, array $beneficios, array $documentos): string
    {
        $fechaEnvio = $sol['fecha_envio'] ? substr($sol['fecha_envio'], 0, 10) : date('Y-m-d');
        [$ano, $mes, $dia] = explode('-', $fechaEnvio);

        $tipo   = $sol['tipo_perfeccionamiento'] ?? '';
        $marca  = fn(bool $c) => $c ? 'X' : '&nbsp;';
        $esOtro = !in_array($tipo, ['Curso', 'Diplomado', 'Pasantía / Estadía', 'Postgrado'], true);

        $jornada = mb_strtolower((string) ($aca['tipo_jornada'] ?? ''));

        $e = fn($v) => htmlspecialchars((string) ($v ?? ''), ENT_QUOTES, 'UTF-8');
        $f = function ($fecha) {
            if (empty($fecha)) return '';
            $d = \DateTime::createFromFormat('Y-m-d', substr($fecha, 0, 10));
            return $d ? $d->format('d/m/Y') : $fecha;
        };
        $m = function ($valor) {
            if ($valor === null || $valor === '') return '';
            return number_format((float) $valor, 0, ',', '.');
        };

        $benMap = [];
        foreach ($beneficios as $b) {
            $benMap[$b['codigo']] = $b;
        }
        $tieneBen = fn(string $codigo) => isset($benMap[$codigo]);
        $ben      = fn(string $codigo, string $campo) => $benMap[$codigo][$campo] ?? null;

        $entregaPrograma = false;
        foreach ($documentos as $doc) {
            if ($doc['nombre_tipo'] === 'Antecedentes del programa' && $doc['estado_doc'] === 'CARGADO') {
                $entregaPrograma = true;
                break;
            }
        }

        $listaBeneficiosInternos = implode(', ', array_column($beneficios, 'descripcion'));

        return '
<style>
    body { font-family: helvetica, sans-serif; font-size: 8.5pt; color: #111; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 8px; }
    td, th { border: 1px solid #444; padding: 3px 5px; vertical-align: middle; }
    .sh { background: #dbe5f1; font-weight: bold; }
    .lbl { background: #f2f2f2; font-weight: bold; }
    .chk { border: 1px solid #444; width: 16px; text-align: center; font-weight: bold; }
    .tit { font-size: 13pt; font-weight: bold; letter-spacing: 1px; }
    .peq { font-size: 7.5pt; color: #333; }
    .center { text-align: center; }
    .boilerplate { text-align: right; font-size: 7.5pt; color: #333; margin-bottom: 2px; }
</style>

<div class="boilerplate">
    Sistema de Gestión de la Calidad<br>
    Departamento de Normalización y Certificación
</div>

<table>
    <tr>
        <td rowspan="2" style="width:16%; text-align:center; font-weight:bold;">UBB</td>
        <td rowspan="2" style="width:54%; text-align:center;">
            <b>UNIVERSIDAD DEL BÍO-BÍO</b><br>VICERRECTORÍA ACADÉMICA
        </td>
        <td colspan="3" class="sh center">Fecha</td>
    </tr>
    <tr>
        <td class="center" style="width:10%;">' . $e($dia) . '<br><span class="peq">Día</span></td>
        <td class="center" style="width:10%;">' . $e($mes) . '<br><span class="peq">Mes</span></td>
        <td class="center" style="width:10%;">' . $e($ano) . '<br><span class="peq">Año</span></td>
    </tr>
    <tr>
        <td colspan="5" class="tit center">FICHA DE POSTULACIÓN — Folio: ' . $e($sol['folio']) . '</td>
    </tr>
</table>

<table>
    <tr><td colspan="3" class="sh">Antecedentes Personales</td></tr>
    <tr>
        <td class="lbl" style="width:10%;">&nbsp;</td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td class="lbl">Apellido Paterno</td>
        <td colspan="2">' . $e($aca['ap_paterno'] ?? '') . '</td>
    </tr>
    <tr>
        <td class="lbl">Apellido Materno</td>
        <td colspan="2">' . $e($aca['ap_materno'] ?? '') . '</td>
    </tr>
    <tr>
        <td class="lbl">Nombres</td>
        <td colspan="2">' . $e($aca['nombres'] ?? '') . '</td>
    </tr>
    <tr>
        <td class="lbl">Facultad</td>
        <td>' . $e($sol['facultad']) . '</td>
        <td>' . $e($sol['departamento']) . ' <span class="peq">(Departamento)</span></td>
    </tr>
    <tr>
        <td class="lbl">Año ingreso UBB</td>
        <td colspan="2">' . $e($aca['anio_ingreso'] ?? '') . '</td>
    </tr>
    <tr>
        <td class="lbl" rowspan="2">Tipo de Jornada<br><span class="peq">(Marque con "x")</span></td>
        <td>Completa <span class="chk">' . $marca(str_contains($jornada, 'complet')) . '</span></td>
        <td rowspan="2">Email: ' . $e($aca['email'] ?? '') . '</td>
    </tr>
    <tr>
        <td>Media Jornada <span class="chk">' . $marca(str_contains($jornada, 'media')) . '</span></td>
    </tr>
</table>

<table>
    <tr><td colspan="6" class="sh">Antecedentes Perfeccionamiento</td></tr>
    <tr>
        <td class="lbl">Perfeccionamiento Solicitado<br><span class="peq">(Marque con "x")</span></td>
        <td class="center">Curso<br><span class="chk">' . $marca($tipo === 'Curso') . '</span></td>
        <td class="center">Diplomado<br><span class="chk">' . $marca($tipo === 'Diplomado') . '</span></td>
        <td class="center">Pasantía<br><span class="chk">' . $marca($tipo === 'Pasantía / Estadía') . '</span></td>
        <td class="center">Postgrado<br><span class="chk">' . $marca($tipo === 'Postgrado') . '</span></td>
        <td class="center">Otro: ' . $e($esOtro ? $tipo : '') . '<br><span class="chk">' . $marca($esOtro) . '</span></td>
    </tr>
    <tr>
        <td class="lbl">Grado al que postula</td>
        <td colspan="5">' . $e($sol['tipo_grado']) . '</td>
    </tr>
    <tr>
        <td class="lbl">Nombre del Programa</td>
        <td colspan="5">' . $e($sol['nombre_programa']) . '</td>
    </tr>
    <tr>
        <td class="lbl">Institución a la que ingresa</td>
        <td colspan="3">' . $e($sol['institucion_destino']) . '</td>
        <td class="lbl">País</td>
        <td>' . $e($sol['pais']) . '</td>
    </tr>
    <tr>
        <td class="lbl">Entrega Programa de Perfeccionamiento al que postula<br><span class="peq">(Marque con "x")</span></td>
        <td class="center" colspan="2">Sí <span class="chk">' . $marca($entregaPrograma) . '</span></td>
        <td class="center" colspan="3">No <span class="chk">' . $marca(!$entregaPrograma) . '</span></td>
    </tr>
    <tr>
        <td class="lbl">Periodo de Perfeccionamiento</td>
        <td colspan="2">Fecha de Inicio: <b>' . $f($sol['fecha_inicio']) . '</b></td>
        <td colspan="3">Fecha de Término: <b>' . $f($sol['fecha_termino']) . '</b></td>
    </tr>
    <tr>
        <td class="lbl">Fecha de Salida de UBB</td>
        <td colspan="5">' . $f($sol['fecha_salida_ubb']) . '</td>
    </tr>
    <tr>
        <td class="lbl">Financiamiento Becas o Convenios</td>
        <td colspan="5">' . $e($sol['financiamiento_externo']) . '</td>
    </tr>
    <tr>
        <td class="lbl">Financiamiento de Unidad Interna<br><span class="peq">(Aceptado)</span></td>
        <td colspan="5">' . $e($listaBeneficiosInternos) . '</td>
    </tr>
    <tr>
        <td class="lbl" rowspan="3">Si ya Obtuvo permiso para<br>perfeccionamiento indique:</td>
        <td class="lbl" colspan="2">Universidad</td>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td class="lbl" colspan="2">Grado</td>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td class="lbl" colspan="2">Periodo</td>
        <td colspan="3">&nbsp;</td>
    </tr>
</table>

<table>
    <tr><td colspan="9" class="sh">Beneficios que solicita a Universidad del Bío-Bío</td></tr>
    <tr>
        <td class="lbl" style="width:22%;">&nbsp;</td>
        <td class="center lbl" style="width:4%;">SI</td>
        <td class="center lbl" style="width:4%;">NO</td>
        <td class="lbl" colspan="6">Detalle</td>
    </tr>
    <tr>
        <td class="lbl">Mantención Total de Remuneraciones</td>
        <td class="center">' . $marca($tieneBen('MANTENCION_REMUNERACIONES')) . '</td>
        <td class="center">' . $marca(!$tieneBen('MANTENCION_REMUNERACIONES')) . '</td>
        <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
        <td class="lbl">Liberación de Jornada</td>
        <td class="center">' . $marca($tieneBen('LIBERACION_JORNADA')) . '</td>
        <td class="center">' . $marca(!$tieneBen('LIBERACION_JORNADA')) . '</td>
        <td class="peq">N° de Horas</td>
        <td colspan="5">' . $e($m($ben('LIBERACION_JORNADA', 'n_horas'))) . '</td>
    </tr>
    <tr>
        <td class="lbl">Beca Universidad del Bío-Bío</td>
        <td class="center">' . $marca($tieneBen('BECA_UBB')) . '</td>
        <td class="center">' . $marca(!$tieneBen('BECA_UBB')) . '</td>
        <td class="peq">Monto Mensual<br>(Estadías Largas)</td>
        <td colspan="2">$' . $e($m($ben('BECA_UBB', 'monto_mensual'))) . '</td>
        <td class="peq">Monto Total por viaje<br>(Estadías Largas)</td>
        <td colspan="2">$' . $e($m($ben('BECA_UBB', 'monto_total_viaje'))) . '</td>
    </tr>
    <tr>
        <td class="lbl">Pasajes</td>
        <td class="center">' . $marca($tieneBen('PASAJES')) . '</td>
        <td class="center">' . $marca(!$tieneBen('PASAJES')) . '</td>
        <td class="peq">Valor Ida</td>
        <td>$' . $e($m($ben('PASAJES', 'valor_ida'))) . '</td>
        <td class="peq">Valor Regreso</td>
        <td>$' . $e($m($ben('PASAJES', 'valor_regreso'))) . '</td>
        <td class="peq">Ida-Regreso</td>
        <td>$' . $e($m($ben('PASAJES', 'valor_ida_regreso'))) . '</td>
    </tr>
    <tr>
        <td class="lbl">Matrículas y Aranceles</td>
        <td class="center">' . $marca($tieneBen('MATRICULA_ARANCEL')) . '</td>
        <td class="center">' . $marca(!$tieneBen('MATRICULA_ARANCEL')) . '</td>
        <td class="peq">Valor Matrícula</td>
        <td colspan="2">$' . $e($m($ben('MATRICULA_ARANCEL', 'valor_matricula'))) . '</td>
        <td class="peq">Valor Arancel</td>
        <td colspan="2">$' . $e($m($ben('MATRICULA_ARANCEL', 'valor_arancel'))) . '</td>
    </tr>
    <tr>
        <td class="lbl">Seguro de Salud</td>
        <td class="center">' . $marca($tieneBen('SEGURO_SALUD')) . '</td>
        <td class="center">' . $marca(!$tieneBen('SEGURO_SALUD')) . '</td>
        <td class="peq">Monto Seguro de Salud</td>
        <td colspan="5">$' . $e($m($ben('SEGURO_SALUD', 'monto_seguro'))) . '</td>
    </tr>
    <tr>
        <td class="lbl">Reemplazo Docente</td>
        <td class="center">' . $marca($tieneBen('REEMPLAZO_DOCENTE')) . '</td>
        <td class="center">' . $marca(!$tieneBen('REEMPLAZO_DOCENTE')) . '</td>
        <td colspan="6">&nbsp;</td>
    </tr>
</table>

<table>
    <tr><td class="sh">Razones que motivan la petición de Patrocinio</td></tr>
    <tr><td style="height:70px; vertical-align:top;">' . nl2br($e($sol['razones_patrocinio'])) . '</td></tr>
    <tr><td style="border:none; padding-top:20px; text-align:right;">Firma Postulante: _______________________</td></tr>
</table>

<table>
    <tr>
        <td class="sh" style="width:24%;">Resolución de Postulación</td>
        <td class="sh center">Director(a) Departamento</td>
        <td class="sh center">Decano(a) de Facultad</td>
    </tr>
    <tr><td class="lbl">Fecha</td><td style="height:18px;"></td><td></td></tr>
    <tr><td class="lbl">Autoriza / No Autoriza</td><td style="height:18px;"></td><td></td></tr>
    <tr><td class="lbl">Firma</td><td style="height:34px;"></td><td></td></tr>
</table>

';
    }
}
