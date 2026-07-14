<?php

namespace UBB\Intranet\Perfeccionamiento;

class SolicitudDocumento
{
    private $db;

    private const DIR_BASE = '/var/www/documentos/perfeccionamiento_academico/solicitudes/';

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function inicializar(int $idSolicitud): void
    {
        $tipos = $this->obtenerTiposRequeridos();

        foreach ($tipos as $tipo) {
            $query = "
                INSERT INTO SOLICITUD_DOCUMENTO (
                    sol_codigo,
                    tdo_codigo,
                    sdo_estado,
                    sdo_ind_bloqueado
                ) VALUES (
                    :id_solicitud,
                    :id_tipo_doc,
                    'PENDIENTE',
                    0
                )
            ";

            $this->db->bindParam(':id_solicitud', $idSolicitud);
            $this->db->bindParam(':id_tipo_doc',  $tipo['id_tipo_doc']);
            $this->db->ejecutar($query);
        }
    }

    public function subir(int $idDocumento, array $archivo): bool
    {
        $documento = $this->obtenerPorId($idDocumento);

        if (!$documento || $documento['bloqueado']) {
            return false;
        }

        if ($archivo['type'] !== 'application/pdf') {
            return false;
        }

        $dir = self::DIR_BASE . $documento['id_solicitud'] . '/';
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }

        $nombreArchivo = uniqid('doc_') . '.pdf';
        $rutaDestino   = $dir . $nombreArchivo;

        if (!move_uploaded_file($archivo['tmp_name'], $rutaDestino)) {
            return false;
        }

        $query = "
            UPDATE SOLICITUD_DOCUMENTO
            SET
                sdo_ruta_archivo    = :ruta,
                sdo_nombre_original = :nombre,
                sdo_estado          = 'CARGADO',
                sdo_fecha_subida    = GETDATE(),
                sdo_login_subida    = :usuario
            WHERE sdo_codigo = :id
        ";

        $this->db->bindParam(':ruta',    $rutaDestino);
        $this->db->bindParam(':nombre',  $archivo['name']);
        $this->db->bindParam(':usuario', $_SESSION['rut'] ?? 'sistema');
        $this->db->bindParam(':id',      $idDocumento);
        $this->db->ejecutar($query);

        return true;
    }

    public function bloquear(int $idSolicitud): void
    {
        $query = "
            UPDATE SOLICITUD_DOCUMENTO
            SET sdo_ind_bloqueado = 1
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);
    }

    public function desbloquear(int $idSolicitud): void
    {
        $query = "
            UPDATE SOLICITUD_DOCUMENTO
            SET sdo_ind_bloqueado = 0
            WHERE sol_codigo = :id_solicitud
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $this->db->ejecutar($query);
    }

    public function obtenerPorSolicitud(int $idSolicitud): array
    {
        $query = "
            SELECT
                sd.sdo_codigo          AS id_sol_documento,
                sd.sol_codigo          AS id_solicitud,
                sd.tdo_codigo          AS id_tipo_doc,
                sd.sdo_ruta_archivo    AS ruta_archivo,
                sd.sdo_nombre_original AS nombre_original,
                sd.sdo_estado          AS estado_doc,
                sd.sdo_ind_bloqueado   AS bloqueado,
                sd.sdo_fecha_subida    AS fecha_subida,
                td.tdo_nombre          AS nombre_tipo,
                td.tdo_ind_obligatorio AS obligatorio
            FROM SOLICITUD_DOCUMENTO sd
            JOIN TIPO_DOCUMENTO td
                ON sd.tdo_codigo = td.tdo_codigo
            WHERE sd.sol_codigo = :id_solicitud
            ORDER BY td.tdo_codigo ASC
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        return $this->db->ejecutar($query) ?: [];
    }

    public function tienePendientesObligatorios(int $idSolicitud): bool
    {
        $query = "
            SELECT COUNT(*) AS total
            FROM SOLICITUD_DOCUMENTO sd
            JOIN TIPO_DOCUMENTO td
                ON sd.tdo_codigo = td.tdo_codigo
            WHERE sd.sol_codigo          = :id_solicitud
              AND td.tdo_ind_obligatorio = 1
              AND sd.sdo_estado          = 'PENDIENTE'
        ";

        $this->db->bindParam(':id_solicitud', $idSolicitud);
        $result = $this->db->ejecutar($query, ['assoc' => true]);

        return $result && (int) $result['total'] > 0;
    }

    private function obtenerPorId(int $idDocumento): array
    {
        $query = "
            SELECT
                sdo_codigo        AS id_sol_documento,
                sol_codigo        AS id_solicitud,
                sdo_ind_bloqueado AS bloqueado
            FROM SOLICITUD_DOCUMENTO
            WHERE sdo_codigo = :id
        ";

        $this->db->bindParam(':id', $idDocumento);
        return $this->db->ejecutar($query, ['assoc' => true]) ?: [];
    }

    private function obtenerTiposRequeridos(): array
    {
        $query = "
            SELECT tdo_codigo AS id_tipo_doc
            FROM TIPO_DOCUMENTO
            WHERE tdo_proceso = 'S' AND tdo_ind_activo = 1
        ";

        return $this->db->ejecutar($query) ?: [];
    }

    public function obtenerIdSolicitudPorDocumento(int $idDocumento): int
    {
        $query = "
            SELECT sol_codigo AS id_solicitud
            FROM SOLICITUD_DOCUMENTO
            WHERE sdo_codigo = :id
        ";

        $this->db->bindParam(':id', $idDocumento);
        $result = $this->db->ejecutar($query, ['assoc' => true]);

        return $result ? (int) $result['id_solicitud'] : 0;
    }
}
