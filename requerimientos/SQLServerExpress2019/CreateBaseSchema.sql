-- CreateBaseSchema.sql — Schema base PVData
-- Idempotente: usa IF NOT EXISTS en cada objeto
-- Generado: 2026-04-08

USE [PVDATANMG]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[Ajuste_Inventario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ajuste_Inventario' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ajuste_Inventario](
	[idajuste] [bigint] IDENTITY(1,1) NOT NULL,
	[usrCap] [bigint] NULL,
	[tipo] [bigint] NULL,
	[definitivo] [bigint] NULL,
	[fchDefinitivo] [datetime2](7) NOT NULL,
	[entradaPrecioCompra] [float] NOT NULL,
	[entradaPrecioVenta] [float] NOT NULL,
	[salidaPrecioCompra] [float] NOT NULL,
	[salidaPrecioVenta] [float] NOT NULL,
	[id_estatus] [bigint] NULL,
	[vobo] [bigint] NULL,
	[usrVoBo] [bigint] NULL,
	[fchVoBo] [datetime2](7) NOT NULL,
	[usrAuto] [bigint] NULL,
	[fchAuto] [datetime2](7) NOT NULL,
	[usuarioCancelacion] [bigint] NOT NULL,
	[fechaCancelacion] [datetime2](7) NOT NULL,
	[motivoCancelacion] [nvarchar](max) NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_Ajuste_Inventario] PRIMARY KEY CLUSTERED 
(
	[idajuste] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ajuste_Inventario_Detalle]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ajuste_Inventario_Detalle' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ajuste_Inventario_Detalle](
	[idajuste] [bigint] NOT NULL,
	[idregistro] [bigint] NOT NULL,
	[id_sucursal] [bigint] NOT NULL,
	[tipo_mov] [nvarchar](450) NOT NULL,
	[codigo] [nvarchar](450) NOT NULL,
	[sucursal] [nvarchar](max) NULL,
	[cantidad] [bigint] NULL,
	[precioven] [float] NOT NULL,
	[preciocom] [float] NOT NULL,
	[factura] [nvarchar](max) NULL,
	[referencia] [nvarchar](max) NULL,
	[observaciones] [nvarchar](max) NULL,
	[id_estatus] [bigint] NULL,
	[vobo] [bigint] NULL,
	[autorizado] [bigint] NULL,
	[id_PeticionStatus] [bigint] NULL,
	[estatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_Ajuste_Inventario_Detalle] PRIMARY KEY CLUSTERED 
(
	[idajuste] ASC,
	[idregistro] ASC,
	[id_sucursal] ASC,
	[tipo_mov] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ajuste_Inventario_Detalle_Log]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ajuste_Inventario_Detalle_Log' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ajuste_Inventario_Detalle_Log](
	[idajuste] [int] NOT NULL,
	[idregistro] [int] NOT NULL,
	[codigo] [nvarchar](450) NOT NULL,
	[solicitado] [int] NOT NULL,
	[aplicado] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[tipo_mov] [nvarchar](max) NULL,
 CONSTRAINT [PK_Ajuste_Inventario_Detalle_Log] PRIMARY KEY CLUSTERED 
(
	[idajuste] ASC,
	[idregistro] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ajuste_Inventario_Estatus]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ajuste_Inventario_Estatus' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ajuste_Inventario_Estatus](
	[id_estatus] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Ajuste_Inventario_Estatus] PRIMARY KEY CLUSTERED 
(
	[id_estatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ajuste_Inventario_Log]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ajuste_Inventario_Log' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ajuste_Inventario_Log](
	[idajuste] [int] NOT NULL,
	[idregistro] [int] NOT NULL,
	[tipomov] [nvarchar](1) NOT NULL,
	[estatus] [int] NOT NULL,
	[fecha] [datetime2](7) NOT NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_Ajuste_Inventario_Log] PRIMARY KEY CLUSTERED 
