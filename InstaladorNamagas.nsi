; ----------------------------------------------------------------------
; Instalador Punto de Venta  �  Versi�n con GUI de SQL�Server y SqlCmdUtils
; ----------------------------------------------------------------------

!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "StrFunc.nsh"
!define MUI_ICON "icono.ico"
!define MUI_UNICON "icono.ico" ; para el icono del desinstalador

; ---------------  CONFIGURACI�N  ---------------
!define APP_NAME            "Namgas"
!define APP_VERSION         "1.0"
!define APP_PUBLISHER       "Namagas"
!define MAIN_INSTALL_FOLDER "NamagasPV"
!define APP_EXE             "App\\ClientePV.exe"

!define SQL_INSTALLER_NAME  "SQLEXPR_x64_ESN.exe"
;!define SQL_CMD_UTILS_MSI   "MsSqlCmdLnUtils.msi"
;!define SQL_SA_PASSWORD     "SAP@ssw0rd123"
;!define SQL_USER            "UsuarioPV"
;!define SQL_PASSWORD        "P@ssw0rd123"

!define DOTNET_INSTALLER_NAME "dotNetF4.7.exe"
!define DOTNET_FRAMEWORK_RELEASE "460798"

!define WEBAPI_SERVICE_NAME "serviceNamagas"
!define WEBAPI_DISPLAY_NAME "serviceNamagas Servicio Web Punto de Venta"
!define WEBAPI_EXE_NAME     "WebApi.exe"
!define SQL_INSTANCE        "NAMAGAS"
!define TEMP_DIR            "$INSTDIR\\Temp"

; --- Conexiones para MigrationTool (PVDATA siempre existe con Windows auth) ---
!define MIGRATION_ORIGEN_CS  "Data Source=(localdb)\\v11.0;Database=PVData;Integrated Security=True;Encrypt=False;TrustServerCertificate=True;"
!define MIGRATION_DESTINO_CS "Data Source=.\\NAMAGAS;Database=PVDataNMG;User Id=namagas;Password=n4m4kg24;Encrypt=False;TrustServerCertificate=True;"


Var SQLInstallSuccess
Var DotNetInstalled
;Var SQLCMD_FOUND_PATH


; ---------------  CONFIG INSTALADOR  ---------------
Name "${APP_NAME}"
OutFile "Instalador_PuntoDeVenta.exe"
InstallDir "$PROGRAMFILES\\${MAIN_INSTALL_FOLDER}"
InstallDirRegKey HKLM "Software\\${APP_NAME}" "Install_Dir"
RequestExecutionLevel admin
ShowInstDetails show
ShowUnInstDetails show
SetCompressor /SOLID lzma

; ---------------  P�GINAS MUI  ---------------
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "Licencia.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "Spanish"




; ---------------  FUNCIONES  ---------------

Function .onInit
  InitPluginsDir
  SetOutPath "$PLUGINSDIR"

  ; Detectar instalación previa en ruta diferente y advertir al usuario
  ReadRegStr $0 HKLM "Software\\${APP_NAME}" "Install_Dir"
  ${If} $0 != ""
  ${AndIf} $0 != $INSTDIR
    MessageBox MB_ICONINFORMATION|MB_OK \
      "Se detectó una instalación previa en:$\n$0$\n$\nLa nueva versión se instalará en:$\n$INSTDIR$\n$\nLos archivos anteriores NO se eliminarán automáticamente.$\nPuede borrarlos manualmente después de verificar que todo funciona."
  ${EndIf}
FunctionEnd

; ---------- Verificar e instalar .NET ----------
Function CheckDotNet
  ReadRegDWORD $0 HKLM "SOFTWARE\\Microsoft\\NET Framework Setup\\NDP\\v4\\Full" "Release"
  ${If} $0 < ${DOTNET_FRAMEWORK_RELEASE}
    StrCpy $DotNetInstalled "false"
  ${Else}
    StrCpy $DotNetInstalled "true"
  ${EndIf}
FunctionEnd

