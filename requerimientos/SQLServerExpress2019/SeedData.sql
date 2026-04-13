-- SeedData.sql — Datos iniciales requeridos para arranque de PVData
-- Idempotente: IF NOT EXISTS en cada INSERT
-- Generado: 2026-04-08

USE [PVData]
GO

-- zona
IF NOT EXISTS (SELECT 1 FROM [zona] WHERE [id_zona] = '1')
    INSERT INTO [zona] ([id_zona],[estado],[nombre]) VALUES ('1',1,'Zona1')
IF NOT EXISTS (SELECT 1 FROM [zona] WHERE [id_zona] = '2')
    INSERT INTO [zona] ([id_zona],[estado],[nombre]) VALUES ('2',1,'Zona2')
GO

-- tipo_sucursal
SET IDENTITY_INSERT [tipo_sucursal] ON
IF NOT EXISTS (SELECT 1 FROM [tipo_sucursal] WHERE [id_tipo_sucursal] = 1)
    INSERT INTO [tipo_sucursal] ([id_tipo_sucursal],[descripcion],[estado],[tipo]) VALUES (1,'desc1',1,'Tipo_1')
IF NOT EXISTS (SELECT 1 FROM [tipo_sucursal] WHERE [id_tipo_sucursal] = 2)
    INSERT INTO [tipo_sucursal] ([id_tipo_sucursal],[descripcion],[estado],[tipo]) VALUES (2,'desc2',1,'Tipo_2')
SET IDENTITY_INSERT [tipo_sucursal] OFF
GO

-- rol
SET IDENTITY_INSERT [rol] ON
IF NOT EXISTS (SELECT 1 FROM [rol] WHERE [id_rol] = 1)
    INSERT INTO [rol] ([id_rol],[descripcion],[estado],[nombre]) VALUES (1,'Este Rol tiene control total del sistema',1,'Administrador')
SET IDENTITY_INSERT [rol] OFF
GO

-- impuesto_tipo
SET IDENTITY_INSERT [impuesto_tipo] ON
IF NOT EXISTS (SELECT 1 FROM [impuesto_tipo] WHERE [id_tipo_impuesto] = 1)
    INSERT INTO [impuesto_tipo] ([id_tipo_impuesto],[estado],[nombre]) VALUES (1,1,'Traslado')
IF NOT EXISTS (SELECT 1 FROM [impuesto_tipo] WHERE [id_tipo_impuesto] = 2)
    INSERT INTO [impuesto_tipo] ([id_tipo_impuesto],[estado],[nombre]) VALUES (2,1,'Retencion')
SET IDENTITY_INSERT [impuesto_tipo] OFF
GO

-- impuesto
SET IDENTITY_INSERT [impuesto] ON
IF NOT EXISTS (SELECT 1 FROM [impuesto] WHERE [id_impuesto] = 1)
    INSERT INTO [impuesto] ([id_impuesto],[descripcion],[estado],[nombre]) VALUES (1,'Impuesto al valor Agregado (IVA)',1,'IVA')
IF NOT EXISTS (SELECT 1 FROM [impuesto] WHERE [id_impuesto] = 2)
    INSERT INTO [impuesto] ([id_impuesto],[descripcion],[estado],[nombre]) VALUES (2,'Impuesto sobre hospedaje (ISH)',1,'ISH')
IF NOT EXISTS (SELECT 1 FROM [impuesto] WHERE [id_impuesto] = 3)
    INSERT INTO [impuesto] ([id_impuesto],[descripcion],[estado],[nombre]) VALUES (3,'Impuesto Sobre la Renta (ISR)',1,'ISR')
SET IDENTITY_INSERT [impuesto] OFF
GO

-- tipo_pago
SET IDENTITY_INSERT [tipo_pago] ON
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 1)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (1,1,'0001-01-01','Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 2)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (2,0,'0001-01-01','Cr&#233;dito')
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 3)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (3,0,'0001-01-01','D&#243;lares')
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 4)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (4,0,'0001-01-01','Tarjeta de Cr&#233;dito')
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 5)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (5,0,'0001-01-01','Vale')
IF NOT EXISTS (SELECT 1 FROM [tipo_pago] WHERE [id_tipo_pago] = 6)
    INSERT INTO [tipo_pago] ([id_tipo_pago],[estado],[fecha],[nombre]) VALUES (6,0,'0001-01-01','Mixto')
SET IDENTITY_INSERT [tipo_pago] OFF
GO

