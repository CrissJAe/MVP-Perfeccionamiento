IF OBJECT_ID('TipoEstado', 'U') IS NOT NULL DROP TABLE TipoEstado;
CREATE TABLE TipoEstado (
    id_estado       INT             NOT NULL IDENTITY(1,1),
    codigo          VARCHAR(30)     NOT NULL,
    descripcion     VARCHAR(100)    NOT NULL,
    tipo_proceso    CHAR(1)         NOT NULL DEFAULT '*',
    orden           INT             NOT NULL DEFAULT 0,
    activo          BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoEstado PRIMARY KEY (id_estado),
    CONSTRAINT UQ_TipoEstado_codigo UNIQUE (codigo)
);
GO

IF OBJECT_ID('TipoPerfeccionamiento', 'U') IS NOT NULL DROP TABLE TipoPerfeccionamiento;
CREATE TABLE TipoPerfeccionamiento (
    id_tipo         INT             NOT NULL IDENTITY(1,1),
    descripcion     VARCHAR(50)     NOT NULL,
    activo          BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoPerfeccionamiento PRIMARY KEY (id_tipo)
);
GO

IF OBJECT_ID('TipoGrado', 'U') IS NOT NULL DROP TABLE TipoGrado;
CREATE TABLE TipoGrado (
    id_tipo_grado   INT             NOT NULL IDENTITY(1,1),
    descripcion     VARCHAR(50)     NOT NULL,
    activo          BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoGrado PRIMARY KEY (id_tipo_grado)
);
GO

IF OBJECT_ID('TipoBeneficio', 'U') IS NOT NULL DROP TABLE TipoBeneficio;
CREATE TABLE TipoBeneficio (
    id_beneficio            INT             NOT NULL IDENTITY(1,1),
    codigo                  VARCHAR(50)     NOT NULL,
    descripcion             VARCHAR(100)    NOT NULL,
    tiene_n_horas           BIT             NOT NULL DEFAULT 0,
    tiene_monto_mensual     BIT             NOT NULL DEFAULT 0,
    tiene_monto_viaje       BIT             NOT NULL DEFAULT 0,
    tiene_valor_ida         BIT             NOT NULL DEFAULT 0,
    tiene_valor_regreso     BIT             NOT NULL DEFAULT 0,
    tiene_valor_ida_regreso BIT             NOT NULL DEFAULT 0,
    tiene_valor_matricula   BIT             NOT NULL DEFAULT 0,
    tiene_valor_arancel     BIT             NOT NULL DEFAULT 0,
    tiene_monto_seguro      BIT             NOT NULL DEFAULT 0,
    activo                  BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoBeneficio PRIMARY KEY (id_beneficio),
    CONSTRAINT UQ_TipoBeneficio_codigo UNIQUE (codigo)
);
GO

IF OBJECT_ID('TipoDocumento', 'U') IS NOT NULL DROP TABLE TipoDocumento;
CREATE TABLE TipoDocumento (
    id_tipo_doc     INT             NOT NULL IDENTITY(1,1),
    nombre          VARCHAR(150)    NOT NULL,
    proceso         CHAR(1)         NOT NULL,
    obligatorio     BIT             NOT NULL DEFAULT 1,
    activo          BIT             NOT NULL DEFAULT 1,
    CONSTRAINT PK_TipoDocumento PRIMARY KEY (id_tipo_doc)
);
GO

IF OBJECT_ID('SecuenciaFolio', 'U') IS NOT NULL DROP TABLE SecuenciaFolio;
CREATE TABLE SecuenciaFolio (
    tipo_proceso    CHAR(1)         NOT NULL,
    anio            INT             NOT NULL,
    ultimo_numero   INT             NOT NULL DEFAULT 0,
    CONSTRAINT PK_SecuenciaFolio PRIMARY KEY (tipo_proceso, anio)
);
GO

IF OBJECT_ID('Academico', 'U') IS NOT NULL DROP TABLE Academico;
CREATE TABLE Academico (
    rut                 VARCHAR(12)     NOT NULL,
    ap_paterno          VARCHAR(100)    NOT NULL,
    ap_materno          VARCHAR(100)    NOT NULL,
    nombres             VARCHAR(150)    NOT NULL,
    facultad            VARCHAR(150)    NOT NULL,
    departamento        VARCHAR(150)    NOT NULL,
    anio_ingreso        INT             NULL,
    tipo_jornada        VARCHAR(50)     NULL,
    email               VARCHAR(150)    NULL,
    fecha_sincronizacion DATETIME       NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Academico PRIMARY KEY (rut)
);
GO