Function InstallDotNet
  ${If} $DotNetInstalled == "false"
    DetailPrint "Instalando .NET Framework 4.7..."
    SetOutPath "${TEMP_DIR}"
    File "requerimientos\\${DOTNET_INSTALLER_NAME}"
    ExecWait '"${TEMP_DIR}\\${DOTNET_INSTALLER_NAME}" /q /norestart' $0
    Delete "${TEMP_DIR}\\${DOTNET_INSTALLER_NAME}"
    ${If} $0 == 0
      DetailPrint ".NET Framework instalado."
    ${Else}
      MessageBox MB_ICONSTOP "Error al instalar .NET Framework (c�d. $0)."
    ${EndIf}
  ${EndIf}
FunctionEnd

; ---------- Instalar SQL Server Express (GUI) ----------
Function InstallSQLServer
  DetailPrint "Verificando si la instancia de SQL Server NAMAGAS ya est� instalada..."

  ;nsExec::Exec 'sc query "MSSQL$${SQL_INSTANCE}"'
  nsExec::Exec 'sc query "MSSQL$$${SQL_INSTANCE}"'

  Pop $0
  ${If} $0 == 0
    DetailPrint "La instancia NAMAGAS ya est� instalada."
    StrCpy $SQLInstallSuccess "true"
    Return
  ${Else}
    DetailPrint "La instancia NAMAGAS no est� instalada. Se proceder� a instalar SQL Server Express..."
  ${EndIf}

  MessageBox MB_ICONINFORMATION|MB_OK "Se instalar� SQL Server Express con la instancia NAMAGAS. Esto puede tardar varios minutos..."

  DetailPrint "Copiando instalador de SQL Server..."
  SetOutPath "${TEMP_DIR}\\SQLServerExpress2019"
  CreateDirectory "${TEMP_DIR}\\SQLServerExpress2019"
  File /r "requerimientos\\SQLServerExpress2019\\*.*"

  DetailPrint "Ejecutando instalaci�n desatendida de SQL Server..."
  nsExec::ExecToLog 'powershell -ExecutionPolicy Bypass -File "${TEMP_DIR}\\SQLServerExpress2019\\InstallSQL.ps1"'
  Pop $0

  ${If} $0 == 0
    DetailPrint "SQL Server instalado correctamente."
    StrCpy $SQLInstallSuccess "true"
  ${Else}
    DetailPrint "Error al instalar SQL Server. C�digo: $0"
    StrCpy $SQLInstallSuccess "false"
    MessageBox MB_ICONSTOP "Error instalando SQL Server:\n\nC�digo: $0"
  ${EndIf}
FunctionEnd