-- tipo_movimiento
SET IDENTITY_INSERT [tipo_movimiento] ON
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 1)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (1,1,'Venta en Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 2)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (2,1,'Venta a Credito')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 3)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (3,1,'Venta con dolares')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 4)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (4,1,'Venta con Tarjeta')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 5)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (5,1,'Venta con vale')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 6)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (6,1,'Venta Mixta')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 7)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (7,1,'Cierre de Caja')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 8)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (8,1,'Apertura de Caja')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 9)  INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (9,1,'Entrada de Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 10) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (10,1,'Salida de Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 11) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (11,1,'Pago a Credito')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 12) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (12,1,'Devolucion')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 13) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (13,1,'Devolucion en Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 14) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (14,1,'Abono en Efectivo')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 15) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (15,1,'Abono en Tarjeta Credito')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 16) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (16,1,'Abono en Dolares')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 17) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (17,1,'Abono en Vale')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 18) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (18,1,'Venta en Apartados')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 20) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (20,1,'Abono Mixto')
IF NOT EXISTS (SELECT 1 FROM [tipo_movimiento] WHERE [id_tipo_movimiento] = 21) INSERT INTO [tipo_movimiento] ([id_tipo_movimiento],[estado],[nombre]) VALUES (21,1,'Traspaso')
SET IDENTITY_INSERT [tipo_movimiento] OFF
GO

-- modulos
SET IDENTITY_INSERT [modulos] ON
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 1) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (1,1,'Productos')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 2) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (2,1,'Clientes')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 3) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (3,1,'Venta')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 4) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (4,1,'Caja')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 5) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (5,1,'Configuracion')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 6) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (6,1,'Seguridad')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 7) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (7,1,'Descuentos')
IF NOT EXISTS (SELECT 1 FROM [modulos] WHERE [id_modulo] = 8) INSERT INTO [modulos] ([id_modulo],[estado],[nombre]) VALUES (8,1,'Reportes')
SET IDENTITY_INSERT [modulos] OFF
GO

-- operaciones
SET IDENTITY_INSERT [operaciones] ON
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 1)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (1,1,'Agergar Producto')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 2)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (2,1,'Editar Producto')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 3)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (3,1,'Desactivar Producto')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 4)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (4,2,'Agergar Cliente')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 5)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (5,2,'Editar Cliente')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 6)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (6,2,'Desactivar Cliente')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 7)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (7,2,'Administrar Credito')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 8)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (8,3,'Realizar Venta')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 9)  INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (9,3,'Buscar Ticket de Venta')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 10) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (10,3,'Cancelar Venta')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 11) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (11,3,'Devolver Producto de Venta')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 12) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (12,4,'Realizar Corte de Caja')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 13) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (13,4,'Ver Informacion de Corte de Caja')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 14) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (14,5,'Configurar Impresora')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 15) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (15,5,'Configurar Cajon')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 16) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (16,5,'Configurar Ticket')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 17) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (17,5,'Configurar Formas de Pago')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 18) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (18,5,'Configurar Impuestos')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 19) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (19,5,'Configurar Tipo de Corte')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 20) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (20,6,'Administrar Usuarios')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 21) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (21,6,'Administrar Roles')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 22) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (22,4,'Ver movimeintos de caja')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 23) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (23,4,'Realizar Cierre de Dia')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 24) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (24,4,'Cambiar fecha operacion')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 25) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (25,7,'Administrar')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 26) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (26,7,'Lectura')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 27) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (27,8,'Reporte Inventarios')
IF NOT EXISTS (SELECT 1 FROM [operaciones] WHERE [id_operacion] = 28) INSERT INTO [operaciones] ([id_operacion],[id_modulo],[nombre]) VALUES (28,5,'Configurar Bascula')
SET IDENTITY_INSERT [operaciones] OFF
GO

