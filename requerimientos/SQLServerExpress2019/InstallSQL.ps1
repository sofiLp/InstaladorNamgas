# Este script debe ejecutarse como Administrador

# --- Variables de configuraci�n ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$SqlSetupPath = Join-Path $ScriptDir "setup.exe"
$ConfigFilePath = Join-Path $ScriptDir "configuration.ini"
$InstanceName = "NAMAGAS"
$SqlServiceName = "MSSQL`$$InstanceName"  # Nota: escapar el $ en PowerShell
$TcpPort = "1433"

# --- Paso 1: Validar archivos ---
Write-Host "Validando archivos de instalaci�n..."

if (-not (Test-Path $SqlSetupPath)) {
    Write-Error "No se encontr� setup.exe en: $SqlSetupPath"
    exit 1
}
if (-not (Test-Path $ConfigFilePath)) {
    Write-Error "No se encontr� configuration.ini en: $ConfigFilePath"
    exit 1
}

Write-Host "Archivos verificados."

# --- Paso 2: Instalar SQL Server silenciosamente ---
Write-Host "Iniciando instalaci�n silenciosa de SQL Server..."

$proceso = Start-Process -FilePath $SqlSetupPath -ArgumentList "/Q /ACTION=Install /IACCEPTSQLSERVERLICENSETERMS /ConfigurationFile=`"$ConfigFilePath`"" -Wait -NoNewWindow -PassThru

if ($proceso.ExitCode -ne 0) {
    Write-Error "La instalaci�n de SQL Server fall� con c�digo: $($proceso.ExitCode)"
    exit $proceso.ExitCode
}

Write-Host "Instalaci�n completada."

# --- Paso 3: Configurar puerto TCP ---
Write-Host "Configurando puerto TCP a $TcpPort..."

$RegTcpPortPath = "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.$InstanceName\MSSQLServer\SuperSocketNetLib\TCP\IPAll"

try {
    # Asignar puerto fijo y deshabilitar din�mico
    Set-ItemProperty -Path $RegTcpPortPath -Name "TcpPort" -Value $TcpPort
    Set-ItemProperty -Path $RegTcpPortPath -Name "TcpDynamicPorts" -Value ""

    Write-Host "Puerto TCP configurado correctamente."
} catch {
    Write-Warning "No se pudo configurar el puerto TCP: $_"
}

# --- Paso 4: Reiniciar servicio SQL Server ---
Write-Host "Reiniciando servicio SQL Server..."

try {
    Restart-Service -Name $SqlServiceName -Force -ErrorAction Stop
    Write-Host "Servicio SQL Server reiniciado correctamente."
} catch {
    Write-Error "Error al reiniciar el servicio SQL Server: $_"
    exit 1
}

# --- Paso 5: Crear login, base de datos y usuario namagas ---
Write-Host "Configurando login y base de datos para Namagas..."

# Esperar a que SQL Server este completamente disponible (hasta 30 seg)
$ServerInstance = ".\$InstanceName"
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
} else {
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
    } catch {
        Write-Warning "Error al configurar login SQL: $_"
        Write-Warning "El cliente debera crear manualmente el login 'namagas' en la instancia $ServerInstance."
    }
}

Write-Host "Proceso finalizado correctamente."