; ---------- Crear BD PVDataNMG (adjuntar MDF + aplicar schema) ----------
Function CreateDatabase
  DetailPrint "Creando base de datos PVDataNMG..."

  ; Detach PVDataNMG si ya existe (libera lock sobre MDF antes de copiarlo)
  CreateDirectory "${TEMP_DIR}"
  SetOutPath "${TEMP_DIR}"
  FileOpen $9 "${TEMP_DIR}\DetachDB.ps1" w
  FileWrite $9 "try {$\n"
  FileWrite $9 "  $$cs = 'Data Source=.\NAMAGAS;Integrated Security=True;Encrypt=False;TrustServerCertificate=True;'$\n"
  FileWrite $9 "  $$conn = New-Object System.Data.SqlClient.SqlConnection($$cs)$\n"
  FileWrite $9 "  $$conn.Open()$\n"
  FileWrite $9 "  $$cmd = $$conn.CreateCommand()$\n"
  FileWrite $9 "  $$cmd.CommandText = $\"IF DB_ID(N'PVDataNMG') IS NOT NULL BEGIN ALTER DATABASE [PVDataNMG] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; EXEC sp_detach_db N'PVDataNMG','true' END$\"$\n"
  FileWrite $9 "  $$cmd.ExecuteNonQuery() | Out-Null$\n"
  FileWrite $9 "  $$conn.Close()$\n"
  FileWrite $9 "} catch { }$\n"
  FileClose $9
  nsExec::ExecToLog 'powershell -NonInteractive -ExecutionPolicy Bypass -File "${TEMP_DIR}\DetachDB.ps1"'
  Pop $0

  ; MDF a ubicación permanente
  CreateDirectory "$INSTDIR\WEBAPI\data"
  SetOutPath "$INSTDIR\WEBAPI\data"
  File "requerimientos\PVDATANMG.mdf"

  ; Schema SQL al temp
  CreateDirectory "${TEMP_DIR}"
  SetOutPath "${TEMP_DIR}"
  File "requerimientos\SQLServerExpress2019\CreateBaseSchema.sql"

  ; Escribir script PowerShell: adjuntar BD + aplicar schema
  FileOpen $9 "${TEMP_DIR}\SetupDB.ps1" w
  FileWrite $9 "$$mdf = '$INSTDIR\WEBAPI\data\PVDATANMG.mdf'$\n"
  FileWrite $9 "$$schemaFile = '$INSTDIR\Temp\CreateBaseSchema.sql'$\n"
  FileWrite $9 "$$dataDir = [System.IO.Path]::GetDirectoryName($$mdf)$\n"
  FileWrite $9 "icacls $\"$$dataDir$\" /grant 'Everyone:(OI)(CI)F' | Out-Null$\n"
  FileWrite $9 "try {$\n"
  FileWrite $9 "  $$csAdmin = 'Data Source=.\NAMAGAS;Integrated Security=True;Encrypt=False;TrustServerCertificate=True;'$\n"
  FileWrite $9 "  $$conn = New-Object System.Data.SqlClient.SqlConnection($$csAdmin)$\n"
  FileWrite $9 "  $$conn.Open()$\n"
  FileWrite $9 "  $$cmd = $$conn.CreateCommand()$\n"
  FileWrite $9 "  $$cmd.CommandText = $\"IF DB_ID(N'PVDataNMG') IS NULL CREATE DATABASE [PVDataNMG] ON (FILENAME=N'$\" + $$mdf + $\"') FOR ATTACH_REBUILD_LOG$\"$\n"
  FileWrite $9 "  $$cmd.ExecuteNonQuery() | Out-Null$\n"
  FileWrite $9 "  $$cmdLogin = $$conn.CreateCommand()$\n"
  FileWrite $9 "  $$cmdLogin.CommandText = $\"IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'namagas') CREATE LOGIN [namagas] WITH PASSWORD = N'n4m4kg24'$\"$\n"
  FileWrite $9 "  $$cmdLogin.ExecuteNonQuery() | Out-Null$\n"
  FileWrite $9 "  $$conn.Close()$\n"
  FileWrite $9 "  $$connPv = New-Object System.Data.SqlClient.SqlConnection($$csAdmin + 'Initial Catalog=PVDataNMG;')$\n"
  FileWrite $9 "  $$connPv.Open()$\n"
  FileWrite $9 "  $$cmdUser = $$connPv.CreateCommand()$\n"
  FileWrite $9 "  $$cmdUser.CommandText = $\"IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'namagas') CREATE USER [namagas] FOR LOGIN [namagas] ELSE ALTER USER [namagas] WITH LOGIN = [namagas]; ALTER ROLE [db_owner] ADD MEMBER [namagas]$\"$\n"
  FileWrite $9 "  $$cmdUser.ExecuteNonQuery() | Out-Null$\n"
  FileWrite $9 "  $$connPv.Close()$\n"
  FileWrite $9 "  Write-Host 'PVDataNMG lista — permisos namagas OK'$\n"
  FileWrite $9 "} catch { Write-Host $\"Error adjuntando BD: $$_$\"; exit 1 }$\n"
  FileWrite $9 "try {$\n"
  FileWrite $9 "  $$csDb = 'Data Source=.\NAMAGAS;Database=PVDataNMG;User Id=namagas;Password=n4m4kg24;Encrypt=False;TrustServerCertificate=True;'$\n"
  FileWrite $9 "  $$conn2 = New-Object System.Data.SqlClient.SqlConnection($$csDb)$\n"
  FileWrite $9 "  $$conn2.Open()$\n"
  FileWrite $9 "  $$content = Get-Content $$schemaFile -Raw$\n"
  FileWrite $9 "  $$batches = $$content -split '(?m)^\s*GO\s*$$'$\n"
  FileWrite $9 "  foreach ($$b in $$batches) {$\n"
  FileWrite $9 "    if ($$b.Trim()) {$\n"
  FileWrite $9 "      $$cmd2 = $$conn2.CreateCommand(); $$cmd2.CommandText = $$b; $$cmd2.CommandTimeout = 300$\n"
  FileWrite $9 "      try { $$cmd2.ExecuteNonQuery() | Out-Null } catch { }$\n"
  FileWrite $9 "    }$\n"
  FileWrite $9 "  }$\n"
  FileWrite $9 "  $$conn2.Close()$\n"
  FileWrite $9 "  Write-Host 'Schema aplicado'$\n"
  FileWrite $9 "} catch { Write-Host $\"Error schema: $$_$\" }$\n"
  FileClose $9

  nsExec::ExecToLog 'powershell -NonInteractive -ExecutionPolicy Bypass -File "${TEMP_DIR}\SetupDB.ps1"'
  Pop $0
  DetailPrint "CreateDatabase exit: $0"
