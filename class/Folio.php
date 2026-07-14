<?php

namespace UBB\Intranet\Perfeccionamiento;

class Folio
{
    private $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function generar(string $tipoProceso): string
    {
        $anio  = (int) date('Y');
        $prefijo = $this->prefijo($tipoProceso);

        $querySelect = "
            SELECT sfo_ultimo_numero AS ultimo_numero
            FROM SECUENCIA_FOLIO
            WHERE sfo_tipo_proceso = :tipo AND sfo_ano = :anio
        ";

        $this->db->bindParam(':tipo', $tipoProceso);
        $this->db->bindParam(':anio', $anio);
        $existe = $this->db->ejecutar($querySelect, ['assoc' => true]);

        if (!$existe) {
            $queryInsert = "
                INSERT INTO SECUENCIA_FOLIO
                    (sfo_tipo_proceso, sfo_ano, sfo_ultimo_numero)
                VALUES (:tipo, :anio, 0)
            ";
            $this->db->bindParam(':tipo', $tipoProceso);
            $this->db->bindParam(':anio', $anio);
            $this->db->ejecutar($queryInsert);
        }

        $queryUpdate = "
            UPDATE SECUENCIA_FOLIO
            SET sfo_ultimo_numero = sfo_ultimo_numero + 1
            WHERE sfo_tipo_proceso = :tipo AND sfo_ano = :anio
        ";
        $this->db->bindParam(':tipo', $tipoProceso);
        $this->db->bindParam(':anio', $anio);
        $this->db->ejecutar($queryUpdate);

        $queryNumero = "
            SELECT sfo_ultimo_numero AS ultimo_numero
            FROM SECUENCIA_FOLIO
            WHERE sfo_tipo_proceso = :tipo AND sfo_ano = :anio
        ";
        $this->db->bindParam(':tipo', $tipoProceso);
        $this->db->bindParam(':anio', $anio);
        $resultado = $this->db->ejecutar($queryNumero, ['assoc' => true]);

        $numero = str_pad($resultado['ultimo_numero'], 3, '0', STR_PAD_LEFT);

        return "{$prefijo}-{$anio}-{$numero}";
    }

    private function prefijo(string $tipoProceso): string
    {
        $prefijos = [
            'S' => 'PA',
            'R' => 'REN',
            'C' => 'CIE',
        ];

        return $prefijos[$tipoProceso] ?? 'XX';
    }
}
