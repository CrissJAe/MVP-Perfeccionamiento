<?php

namespace UBB\Intranet\Perfeccionamiento;

class Historial
{
    private $db;

    private const TABLAS = [
        'S' => [
            'historial' => 'SOLICITUD_HISTORIAL',
            'fk'        => 'sol_codigo',
            'prefijo'   => 'shi',
        ],
        'R' => [
            'historial' => 'RENOVACION_HISTORIAL',
            'fk'        => 'ren_codigo',
            'prefijo'   => 'rhi',
        ],
        'C' => [
            'historial' => 'CIERRE_HISTORIAL',
            'fk'        => 'cie_codigo',
            'prefijo'   => 'chi',
        ],
    ];

    private const ESTADOS = [
        'BORRADOR'            => 'Borrador',
        'EN_TRAMITE'          => 'En trámite',
        'REVISION_DEPTO'      => 'Revisión Departamento',
        'REVISION_FACULTAD'   => 'Revisión Facultad',
        'REVISION_COMITE'     => 'Revisión Comité',
        'SIAPER'              => 'SIAPER',
        'DECRETACION'         => 'Decretación',
        'DECRETADO'           => 'Decretado',
        'APROBADO'            => 'Aprobado',
        'RECHAZADO'           => 'Rechazado',
        'OBSERVADO'           => 'Observado',
        'CERRADO'             => 'Cerrado',
    ];

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function registrar(
        string $tipoProceso,
        int    $idProceso,
        string $codigoEstado,
        string $usuario,
        string $rolUsuario,
        string $observacion = null
    ): bool {
        $tabla = self::TABLAS[$tipoProceso]['historial'];
        $fk    = self::TABLAS[$tipoProceso]['fk'];
        $p     = self::TABLAS[$tipoProceso]['prefijo'];

        $idEstado = $this->obtenerIdEstado($codigoEstado);
        if (!$idEstado) {
            return false;
        }

        $query = "
            INSERT INTO {$tabla}
                ({$fk}, tes_codigo, {$p}_observacion, {$p}_fecha_evento, {$p}_login_evento, {$p}_rol_usuario)
            VALUES
                (:id_proceso, :id_estado, :observacion, GETDATE(), :usuario, :rol)
        ";

        $this->db->bindParam(':id_proceso',  $idProceso);
        $this->db->bindParam(':id_estado',   $idEstado);
        $this->db->bindParam(':observacion', $observacion);
        $this->db->bindParam(':usuario',     $usuario);
        $this->db->bindParam(':rol',         $rolUsuario);
        $this->db->ejecutar($query);

        return true;
    }

    public function obtenerPorProceso(string $tipoProceso, int $idProceso): array
    {
        $tabla = self::TABLAS[$tipoProceso]['historial'];
        $fk    = self::TABLAS[$tipoProceso]['fk'];
        $p     = self::TABLAS[$tipoProceso]['prefijo'];

        $query = "
            SELECT
                h.{$p}_codigo        AS id_historial,
                h.{$p}_observacion   AS observacion,
                h.{$p}_fecha_evento  AS fecha_evento,
                h.{$p}_login_evento  AS usuario_evento,
                h.{$p}_rol_usuario   AS rol_usuario,
                e.tes_codigo_interno AS codigo_estado,
                e.tes_descripcion    AS estado,
                e.tes_orden          AS orden
            FROM {$tabla} h
            JOIN TIPO_ESTADO e
                ON h.tes_codigo = e.tes_codigo
            WHERE h.{$fk} = :id_proceso
            ORDER BY h.{$p}_fecha_evento ASC
        ";

        $this->db->bindParam(':id_proceso', $idProceso);
        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerUltimoEstado(string $tipoProceso, int $idProceso): array
    {
        $eventos = $this->obtenerPorProceso($tipoProceso, $idProceso);
        return !empty($eventos) ? end($eventos) : [];
    }

    public function obtenerEstadoAnteriorA(string $tipoProceso, int $idProceso, string $codigoEstado): array
    {
        $eventos = $this->obtenerPorProceso($tipoProceso, $idProceso);
        $anterior = [];

        foreach ($eventos as $evento) {
            if ($evento['codigo_estado'] === $codigoEstado) {
                break;
            }
            $anterior = $evento;
        }

        return $anterior;
    }

    private function obtenerIdEstado(string $codigo): ?int
    {
        $query = "
            SELECT tes_codigo AS id_estado
            FROM TIPO_ESTADO
            WHERE tes_codigo_interno = :codigo
        ";

        $this->db->bindParam(':codigo', $codigo);
        $result = $this->db->ejecutar($query, ['assoc' => true]);

        return $result ? (int) $result['id_estado'] : null;
    }

    public static function etiquetaEstado(string $codigo): string
    {
        return self::ESTADOS[$codigo] ?? $codigo;
    }
}
