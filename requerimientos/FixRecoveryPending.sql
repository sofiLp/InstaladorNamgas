-- ============================================================
-- Fix: PVDataNMG en Recovery Pending
-- Ejecutar en SSMS como sa o Windows Auth admin
-- ============================================================

-- Paso 1: Verificar ruta del MDF
SELECT name, physical_name, state_desc
FROM sys.master_files
WHERE DB_NAME(database_id) = 'PVDataNMG'
GO

-- Paso 2: Forzar modo EMERGENCY para poder manipular la BD
ALTER DATABASE [PVDataNMG] SET EMERGENCY
GO

-- Paso 3: Single user para operaciones exclusivas
ALTER DATABASE [PVDataNMG] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

-- Paso 4: Detach limpio
EXEC sp_detach_db N'PVDataNMG', 'true'
GO

-- Paso 5: Dar permisos al servicio SQL Server sobre el directorio de datos
-- (reemplaza la ruta si el MDF está en otro lugar)
EXEC xp_cmdshell 'icacls "C:\Program Files (x86)\NamagasPV\WEBAPI\data" /grant "NT Service\MSSQL$NAMAGAS:(OI)(CI)F" /T'
GO

-- Paso 6: Re-adjuntar creando nuevo log automáticamente
CREATE DATABASE [PVDataNMG]
ON (FILENAME = N'C:\Program Files (x86)\NamagasPV\WEBAPI\data\PVDATANMG.mdf')
FOR ATTACH_REBUILD_LOG
GO

-- Paso 7: Verificar que quedó ONLINE
SELECT name, state_desc FROM sys.databases WHERE name = 'PVDataNMG'
GO

PRINT 'PVDataNMG recuperada correctamente.'
GO
