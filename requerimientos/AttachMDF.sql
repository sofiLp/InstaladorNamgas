-- Ejecutar en SSMS como sa / Windows Auth admin
-- ANTES: copiar PVDATANMG.mdf a C:\Program Files (x86)\NamagasPV\WEBAPI\data\

-- Paso 1: Eliminar la entrada huérfana (Recovery Pending sin archivo)
IF DB_ID('PVDataNMG') IS NOT NULL
    DROP DATABASE [PVDataNMG]
GO

-- Paso 2: Dar permisos al servicio SQL Server sobre el directorio
EXEC sp_configure 'show advanced options', 1; RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1; RECONFIGURE;
GO
EXEC xp_cmdshell 'icacls "C:\Program Files (x86)\NamagasPV\WEBAPI\data" /grant "NT Service\MSSQL$NAMAGAS:(OI)(CI)F" /T'
GO

-- Paso 3: Adjuntar MDF y crear nuevo log automáticamente
CREATE DATABASE [PVDataNMG]
ON (FILENAME = N'C:\Program Files (x86)\NamagasPV\WEBAPI\data\PVDATANMG.mdf')
FOR ATTACH_REBUILD_LOG
GO

-- Paso 4: Verificar
SELECT name, state_desc FROM sys.databases WHERE name = 'PVDataNMG'
GO

-- Paso 5: Permisos namagas
USE [master]
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'namagas')
    CREATE LOGIN [namagas] WITH PASSWORD = N'n4m4kg24', CHECK_POLICY=OFF, CHECK_EXPIRATION=OFF
GO

USE [PVDataNMG]
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'namagas')
    CREATE USER [namagas] FOR LOGIN [namagas]
ELSE
    ALTER USER [namagas] WITH LOGIN = [namagas]

ALTER ROLE [db_owner] ADD MEMBER [namagas]
PRINT 'Listo. PVDataNMG online con namagas como db_owner.'
GO
