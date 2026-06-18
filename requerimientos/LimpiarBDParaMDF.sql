-- ============================================================
-- LimpiarBDParaMDF.sql
-- Prepara PVDataNMG para ser usada como MDF del instalador.
-- Elimina datos de transacciones y configuración específica.
-- Conserva catálogos y configuración general.
-- ============================================================
USE [PVDataNMG]
GO

-- ============================================================
-- 1. DESACTIVAR CONSTRAINTS TEMPORALMENTE
-- ============================================================
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO

-- ============================================================
-- 2. TRANSACCIONES DE VENTA
-- ============================================================
DELETE FROM [venta_descuento_producto]
DELETE FROM [venta_cancelada]
DELETE FROM [venta_pago]
DELETE FROM [venta_producto]
DELETE FROM [venta]
GO

-- ============================================================
-- 3. CAJA Y MOVIMIENTOS
-- ============================================================
DELETE FROM [caja_movimiento]
DELETE FROM [caja_operacion]
DELETE FROM [Info_Corte_Caja]
DELETE FROM [info_Cierre_dia]
DELETE FROM [Movimiento_Efectivo]
GO

-- ============================================================
-- 4. TRANSFERENCIAS
-- ============================================================
DELETE FROM [Transferencia_Detalle]
DELETE FROM [Transferencia]
GO

-- ============================================================
-- 5. INVENTARIO (resetear existencias, conservar filas por producto)
-- ============================================================
UPDATE [inventario]
SET existencia = 0,
    apartado = 0,
    precio_compra = 0,
    precio_venta = 0
GO

DELETE FROM [inventario_log]
DELETE FROM [Inventario_Fisico_Completo]
DELETE FROM [movimiento_Inventario]
DELETE FROM [Log_InventarioOperaciones]
GO

-- ============================================================
-- 6. AJUSTES DE INVENTARIO
-- ============================================================
DELETE FROM [Ajuste_Inventario_Detalle_Log]
DELETE FROM [Ajuste_Inventario_Detalle]
DELETE FROM [Ajuste_Inventario_Log]
DELETE FROM [Ajuste_Inventario]
GO

-- ============================================================
-- 7. EMPRESA Y SUCURSAL (limpiar datos del dev — la sucursal llena los suyos)
-- ============================================================
DELETE FROM [empresa]
DELETE FROM [sucursal]
DELETE FROM [Catalogo_Sucursal]
GO

-- ============================================================
-- 8. CLIENTES (borrar datos personales del dev)
-- ============================================================
DELETE FROM [cliente]
GO

-- ============================================================
-- 9. LOGS Y TRANSMISIÓN
-- ============================================================
DELETE FROM [ControlTransmision]
DELETE FROM [Log_Error]
DELETE FROM [log_usuario]
DELETE FROM [log_producto]
DELETE FROM [log_producto_imagen]
DELETE FROM [Log_Catalogo_Operacion]

-- Tabla de registro de instalación (nueva instalación = nuevo registro)
DELETE FROM [RegistroInstalacionPV]
GO

-- ============================================================
-- 10. ÓRDENES DE COMPRA (si existen del dev)
-- ============================================================
IF OBJECT_ID('Ci_Orden_Compra_Producto', 'U') IS NOT NULL
    DELETE FROM [Ci_Orden_Compra_Producto]
IF OBJECT_ID('Ci_Orden_Compra', 'U') IS NOT NULL
    DELETE FROM [Ci_Orden_Compra]
GO

-- ============================================================
-- 11. ML (predicciones — se regeneran por sucursal)
-- ============================================================
IF OBJECT_ID('MLAlerta', 'U') IS NOT NULL           DELETE FROM [MLAlerta]
IF OBJECT_ID('MLHistorico_Cambios', 'U') IS NOT NULL DELETE FROM [MLHistorico_Cambios]
IF OBJECT_ID('MLMetricas_Analisis', 'U') IS NOT NULL DELETE FROM [MLMetricas_Analisis]
IF OBJECT_ID('MLRecomendacion_Especifica', 'U') IS NOT NULL DELETE FROM [MLRecomendacion_Especifica]
IF OBJECT_ID('MLAnalisis_Recomendaciones', 'U') IS NOT NULL DELETE FROM [MLAnalisis_Recomendaciones]
IF OBJECT_ID('ML_Predicciones_Cache', 'U') IS NOT NULL DELETE FROM [ML_Predicciones_Cache]
IF OBJECT_ID('ML_Resultado_Prediccion', 'U') IS NOT NULL DELETE FROM [ML_Resultado_Prediccion]
IF OBJECT_ID('MLModelos', 'U') IS NOT NULL          DELETE FROM [MLModelos]
IF OBJECT_ID('MLProgramacionEntrenamiento', 'U') IS NOT NULL DELETE FROM [MLProgramacionEntrenamiento]
GO

-- ============================================================
-- 12. FACTURACIÓN ELECTRÓNICA (se configura por sucursal)
-- ============================================================
IF OBJECT_ID('Fe_Documentos_detalle_desgloce', 'U') IS NOT NULL DELETE FROM [Fe_Documentos_detalle_desgloce]
IF OBJECT_ID('Fe_Documento_imp', 'U') IS NOT NULL DELETE FROM [Fe_Documento_imp]
IF OBJECT_ID('Fe_Documento_Complemento', 'U') IS NOT NULL DELETE FROM [Fe_Documento_Complemento]
IF OBJECT_ID('Fe_Documento_Detalle', 'U') IS NOT NULL DELETE FROM [Fe_Documento_Detalle]
IF OBJECT_ID('Fe_Documentos', 'U') IS NOT NULL DELETE FROM [Fe_Documentos]
IF OBJECT_ID('Fe_NC_Cancelacion', 'U') IS NOT NULL DELETE FROM [Fe_NC_Cancelacion]
IF OBJECT_ID('Fe_Factura_global', 'U') IS NOT NULL DELETE FROM [Fe_Factura_global]
IF OBJECT_ID('Fe_Series', 'U') IS NOT NULL DELETE FROM [Fe_Series]
GO

-- ============================================================
-- 13. USUARIOS — conservar solo el admin con password default
-- ============================================================
DELETE FROM [usuarios] WHERE id_usuario <> 1

-- Resetear admin: password = "12345", nombre limpio
UPDATE [usuarios]
SET password = '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5',
    nombre = 'Administrador',
    apellidos = 'Administrador',
    email = NULL,
    telefono = NULL,
    estado = 1,
    id_empleado = 0
WHERE id_usuario = 1
GO

-- ============================================================
-- 14. REACTIVAR CONSTRAINTS
-- ============================================================
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
GO

-- ============================================================
-- 15. SHRINK para compactar el MDF antes de copiarlo
-- ============================================================
DBCC SHRINKDATABASE ([PVDataNMG], 10)
GO

PRINT 'Limpieza completada. La BD está lista para exportar como MDF del instalador.'
GO