IF OBJECT_ID('Solicitud', 'U') IS NOT NULL DROP TABLE Solicitud;
CREATE TABLE Solicitud (
    id_solicitud                INT             NOT NULL IDENTITY(1,1),
    folio                       VARCHAR(20)     NULL,
    rut_academico               VARCHAR(12)     NOT NULL,
    id_estado                   INT             NOT NULL,
    id_tipo_perfeccionamiento   INT             NOT NULL,
    id_tipo_grado               INT             NULL,
    nombre_programa             VARCHAR(200)    NOT NULL,
    institucion_destino         VARCHAR(200)    NOT NULL,
    pais                        VARCHAR(100)    NOT NULL,
    fecha_inicio                DATE            NOT NULL,
    fecha_termino               DATE            NOT NULL,
    fecha_salida_ubb            DATE            NULL,
    financiamiento_externo      VARCHAR(300)    NULL,
    razones_patrocinio          VARCHAR(4000)   NULL,
    informacion_adicional       VARCHAR(4000)   NULL,
    ruta_pdf                    VARCHAR(500)    NULL,
    fecha_creacion              DATETIME        NOT NULL DEFAULT GETDATE(),
    fecha_envio                 DATETIME        NULL,
    fecha_modificacion          DATETIME        NULL,
    usuario_creacion            VARCHAR(50)     NOT NULL,
    usuario_modificacion        VARCHAR(50)     NULL,
    CONSTRAINT PK_Solicitud PRIMARY KEY (id_solicitud),
    CONSTRAINT FK_Solicitud_Academico
        FOREIGN KEY (rut_academico) REFERENCES Academico(rut),
    CONSTRAINT FK_Solicitud_Estado
        FOREIGN KEY (id_estado) REFERENCES TipoEstado(id_estado),
    CONSTRAINT FK_Solicitud_TipoPerfeccionamiento
        FOREIGN KEY (id_tipo_perfeccionamiento) REFERENCES TipoPerfeccionamiento(id_tipo),
    CONSTRAINT FK_Solicitud_TipoGrado
        FOREIGN KEY (id_tipo_grado) REFERENCES TipoGrado(id_tipo_grado)
);
GO

IF OBJECT_ID('SolicitudBeneficio', 'U') IS NOT NULL DROP TABLE SolicitudBeneficio;
CREATE TABLE SolicitudBeneficio (
    id_sol_beneficio    INT             NOT NULL IDENTITY(1,1),
    id_solicitud        INT             NOT NULL,
    id_tipo_beneficio   INT             NOT NULL,
    n_horas             INT             NULL,
    monto_mensual       DECIMAL(12,2)   NULL,
    monto_total_viaje   DECIMAL(12,2)   NULL,
    valor_ida           DECIMAL(12,2)   NULL,
    valor_regreso       DECIMAL(12,2)   NULL,
    valor_ida_regreso   DECIMAL(12,2)   NULL,
    valor_matricula     DECIMAL(12,2)   NULL,
    valor_arancel       DECIMAL(12,2)   NULL,
    monto_seguro        DECIMAL(12,2)   NULL,
    CONSTRAINT PK_SolicitudBeneficio PRIMARY KEY (id_sol_beneficio),
    CONSTRAINT FK_SolBeneficio_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
    CONSTRAINT FK_SolBeneficio_Tipo
        FOREIGN KEY (id_tipo_beneficio) REFERENCES TipoBeneficio(id_beneficio),
    CONSTRAINT UQ_SolBeneficio UNIQUE (id_solicitud, id_tipo_beneficio)
);
GO

IF OBJECT_ID('SolicitudDocumento', 'U') IS NOT NULL DROP TABLE SolicitudDocumento;
CREATE TABLE SolicitudDocumento (
    id_sol_documento    INT             NOT NULL IDENTITY(1,1),
    id_solicitud        INT             NOT NULL,
    id_tipo_doc         INT             NOT NULL,
    ruta_archivo        VARCHAR(500)    NULL,
    nombre_original     VARCHAR(255)    NULL,
    estado_doc          VARCHAR(20)     NOT NULL DEFAULT 'PENDIENTE',
    bloqueado           BIT             NOT NULL DEFAULT 0,
    fecha_subida        DATETIME        NULL,
    usuario_subida      VARCHAR(50)     NULL,
    CONSTRAINT PK_SolicitudDocumento PRIMARY KEY (id_sol_documento),
    CONSTRAINT FK_SolDocumento_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
    CONSTRAINT FK_SolDocumento_Tipo
        FOREIGN KEY (id_tipo_doc) REFERENCES TipoDocumento(id_tipo_doc)
);
GO

