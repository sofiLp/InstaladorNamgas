# Empresa: Namagas / Elemento diseño: Instalador / Objetivo: Crear login namagas en instancia NAMAGAS
# Idempotente — no falla si login/BD/usuario ya existen

$ScriptDir      = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstanceName   = "NAMAGAS"
$ServerInstance = ".\$InstanceName"
$SchemaScript   = Join-Path $ScriptDir "CreateBaseSchema.sql"
$LogFile        = Join-Path (Split-Path $ScriptDir) "configurar_login.log"

function Log($msg) {
    $line = "[$(Get-Date -Format 'HH:mm:ss')] $msg"
    Write-Host $line
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}

Log "=== ConfigurarLogin.ps1 iniciado ==="
Log "ScriptDir: $ScriptDir"
Log "ServerInstance: $ServerInstance"

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
    Log "ERROR: SQL Server no respondio a tiempo en $ServerInstance. Verifique que el servicio MSSQL`$NAMAGAS este activo."
    exit 1
}

try {
    $conn = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Integrated Security=True;Connect Timeout=15;")
    $conn.Open()

    # 1. Crear login si no existe
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'namagas') CREATE LOGIN namagas WITH PASSWORD = 'n4m4kg24', CHECK_POLICY = OFF"
    $cmd.ExecuteNonQuery() | Out-Null
    Log "Login 'namagas' verificado."

    # 2. Crear base de datos si no existe
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "SELECT COUNT(1) FROM sys.databases WHERE name = 'PVDATANMG'"
    $bExiste = [bool]$cmd.ExecuteScalar()

    if (-not $bExiste) {
        $sMdfSrc = Join-Path (Split-Path $ScriptDir) "PVDATANMG.mdf"
        $sLdfSrc = Join-Path (Split-Path $ScriptDir) "PVDATANMG_log.ldf"
        Log "Buscando MDF en: $sMdfSrc"

        if ((Test-Path $sMdfSrc) -and (Test-Path $sLdfSrc)) {
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "SELECT CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(260))"
            $sDataDir = $cmd.ExecuteScalar().TrimEnd('\')
            Log "Directorio de datos SQL: $sDataDir"

            $sMdfDest = Join-Path $sDataDir "PVDATANMG.mdf"
            $sLdfDest = Join-Path $sDataDir "PVDATANMG_log.ldf"
            Copy-Item $sMdfSrc $sMdfDest -Force
            Copy-Item $sLdfSrc $sLdfDest -Force
            Log "MDF/LDF copiados a $sDataDir"

            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "CREATE DATABASE [PVDATANMG] ON (FILENAME = '$sMdfDest'), (FILENAME = '$sLdfDest') FOR ATTACH"
            $cmd.ExecuteNonQuery() | Out-Null
            Log "PVDATANMG adjuntada desde MDF."

            foreach ($sRename in @(
                "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData',     NEWNAME = 'PVDATANMG')",
                "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData_log', NEWNAME = 'PVDATANMG_log')"
            )) {
                try {
                    $cmd = $conn.CreateCommand(); $cmd.CommandText = $sRename; $cmd.ExecuteNonQuery() | Out-Null
                } catch {}
            }
        } else {
            Log "Sin archivos MDF — creando PVDATANMG vacia..."
            $cmd = $conn.CreateCommand()
            $cmd.CommandText = "CREATE DATABASE [PVDATANMG]"
            $cmd.ExecuteNonQuery() | Out-Null
            Log "PVDATANMG creada (vacia)."
        }
    } else {
        Log "PVDATANMG ya existe, omitiendo creacion."
    }

    $conn.Close()

    # 3. Ejecutar CreateBaseSchema.sql para crear/actualizar tablas
    if (Test-Path $SchemaScript) {
        Log "Aplicando schema (CreateBaseSchema.sql)..."
        $sSql = Get-Content $SchemaScript -Raw
        $conn2 = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Database=PVDATANMG;Integrated Security=True;Connect Timeout=15;")
        $conn2.Open()
        foreach ($sBloque in ($sSql -split '\bGO\b')) {
            $sTrimmed = $sBloque.Trim()
            if ($sTrimmed.Length -gt 0 -and $sTrimmed -notmatch '^\s*USE\s+') {
                try {
                    $cmd = $conn2.CreateCommand(); $cmd.CommandText = $sTrimmed; $cmd.ExecuteNonQuery() | Out-Null
                } catch {
                    Log "WARN schema: $_"
                }
            }
        }
        $conn2.Close()
        Log "Schema aplicado."
    } else {
        Log "WARN: CreateBaseSchema.sql no encontrado en $SchemaScript"
    }

    # 4. Crear usuario namagas en PVDATANMG con permisos db_owner
    $conn3 = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Database=PVDATANMG;Integrated Security=True;Connect Timeout=15;")
    $conn3.Open()
    foreach ($sSqlU in @(
        "IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'namagas') CREATE USER namagas FOR LOGIN namagas",
        "ALTER ROLE db_owner ADD MEMBER namagas"
    )) {
        $cmd = $conn3.CreateCommand(); $cmd.CommandText = $sSqlU; $cmd.ExecuteNonQuery() | Out-Null
    }
    $conn3.Close()

    Log "Login 'namagas' y base de datos 'PVDATANMG' configurados correctamente."
    exit 0

} catch {
    Log "ERROR: $_"
    exit 1
}