-- unidadmedida
SET IDENTITY_INSERT [unidadmedida] ON
IF NOT EXISTS (SELECT 1 FROM [unidadmedida] WHERE [id_unidadmedida] = 1)
    INSERT INTO [unidadmedida] ([id_unidadmedida],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [unidadmedida] OFF
GO

-- presentacion
SET IDENTITY_INSERT [presentacion] ON
IF NOT EXISTS (SELECT 1 FROM [presentacion] WHERE [id_presentacion] = 1)
    INSERT INTO [presentacion] ([id_presentacion],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [presentacion] OFF
GO

-- talla
SET IDENTITY_INSERT [talla] ON
IF NOT EXISTS (SELECT 1 FROM [talla] WHERE [id_talla] = 1)
    INSERT INTO [talla] ([id_talla],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [talla] OFF
GO

-- marca
SET IDENTITY_INSERT [marca] ON
IF NOT EXISTS (SELECT 1 FROM [marca] WHERE [id_marca] = 1)
    INSERT INTO [marca] ([id_marca],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [marca] OFF
GO

-- categoria
SET IDENTITY_INSERT [categoria] ON
IF NOT EXISTS (SELECT 1 FROM [categoria] WHERE [id_categoria] = 1)
    INSERT INTO [categoria] ([id_categoria],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [categoria] OFF
GO

-- subcategoria
SET IDENTITY_INSERT [subcategoria] ON
IF NOT EXISTS (SELECT 1 FROM [subcategoria] WHERE [id_subcategoria] = 1)
    INSERT INTO [subcategoria] ([id_subcategoria],[activo],[fch_crea],[nombre]) VALUES (1,1,'0001-01-01','NO APLICA')
SET IDENTITY_INSERT [subcategoria] OFF
GO

-- impresora
SET IDENTITY_INSERT [impresora] ON
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 1) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (1,1,'ESC/POS (Default)')
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 2) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (2,1,'Ithaca PCOS')
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 3) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (3,1,'EPSON')
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 4) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (4,1,'STAR')
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 5) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (5,1,'Microline')
IF NOT EXISTS (SELECT 1 FROM [impresora] WHERE [id_impresora] = 6) INSERT INTO [impresora] ([id_impresora],[estado],[nombre]) VALUES (6,1,'CUSTOM KUBE')
SET IDENTITY_INSERT [impresora] OFF
GO

-- impresora_comando
SET IDENTITY_INSERT [impresora_comando] ON
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 1)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (1,'[ESC]p0','[ESC]i',1,1,'Apertura a traves de impresion')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 2)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (2,'[ESC]x1','[ESC]v',1,2,'Cajon 1')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 3)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (3,'[ESC]x2','[ESC]v',1,2,'Cajon 2')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 4)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (4,'[ESC]p0','[ESC]i',1,3,'Cajon 1')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 5)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (5,'[ESC]p1','[ESC]i',1,3,'Cajon 2')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 6)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (6,'[BEL]','[ESC]d0',1,4,'Cajon 1')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 7)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (7,'[SUB]','[ESC]d0',1,4,'Cajon 2')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 8)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (8,'[BEL]','[EM]',1,5,'Cajon 1')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 9)  INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (9,'[BS]','[EM]',1,5,'Cajon 2')
IF NOT EXISTS (SELECT 1 FROM [impresora_comando] WHERE [id_comando] = 10) INSERT INTO [impresora_comando] ([id_comando],[abrir_cajon],[corte_papel],[estado],[id_impresora],[nombre]) VALUES (10,'[ESC]p0ii','[ESC]i',1,6,'Cajon 1')
SET IDENTITY_INSERT [impresora_comando] OFF
GO

-- cliente (Publico en General — requerido por FK de ML_Resultado_Prediccion y venta)
SET IDENTITY_INSERT [cliente] ON
IF NOT EXISTS (SELECT 1 FROM [cliente] WHERE [id_cliente] = 1)
    INSERT INTO [cliente] ([id_cliente],[credito],[estado],[ilimitdo],[limite],[nombre],[saldo])
    VALUES (1,0,1,0,0.0,'Publico en General',0.0)
SET IDENTITY_INSERT [cliente] OFF
GO

-- usuarios (Administrador — usuario inicial, password = SHA256 de la contrasena configurada)
SET IDENTITY_INSERT [usuarios] ON
IF NOT EXISTS (SELECT 1 FROM [usuarios] WHERE [id_usuario] = 1)
    INSERT INTO [usuarios] ([id_usuario],[apellidos],[estado],[fecha_creacion],[id_empleado],[id_rol],[nombre],[password],[user_name])
    VALUES (1,'Administrador',1,'2025-11-13 17:23:32.3967750',0,1,'Administrador',
            '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','Administrador')
SET IDENTITY_INSERT [usuarios] OFF
GO

-- CatalagoOperacion
SET IDENTITY_INSERT [CatalagoOperacion] ON
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 1)  INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (1,5,1,15,0,'Ventas')
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 2)  INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (2,5,1,15,0,'Producto')
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 3)  INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (3,5,1,15,0,'Invnetario')
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 4)  INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (4,5,1,15,2,'Configuracion')
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 5)  INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (5,5,1,15,2,'Caja')
IF NOT EXISTS (SELECT 1 FROM [CatalagoOperacion] WHERE [id_operacion] = 10) INSERT INTO [CatalagoOperacion] ([id_operacion],[dias_auditar],[estatus],[frecuencia],[numero_transmision],[operacion]) VALUES (10,5,1,15,2,'Usuario')
SET IDENTITY_INSERT [CatalagoOperacion] OFF
GO