IF OBJECT_ID('SolicitudDocumentoAdicional', 'U') IS NOT NULL DROP TABLE SolicitudDocumentoAdicional;
CREATE TABLE SolicitudDocumentoAdicional (
    id_sol_doc_adicional    INT             NOT NULL IDENTITY(1,1),
    id_solicitud            INT             NOT NULL,
    nombre_documento        VARCHAR(255)    NOT NULL,
    ruta_archivo            VARCHAR(500)    NOT NULL,
    nombre_original         VARCHAR(255)    NOT NULL,
    fecha_subida            DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_subida          VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_SolicitudDocumentoAdicional PRIMARY KEY (id_sol_doc_adicional),
    CONSTRAINT FK_SolDocAdicional_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud)
);
GO

IF OBJECT_ID('SolicitudHistorial', 'U') IS NOT NULL DROP TABLE SolicitudHistorial;
CREATE TABLE SolicitudHistorial (
    id_historial        INT             NOT NULL IDENTITY(1,1),
    id_solicitud        INT             NOT NULL,
    id_estado_nuevo     INT             NOT NULL,
    observacion         VARCHAR(4000)   NULL,
    fecha_evento        DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_evento      VARCHAR(50)     NOT NULL,
    rol_usuario         VARCHAR(30)     NOT NULL,
    CONSTRAINT PK_SolicitudHistorial PRIMARY KEY (id_historial),
    CONSTRAINT FK_SolHistorial_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
    CONSTRAINT FK_SolHistorial_Estado
        FOREIGN KEY (id_estado_nuevo) REFERENCES TipoEstado(id_estado)
);
GO

IF OBJECT_ID('Renovacion', 'U') IS NOT NULL DROP TABLE Renovacion;
CREATE TABLE Renovacion (
    id_renovacion               INT             NOT NULL IDENTITY(1,1),
    folio                       VARCHAR(20)     NULL,
    id_solicitud                INT             NOT NULL,
    id_estado                   INT             NOT NULL,
    numero_renovacion           INT             NOT NULL,
    grado_academico             VARCHAR(100)    NOT NULL,
    nombre_programa             VARCHAR(200)    NOT NULL,
    institucion                 VARCHAR(200)    NOT NULL,
    pais                        VARCHAR(100)    NOT NULL,
    fecha_inicio_programa       DATE            NOT NULL,
    fecha_inicio_renovacion     DATE            NOT NULL,
    fecha_termino_renovacion    DATE            NOT NULL,
    financiamiento_becas        VARCHAR(300)    NULL,
    financiamiento_interno      VARCHAR(300)    NULL,
    razones_renovacion          VARCHAR(4000)   NULL,
    informacion_adicional       VARCHAR(4000)   NULL,
    ruta_pdf                    VARCHAR(500)    NULL,
    fecha_creacion              DATETIME        NOT NULL DEFAULT GETDATE(),
    fecha_envio                 DATETIME        NULL,
    fecha_modificacion          DATETIME        NULL,
    usuario_creacion            VARCHAR(50)     NOT NULL,
    usuario_modificacion        VARCHAR(50)     NULL,
    CONSTRAINT PK_Renovacion PRIMARY KEY (id_renovacion),
    CONSTRAINT FK_Renovacion_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
    CONSTRAINT FK_Renovacion_Estado
        FOREIGN KEY (id_estado) REFERENCES TipoEstado(id_estado)
);
GO

