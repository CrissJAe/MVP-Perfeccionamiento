<?php

namespace UBB\Intranet\Perfeccionamiento;

class SolicitudBeneficio
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function guardar(int $idSolicitud, array $beneficios): bool
    {
        $this->eliminarPorSolicitud($idSolicitud);

        foreach ($beneficios as $beneficio) {
            foreach ($beneficio as $k => $v) {
                if (is_string($v) && trim($v) === '') {
                    $beneficio[$k] = null;
                }
            }
            $query = "
                INSERT INTO SOLICITUD_BENEFICIO (
                    sol_codigo,
                    tbe_codigo,
                    sbe_n_horas,
                    sbe_monto_mensual,
                    sbe_monto_total_viaje,
                    sbe_valor_ida,
                    sbe_valor_regreso,
                    sbe_valor_ida_regreso,
                    sbe_valor_matricula,
                    sbe_valor_arancel,
                    sbe_monto_seguro
                ) VALUES (
                    :id_solicitud,
                    :id_tipo_beneficio,
                    :n_horas,
                    :monto_mensual,
                    :monto_total_viaje,
                    :valor_ida,
                    :valor_regreso,
                    :valor_ida_regreso,
                    :valor_matricula,
                    :valor_arancel,
                    :monto_seguro
                )
            ";

            $this->db->bindParam(':id_solicitud',      $idSolicitud);
            $this->db->bindParam(':id_tipo_beneficio', $beneficio['id_tipo_beneficio']);
            $this->db->bindParam(':n_horas',           $beneficio['n_horas']           ?? null);
            $this->db->bindParam(':monto_mensual',     $beneficio['monto_mensual']     ?? null);
            $this->db->bindParam(':monto_total_viaje', $beneficio['monto_total_viaje'] ?? null);
            $this->db->bindParam(':valor_ida',         $beneficio['valor_ida']         ?? null);
            $this->db->bindParam(':valor_regreso',     $beneficio['valor_regreso']     ?? null);
            $this->db->bindParam(':valor_ida_regreso', $beneficio['valor_ida_regreso'] ?? null);
            $this->db->bindParam(':valor_matricula',   $beneficio['valor_matricula']   ?? null);
            $this->db->bindParam(':valor_arancel',     $beneficio['valor_arancel']     ?? null);
            $this->db->bindParam(':monto_seguro',      $beneficio['monto_seguro']      ?? null);
            $this->db->ejecutar($query);
        }

        return true;
    }

    public function obtenerPorSolicitud(int $idSolicitud): array
    {
        $query = "
            SELECT
                sb.sbe_codigo             AS id_sol_beneficio,
                sb.tbe_codigo             AS id_tipo_beneficio,
                sb.sbe_n_horas            AS n_horas,
                sb.sbe_monto_mensual      AS monto_mensual,
                sb.sbe_monto_total_viaje  AS monto_total_viaje,
                sb.sbe_valor_ida          AS valor_ida,
                sb.sbe_valor_regreso      AS valor_regreso,
                sb.sbe_valor_ida_regreso  AS valor_ida_regreso,
                sb.sbe_valor_matricula    AS valor_matricula,
                sb.sbe_valor_arancel      AS valor_arancel,
                sb.sbe_monto_seguro       AS monto_seguro,
                tb.tbe_codigo_interno     AS codigo,
                tb.tbe_descripcion        AS descripcion,
                tb.tbe_ind_n_horas            AS tiene_n_horas,
                tb.tbe_ind_monto_mensual      AS tiene_monto_mensual,
                tb.tbe_ind_monto_viaje        AS tiene_monto_viaje,
                tb.tbe_ind_valor_ida          AS tiene_valor_ida,
                tb.tbe_ind_valor_regreso      AS tiene_valor_regreso,
                tb.tbe_ind_valor_ida_regreso  AS tiene_valor_ida_regreso,
                tb.tbe_ind_valor_matricula    AS tiene_valor_matricula,
                tb.tbe_ind_valor_arancel      AS tiene_valor_arancel,
                tb.tbe_ind_monto_seguro       AS tiene_monto_seguro
            FROM SOLICITUD_BENEFICIO sb
            JOIN TIPO_BENEFICIO tb
                ON sb.tbe_codigo = tb.tbe_codigo
            WHERE sb.sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerTipos(): array
    {
        $query = "
            SELECT
                tbe_codigo            AS id_beneficio,
                tbe_codigo_interno    AS codigo,
                tbe_descripcion       AS descripcion,
                tbe_ind_n_horas           AS tiene_n_horas,
                tbe_ind_monto_mensual     AS tiene_monto_mensual,
                tbe_ind_monto_viaje       AS tiene_monto_viaje,
                tbe_ind_valor_ida         AS tiene_valor_ida,
                tbe_ind_valor_regreso     AS tiene_valor_regreso,
                tbe_ind_valor_ida_regreso AS tiene_valor_ida_regreso,
                tbe_ind_valor_matricula   AS tiene_valor_matricula,
                tbe_ind_valor_arancel     AS tiene_valor_arancel,
                tbe_ind_monto_seguro      AS tiene_monto_seguro
            FROM TIPO_BENEFICIO
            WHERE tbe_ind_activo = 1
            ORDER BY tbe_codigo ASC
        ";

        return $this->db->ejecutar($query) ?: [];
    }

    private function eliminarPorSolicitud(int $idSolicitud): void
    {
        $query = "
            DELETE FROM SOLICITUD_BENEFICIO
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);
    }
}
