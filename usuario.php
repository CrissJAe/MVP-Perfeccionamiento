<?php

header('Content-Type: text/html; charset=utf-8');

$sessionDir = __DIR__ . '/storage/sessions/';
if (!is_dir($sessionDir)) {
    mkdir($sessionDir, 0777, true);
}
session_save_path($sessionDir);

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$usuarios = require __DIR__ . '/config/usuarios_prueba.php';

if (isset($_POST['cambiar_rut']) && isset($usuarios[$_POST['cambiar_rut']])) {
    $_SESSION['mock_rut'] = $_POST['cambiar_rut'];
}

$rutActivo = $_SESSION['mock_rut'] ?? array_key_first($usuarios);
$activo    = $usuarios[$rutActivo];
?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <title>Selector de usuario</title>
    <style>
        body {
            font-family: system-ui, sans-serif;
            max-width: 720px;
            margin: 2rem auto;
            padding: 0 1rem;
            color: #1a1a2e;
        }

        h1 {
            font-size: 1.3rem;
        }

        h2 {
            font-size: 1rem;
            margin-top: 2rem;
        }

        .aviso {
            background: #fff3cd;
            border: 1px solid #e0c060;
            padding: .5rem .8rem;
            border-radius: 6px;
            font-size: .85rem;
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: .8rem 1rem;
            margin: .6rem 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
        }

        .card.activa {
            border-color: #14509e;
            background: #eef4fb;
        }

        .card small {
            display: block;
            color: #555;
        }

        button {
            cursor: pointer;
            padding: .45rem .9rem;
            border-radius: 6px;
            border: 1px solid #14509e;
            background: #14509e;
            color: #fff;
        }

        button.sec {
            background: #fff;
            color: #14509e;
        }

        .acciones {
            display: flex;
            flex-wrap: wrap;
            gap: .5rem;
        }

        .acciones form {
            display: inline;
        }
    </style>
</head>

<body>
    <h1>Selector de usuario</h1>
    <p class="aviso">Página que simula el inicio de sesión de la intranet: el usuario elegido queda activo para las vistas del módulo.</p>

    <h2>Usuario activo: <?= htmlspecialchars($activo['nombres'] . ' ' . $activo['paterno']) ?> (<?= htmlspecialchars($rutActivo) ?>)</h2>

    <?php foreach ($usuarios as $rut => $u): ?>
        <div class="card <?= $rut === $rutActivo ? 'activa' : '' ?>">
            <div>
                <strong><?= htmlspecialchars($u['nombres'] . ' ' . $u['paterno'] . ' ' . $u['materno']) ?></strong>
                <small><?= htmlspecialchars($u['_etiqueta'] ?? '') ?></small>
                <small>RUT <?= htmlspecialchars($rut) ?> — <?= htmlspecialchars($u['correo']) ?></small>
            </div>
            <?php if ($rut !== $rutActivo): ?>
                <form method="post">
                    <input type="hidden" name="cambiar_rut" value="<?= htmlspecialchars($rut) ?>">
                    <button type="submit">Usar</button>
                </form>
            <?php else: ?>
                <strong>✔ activo</strong>
            <?php endif; ?>
        </div>
    <?php endforeach; ?>

    <h2>Ir a las vistas</h2>
    <div class="acciones">
        <form action="solicitud_nueva.php" method="get">
            <button type="submit" class="sec">Vista académico</button>
        </form>
        <form action="bandeja_postulacion.php" method="post">
            <input type="hidden" name="rol_usuario" value="DIRECTOR">
            <button type="submit" class="sec">Bandeja como Director</button>
        </form>
        <form action="bandeja_postulacion.php" method="post">
            <input type="hidden" name="rol_usuario" value="DECANO">
            <button type="submit" class="sec">Bandeja como Decano</button>
        </form>
        <form action="bandeja_postulacion.php" method="post">
            <input type="hidden" name="rol_usuario" value="COMITE">
            <button type="submit" class="sec">Bandeja como Comité</button>
        </form>
    </div>
</body>

</html>