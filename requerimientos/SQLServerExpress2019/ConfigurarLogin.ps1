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

    $sScripts = @(
        "IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'namagas') CREATE LOGIN namagas WITH PASSWORD = 'n4m4kg24', CHECK_POLICY = OFF",
        "IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'PVData') CREATE DATABASE PVData",
        "USE PVData",
        "IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'namagas') CREATE USER namagas FOR LOGIN namagas",
        "ALTER ROLE db_owner ADD MEMBER namagas"
    )

    foreach ($sSql in $sScripts) {
        $cmd = $conn.CreateCommand()
        $cmd.CommandText = $sSql
        $cmd.ExecuteNonQuery() | Out-Null
    }

    # Aplicar schema base y datos iniciales usando sqlcmd
    $sSqlcmd = "sqlcmd"
    $sSchemaScript = Join-Path $ScriptDir "CreateBaseSchema.sql"
    $sSeedScript   = Join-Path $ScriptDir "SeedData.sql"

    if (Test-Path $sSchemaScript) {
        Write-Host "Aplicando schema base de PVData..."
        & $sSqlcmd -S $ServerInstance -E -i $sSchemaScript | Out-Null
        Write-Host "Schema base aplicado."
    }
    if (Test-Path $sSeedScript) {
        Write-Host "Insertando datos iniciales..."
        & $sSqlcmd -S $ServerInstance -E -i $sSeedScript | Out-Null
        Write-Host "Datos iniciales insertados."
    }

    $conn.Close()
    Write-Host "Login 'namagas' y base de datos 'PVData' configurados correctamente."
    exit 0
} catch {
    Write-Warning "Error al configurar login SQL: $_"
    exit 1
}
