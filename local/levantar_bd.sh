set -e
export MSYS_NO_PATHCONV=1

PASS='Ubb.Perfec2026'
SQLCMD='/opt/mssql-tools/bin/sqlcmd -I'
CONT='perfeccionamiento-mssql'

echo "==> Levantando SQL Server..."
docker compose up -d mssql

echo "==> Esperando a que SQL Server esté listo..."
for i in $(seq 1 30); do
    if docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -Q "SELECT 1" -b > /dev/null 2>&1; then
        echo "    Listo."
        break
    fi
    if [ "$i" -eq 30 ]; then
        echo "ERROR: SQL Server no respondió. Revisa: docker logs $CONT"
        exit 1
    fi
    sleep 3
done

echo "==> 00: Creando bases de datos..."
docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -i /db/00_bases.sql -b

echo "==> 01: Ejecutando esquema del módulo..."
docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -d Perfeccionamiento -i /db/01_esquema.sql -b

echo "==> 02: Creando mock de Vra..."
docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -i /db/02_vra.sql -b

echo "==> 03: Cargando seeds..."
docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -i /db/03_seed.sql -b

echo ""
echo "==> Verificación:"
docker exec $CONT $SQLCMD -S localhost -U sa -P "$PASS" -d Perfeccionamiento \
    -Q "SELECT s.sol_folio, a.aca_nombres + ' ' + a.aca_apellido_paterno AS academico, e.tes_descripcion AS estado FROM dbo.SOLICITUD s JOIN dbo.ACADEMICO a ON a.aca_rut = s.aca_rut JOIN dbo.TIPO_ESTADO e ON e.tes_codigo = s.tes_codigo"

echo ""
echo "Base de datos local lista. Conexión desde PHP: host=mssql, base=Perfeccionamiento, usuario=sa"
