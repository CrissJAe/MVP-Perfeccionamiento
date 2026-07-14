<?php

/** @var \UBB\Intranet\DatabasePDO $db */

require_once __DIR__ . '/config/bootstrap.php';

$idDocumento = isset($_GET['id']) ? (int) $_GET['id'] : 0;

if ($idDocumento <= 0) {
    http_response_code(400);
    exit('Solicitud inválida.');
}

$query = "
    SELECT
        sdo_ruta_archivo    AS ruta,
        sdo_nombre_original AS nombre
    FROM SOLICITUD_DOCUMENTO
    WHERE sdo_codigo = :id
";

$db->bindParam(':id', $idDocumento);
$doc = $db->ejecutar($query, ['assoc' => true]);

if (!$doc || empty($doc['ruta']) || !is_file($doc['ruta'])) {
    http_response_code(404);
    exit('Documento no encontrado.');
}

$nombre = $doc['nombre'] ?: 'documento.pdf';

header('Content-Type: application/pdf');
header('Content-Disposition: inline; filename="' . basename($nombre) . '"');
header('Content-Length: ' . filesize($doc['ruta']));
readfile($doc['ruta']);
exit;
