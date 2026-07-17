# Perfeccionamiento Académico — UBB

Módulo de la Intranet 8.4 de la Universidad del Bío-Bío para gestionar el
ciclo completo de solicitudes de perfeccionamiento académico: creación y
adjunto de documentos, envío con folio correlativo, revisión por
Director / Decano / Comité (aprobar, rechazar u observar con motivo),
historial trazable por etapa y generación automática de la Ficha de
Postulación en PDF.

> El entorno Docker incluido está orientado a desarrollo y evaluación
> local. La sesión de usuario, la base de datos y las credenciales que
> trae son un mock aislado, no representan la autenticación ni la base
> de datos institucional real. Al integrar el módulo en la intranet, la
> carpeta `local/` y el mock de `config/bootstrap.php` se reemplazan por
> el bootstrap real, que ya provee `$web`, `$db` y `$smarty` desde el
> contexto completo de la intranet.

## Componentes

| Componente | Tecnología | Responsabilidad |
| --- | --- | --- |
| `web` | Apache 2.4, PHP 7.4/8.2, Smarty 4 | Vistas, lógica de negocio, generación de PDF (mPDF). |
| `mssql` (Docker) | SQL Server 2017 | Esquema institucional, catálogos y datos semilla. |
| `db-init` (Docker) | sqlcmd | Carga el esquema, el mock y el seed al arrancar; se ejecuta una vez y termina. |
| SQL Server nativo (servidor institucional) | SQL Server 2019 | Mismo rol que `mssql`, fuera de Docker. |

## Funcionalidades

- Registro y edición de solicitudes con validación de campos obligatorios.
- Adjunto de documentos por tipo, con bloqueo automático al enviar.
- Envío con folio correlativo anual (`PA-AAAA-NNN`) y generación de la
  Ficha de Postulación en PDF.
- Bandeja de revisión con filtros; aprobar, rechazar u observar con
  motivo obligatorio (excepto aprobar).
- Avance de etapa según el rol de quien revisa (Director → Facultad →
  Comité → Aprobado).
- Historial por solicitud: fecha, etapa, responsable y observación de
  cada evento.
- Ciclo de corrección: una solicitud observada puede editarse y
  reenviarse conservando el mismo folio.
- Simulador de sesión y de roles (`usuario.php`) para desarrollo local
  sin depender de la intranet real.

## Desarrollo local

### Requisitos

- Docker Desktop.

### 1. Clonar y levantar

```bash
git clone https://github.com/CrissJAe/MVP-Perfeccionamiento.git
cd MVP-Perfeccionamiento
docker compose up
```

`docker compose up` hace todo automáticamente: levanta SQL Server y
espera a que esté sano, carga el esquema completo y los datos semilla
(reinicia limpio en cada arranque, para partir siempre de un estado
conocido), instala las dependencias de Composer dentro del contenedor
si no existen, y levanta Apache/PHP. El primer arranque tarda varios
minutos por el build de la imagen; los siguientes son casi inmediatos.

### 2. Elegir un usuario de prueba

Abre <http://localhost/usuario.php> y selecciona un usuario académico
o el usuario de gestión, para simular Director, Decano o Comité.

## Datos de demostración

El seed carga académicos y solicitudes en distintos estados. Las
credenciales son solo para el mock local:

```text
Académicos
Andrea Paz Soto Riquelme    — RUT 15111222 — tiene un borrador listo para enviar
Rodrigo Andrés Fuentes Molina — RUT 14222333 — solicitud PA-2026-001 enviada
María José Carrasco Vidal   — RUT 16333444 — solicitud PA-2026-002 observada

Usuario de gestión (Director / Decano / Comité)
Revisor Demo Gestión — RUT 11000111
```

No hay contraseña real, el mock autentica solo con el RUT elegido.

## Variables de entorno

| Ubicación | Variables principales |
| --- | --- |
| `docker-compose.override.yml` | `DB_HOST=mssql` (sobrescribe el default para que el contenedor `web` hable con `mssql` en vez de `localhost`). |
| `config/bootstrap.php` (valores por defecto si no hay entorno) | `DB_HOST` (`localhost`), `DB_PORT` (`1433`), `DB_NAME` (`Perfeccionamiento`), `DB_USER` (`sa`), `DB_PASS`. |

Los defaults están pensados para que un `git clone` limpio en el
servidor institucional funcione sin configuración adicional.

## Despliegue en servidor institucional

El servidor de staging no admite Docker-in-Docker — el módulo corre
nativo sobre PHP 7.4, con SQL Server 2019 y Apache ya configurados por
fuera de este repo (vhost con `DocumentRoot` apuntando a la carpeta del
proyecto, más un `Alias /perfeccionamiento` hacia la misma carpeta,
porque los templates usan rutas con ese prefijo).

```bash
cd /var/www
git clone https://github.com/CrissJAe/MVP-Perfeccionamiento.git perfeccionamiento
chown -R www-data:www-data /var/www/perfeccionamiento
cd perfeccionamiento
mkdir -p documentos/perfeccionamiento_academico/solicitudes storage/sessions storage/cache storage/templates_c
chown -R www-data:www-data documentos storage
composer install --no-dev --optimize-autoloader
```

`--no-dev` omite `symfony/var-dumper` (solo se usa para depurar el mock
local; en el servidor, la clase `DatabasePDO` real recibe `dump()`
desde el `vendor/` raíz de la intranet completa).

Para cargar o actualizar el esquema y los datos de prueba:

```bash
bash local/levantar_bd_servidor.sh
```

No usar las credenciales por defecto de `DB_PASS` ni el mock de sesión
fuera de un entorno de desarrollo o staging controlado.

## Verificación disponible

```bash
composer validate
docker compose config
```

Aún no hay una suite de pruebas automatizadas (PHPUnit) — pendiente
fuera del alcance del MVP actual, junto con Renovación, Cierre de
patrocinio y Reportes.