FunctionEnd

; ---------- Migrar PVDATA → PVDATANMG (omite si pvOrigen no existe) ----------
Function RunMigrationTool
  DetailPrint "Ejecutando MigrationTool (migración de datos si aplica)..."

  CreateDirectory "${TEMP_DIR}\MigrationTool"
  SetOutPath "${TEMP_DIR}\MigrationTool"
  File "MigrationTool\MigrationTool.exe"
  File "MigrationTool\Microsoft.Data.SqlClient.SNI.dll"

  ; Escribir appsettings.json con las conexiones
  FileOpen $9 "${TEMP_DIR}\MigrationTool\appsettings.json" w
  FileWrite $9 '{$\n'
  FileWrite $9 '  "ConnectionStrings": {$\n'
  FileWrite $9 '    "pvOrigen":      "${MIGRATION_ORIGEN_CS}",$\n'
  FileWrite $9 '    "pvconnectionc": "${MIGRATION_DESTINO_CS}"$\n'
  FileWrite $9 '  }$\n'
  FileWrite $9 '}$\n'
  FileClose $9

  nsExec::ExecToLog '"${TEMP_DIR}\MigrationTool\MigrationTool.exe" --silent'
  Pop $0
  DetailPrint "MigrationTool exit code: $0"
  ${If} $0 == 0
    DetailPrint "Setup y migración completados."
  ${Else}
    DetailPrint "MigrationTool finalizó con código $0 — revise migration.log en $INSTDIR\WEBAPI"
  ${EndIf}

  ; Copiar log para diagnóstico y limpiar herramienta
  CreateDirectory "$INSTDIR\WEBAPI"
  CopyFiles "${TEMP_DIR}\MigrationTool\migration.log" "$INSTDIR\WEBAPI\migration.log"
  RMDir /r "${TEMP_DIR}\MigrationTool"
FunctionEnd

; ---------- Instalar servicio WebAPI ----------
Function InstallWindowsService
  DetailPrint "Instalando servicio WebAPI..."
  CreateDirectory "$INSTDIR\\WEBAPI"

  ; Detener y eliminar servicio existente antes de copiar archivos
  nsExec::ExecToLog 'sc query "${WEBAPI_SERVICE_NAME}"'
  Pop $0
  ${If} $0 == 0
    nsExec::ExecToLog 'sc stop "${WEBAPI_SERVICE_NAME}"'
    Sleep 2000
    nsExec::ExecToLog 'sc delete "${WEBAPI_SERVICE_NAME}"'
  ${EndIf}

  ; Preservar appsettings.json si ya existe (reinstalación en equipo configurado)
  IfFileExists "$INSTDIR\\WEBAPI\\appsettings.json" appsettings_existe appsettings_nuevo
  appsettings_existe:
    DetailPrint "appsettings.json existente preservado (configuración de BD del equipo)"
    Goto copiar_webapi
  appsettings_nuevo:
    DetailPrint "Instalación nueva — copiando appsettings.json por defecto"
  copiar_webapi:

  SetOutPath "$INSTDIR\\WEBAPI"
  ; Copiar todos los archivos excepto appsettings.json (ya manejado arriba), debug symbols y dev config
  File /r /x "appsettings.json" /x "appsettings.Development.json" /x "*.pdb" "WEBAPI\\*.*"

  ; Solo copiar appsettings.json si no existía
  IfFileExists "$INSTDIR\\WEBAPI\\appsettings.json" 0 copiar_appsettings
    Goto appsettings_listo
  copiar_appsettings:
    File "WEBAPI\\appsettings.json"
  appsettings_listo:

  nsExec::ExecToLog 'sc create "${WEBAPI_SERVICE_NAME}" binPath= "\"$INSTDIR\\WEBAPI\\${WEBAPI_EXE_NAME}\"" DisplayName= "${WEBAPI_DISPLAY_NAME}" start= auto'
  Pop $0
  ${If} $0 == 0
    nsExec::ExecToLog 'sc start "${WEBAPI_SERVICE_NAME}"'
  ${EndIf}