IF OBJECT_ID('RenovacionBeneficio', 'U') IS NOT NULL DROP TABLE RenovacionBeneficio;
CREATE TABLE RenovacionBeneficio (
    id_ren_beneficio    INT             NOT NULL IDENTITY(1,1),
    id_renovacion       INT             NOT NULL,
    id_tipo_beneficio   INT             NOT NULL,
    n_horas             INT             NULL,
    monto_mensual       DECIMAL(12,2)   NULL,
    monto_total_viaje   DECIMAL(12,2)   NULL,
    valor_ida           DECIMAL(12,2)   NULL,
    valor_regreso       DECIMAL(12,2)   NULL,
    valor_ida_regreso   DECIMAL(12,2)   NULL,
    valor_matricula     DECIMAL(12,2)   NULL,
    valor_arancel       DECIMAL(12,2)   NULL,
    monto_seguro        DECIMAL(12,2)   NULL,
    CONSTRAINT PK_RenovacionBeneficio PRIMARY KEY (id_ren_beneficio),
    CONSTRAINT FK_RenBeneficio_Renovacion
        FOREIGN KEY (id_renovacion) REFERENCES Renovacion(id_renovacion),
    CONSTRAINT FK_RenBeneficio_Tipo
        FOREIGN KEY (id_tipo_beneficio) REFERENCES TipoBeneficio(id_beneficio),
    CONSTRAINT UQ_RenBeneficio UNIQUE (id_renovacion, id_tipo_beneficio)
);
GO

IF OBJECT_ID('RenovacionDocumento', 'U') IS NOT NULL DROP TABLE RenovacionDocumento;
CREATE TABLE RenovacionDocumento (
    id_ren_documento    INT             NOT NULL IDENTITY(1,1),
    id_renovacion       INT             NOT NULL,
    id_tipo_doc         INT             NOT NULL,
    ruta_archivo        VARCHAR(500)    NULL,
    nombre_original     VARCHAR(255)    NULL,
    estado_doc          VARCHAR(20)     NOT NULL DEFAULT 'PENDIENTE',
    bloqueado           BIT             NOT NULL DEFAULT 0,
    fecha_subida        DATETIME        NULL,
    usuario_subida      VARCHAR(50)     NULL,
    CONSTRAINT PK_RenovacionDocumento PRIMARY KEY (id_ren_documento),
    CONSTRAINT FK_RenDocumento_Renovacion
        FOREIGN KEY (id_renovacion) REFERENCES Renovacion(id_renovacion),
    CONSTRAINT FK_RenDocumento_Tipo
        FOREIGN KEY (id_tipo_doc) REFERENCES TipoDocumento(id_tipo_doc)
);
GO

IF OBJECT_ID('RenovacionDocumentoAdicional', 'U') IS NOT NULL DROP TABLE RenovacionDocumentoAdicional;
CREATE TABLE RenovacionDocumentoAdicional (
    id_ren_doc_adicional    INT             NOT NULL IDENTITY(1,1),
    id_renovacion           INT             NOT NULL,
    nombre_documento        VARCHAR(255)    NOT NULL,
    ruta_archivo            VARCHAR(500)    NOT NULL,
    nombre_original         VARCHAR(255)    NOT NULL,
    fecha_subida            DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_subida          VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_RenovacionDocumentoAdicional PRIMARY KEY (id_ren_doc_adicional),
    CONSTRAINT FK_RenDocAdicional_Renovacion
        FOREIGN KEY (id_renovacion) REFERENCES Renovacion(id_renovacion)
);
GO

IF OBJECT_ID('RenovacionHistorial', 'U') IS NOT NULL DROP TABLE RenovacionHistorial;
CREATE TABLE RenovacionHistorial (
    id_historial        INT             NOT NULL IDENTITY(1,1),
    id_renovacion       INT             NOT NULL,
    id_estado_nuevo     INT             NOT NULL,
    observacion         VARCHAR(4000)   NULL,
    fecha_evento        DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_evento      VARCHAR(50)     NOT NULL,
    rol_usuario         VARCHAR(30)     NOT NULL,
    CONSTRAINT PK_RenovacionHistorial PRIMARY KEY (id_historial),
    CONSTRAINT FK_RenHistorial_Renovacion
        FOREIGN KEY (id_renovacion) REFERENCES Renovacion(id_renovacion),
    CONSTRAINT FK_RenHistorial_Estado
        FOREIGN KEY (id_estado_nuevo) REFERENCES TipoEstado(id_estado)
);
GO

