<?php

/** @var \UBB\Intranet\DatabasePDO $db */

require_once __DIR__ . '/config/bootstrap.php';

$idSolicitud = isset($_GET['id']) ? (int) $_GET['id'] : 0;

if ($idSolicitud <= 0) {
    http_response_code(400);
    exit('Solicitud inválida.');
}

$query = "
    SELECT sol_ruta_pdf AS ruta, sol_folio AS folio
    FROM SOLICITUD
    WHERE sol_codigo = :id
";

$db->bindParam(':id', $idSolicitud);
$sol = $db->ejecutar($query, ['assoc' => true]);

if (!$sol || empty($sol['ruta']) || !is_file($sol['ruta'])) {
    http_response_code(404);
    exit('Ficha no encontrada.');
}

header('Content-Type: application/pdf');
header('Content-Disposition: inline; filename="ficha_postulacion_' . basename((string) $sol['folio']) . '.pdf"');
header('Content-Length: ' . filesize($sol['ruta']));
readfile($sol['ruta']);
exit;
