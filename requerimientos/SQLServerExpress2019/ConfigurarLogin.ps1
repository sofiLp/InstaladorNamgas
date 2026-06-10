# Empresa: Namagas / Elemento diseño: Instalador / Objetivo: Crear login namagas en instancia NAMAGAS
# Idempotente — no falla si login/BD/usuario ya existen

$ScriptDir      = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstanceName   = "NAMAGAS"
$ServerInstance = ".\$InstanceName"
$SchemaScript   = Join-Path $ScriptDir "CreateBaseSchema.sql"

Write-Host "Configurando login y base de datos en $ServerInstance..."

# Esperar hasta 30 segundos a que SQL Server esté disponible
$bListo = $false
for ($i = 1; $i -le 10; $i++) {
    try {
        $connTest = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Integrated Security=True;Connect Timeout=3;")
        $connTest.Open()
        $connTest.Close()
        $bListo = $true
        break
    } catch {
        Write-Host "Esperando SQL Server... intento $i/10"
        Start-Sleep -Seconds 3
    }
}

if (-not $bListo) {
    Write-Warning "SQL Server no respondio a tiempo. El login 'namagas' debera crearse manualmente."
    exit 1
}

try {
    $conn = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Integrated Security=True;Connect Timeout=15;")
    $conn.Open()

    # 1. Crear login si no existe
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'namagas') CREATE LOGIN namagas WITH PASSWORD = 'n4m4kg24', CHECK_POLICY = OFF"
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Login 'namagas' verificado."

    # 2. Crear base de datos si no existe
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT COUNT(1) FROM sys.databases WHERE name = 'PVDATANMG'"
    $bExiste = [bool]$cmd.ExecuteScalar()

    if (-not $bExiste) {
        # Intentar adjuntar desde MDF si existen los archivos
        $sMdfSrc = Join-Path (Split-Path $ScriptDir) "PVDATANMG.mdf"
        $sLdfSrc = Join-Path (Split-Path $ScriptDir) "PVDATANMG_log.ldf"

        if ((Test-Path $sMdfSrc) -and (Test-Path $sLdfSrc)) {
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "SELECT CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(260))"
            $sDataDir = $cmd.ExecuteScalar().TrimEnd('\')

            $sMdfDest = Join-Path $sDataDir "PVDATANMG.mdf"
            $sLdfDest = Join-Path $sDataDir "PVDATANMG_log.ldf"
            Copy-Item $sMdfSrc $sMdfDest -Force
            Copy-Item $sLdfSrc $sLdfDest -Force

            Write-Host "Adjuntando PVDATANMG desde archivos MDF..."
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "CREATE DATABASE [PVDATANMG] ON (FILENAME = '$sMdfDest'), (FILENAME = '$sLdfDest') FOR ATTACH"
            $cmd.ExecuteNonQuery() | Out-Null

            foreach ($sRename in @(
                "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData',     NEWNAME = 'PVDATANMG')",
                "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData_log', NEWNAME = 'PVDATANMG_log')"
            )) {
                try {
                    $cmd = $conn.CreateCommand(); $cmd.CommandText = $sRename; $cmd.ExecuteNonQuery() | Out-Null
                } catch {}
            }
        } else {
            # Sin MDF — crear base vacía y aplicar schema
            Write-Host "Sin archivos MDF — creando PVDATANMG vacía..."
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "CREATE DATABASE [PVDATANMG]"
            $cmd.ExecuteNonQuery() | Out-Null
        }
    } else {
        Write-Host "PVDATANMG ya existe, omitiendo creación."
    }

    $conn.Close()

    # 3. Ejecutar CreateBaseSchema.sql para crear/actualizar tablas
    if (Test-Path $SchemaScript) {
        Write-Host "Aplicando schema (CreateBaseSchema.sql)..."
        $sSql = Get-Content $SchemaScript -Raw
        # Ejecutar bloque por bloque separado por GO
        $conn2 = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Database=PVDATANMG;Integrated Security=True;Connect Timeout=15;")
        $conn2.Open()
        foreach ($sBloque in ($sSql -split '\bGO\b')) {
            $sTrimmed = $sBloque.Trim()
            if ($sTrimmed.Length -gt 0 -and $sTrimmed -notmatch '^\s*USE\s+') {
                try {
                    $cmd = $conn2.CreateCommand(); $cmd.CommandText = $sTrimmed; $cmd.ExecuteNonQuery() | Out-Null
                } catch {
                    Write-Warning "Schema block warning (puede ser normal si ya existe): $_"
                }
            }
        }
        $conn2.Close()
        Write-Host "Schema aplicado."
    } else {
        Write-Warning "CreateBaseSchema.sql no encontrado en $SchemaScript"
    }

    # 4. Crear usuario namagas en PVDATANMG con permisos db_owner
    $conn3 = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Database=PVDATANMG;Integrated Security=True;Connect Timeout=15;")
    $conn3.Open()
    foreach ($sSql in @(
        "IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'namagas') CREATE USER namagas FOR LOGIN namagas",
        "ALTER ROLE db_owner ADD MEMBER namagas"
    )) {
        $cmd = $conn3.CreateCommand(); $cmd.CommandText = $sSql; $cmd.ExecuteNonQuery() | Out-Null
    }
    $conn3.Close()

    Write-Host "Login 'namagas' y base de datos 'PVDATANMG' configurados correctamente."
    exit 0

} catch {
    Write-Warning "Error al configurar login SQL: $_"
    exit 1
}