IF OBJECT_ID('Cierre', 'U') IS NOT NULL DROP TABLE Cierre;
CREATE TABLE Cierre (
    id_cierre                   INT             NOT NULL IDENTITY(1,1),
    folio                       VARCHAR(20)     NULL,
    id_solicitud                INT             NOT NULL,
    id_estado                   INT             NOT NULL,
    tipo_cierre                 CHAR(1)         NOT NULL DEFAULT 'E',
    grado_obtenido              VARCHAR(100)    NOT NULL,
    nombre_programa             VARCHAR(200)    NOT NULL,
    institucion                 VARCHAR(200)    NOT NULL,
    pais                        VARCHAR(100)    NOT NULL,
    fecha_inicio_programa       DATE            NOT NULL,
    fecha_termino_programa      DATE            NOT NULL,
    fecha_reincorporacion_ubb   DATE            NULL,
    situacion_actual            VARCHAR(4000)   NULL,
    informacion_adicional       VARCHAR(4000)   NULL,
    ruta_pdf                    VARCHAR(500)    NULL,
    fecha_creacion              DATETIME        NOT NULL DEFAULT GETDATE(),
    fecha_envio                 DATETIME        NULL,
    fecha_modificacion          DATETIME        NULL,
    usuario_creacion            VARCHAR(50)     NOT NULL,
    usuario_modificacion        VARCHAR(50)     NULL,
    CONSTRAINT PK_Cierre PRIMARY KEY (id_cierre),
    CONSTRAINT FK_Cierre_Solicitud
        FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
    CONSTRAINT FK_Cierre_Estado
        FOREIGN KEY (id_estado) REFERENCES TipoEstado(id_estado),
    CONSTRAINT CK_Cierre_tipo CHECK (tipo_cierre IN ('E', 'C'))
);
GO

IF OBJECT_ID('CierreDocumento', 'U') IS NOT NULL DROP TABLE CierreDocumento;
CREATE TABLE CierreDocumento (
    id_cie_documento    INT             NOT NULL IDENTITY(1,1),
    id_cierre           INT             NOT NULL,
    id_tipo_doc         INT             NOT NULL,
    ruta_archivo        VARCHAR(500)    NULL,
    nombre_original     VARCHAR(255)    NULL,
    estado_doc          VARCHAR(20)     NOT NULL DEFAULT 'PENDIENTE',
    bloqueado           BIT             NOT NULL DEFAULT 0,
    fecha_subida        DATETIME        NULL,
    usuario_subida      VARCHAR(50)     NULL,
    CONSTRAINT PK_CierreDocumento PRIMARY KEY (id_cie_documento),
    CONSTRAINT FK_CieDocumento_Cierre
        FOREIGN KEY (id_cierre) REFERENCES Cierre(id_cierre),
    CONSTRAINT FK_CieDocumento_Tipo
        FOREIGN KEY (id_tipo_doc) REFERENCES TipoDocumento(id_tipo_doc)
);
GO

IF OBJECT_ID('CierreDocumentoAdicional', 'U') IS NOT NULL DROP TABLE CierreDocumentoAdicional;
CREATE TABLE CierreDocumentoAdicional (
    id_cie_doc_adicional    INT             NOT NULL IDENTITY(1,1),
    id_cierre               INT             NOT NULL,
    nombre_documento        VARCHAR(255)    NOT NULL,
    ruta_archivo            VARCHAR(500)    NOT NULL,
    nombre_original         VARCHAR(255)    NOT NULL,
    fecha_subida            DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_subida          VARCHAR(50)     NOT NULL,
    CONSTRAINT PK_CierreDocumentoAdicional PRIMARY KEY (id_cie_doc_adicional),
    CONSTRAINT FK_CieDocAdicional_Cierre
        FOREIGN KEY (id_cierre) REFERENCES Cierre(id_cierre)
);
GO

IF OBJECT_ID('CierreHistorial', 'U') IS NOT NULL DROP TABLE CierreHistorial;
CREATE TABLE CierreHistorial (
    id_historial        INT             NOT NULL IDENTITY(1,1),
    id_cierre           INT             NOT NULL,
    id_estado_nuevo     INT             NOT NULL,
    observacion         VARCHAR(4000)   NULL,
    fecha_evento        DATETIME        NOT NULL DEFAULT GETDATE(),
    usuario_evento      VARCHAR(50)     NOT NULL,
    rol_usuario         VARCHAR(30)     NOT NULL,
    CONSTRAINT PK_CierreHistorial PRIMARY KEY (id_historial),
    CONSTRAINT FK_CieHistorial_Cierre
        FOREIGN KEY (id_cierre) REFERENCES Cierre(id_cierre),
    CONSTRAINT FK_CieHistorial_Estado
        FOREIGN KEY (id_estado_nuevo) REFERENCES TipoEstado(id_estado)
);
GO