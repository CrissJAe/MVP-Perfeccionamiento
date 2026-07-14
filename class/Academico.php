<?php

namespace UBB\Intranet\Perfeccionamiento;

class Academico
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function obtenerPorRut(string $rut): array
    {
        $local = $this->obtenerLocal($rut);

        if (!empty($local)) {
            return $local;
        }

        $remoto = $this->obtenerDesdeVra($rut);

        if (!empty($remoto)) {
            $this->guardarLocal($remoto);
        }

        return $remoto ?: [];
    }

    public function obtenerNombreCompleto(array $academico): string
    {
        return trim(
            $academico['nombres']    . ' ' .
                $academico['ap_paterno'] . ' ' .
                $academico['ap_materno']
        );
    }

    public function obtenerDepartamentos(): array
    {
        $query = "
            SELECT DISTINCT
                aca_departamento AS departamento
            FROM ACADEMICO
            WHERE aca_departamento IS NOT NULL
              AND LTRIM(RTRIM(aca_departamento)) <> ''
            ORDER BY aca_departamento ASC
        ";

        return $this->db->ejecutar($query) ?: [];
    }

    private function obtenerLocal(string $rut): array
    {
        $query = "
            SELECT
                aca_rut              AS rut,
                aca_apellido_paterno AS ap_paterno,
                aca_apellido_materno AS ap_materno,
                aca_nombres          AS nombres,
                aca_facultad         AS facultad,
                aca_departamento     AS departamento,
                aca_ano_ingreso      AS anio_ingreso,
                aca_tipo_jornada     AS tipo_jornada,
                aca_email            AS email
            FROM ACADEMICO
            WHERE aca_rut = :rut
        ";

        $this->db->bindParam(':rut', $rut);
        return $this->db->ejecutar($query, ['assoc' => true]) ?: [];
    }

    private function obtenerDesdeVra(string $rut): array
    {
        $query = "
            SELECT TOP 1
                mae_rut               AS rut,
                mae_apellido_paterno  AS ap_paterno,
                mae_apellido_materno  AS ap_materno,
                mae_nombre            AS nombres,
                LTRIM(RTRIM(facultad))     AS facultad,
                LTRIM(RTRIM(reparticion))  AS departamento,
                SUBSTRING(fecha_ing_ubb, 1, 4) AS anio_ingreso,
                jornada               AS tipo_jornada,
                email                 AS email
            FROM Vra..JERARQUIZACION_ANTECEDENTES_PERSONALES
            WHERE mae_rut = :rut
            ORDER BY id_tabla DESC
        ";

        $this->db->bindParam(':rut', $rut);
        return $this->db->ejecutar($query, ['assoc' => true]) ?: [];
    }

    private function guardarLocal(array $datos): void
    {
        $query = "
            INSERT INTO ACADEMICO (
                aca_rut, aca_apellido_paterno, aca_apellido_materno, aca_nombres,
                aca_facultad, aca_departamento, aca_ano_ingreso,
                aca_tipo_jornada, aca_email
            ) VALUES (
                :rut, :ap_paterno, :ap_materno, :nombres,
                :facultad, :departamento, :anio_ingreso,
                :tipo_jornada, :email
            )
        ";

        $this->db->bindParam(':rut',          $datos['rut']);
        $this->db->bindParam(':ap_paterno',   $datos['ap_paterno']);
        $this->db->bindParam(':ap_materno',   $datos['ap_materno']);
        $this->db->bindParam(':nombres',      $datos['nombres']);
        $this->db->bindParam(':facultad',     $datos['facultad']);
        $this->db->bindParam(':departamento', $datos['departamento']);
        $this->db->bindParam(':anio_ingreso', $datos['anio_ingreso'] ?? null);
        $this->db->bindParam(':tipo_jornada', $datos['tipo_jornada'] ?? null);
        $this->db->bindParam(':email',        $datos['email'] ?? null);
        $this->db->ejecutar($query);
    }
}
