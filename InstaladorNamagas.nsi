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

!define WEBAPI_SERVICE_NAME "ApiNAMAGAS"
!define WEBAPI_DISPLAY_NAME "ApiNAMAGAS Servicio Web Punto de Venta"
!define WEBAPI_EXE_NAME     "WebApi.exe"
!define SQL_INSTANCE "NAMAGAS"
!define TEMP_DIR "$INSTDIR\\Temp"


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
    DetailPrint "Configurando login y base de datos PVDATANMG..."
    SetOutPath "${TEMP_DIR}"
    File "requerimientos\\PVDATANMG.mdf"
    File "requerimientos\\PVDATANMG_log.ldf"
    SetOutPath "${TEMP_DIR}\\SQLServerExpress2019"
    CreateDirectory "${TEMP_DIR}\\SQLServerExpress2019"
    File "requerimientos\\SQLServerExpress2019\\ConfigurarLogin.ps1"
    File "requerimientos\\SQLServerExpress2019\\CreateBaseSchema.sql"
    File "requerimientos\\SQLServerExpress2019\\SeedData.sql"
    nsExec::ExecToLog 'powershell -ExecutionPolicy Bypass -File "${TEMP_DIR}\\SQLServerExpress2019\\ConfigurarLogin.ps1"'
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
  nsExec::ExecToLog 'powershell -ExecutionPolicy Bypass -File "$INSTDIR\\Temp\\SQLServerExpress2019\\InstallSQL.ps1"'
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





; ---------- Instalar servicio WebAPI ----------
Function InstallWindowsService
  DetailPrint "Instalando servicio WebAPI..."
  CreateDirectory "$INSTDIR\\WEBAPI"
  SetOutPath "$INSTDIR\\WEBAPI"
  File /r "WEBAPI\\*.*"

  nsExec::ExecToLog 'sc query "${WEBAPI_SERVICE_NAME}"'
  Pop $0
  ${If} $0 == 0
    nsExec::ExecToLog 'sc stop "${WEBAPI_SERVICE_NAME}"'
    Sleep 2000
    nsExec::ExecToLog 'sc delete "${WEBAPI_SERVICE_NAME}"'
  ${EndIf}

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

