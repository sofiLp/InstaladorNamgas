-- Ejecutar en SQL Server de la sucursal como administrador (sa o Windows auth)
-- Crea login namagas, repara usuario huérfano y da permisos db_owner

USE [master]
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = N'namagas')
BEGIN
    CREATE LOGIN [namagas] WITH PASSWORD = N'n4m4kg24',
        CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
    PRINT 'Login namagas creado.'
END
ELSE
    PRINT 'Login namagas ya existe.'
GO

USE [PVDataNMG]
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'namagas')
BEGIN
    CREATE USER [namagas] FOR LOGIN [namagas]
    PRINT 'Usuario namagas creado.'
END
ELSE
BEGIN
    -- Reparar usuario huérfano (SID no coincide con login)
    ALTER USER [namagas] WITH LOGIN = [namagas]
    PRINT 'Usuario namagas vinculado al login.'
END

ALTER ROLE [db_owner] ADD MEMBER [namagas]
PRINT 'Permisos db_owner asignados a namagas. Listo.'
GO