FunctionEnd

Function AgregarReglaSalidaCliente
  DetailPrint "Verificando regla de firewall para ClientePV.exe (salida)"
  ExecWait 'netsh advfirewall firewall show rule name="ClientePV - Salida SignalR"' $0
  ${If} $0 != 0
    DetailPrint "Agregando regla de salida para ClientePV.exe"
    ExecWait 'netsh advfirewall firewall add rule name="ClientePV - Salida SignalR" dir=out action=allow program="$INSTDIR\\App\\ClientePV.exe" enable=yes profile=any'
  ${Else}
    DetailPrint "La regla de salida ya existe"
  ${EndIf}
FunctionEnd

Function AgregarReglaSQLServer
  DetailPrint "Verificando regla de firewall para SQL Server puerto 1433 (entrada)"
  ExecWait 'netsh advfirewall firewall show rule name="SQL Server NAMAGAS - Entrada"' $0
  ${If} $0 != 0
    DetailPrint "Agregando regla de entrada para SQL Server puerto 1433"
    ExecWait 'netsh advfirewall firewall add rule name="SQL Server NAMAGAS - Entrada" dir=in action=allow protocol=TCP localport=1433 enable=yes profile=any'
  ${Else}
    DetailPrint "La regla de SQL Server ya existe"
  ${EndIf}
FunctionEnd


; ---------------  SECCI�N PRINCIPAL  ---------------
Section "Instalaci�n principal"
  CreateDirectory "${TEMP_DIR}"

  Call CheckDotNet
  Call InstallDotNet
  Call InstallSQLServer
  ;Call InstallSqlCmdUtils
; Call EjecutarConfiguradorSQL

  Call CreateDatabase
  Call RunMigrationTool

  ; Copiar aplicaci�n
  SetOutPath "$INSTDIR\\App"
  File /r "App\\*.*"

  ; Servicio
  Call InstallWindowsService

  ; Accesos directos
  CreateDirectory "$SMPROGRAMS\\${APP_NAME}"
  CreateShortcut "$SMPROGRAMS\\${APP_NAME}\\${APP_NAME}.lnk" "$INSTDIR\\${APP_EXE}"
  CreateShortcut "$DESKTOP\\${APP_NAME}.lnk" "$INSTDIR\\${APP_EXE}"

  ; Desinstalador
  WriteUninstaller "$INSTDIR\\uninstall.exe"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "UninstallString" '"$INSTDIR\\uninstall.exe"'
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "Publisher" "${APP_PUBLISHER}"
  WriteRegStr HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}" "InstallLocation" "$INSTDIR"

  ; Guardar ruta de instalación para que futuras reinstalaciones la detecten
  WriteRegStr HKLM "Software\\${APP_NAME}" "Install_Dir" "$INSTDIR"
SectionEnd

Section "Firewall Rules"
  Call AgregarReglaSalidaCliente
  Call AgregarReglaSQLServer
SectionEnd

; ---------------  DESINSTALACI�N  ---------------
Section "Uninstall"
  nsExec::ExecToLog 'sc stop "${WEBAPI_SERVICE_NAME}"'
  Sleep 2000
  nsExec::ExecToLog 'sc delete "${WEBAPI_SERVICE_NAME}"'

  Delete "$INSTDIR\\uninstall.exe"
  RMDir /r "$INSTDIR"

  Delete "$SMPROGRAMS\\${APP_NAME}\\*.*"
  RMDir "$SMPROGRAMS\\${APP_NAME}"
  Delete "$DESKTOP\\${APP_NAME}.lnk"

  DeleteRegKey HKLM "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\${APP_NAME}"
  DeleteRegKey HKLM "Software\\${APP_NAME}"
SectionEnd