(
	[idajuste] ASC,
	[idregistro] ASC,
	[tipomov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caja]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'caja' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[caja](
	[id_caja] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](200) NOT NULL,
	[estado] [bit] NOT NULL,
	[abierta] [bit] NOT NULL,
	[equipo] [nvarchar](max) NULL,
	[es_servidor] [bit] NOT NULL DEFAULT 0,
	[descripcion] [nvarchar](300) NULL,
	[nombre_equipo] [nvarchar](200) NULL,
	[ip_address] [nvarchar](50) NULL,
	[fecha_registro] [datetime] NULL,
 CONSTRAINT [PK_caja] PRIMARY KEY CLUSTERED
(
	[id_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caja_movimiento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'caja_movimiento' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[caja_movimiento](
	[id_movimiento_caja] [int] IDENTITY(1,1) NOT NULL,
	[id_caja] [int] NOT NULL,
	[id_tipo_movimiento] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[total] [float] NOT NULL,
	[fecha] [datetime2](7) NOT NULL,
	[comentarios] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
	[fecha_operacion] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_caja_movimiento] PRIMARY KEY CLUSTERED 
(
	[id_movimiento_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[caja_operacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'caja_operacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[caja_operacion](
	[fecha_operacion] [datetime2](7) NOT NULL,
	[fecha_apertura] [datetime2](7) NOT NULL,
	[id_usuario_apertura] [int] NOT NULL,
	[fecha_cierre] [datetime2](7) NULL,
	[id_usuario_cierre] [int] NULL,
 CONSTRAINT [PK_caja_operacion] PRIMARY KEY CLUSTERED 
(
	[fecha_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalagoOperacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CatalagoOperacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[CatalagoOperacion](
	[id_operacion] [int] IDENTITY(1,1) NOT NULL,
	[operacion] [nvarchar](max) NOT NULL,
	[dias_auditar] [int] NOT NULL,
	[frecuencia] [int] NOT NULL,
	[numero_transmision] [int] NOT NULL,
	[hora_inicio] [time](7) NULL,
	[hora_fin] [time](7) NULL,
	[estatus] [bit] NOT NULL,
 CONSTRAINT [PK_CatalagoOperacion] PRIMARY KEY CLUSTERED 
(
	[id_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Catalogo_Producto_sat]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Catalogo_Producto_sat' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Catalogo_Producto_sat](
	[Clave_Sat] [nvarchar](450) NOT NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Catalogo_Producto_sat] PRIMARY KEY CLUSTERED 
(
	[Clave_Sat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Catalogo_Sucursal]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Catalogo_Sucursal' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Catalogo_Sucursal](
	[id_sucursal] [int] IDENTITY(1,1) NOT NULL,
	[id_tipo_sucursal] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_zona] [nvarchar](max) NULL,
	[clave] [nvarchar](max) NULL,
	[nombre] [nvarchar](200) NOT NULL,
	[estado] [bit] NOT NULL,
	[Codigo_postal] [nvarchar](max) NULL,
	[Calle] [nvarchar](max) NULL,
	[Numero_interior] [nvarchar](max) NULL,
	[Correo] [nvarchar](max) NULL,
	[telefono] [nvarchar](max) NULL,
	[Aplica_Facturacion] [int] NOT NULL,
 CONSTRAINT [PK_Catalogo_Sucursal] PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatalogoDolar]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CatalogoDolar' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[CatalogoDolar](
	[FechaActual] [datetime2](7) NOT NULL,
	[FechaValorDolar] [datetime2](7) NOT NULL,
	[PrecioDolar] [float] NOT NULL,
 CONSTRAINT [PK_CatalogoDolar] PRIMARY KEY CLUSTERED 
(
	[FechaActual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'categoria' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[categoria](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_categoria] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ci_Orden_Compra]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ci_Orden_Compra' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ci_Orden_Compra](
	[id_orden_compra] [int] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[id_status] [int] NOT NULL,
	[fecha] [datetime2](7) NOT NULL,
	[fecha_limite_confirmacion] [datetime2](7) NOT NULL,
	[fecha_entrega_esperada] [datetime2](7) NOT NULL,
	[costo] [float] NOT NULL,
	[precio] [float] NOT NULL,
	[id_sucursal_recepcion] [int] NOT NULL,
	[fecha_recepcion] [datetime2](7) NOT NULL,
	[fecha_recepcion_pv] [datetime2](7) NOT NULL,
	[usr_crea] [int] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Ci_Orden_Compra] PRIMARY KEY CLUSTERED 
(
	[id_orden_compra] ASC,
	[id_proveedor] ASC,
	[id_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ci_Orden_Compra_Producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Ci_Orden_Compra_Producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Ci_Orden_Compra_Producto](
	[id_orden_compra] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[cantidad_recibida] [int] NOT NULL,
	[costo] [float] NOT NULL,
	[costo_total] [float] NOT NULL,
	[precio] [float] NOT NULL,
	[precio_total] [float] NOT NULL,
	[acciones] [int] NOT NULL,
 CONSTRAINT [PK_Ci_Orden_Compra_Producto] PRIMARY KEY CLUSTERED 
(
	[id_orden_compra] ASC,
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'cliente' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[apellidos] [nvarchar](max) NULL,
	[domicilio] [nvarchar](max) NULL,
	[email] [nvarchar](max) NULL,
	[telefono] [nvarchar](max) NULL,
	[codigo_postal] [nvarchar](max) NULL,
	[ilimitdo] [bit] NOT NULL,
	[credito] [bit] NOT NULL,
	[limite] [float] NOT NULL,
	[saldo] [float] NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_cliente] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configuracion_Bascula]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Configuracion_Bascula' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Configuracion_Bascula](
	[id_configuracion_bascula] [int] IDENTITY(1,1) NOT NULL,
	[Puerto] [nvarchar](max) NULL,
	[BaudRate] [int] NOT NULL,
	[equipo] [nvarchar](max) NULL,
 CONSTRAINT [PK_Configuracion_Bascula] PRIMARY KEY CLUSTERED 
(
	[id_configuracion_bascula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuracion_cajon]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'configuracion_cajon' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[configuracion_cajon](
	[id_configuracion_cajon] [int] IDENTITY(1,1) NOT NULL,
	[id_comando] [int] NOT NULL,
	[nombre_comando] [nvarchar](max) NULL,
	[abrir_cajon] [nvarchar](max) NULL,
	[corte_papel] [nvarchar](max) NULL,
	[puerto] [nvarchar](max) NULL,
	[equipo] [nvarchar](max) NULL,
 CONSTRAINT [PK_configuracion_cajon] PRIMARY KEY CLUSTERED 
(
	[id_configuracion_cajon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuracion_corte]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'configuracion_corte' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[configuracion_corte](
	[id_configuracion_corte] [int] IDENTITY(1,1) NOT NULL,
	[tipo_corte_value] [int] NOT NULL,
 CONSTRAINT [PK_configuracion_corte] PRIMARY KEY CLUSTERED 
(
	[id_configuracion_corte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuracion_impresora]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'configuracion_impresora' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[configuracion_impresora](
	[id_configuracion_impresora] [int] IDENTITY(1,1) NOT NULL,
	[equipo] [nvarchar](max) NULL,
	[nombre_impresora] [nvarchar](max) NULL,
	[columnas] [int] NOT NULL,
 CONSTRAINT [PK_configuracion_impresora] PRIMARY KEY CLUSTERED 
(
	[id_configuracion_impresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuracion_ticket]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'configuracion_ticket' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[configuracion_ticket](
	[id_configuracion_ticket] [int] IDENTITY(1,1) NOT NULL,
	[logo] [varbinary](max) NULL,
	[cabecera] [nvarchar](max) NULL,
	[pie] [nvarchar](max) NULL,
	[incluir_impuesto] [bit] NOT NULL,
 CONSTRAINT [PK_configuracion_ticket] PRIMARY KEY CLUSTERED 
(
	[id_configuracion_ticket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[controlTransmision]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'controlTransmision' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[controlTransmision](
	[id_operacion] [int] NOT NULL,
	[FechaCreacion] [datetime2](7) NOT NULL,
	[FechaInicio] [datetime2](7) NOT NULL,
	[FechaFin] [datetime2](7) NOT NULL,
	[AplicoAuditoria] [bit] NOT NULL,
	[CantadorTransmision] [int] NOT NULL,
	[Duracion] [float] NOT NULL,
 CONSTRAINT [PK_controlTransmision] PRIMARY KEY CLUSTERED 
(
	[id_operacion] ASC,
	[FechaCreacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CPrueba]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CPrueba' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[CPrueba](
	[id_producto] [int] NOT NULL,
	[id_producto_Recomendado] [int] NOT NULL,
	[Observacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_CPrueba] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC,
	[id_producto_Recomendado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[departamento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'departamento' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[departamento](
	[id_departamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_departamento] PRIMARY KEY CLUSTERED 
(
	[id_departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empresa]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'empresa' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[empresa](
	[id_empresa] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](200) NOT NULL,
	[regimenFiscal] [nvarchar](max) NULL,
	[RFC] [nvarchar](max) NULL,
 CONSTRAINT [PK_empresa] PRIMARY KEY CLUSTERED 
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Documento_complemento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Documento_complemento' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Documento_complemento](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[Item] [int] NOT NULL,
	[CuentaPredial] [nvarchar](max) NULL,
	[dBase] [decimal](18, 2) NOT NULL,
	[Impuesto] [varchar](15) NOT NULL,
	[TipoFactor] [varchar](15) NOT NULL,
	[TasaOCuota] [varchar](15) NOT NULL,
	[ImporteImp] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Fe_Documentos_complemento] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC,
	[Item] ASC,
	[Impuesto] ASC,
	[TipoFactor] ASC,
	[TasaOCuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Documento_Detalle]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Documento_Detalle' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Documento_Detalle](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[item] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[unidad] [nvarchar](max) NULL,
	[codigo_producto] [nvarchar](max) NULL,
	[descripcion] [nvarchar](max) NULL,
	[valor_unitario] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL,
	[iva] [decimal](18, 2) NOT NULL,
	[descuento] [decimal](18, 2) NOT NULL,
	[clave_producto_sat] [nvarchar](max) NULL,
	[clave_unidad_medida] [nvarchar](max) NULL,
	[base_fe] [decimal](18, 2) NOT NULL,
	[impuesto] [nvarchar](max) NULL,
	[tasa_o_cuota] [nvarchar](max) NULL,
	[importe_imp] [decimal](18, 2) NOT NULL,
	[base0] [decimal](18, 2) NOT NULL,
	[impuesto0] [nvarchar](max) NULL,
	[tipo_factor_0] [nvarchar](max) NULL,
	[tasa_o_cuota_0] [nvarchar](max) NULL,
	[importe_imp0] [decimal](18, 2) NOT NULL,
	[tipo_impuesto] [bit] NOT NULL,
	[objeto_imp] [nvarchar](max) NULL,
	[fecha_OP] [date] NULL,
 CONSTRAINT [PK_Fe_Documento_Detalle] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC,
	[item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Documento_imp]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Documento_imp' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Documento_imp](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[impuesto] [nvarchar](450) NOT NULL,
	[tipo_factor] [nvarchar](450) NOT NULL,
	[tasa_O_Cuota] [nvarchar](450) NOT NULL,
	[dbase] [float] NOT NULL,
	[importe] [float] NOT NULL,
	[tipoImpuesto] [bit] NOT NULL,
 CONSTRAINT [PK_Fe_Documento_imp] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC,
	[impuesto] ASC,
	[tipo_factor] ASC,
	[tasa_O_Cuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Documentos]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Documentos' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Documentos](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[rfc_receptor] [nvarchar](max) NULL,
	[fecha] [nvarchar](max) NULL,
	[formadepago] [nvarchar](max) NULL,
	[codiciones_de_pago] [nvarchar](max) NULL,
	[subtotal] [float] NOT NULL,
	[descuento] [float] NOT NULL,
	[motivo_descuento] [nvarchar](max) NULL,
	[total] [float] NOT NULL,
	[metodo_de_pago] [nvarchar](max) NULL,
	[id_tipo_comprobante] [int] NOT NULL,
	[iva] [decimal](18, 2) NOT NULL,
	[fecha_Facturacion] [datetime2](7) NOT NULL,
	[venta_iva0] [decimal](18, 2) NOT NULL,
	[iva0] [decimal](18, 2) NOT NULL,
	[venta_iva16] [decimal](18, 2) NOT NULL,
	[iva16] [decimal](18, 2) NOT NULL,
	[descuento0] [decimal](18, 2) NOT NULL,
	[descuento16] [decimal](18, 2) NOT NULL,
	[uuid] [nvarchar](max) NULL,
	[nombre_archivo] [nvarchar](max) NULL,
	[id_credito] [int] NOT NULL,
	[correo_envio] [nvarchar](max) NULL,
	[estatus] [bit] NOT NULL,
	[id_certificado] [int] NOT NULL,
	[usrC] [int] NOT NULL,
	[fechaC] [datetime2](7) NOT NULL,
	[observaciones] [nvarchar](max) NULL,
	[moneda] [nvarchar](max) NULL,
	[tipo_cambio] [decimal](18, 2) NOT NULL,
	[tipo_de_comprobante] [nvarchar](max) NULL,
	[Lugar_expedicion] [nvarchar](max) NULL,
	[tipo_Relacion] [nvarchar](max) NULL,
	[uuid_r] [nvarchar](max) NULL,
	[usoCFDI] [nvarchar](max) NULL,
	[retenidos] [decimal](18, 2) NOT NULL,
	[version] [nvarchar](max) NULL,
	[nocert] [nvarchar](max) NULL,
	[nocertsat] [nvarchar](max) NULL,
	[verificado] [bit] NOT NULL,
	[exportacion] [nvarchar](max) NULL,
	[periodicidad] [nvarchar](max) NULL,
	[meses] [nvarchar](max) NULL,
	[periodo] [int] NOT NULL,
	[global] [bit] NOT NULL,
	[docimilio_fiscal] [nvarchar](max) NULL,
	[regimen_fiscal_Receptor] [nvarchar](max) NULL,
	[recidencia_fiscal] [nvarchar](max) NULL,
	[num_Reg_Id_Trib] [nvarchar](max) NULL,
	[xml_Precfdi] [nvarchar](max) NULL,
	[Estatus_envio] [bit] NULL,
	[receptor] [varchar](max) NULL,
 CONSTRAINT [PK_Fe_Documentos] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Documentos_desgloce]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Documentos_desgloce' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Documentos_desgloce](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[codigo_Producto] [nvarchar](450) NOT NULL,
	[descripcion_producto] [nvarchar](max) NULL,
	[cantidad] [int] NOT NULL,
	[unidad] [nvarchar](max) NULL,
	[valor_unitario] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL,
	[clave_producto_Ser] [nvarchar](max) NULL,
 CONSTRAINT [PK_Fe_Documentos_desgloce] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC,
	[codigo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fe_Factura_global]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'fe_Factura_global' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[fe_Factura_global](
	[id_venta] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[serie] [varchar](10) NOT NULL,
	[Folio] [int] NOT NULL,
	[fecha_operacion] [datetime2](7) NOT NULL,
	[clave] [varchar](15) NOT NULL,
	[dBase] [decimal](18, 2) NOT NULL,
	[Impuesto] [varchar](15) NOT NULL,
	[TipoFactor] [varchar](15) NOT NULL,
	[TasaOCuota] [varchar](15) NOT NULL,
	[ImporteImp] [decimal](18, 2) NOT NULL,
	[precio_total] [decimal](18, 2) NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_fe_Factura_global] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC,
	[id_producto] ASC,
	[serie] ASC,
	[Folio] ASC,
	[Impuesto] ASC,
	[TipoFactor] ASC,
	[TasaOCuota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_NC_Cancelacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_NC_Cancelacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_NC_Cancelacion](
	[serie] [nvarchar](450) NOT NULL,
	[Folio] [int] NOT NULL,
	[razon] [nvarchar](max) NULL,
	[usr_can] [int] NOT NULL,
	[fecha_can] [datetime2](7) NOT NULL,
	[clave_motivo_sat] [nvarchar](max) NULL,
	[uuid_relacionado] [nvarchar](max) NULL,
	[respuesta_cancelacion] [nvarchar](max) NULL,
	[fecha_respuesta] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Fe_NC_Cancelacion] PRIMARY KEY CLUSTERED 
(
	[serie] ASC,
	[Folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fe_Series]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Fe_Series' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Fe_Series](
	[serie] [nvarchar](450) NOT NULL,
	[impuestoestatal] [decimal](18, 2) NOT NULL,
	[activo] [bit] NOT NULL,
	[manual] [bit] NOT NULL,
	[id_tiposerie] [bit] NOT NULL,
 CONSTRAINT [PK_Fe_Series] PRIMARY KEY CLUSTERED 
(
	[serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impresora]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impresora' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impresora](
	[id_impresora] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_impresora] PRIMARY KEY CLUSTERED 
(
	[id_impresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impresora_comando]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impresora_comando' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impresora_comando](
	[id_comando] [int] IDENTITY(1,1) NOT NULL,
	[id_impresora] [int] NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[abrir_cajon] [nvarchar](max) NULL,
	[corte_papel] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_impresora_comando] PRIMARY KEY CLUSTERED 
(
	[id_comando] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impuesto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impuesto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impuesto](
	[id_impuesto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[descripcion] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
	[Clave_impuesto] [nvarchar](max) NULL,
	[tasa_O_Cuota] [nvarchar](max) NULL,
	[tipo_factor] [nvarchar](max) NULL,
 CONSTRAINT [PK_impuesto] PRIMARY KEY CLUSTERED 
(
	[id_impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Impuesto_Detalle]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Impuesto_Detalle' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Impuesto_Detalle](
	[id_impuesto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[Detalle] [nvarchar](max) NULL,
	[Clave_sat] [nvarchar](max) NULL,
	[Impuesto_factor] [nvarchar](max) NULL,
	[Impuesto_tipo] [nvarchar](max) NULL,
	[Valor] [real] NOT NULL,
	[incluir_nuevos_productos] [bit] NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_Impuesto_Detalle] PRIMARY KEY CLUSTERED 
(
	[id_impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impuesto_factor]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impuesto_factor' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impuesto_factor](
	[id_factor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_impuesto_factor] PRIMARY KEY CLUSTERED 
(
	[id_factor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impuesto_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impuesto_producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impuesto_producto](
	[id_lista_impuesto] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[objeto_impuesto] [nvarchar](max) NULL,
 CONSTRAINT [PK_impuesto_producto] PRIMARY KEY CLUSTERED 
(
	[id_lista_impuesto] ASC,
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[impuesto_tipo]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'impuesto_tipo' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[impuesto_tipo](
	[id_tipo_impuesto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_impuesto_tipo] PRIMARY KEY CLUSTERED 
(
	[id_tipo_impuesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[info_Cierre_dia]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'info_Cierre_dia' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[info_Cierre_dia](
	[id_info_cierre] [int] IDENTITY(1,1) NOT NULL,
	[apertura] [float] NOT NULL,
	[venta_efectivo] [float] NOT NULL,
	[num_venta_efectivo] [int] NOT NULL,
	[venta_tarjeta] [float] NOT NULL,
	[num_venta_tarjeta] [int] NOT NULL,
	[venta_apartados] [float] NOT NULL,
	[num_venta_apartados] [int] NOT NULL,
	[venta_vales] [float] NOT NULL,
	[num_venta_vales] [int] NOT NULL,
	[venta_devoluciones] [float] NOT NULL,
	[num_venta_devoluciones] [int] NOT NULL,
	[abonos] [float] NOT NULL,
	[devoluciones_Efectivo] [float] NOT NULL,
	[entrada_Efectivo] [float] NOT NULL,
	[salida_Efectivo] [float] NOT NULL,
	[dinero_en_Caja] [float] NOT NULL,
	[diferencia] [float] NOT NULL,
	[total_Ventas] [float] NOT NULL,
	[total_Caja] [float] NOT NULL,
	[id_caja] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[fecha_Operacion] [datetime2](7) NOT NULL,
	[fecha_Apertura] [datetime2](7) NOT NULL,
	[fecha_Cierre] [datetime2](7) NOT NULL,
	[estatus_envio] [bit] NOT NULL,
 CONSTRAINT [PK_info_Cierre_dia] PRIMARY KEY CLUSTERED 
(
	[id_info_cierre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[info_corte_caja]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'info_corte_caja' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[info_corte_caja](
	[id_info_caja] [int] IDENTITY(1,1) NOT NULL,
	[apertura] [float] NOT NULL,
	[venta_efectivo] [float] NOT NULL,
	[num_venta_efectivo] [int] NOT NULL,
	[venta_tarjeta] [float] NOT NULL,
	[num_venta_tarjeta] [int] NOT NULL,
	[venta_apartados] [float] NOT NULL,
	[num_venta_apartados] [int] NOT NULL,
	[venta_vales] [float] NOT NULL,
	[num_venta_vales] [int] NOT NULL,
	[venta_devoluciones] [float] NOT NULL,
	[num_venta_devoluciones] [int] NOT NULL,
	[abonos] [float] NOT NULL,
	[devoluciones_Efectivo] [float] NOT NULL,
	[entrada_Efectivo] [float] NOT NULL,
	[salida_Efectivo] [float] NOT NULL,
	[dinero_en_Caja] [float] NOT NULL,
	[diferencia] [float] NOT NULL,
	[total_Ventas] [float] NOT NULL,
	[total_Caja] [float] NOT NULL,
	[id_caja] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[fecha_Operacion] [datetime2](7) NOT NULL,
	[fecha_Apertura] [datetime2](7) NOT NULL,
	[fecha_Cierre] [datetime2](7) NOT NULL,
	[estatus_envio] [bit] NOT NULL,
 CONSTRAINT [PK_info_corte_caja] PRIMARY KEY CLUSTERED 
(
	[id_info_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informacion_PC]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Informacion_PC' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Informacion_PC](
	[id_Maquina] [nvarchar](450) NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[nombre_Maquina] [nvarchar](max) NULL,
	[sistema_Operativo] [nvarchar](max) NULL,
	[Arquitectura] [nvarchar](max) NULL,
	[nombre_procesador] [nvarchar](max) NULL,
	[nucleos] [nvarchar](max) NULL,
	[Memoria_total] [nvarchar](max) NULL,
	[Nombre_Disco_Duro] [nvarchar](max) NULL,
	[tamaño_Disco_Duro] [nvarchar](max) NULL,
 CONSTRAINT [PK_Informacion_PC] PRIMARY KEY CLUSTERED 
(
	[id_Maquina] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'inventario' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[inventario](
	[id_producto] [int] NOT NULL,
	[existencia] [int] NOT NULL,
	[apartado] [int] NOT NULL,
	[inventario_minimo] [int] NOT NULL,
	[inventario_maximo] [int] NOT NULL,
	[precio_compra] [float] NOT NULL,
	[precio_venta] [float] NOT NULL,
	[fecha_modificacion] [datetime2](7) NOT NULL,
	[usr_crea] [int] NOT NULL,
	[activo] [bit] NOT NULL,
	[Ubicacion] [nvarchar](max) NULL,
 CONSTRAINT [PK_inventario] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario_Log]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Inventario_Log' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Inventario_Log](
	[Fecha_Actual] [datetime2](7) NOT NULL,
	[Ultimo_Envio] [datetime2](7) NOT NULL,
	[Estatus] [bit] NOT NULL,
 CONSTRAINT [PK_Inventario_Log] PRIMARY KEY CLUSTERED 
(
	[Fecha_Actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventarioFisicoCompleto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'InventarioFisicoCompleto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[InventarioFisicoCompleto](
	[Fecha_Operacion] [datetime2](7) NOT NULL,
	[Id_Producto] [int] NOT NULL,
	[Contado] [bit] NOT NULL,
	[Existencia_Inicial] [int] NOT NULL,
	[Existencia_Final] [int] NOT NULL,
	[Entradas] [int] NOT NULL,
	[Salidas] [int] NOT NULL,
	[Activo] [bit] NOT NULL,
	[Precio_Compra] [float] NOT NULL,
	[Precio_Venta] [float] NOT NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_InventarioFisicoCompleto] PRIMARY KEY CLUSTERED 
(
	[Fecha_Operacion] ASC,
	[Id_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log_Catalogo_Operacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Log_Catalogo_Operacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Log_Catalogo_Operacion](
	[Fecha_Actualizacion] [datetime2](7) NOT NULL,
	[Estatus] [bit] NOT NULL,
 CONSTRAINT [PK_Log_Catalogo_Operacion] PRIMARY KEY CLUSTERED 
(
	[Fecha_Actualizacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log_Error]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Log_Error' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Log_Error](
	[Id_Error] [int] IDENTITY(1,1) NOT NULL,
	[Fecha_Error] [datetime2](7) NOT NULL,
	[Message_Error] [nvarchar](max) NULL,
	[Ruta] [nvarchar](max) NULL,
 CONSTRAINT [PK_Log_Error] PRIMARY KEY CLUSTERED 
(
	[Id_Error] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Log_producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Log_producto](
	[Fecha_Actual] [datetime2](7) NOT NULL,
	[Ultima_Actualizacion] [datetime2](7) NOT NULL,
	[Estatus] [bit] NOT NULL,
 CONSTRAINT [PK_Log_producto] PRIMARY KEY CLUSTERED 
(
	[Fecha_Actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log_producto_imagen]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Log_producto_imagen' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Log_producto_imagen](
	[Fecha_Actual] [datetime2](7) NOT NULL,
	[Ultima_Actualizacion] [datetime2](7) NOT NULL,
	[Estatus] [bit] NOT NULL,
	[DescargaZip] [bit] NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_Log_producto_imagen] PRIMARY KEY CLUSTERED 
(
	[Fecha_Actual] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[marca]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'marca' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[marca](
	[id_marca] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_marca] PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[modulos]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'modulos' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[modulos](
	[id_modulo] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_modulos] PRIMARY KEY CLUSTERED 
(
	[id_modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movimiento_efectivo]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'movimiento_efectivo' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[movimiento_efectivo](
	[id_movimiento_efectivo] [int] IDENTITY(1,1) NOT NULL,
	[id_Tipo_Movimiento] [nvarchar](max) NULL,
	[tipo] [nvarchar](max) NULL,
	[Cantidad] [float] NOT NULL,
	[Concepto] [nvarchar](max) NULL,
	[Fecha_Movimiento] [datetime2](7) NOT NULL,
	[fecha_Operacion] [datetime2](7) NOT NULL,
	[id_Usuario] [int] NOT NULL,
 CONSTRAINT [PK_movimiento_efectivo] PRIMARY KEY CLUSTERED 
(
	[id_movimiento_efectivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[movimiento_Inventario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'movimiento_Inventario' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[movimiento_Inventario](
	[id_movimiento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_movimiento_Inventario] PRIMARY KEY CLUSTERED 
(
	[id_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[operaciones]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'operaciones' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[operaciones](
	[id_operacion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[id_modulo] [int] NOT NULL,
 CONSTRAINT [PK_operaciones] PRIMARY KEY CLUSTERED 
(
	[id_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[presentacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'presentacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[presentacion](
	[id_presentacion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_presentacion] PRIMARY KEY CLUSTERED 
(
	[id_presentacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto](
	[id_producto] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [nvarchar](45) NOT NULL,
	[clave] [nvarchar](max) NULL,
	[id_presentacion] [int] NOT NULL,
	[id_unidadmedida] [int] NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_talla] [int] NULL,
	[nombre] [nvarchar](150) NOT NULL,
	[descripcion] [text] NULL,
	[clave_sat] [nvarchar](max) NULL,
	[FiltroProducto] [nvarchar](max) NULL,
	[combo] [bit] NOT NULL,
	[aplica_caducidad] [bit] NOT NULL,
	[controlado] [bit] NOT NULL,
	[activo] [bit] NOT NULL,
	[venta] [bit] NOT NULL,
	[Inventario] [bit] NOT NULL,
	[estatusEnvio] [bit] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
 CONSTRAINT [PK_producto] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_clasificacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto_clasificacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto_clasificacion](
	[id_producto] [int] NOT NULL,
	[id_departamento] [int] NOT NULL,
	[id_categoria] [int] NOT NULL,
	[id_subcategoria] [int] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
 CONSTRAINT [PK_producto_clasificacion] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_img]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto_img' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto_img](
	[id_imagen] [int] IDENTITY(1,1) NOT NULL,
	[id_producto] [int] NOT NULL,
	[Imagen] [varbinary](max) NULL,
	[Imagen_base64] [nvarchar](max) NULL,
	[descripcion] [nvarchar](max) NULL,
	[principal] [bit] NOT NULL,
	[ContentType] [nvarchar](max) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_producto_img] PRIMARY KEY CLUSTERED 
(
	[id_imagen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_recomendado]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto_recomendado' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto_recomendado](
	[id_producto] [int] NOT NULL,
	[id_producto_Recomendado] [int] NOT NULL,
	[Codigo_Recomendado] [nvarchar](max) NULL,
	[Observacion] [nvarchar](max) NULL,
	[Codigo_Producto] [nvarchar](max) NULL,
	[activo] [int] NULL,
	[imagen] [nvarchar](max) NULL,
	[Imagen_Producto] [bit] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_producto_recomendado] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC,
	[id_producto_Recomendado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_remplazo]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto_remplazo' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto_remplazo](
	[id_producto] [int] NOT NULL,
	[id_producto_Remplazo] [int] NOT NULL,
	[Codigo_Remplazo] [nvarchar](max) NULL,
	[Observacion] [nvarchar](max) NULL,
	[Codigo_Producto] [nvarchar](max) NULL,
	[activo] [int] NULL,
	[imagen] [nvarchar](max) NULL,
	[Imagen_Producto] [bit] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_producto_remplazo] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC,
	[id_producto_Remplazo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_sat]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'producto_sat' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[producto_sat](
	[id_producto_sat] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_producto_sat] PRIMARY KEY CLUSTERED 
(
	[id_producto_sat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'proveedor' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[proveedor](
	[id_proveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[razon_social] [nvarchar](100) NULL,
	[rfc] [nvarchar](13) NULL,
	[telefono] [nvarchar](15) NULL,
	[correo] [nvarchar](50) NULL,
	[direccion] [nvarchar](100) NULL,
	[id_municipio] [int] NULL,
	[id_estado] [int] NULL,
	[id_pais] [int] NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_proveedor] PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedor_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'proveedor_producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[proveedor_producto](
	[id_proveedor] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistroInstalacionPV]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RegistroInstalacionPV' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[RegistroInstalacionPV](
	[IdRegistro] [int] IDENTITY(1,1) NOT NULL,
	[ClaveCliente] [nvarchar](255) NOT NULL,
	[FechaInstalacion] [datetime2](7) NOT NULL,
	[FechaVencimiento] [datetime2](7) NOT NULL,
	[Activo] [bit] NOT NULL,
	[NombreCliente] [nvarchar](255) NULL,
	[RFC] [nvarchar](max) NULL,
	[MacAddress] [nvarchar](50) NULL,
 CONSTRAINT [PK_RegistroInstalacionPV] PRIMARY KEY CLUSTERED 
(
	[IdRegistro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rh_Asignacion_Peticion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Rh_Asignacion_Peticion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Rh_Asignacion_Peticion](
	[id_peticion] [int] IDENTITY(1,1) NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_empleado] [int] NOT NULL,
	[id_asignacionstatus] [int] NOT NULL,
	[id_asignaciontipo] [int] NOT NULL,
	[fch_programada] [datetime2](7) NOT NULL,
	[fch_aplicacion] [datetime2](7) NOT NULL,
	[id_peticionstatus] [int] NOT NULL,
	[cubreturno] [int] NOT NULL,
	[fechaBajacubreturno] [datetime2](7) NOT NULL,
	[fch_crea] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Rh_Asignacion_Peticion] PRIMARY KEY CLUSTERED 
(
	[id_peticion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'rol' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[rol](
	[id_rol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](30) NOT NULL,
	[descripcion] [nvarchar](256) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_rol] PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol_operacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'rol_operacion' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[rol_operacion](
	[id_rol_operacion] [int] IDENTITY(1,1) NOT NULL,
	[id_rol] [int] NOT NULL,
	[id_operacion] [int] NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_rol_operacion] PRIMARY KEY CLUSTERED 
(
	[id_rol_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subcategoria]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'subcategoria' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[subcategoria](
	[id_subcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_subcategoria] PRIMARY KEY CLUSTERED 
(
	[id_subcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sucursal]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'sucursal' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[sucursal](
	[id_sucursal] [int] IDENTITY(1,1) NOT NULL,
	[id_tipo_sucursal] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_zona] [nvarchar](450) NOT NULL,
	[clave] [nvarchar](max) NULL,
	[nombre] [nvarchar](200) NOT NULL,
	[estado] [bit] NOT NULL,
	[Codigo_postal] [nvarchar](max) NULL,
	[Calle] [nvarchar](max) NULL,
	[Numero_interior] [nvarchar](max) NULL,
	[Correo] [nvarchar](max) NULL,
	[telefono] [nvarchar](max) NULL,
	[Aplica_Facturacion] [int] NOT NULL,
 CONSTRAINT [PK_sucursal] PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[talla]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'talla' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[talla](
	[id_talla] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_talla] PRIMARY KEY CLUSTERED 
(
	[id_talla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_movimiento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tipo_movimiento' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[tipo_movimiento](
	[id_tipo_movimiento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tipo_movimiento] PRIMARY KEY CLUSTERED 
(
	[id_tipo_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_pago]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tipo_pago' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[tipo_pago](
	[id_tipo_pago] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](max) NULL,
	[valor] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
	[fecha] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_tipo_pago] PRIMARY KEY CLUSTERED 
(
	[id_tipo_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_sucursal]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tipo_sucursal' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[tipo_sucursal](
	[id_tipo_sucursal] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [nvarchar](200) NOT NULL,
	[descripcion] [nvarchar](max) NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_tipo_sucursal] PRIMARY KEY CLUSTERED 
(
	[id_tipo_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transferencia]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Transferencia' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Transferencia](
	[Id_Sucursal] [bigint] NOT NULL,
	[Folio] [bigint] NOT NULL,
	[Tipo] [nvarchar](max) NULL,
	[Origen] [nvarchar](max) NULL,
	[id_sucursal_destino] [bigint] NULL,
	[Destino] [nvarchar](max) NULL,
	[captura] [datetime2](7) NOT NULL,
	[Autorizacion] [datetime2](7) NOT NULL,
	[Recepcion] [datetime2](7) NOT NULL,
	[Importe] [float] NOT NULL,
	[Costo] [float] NOT NULL,
	[Motivo] [nvarchar](max) NULL,
	[Cancelada] [bit] NOT NULL,
	[Fecha_Cancelada] [datetime2](7) NOT NULL,
	[Usuario_Id_Cancela] [bigint] NULL,
	[Revocada] [bit] NULL,
	[Fecha_Revoca] [datetime2](7) NOT NULL,
	[Preautorizada] [bit] NULL,
	[UsrAuto] [bigint] NULL,
	[Id_Traspaso] [bigint] NULL,
	[Id_PeticionStatus] [bigint] NULL,
	[transferenciascol] [nvarchar](max) NULL,
	[Observacion] [nvarchar](max) NULL,
	[solicitudSimilares] [bigint] NULL,
	[Aplico_Envio_PV] [bit] NOT NULL,
	[Aplico_Recibio_PV] [bit] NOT NULL,
 CONSTRAINT [PK_Transferencia] PRIMARY KEY CLUSTERED 
(
	[Id_Sucursal] ASC,
	[Folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transferencia_Detalle]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Transferencia_Detalle' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Transferencia_Detalle](
	[Id_Sucursal] [bigint] NOT NULL,
	[Folio] [bigint] NOT NULL,
	[Codigo] [nvarchar](450) NOT NULL,
	[Cantidad] [bigint] NOT NULL,
	[Precio] [float] NOT NULL,
	[Importe] [float] NOT NULL,
	[Costo] [float] NOT NULL,
	[Descto] [float] NOT NULL,
	[CantidadAplicada] [bigint] NOT NULL,
 CONSTRAINT [PK_Transferencia_Detalle] PRIMARY KEY CLUSTERED 
(
	[Id_Sucursal] ASC,
	[Folio] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[unidadmedida]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'unidadmedida' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[unidadmedida](
	[id_unidadmedida] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](45) NULL,
	[fch_crea] [datetime2](7) NOT NULL,
	[usr_crea] [int] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_unidadmedida] PRIMARY KEY CLUSTERED 
(
	[id_unidadmedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'usuarios' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[usuarios](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[id_rol] [int] NOT NULL,
	[id_empleado] [int] NOT NULL,
	[fecha_creacion] [datetime2](7) NOT NULL,
	[user_name] [nvarchar](200) NOT NULL,
	[nombre] [nvarchar](200) NULL,
	[apellidos] [nvarchar](200) NULL,
	[email] [nvarchar](200) NULL,
	[estado] [bit] NOT NULL,
	[telefono] [nvarchar](50) NULL,
	[password] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'venta' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[venta](
	[id_venta] [int] IDENTITY(1,1) NOT NULL,
	[id_caja] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_tipo_movimiento] [int] NOT NULL,
	[id_cliente] [int] NOT NULL,
	[folio] [nvarchar](max) NULL,
	[nombre_ticket] [nvarchar](max) NULL,
	[articulos] [int] NOT NULL,
	[total] [float] NOT NULL,
	[fecha_venta] [datetime2](7) NOT NULL,
	[fecha_operacion] [datetime2](7) NOT NULL,
	[liquidada] [bit] NOT NULL,
	[estado] [bit] NOT NULL,
	[deuda] [float] NOT NULL,
	[sub_total] [float] NOT NULL,
	[total_impuesto] [float] NOT NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_venta] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta_cancelada]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'venta_cancelada' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[venta_cancelada](
	[id_venta_cancelada] [int] IDENTITY(1,1) NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[motivo] [nvarchar](max) NULL,
	[fecha] [datetime2](7) NOT NULL,
	[EstatusEnvio] [bit] NOT NULL,
 CONSTRAINT [PK_venta_cancelada] PRIMARY KEY CLUSTERED 
(
	[id_venta_cancelada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta_Descuento_Producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Venta_Descuento_Producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[Venta_Descuento_Producto](
	[id_venta] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[descuento] [float] NOT NULL,
	[Porcentaje] [float] NOT NULL,
	[Total_Sin_Descuento] [float] NOT NULL,
 CONSTRAINT [PK_Venta_Descuento_Producto] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC,
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta_pago]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'venta_pago' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[venta_pago](
	[id_venta_pago] [int] IDENTITY(1,1) NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_tipo_pago] [int] NOT NULL,
	[cambio] [float] NOT NULL,
	[importe] [float] NOT NULL,
	[tipo_cambio] [nvarchar](max) NULL,
	[tasa] [nvarchar](max) NULL,
	[abono] [bit] NOT NULL,
	[referencia] [nvarchar](max) NULL,
	[fecha] [datetime2](7) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_venta_pago] PRIMARY KEY CLUSTERED 
(
	[id_venta_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'venta_producto' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[venta_producto](
	[id_venta] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[precio_venta] [float] NOT NULL,
	[estado] [bit] NOT NULL,
	[cantidad] [int] NOT NULL,
	[importe] [float] NOT NULL,
	[sub_total] [float] NOT NULL,
	[total_impuesto] [float] NOT NULL,
	[devolucion] [bit] NOT NULL,
	[cantidad_devolucion] [int] NOT NULL,
 CONSTRAINT [PK_venta_producto] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC,
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zona]    Script Date: 05/03/2026 01:27:21 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'zona' AND TABLE_SCHEMA = 'dbo')
CREATE TABLE [dbo].[zona](
	[id_zona] [nvarchar](450) NOT NULL,
	[nombre] [nvarchar](200) NOT NULL,
	[estado] [bit] NOT NULL,
 CONSTRAINT [PK_zona] PRIMARY KEY CLUSTERED 
(
	[id_zona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_caja_movimiento_id_caja]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_caja_movimiento_id_caja')
CREATE NONCLUSTERED INDEX [IX_caja_movimiento_id_caja] ON [dbo].[caja_movimiento]
(
	[id_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_caja_movimiento_id_tipo_movimiento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_caja_movimiento_id_tipo_movimiento')
CREATE NONCLUSTERED INDEX [IX_caja_movimiento_id_tipo_movimiento] ON [dbo].[caja_movimiento]
(
	[id_tipo_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_caja_movimiento_id_usuario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_caja_movimiento_id_usuario')
CREATE NONCLUSTERED INDEX [IX_caja_movimiento_id_usuario] ON [dbo].[caja_movimiento]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Catalogo_Sucursal_id_empresa]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Catalogo_Sucursal_id_empresa')
CREATE NONCLUSTERED INDEX [IX_Catalogo_Sucursal_id_empresa] ON [dbo].[Catalogo_Sucursal]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_impresora_comando_id_impresora]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_impresora_comando_id_impresora')
CREATE NONCLUSTERED INDEX [IX_impresora_comando_id_impresora] ON [dbo].[impresora_comando]
(
	[id_impresora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_impuesto_producto_id_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_impuesto_producto_id_producto')
CREATE NONCLUSTERED INDEX [IX_impuesto_producto_id_producto] ON [dbo].[impuesto_producto]
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_operaciones_id_modulo]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_operaciones_id_modulo')
CREATE NONCLUSTERED INDEX [IX_operaciones_id_modulo] ON [dbo].[operaciones]
(
	[id_modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_id_marca]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_id_marca')
CREATE NONCLUSTERED INDEX [IX_producto_id_marca] ON [dbo].[producto]
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_id_presentacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_id_presentacion')
CREATE NONCLUSTERED INDEX [IX_producto_id_presentacion] ON [dbo].[producto]
(
	[id_presentacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_id_talla]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_id_talla')
CREATE NONCLUSTERED INDEX [IX_producto_id_talla] ON [dbo].[producto]
(
	[id_talla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_id_unidadmedida]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_id_unidadmedida')
CREATE NONCLUSTERED INDEX [IX_producto_id_unidadmedida] ON [dbo].[producto]
(
	[id_unidadmedida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_clasificacion_id_categoria]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_clasificacion_id_categoria')
CREATE NONCLUSTERED INDEX [IX_producto_clasificacion_id_categoria] ON [dbo].[producto_clasificacion]
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_clasificacion_id_departamento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_clasificacion_id_departamento')
CREATE NONCLUSTERED INDEX [IX_producto_clasificacion_id_departamento] ON [dbo].[producto_clasificacion]
(
	[id_departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_clasificacion_id_subcategoria]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_clasificacion_id_subcategoria')
CREATE NONCLUSTERED INDEX [IX_producto_clasificacion_id_subcategoria] ON [dbo].[producto_clasificacion]
(
	[id_subcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_producto_img_id_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_producto_img_id_producto')
CREATE NONCLUSTERED INDEX [IX_producto_img_id_producto] ON [dbo].[producto_img]
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_rol_operacion_id_operacion]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_rol_operacion_id_operacion')
CREATE NONCLUSTERED INDEX [IX_rol_operacion_id_operacion] ON [dbo].[rol_operacion]
(
	[id_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_rol_operacion_id_rol]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_rol_operacion_id_rol')
CREATE NONCLUSTERED INDEX [IX_rol_operacion_id_rol] ON [dbo].[rol_operacion]
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sucursal_id_empresa]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_sucursal_id_empresa')
CREATE NONCLUSTERED INDEX [IX_sucursal_id_empresa] ON [dbo].[sucursal]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sucursal_id_tipo_sucursal]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_sucursal_id_tipo_sucursal')
CREATE NONCLUSTERED INDEX [IX_sucursal_id_tipo_sucursal] ON [dbo].[sucursal]
(
	[id_tipo_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_sucursal_id_zona]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_sucursal_id_zona')
CREATE NONCLUSTERED INDEX [IX_sucursal_id_zona] ON [dbo].[sucursal]
(
	[id_zona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_usuarios_id_rol]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_usuarios_id_rol')
CREATE NONCLUSTERED INDEX [IX_usuarios_id_rol] ON [dbo].[usuarios]
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_id_caja]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_id_caja')
CREATE NONCLUSTERED INDEX [IX_venta_id_caja] ON [dbo].[venta]
(
	[id_caja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_id_cliente]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_id_cliente')
CREATE NONCLUSTERED INDEX [IX_venta_id_cliente] ON [dbo].[venta]
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_id_tipo_movimiento]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_id_tipo_movimiento')
CREATE NONCLUSTERED INDEX [IX_venta_id_tipo_movimiento] ON [dbo].[venta]
(
	[id_tipo_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_id_usuario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_id_usuario')
CREATE NONCLUSTERED INDEX [IX_venta_id_usuario] ON [dbo].[venta]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_cancelada_id_usuario]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_cancelada_id_usuario')
CREATE NONCLUSTERED INDEX [IX_venta_cancelada_id_usuario] ON [dbo].[venta_cancelada]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_cancelada_id_venta]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_cancelada_id_venta')
CREATE UNIQUE NONCLUSTERED INDEX [IX_venta_cancelada_id_venta] ON [dbo].[venta_cancelada]
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Venta_Descuento_Producto_id_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Venta_Descuento_Producto_id_producto')
CREATE NONCLUSTERED INDEX [IX_Venta_Descuento_Producto_id_producto] ON [dbo].[Venta_Descuento_Producto]
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_pago_id_tipo_pago]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_pago_id_tipo_pago')
CREATE NONCLUSTERED INDEX [IX_venta_pago_id_tipo_pago] ON [dbo].[venta_pago]
(
	[id_tipo_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_pago_id_venta]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_pago_id_venta')
CREATE NONCLUSTERED INDEX [IX_venta_pago_id_venta] ON [dbo].[venta_pago]
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_venta_producto_id_producto]    Script Date: 05/03/2026 01:27:21 p. m. ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_venta_producto_id_producto')
CREATE NONCLUSTERED INDEX [IX_venta_producto_id_producto] ON [dbo].[venta_producto]
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_caja_movimiento_caja_id_caja')
ALTER TABLE [dbo].[caja_movimiento]  WITH CHECK ADD  CONSTRAINT [FK_caja_movimiento_caja_id_caja] FOREIGN KEY([id_caja])
REFERENCES [dbo].[caja] ([id_caja])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[caja_movimiento] CHECK CONSTRAINT [FK_caja_movimiento_caja_id_caja]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_caja_movimiento_tipo_movimiento_id_tipo_movimiento')
ALTER TABLE [dbo].[caja_movimiento]  WITH CHECK ADD  CONSTRAINT [FK_caja_movimiento_tipo_movimiento_id_tipo_movimiento] FOREIGN KEY([id_tipo_movimiento])
REFERENCES [dbo].[tipo_movimiento] ([id_tipo_movimiento])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[caja_movimiento] CHECK CONSTRAINT [FK_caja_movimiento_tipo_movimiento_id_tipo_movimiento]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_caja_movimiento_usuarios_id_usuario')
ALTER TABLE [dbo].[caja_movimiento]  WITH CHECK ADD  CONSTRAINT [FK_caja_movimiento_usuarios_id_usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuarios] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[caja_movimiento] CHECK CONSTRAINT [FK_caja_movimiento_usuarios_id_usuario]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Catalogo_Sucursal_empresa_id_empresa')
ALTER TABLE [dbo].[Catalogo_Sucursal]  WITH CHECK ADD  CONSTRAINT [FK_Catalogo_Sucursal_empresa_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Catalogo_Sucursal] CHECK CONSTRAINT [FK_Catalogo_Sucursal_empresa_id_empresa]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_CPrueba_producto_id_producto')
ALTER TABLE [dbo].[CPrueba]  WITH CHECK ADD  CONSTRAINT [FK_CPrueba_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CPrueba] CHECK CONSTRAINT [FK_CPrueba_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_impresora_comando_impresora_id_impresora')
ALTER TABLE [dbo].[impresora_comando]  WITH CHECK ADD  CONSTRAINT [FK_impresora_comando_impresora_id_impresora] FOREIGN KEY([id_impresora])
REFERENCES [dbo].[impresora] ([id_impresora])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[impresora_comando] CHECK CONSTRAINT [FK_impresora_comando_impresora_id_impresora]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_impuesto_producto_Impuesto_Detalle_id_lista_impuesto')
ALTER TABLE [dbo].[impuesto_producto]  WITH CHECK ADD  CONSTRAINT [FK_impuesto_producto_Impuesto_Detalle_id_lista_impuesto] FOREIGN KEY([id_lista_impuesto])
REFERENCES [dbo].[Impuesto_Detalle] ([id_impuesto])
GO
ALTER TABLE [dbo].[impuesto_producto] CHECK CONSTRAINT [FK_impuesto_producto_Impuesto_Detalle_id_lista_impuesto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_impuesto_producto_producto_id_producto')
ALTER TABLE [dbo].[impuesto_producto]  WITH CHECK ADD  CONSTRAINT [FK_impuesto_producto_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[impuesto_producto] CHECK CONSTRAINT [FK_impuesto_producto_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_inventario_producto_id_producto')
ALTER TABLE [dbo].[inventario]  WITH CHECK ADD  CONSTRAINT [FK_inventario_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventario] CHECK CONSTRAINT [FK_inventario_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_operaciones_modulos_id_modulo')
ALTER TABLE [dbo].[operaciones]  WITH CHECK ADD  CONSTRAINT [FK_operaciones_modulos_id_modulo] FOREIGN KEY([id_modulo])
REFERENCES [dbo].[modulos] ([id_modulo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[operaciones] CHECK CONSTRAINT [FK_operaciones_modulos_id_modulo]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_marca_id_marca')
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_marca_id_marca] FOREIGN KEY([id_marca])
REFERENCES [dbo].[marca] ([id_marca])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_marca_id_marca]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_presentacion_id_presentacion')
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_presentacion_id_presentacion] FOREIGN KEY([id_presentacion])
REFERENCES [dbo].[presentacion] ([id_presentacion])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_presentacion_id_presentacion]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_talla_id_talla')
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_talla_id_talla] FOREIGN KEY([id_talla])
REFERENCES [dbo].[talla] ([id_talla])
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_talla_id_talla]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_unidadmedida_id_unidadmedida')
ALTER TABLE [dbo].[producto]  WITH CHECK ADD  CONSTRAINT [FK_producto_unidadmedida_id_unidadmedida] FOREIGN KEY([id_unidadmedida])
REFERENCES [dbo].[unidadmedida] ([id_unidadmedida])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_unidadmedida_id_unidadmedida]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_clasificacion_categoria_id_categoria')
ALTER TABLE [dbo].[producto_clasificacion]  WITH CHECK ADD  CONSTRAINT [FK_producto_clasificacion_categoria_id_categoria] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[categoria] ([id_categoria])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_clasificacion] CHECK CONSTRAINT [FK_producto_clasificacion_categoria_id_categoria]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_clasificacion_departamento_id_departamento')
ALTER TABLE [dbo].[producto_clasificacion]  WITH CHECK ADD  CONSTRAINT [FK_producto_clasificacion_departamento_id_departamento] FOREIGN KEY([id_departamento])
REFERENCES [dbo].[departamento] ([id_departamento])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_clasificacion] CHECK CONSTRAINT [FK_producto_clasificacion_departamento_id_departamento]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_clasificacion_producto_id_producto')
ALTER TABLE [dbo].[producto_clasificacion]  WITH CHECK ADD  CONSTRAINT [FK_producto_clasificacion_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_clasificacion] CHECK CONSTRAINT [FK_producto_clasificacion_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_clasificacion_subcategoria_id_subcategoria')
ALTER TABLE [dbo].[producto_clasificacion]  WITH CHECK ADD  CONSTRAINT [FK_producto_clasificacion_subcategoria_id_subcategoria] FOREIGN KEY([id_subcategoria])
REFERENCES [dbo].[subcategoria] ([id_subcategoria])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_clasificacion] CHECK CONSTRAINT [FK_producto_clasificacion_subcategoria_id_subcategoria]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_img_producto_id_producto')
ALTER TABLE [dbo].[producto_img]  WITH CHECK ADD  CONSTRAINT [FK_producto_img_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_img] CHECK CONSTRAINT [FK_producto_img_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_recomendado_producto_id_producto')
ALTER TABLE [dbo].[producto_recomendado]  WITH CHECK ADD  CONSTRAINT [FK_producto_recomendado_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_recomendado] CHECK CONSTRAINT [FK_producto_recomendado_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_producto_remplazo_producto_id_producto')
ALTER TABLE [dbo].[producto_remplazo]  WITH CHECK ADD  CONSTRAINT [FK_producto_remplazo_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[producto_remplazo] CHECK CONSTRAINT [FK_producto_remplazo_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_rol_operacion_operaciones_id_operacion')
ALTER TABLE [dbo].[rol_operacion]  WITH CHECK ADD  CONSTRAINT [FK_rol_operacion_operaciones_id_operacion] FOREIGN KEY([id_operacion])
REFERENCES [dbo].[operaciones] ([id_operacion])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[rol_operacion] CHECK CONSTRAINT [FK_rol_operacion_operaciones_id_operacion]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_rol_operacion_rol_id_rol')
ALTER TABLE [dbo].[rol_operacion]  WITH CHECK ADD  CONSTRAINT [FK_rol_operacion_rol_id_rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id_rol])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[rol_operacion] CHECK CONSTRAINT [FK_rol_operacion_rol_id_rol]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_sucursal_empresa_id_empresa')
ALTER TABLE [dbo].[sucursal]  WITH CHECK ADD  CONSTRAINT [FK_sucursal_empresa_id_empresa] FOREIGN KEY([id_empresa])
REFERENCES [dbo].[empresa] ([id_empresa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sucursal] CHECK CONSTRAINT [FK_sucursal_empresa_id_empresa]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_sucursal_tipo_sucursal_id_tipo_sucursal')
ALTER TABLE [dbo].[sucursal]  WITH CHECK ADD  CONSTRAINT [FK_sucursal_tipo_sucursal_id_tipo_sucursal] FOREIGN KEY([id_tipo_sucursal])
REFERENCES [dbo].[tipo_sucursal] ([id_tipo_sucursal])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sucursal] CHECK CONSTRAINT [FK_sucursal_tipo_sucursal_id_tipo_sucursal]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_sucursal_zona_id_zona')
ALTER TABLE [dbo].[sucursal]  WITH CHECK ADD  CONSTRAINT [FK_sucursal_zona_id_zona] FOREIGN KEY([id_zona])
REFERENCES [dbo].[zona] ([id_zona])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sucursal] CHECK CONSTRAINT [FK_sucursal_zona_id_zona]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_usuarios_rol_id_rol')
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD  CONSTRAINT [FK_usuarios_rol_id_rol] FOREIGN KEY([id_rol])
REFERENCES [dbo].[rol] ([id_rol])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuarios] CHECK CONSTRAINT [FK_usuarios_rol_id_rol]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_caja_id_caja')
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_caja_id_caja] FOREIGN KEY([id_caja])
REFERENCES [dbo].[caja] ([id_caja])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_caja_id_caja]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_cliente_id_cliente')
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_cliente_id_cliente] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[cliente] ([id_cliente])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_cliente_id_cliente]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_tipo_movimiento_id_tipo_movimiento')
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_tipo_movimiento_id_tipo_movimiento] FOREIGN KEY([id_tipo_movimiento])
REFERENCES [dbo].[tipo_movimiento] ([id_tipo_movimiento])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_tipo_movimiento_id_tipo_movimiento]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_usuarios_id_usuario')
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK_venta_usuarios_id_usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuarios] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK_venta_usuarios_id_usuario]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_cancelada_usuarios_id_usuario')
ALTER TABLE [dbo].[venta_cancelada]  WITH CHECK ADD  CONSTRAINT [FK_venta_cancelada_usuarios_id_usuario] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuarios] ([id_usuario])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta_cancelada] CHECK CONSTRAINT [FK_venta_cancelada_usuarios_id_usuario]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_cancelada_venta_id_venta')
ALTER TABLE [dbo].[venta_cancelada]  WITH CHECK ADD  CONSTRAINT [FK_venta_cancelada_venta_id_venta] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[venta_cancelada] CHECK CONSTRAINT [FK_venta_cancelada_venta_id_venta]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Venta_Descuento_Producto_producto_id_producto')
ALTER TABLE [dbo].[Venta_Descuento_Producto]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Descuento_Producto_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Venta_Descuento_Producto] CHECK CONSTRAINT [FK_Venta_Descuento_Producto_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Venta_Descuento_Producto_venta_id_venta')
ALTER TABLE [dbo].[Venta_Descuento_Producto]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Descuento_Producto_venta_id_venta] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[Venta_Descuento_Producto] CHECK CONSTRAINT [FK_Venta_Descuento_Producto_venta_id_venta]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_pago_tipo_pago_id_tipo_pago')
ALTER TABLE [dbo].[venta_pago]  WITH CHECK ADD  CONSTRAINT [FK_venta_pago_tipo_pago_id_tipo_pago] FOREIGN KEY([id_tipo_pago])
REFERENCES [dbo].[tipo_pago] ([id_tipo_pago])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta_pago] CHECK CONSTRAINT [FK_venta_pago_tipo_pago_id_tipo_pago]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_pago_venta_id_venta')
ALTER TABLE [dbo].[venta_pago]  WITH CHECK ADD  CONSTRAINT [FK_venta_pago_venta_id_venta] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[venta_pago] CHECK CONSTRAINT [FK_venta_pago_venta_id_venta]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_producto_producto_id_producto')
ALTER TABLE [dbo].[venta_producto]  WITH CHECK ADD  CONSTRAINT [FK_venta_producto_producto_id_producto] FOREIGN KEY([id_producto])
REFERENCES [dbo].[producto] ([id_producto])
GO
ALTER TABLE [dbo].[venta_producto] CHECK CONSTRAINT [FK_venta_producto_producto_id_producto]
GO
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_venta_producto_venta_id_venta')
ALTER TABLE [dbo].[venta_producto]  WITH CHECK ADD  CONSTRAINT [FK_venta_producto_venta_id_venta] FOREIGN KEY([id_venta])
REFERENCES [dbo].[venta] ([id_venta])
GO
ALTER TABLE [dbo].[venta_producto] CHECK CONSTRAINT [FK_venta_producto_venta_id_venta]
GO
