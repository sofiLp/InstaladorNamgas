# Empresa: Namagas / Elemento diseño: Instalador / Objetivo: Crear login namagas en instancia NAMAGAS
# Idempotente — no falla si login/BD/usuario ya existen

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$InstanceName = "NAMAGAS"
$ServerInstance = ".\$InstanceName"

Write-Host "Configurando login y base de datos en $ServerInstance..."

# Esperar hasta 30 segundos a que SQL Server este disponible
$iMaxIntentos = 10
$bListo = $false
for ($i = 1; $i -le $iMaxIntentos; $i++) {
    try {
        Add-Type -AssemblyName "System.Data"
        $connTest = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Integrated Security=True;Connect Timeout=3;")
        $connTest.Open()
        $connTest.Close()
        $bListo = $true
        break
    } catch {
        Write-Host "Esperando SQL Server... intento $i/$iMaxIntentos"
        Start-Sleep -Seconds 3
    }
}

if (-not $bListo) {
    Write-Warning "SQL Server no respondio a tiempo. El login 'namagas' debera crearse manualmente."
    exit 1
}

try {
    Add-Type -AssemblyName "System.Data"
    $conn = New-Object System.Data.SqlClient.SqlConnection("Server=$ServerInstance;Integrated Security=True;Connect Timeout=15;")
    $conn.Open()

    # Crear login si no existe
    $cmdLogin = $conn.CreateCommand()
    $cmdLogin.CommandText = "IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'namagas') CREATE LOGIN namagas WITH PASSWORD = 'n4m4kg24', CHECK_POLICY = OFF"
    $cmdLogin.ExecuteNonQuery() | Out-Null

    # Adjuntar BD desde archivos MDF/LDF si no existe
    if (-not ($conn.CreateCommand() | ForEach-Object { $_.CommandText = "SELECT COUNT(1) FROM sys.databases WHERE name = 'PVDATANMG'"; $_.ExecuteScalar() })) {
        $cmdDataDir = $conn.CreateCommand()
        $cmdDataDir.CommandText = "SELECT CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(260))"
        $sSqlDataDir = $cmdDataDir.ExecuteScalar().TrimEnd('\')

        $sTempDir    = Split-Path $ScriptDir
        $sMdfSrc     = Join-Path $sTempDir "PVDATANMG.mdf"
        $sLdfSrc     = Join-Path $sTempDir "PVDATANMG_log.ldf"
        $sMdfDest    = Join-Path $sSqlDataDir "PVDATANMG.mdf"
        $sLdfDest    = Join-Path $sSqlDataDir "PVDATANMG_log.ldf"

        Write-Host "Copiando archivos de base de datos a $sSqlDataDir..."
        Copy-Item $sMdfSrc $sMdfDest -Force
        Copy-Item $sLdfSrc $sLdfDest -Force

        Write-Host "Adjuntando base de datos PVDATANMG..."
        $cmdAttach = $conn.CreateCommand()
        $cmdAttach.CommandText = "CREATE DATABASE [PVDATANMG] ON (FILENAME = '$sMdfDest'), (FILENAME = '$sLdfDest') FOR ATTACH"
        $cmdAttach.ExecuteNonQuery() | Out-Null

        # Renombrar nombres logicos internos de PVData → PVDATANMG
        $cmdRename = $conn.CreateCommand()
        $cmdRename.CommandText = "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData', NEWNAME = 'PVDATANMG')"
        try { $cmdRename.ExecuteNonQuery() | Out-Null } catch {}
        $cmdRename.CommandText = "ALTER DATABASE [PVDATANMG] MODIFY FILE (NAME = 'PVData_log', NEWNAME = 'PVDATANMG_log')"
        try { $cmdRename.ExecuteNonQuery() | Out-Null } catch {}
    } else {
        Write-Host "La base de datos PVDATANMG ya existe, omitiendo adjuntar."
    }

    # Crear usuario en BD si no existe
    $sScripts = @(
        "USE PVDATANMG",
        "IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'namagas') CREATE USER namagas FOR LOGIN namagas",
        "ALTER ROLE db_owner ADD MEMBER namagas"
    )
    foreach ($sSql in $sScripts) {
        $cmd = $conn.CreateCommand()
        $cmd.CommandText = $sSql
        $cmd.ExecuteNonQuery() | Out-Null
    }

    $conn.Close()
    Write-Host "Login 'namagas' y base de datos 'PVDATANMG' configurados correctamente."
    exit 0
} catch {
    Write-Warning "Error al configurar login SQL: $_"
    exit 1
}
