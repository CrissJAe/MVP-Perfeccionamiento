if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE') and o.name = 'FK_CIERRE_SOLICITUD')
alter table dbo.CIERRE
   drop constraint FK_CIERRE_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE') and o.name = 'FK_CIERRE_TIPO_ESTADO')
alter table dbo.CIERRE
   drop constraint FK_CIERRE_TIPO_ESTADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE') and o.name = 'FK_CIERRE_TIPO_GRADO')
alter table dbo.CIERRE
   drop constraint FK_CIERRE_TIPO_GRADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE_DOCUMENTO') and o.name = 'FK_CIERRE_DOCUMENTO_CIERRE')
alter table dbo.CIERRE_DOCUMENTO
   drop constraint FK_CIERRE_DOCUMENTO_CIERRE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE_DOCUMENTO') and o.name = 'FK_CIERRE_DOCUMENTO_TIPO_DOCUMENTO')
alter table dbo.CIERRE_DOCUMENTO
   drop constraint FK_CIERRE_DOCUMENTO_TIPO_DOCUMENTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE_DOCUMENTO_ADICIONAL') and o.name = 'FK_CIERRE_DOCUMENTO_ADICIONAL_CIERRE')
alter table dbo.CIERRE_DOCUMENTO_ADICIONAL
   drop constraint FK_CIERRE_DOCUMENTO_ADICIONAL_CIERRE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE_HISTORIAL') and o.name = 'FK_CIERRE_HISTORIAL_CIERRE')
alter table dbo.CIERRE_HISTORIAL
   drop constraint FK_CIERRE_HISTORIAL_CIERRE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.CIERRE_HISTORIAL') and o.name = 'FK_CIERRE_HISTORIAL_TIPO_ESTADO')
alter table dbo.CIERRE_HISTORIAL
   drop constraint FK_CIERRE_HISTORIAL_TIPO_ESTADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION') and o.name = 'FK_RENOVACION_SOLICITUD')
alter table dbo.RENOVACION
   drop constraint FK_RENOVACION_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION') and o.name = 'FK_RENOVACION_TIPO_ESTADO')
alter table dbo.RENOVACION
   drop constraint FK_RENOVACION_TIPO_ESTADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_BENEFICIO') and o.name = 'FK_RENOVACION_BENEFICIO_RENOVACION')
alter table dbo.RENOVACION_BENEFICIO
   drop constraint FK_RENOVACION_BENEFICIO_RENOVACION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_BENEFICIO') and o.name = 'FK_RENOVACION_BENEFICIO_TIPO_BENEFICIO')
alter table dbo.RENOVACION_BENEFICIO
   drop constraint FK_RENOVACION_BENEFICIO_TIPO_BENEFICIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_DOCUMENTO') and o.name = 'FK_RENOVACION_DOCUMENTO_RENOVACION')
alter table dbo.RENOVACION_DOCUMENTO
   drop constraint FK_RENOVACION_DOCUMENTO_RENOVACION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_DOCUMENTO') and o.name = 'FK_RENOVACION_DOCUMENTO_TIPO_DOCUMENTO')
alter table dbo.RENOVACION_DOCUMENTO
   drop constraint FK_RENOVACION_DOCUMENTO_TIPO_DOCUMENTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_DOCUMENTO_ADICIONAL') and o.name = 'FK_RENOVACION_DOCUMENTO_ADICIONAL_RENOVACION')
alter table dbo.RENOVACION_DOCUMENTO_ADICIONAL
   drop constraint FK_RENOVACION_DOCUMENTO_ADICIONAL_RENOVACION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_HISTORIAL') and o.name = 'FK_RENOVACION_HISTORIAL_RENOVACION')
alter table dbo.RENOVACION_HISTORIAL
   drop constraint FK_RENOVACION_HISTORIAL_RENOVACION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.RENOVACION_HISTORIAL') and o.name = 'FK_RENOVACION_HISTORIAL_TIPO_ESTADO')
alter table dbo.RENOVACION_HISTORIAL
   drop constraint FK_RENOVACION_HISTORIAL_TIPO_ESTADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD') and o.name = 'FK_SOLICITUD_ACADEMICO')
alter table dbo.SOLICITUD
   drop constraint FK_SOLICITUD_ACADEMICO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD') and o.name = 'FK_SOLICITUD_TIPO_ESTADO')
alter table dbo.SOLICITUD
   drop constraint FK_SOLICITUD_TIPO_ESTADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD') and o.name = 'FK_SOLICITUD_TIPO_GRADO')
alter table dbo.SOLICITUD
   drop constraint FK_SOLICITUD_TIPO_GRADO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD') and o.name = 'FK_SOLICITUD_TIPO_PERFECCIONAMIENTO')
alter table dbo.SOLICITUD
   drop constraint FK_SOLICITUD_TIPO_PERFECCIONAMIENTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_BENEFICIO') and o.name = 'FK_SOLICITUD_BENEFICIO_SOLICITUD')
alter table dbo.SOLICITUD_BENEFICIO
   drop constraint FK_SOLICITUD_BENEFICIO_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_BENEFICIO') and o.name = 'FK_SOLICITUD_BENEFICIO_TIPO_BENEFICIO')
alter table dbo.SOLICITUD_BENEFICIO
   drop constraint FK_SOLICITUD_BENEFICIO_TIPO_BENEFICIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_DOCUMENTO') and o.name = 'FK_SOLICITUD_DOCUMENTO_SOLICITUD')
alter table dbo.SOLICITUD_DOCUMENTO
   drop constraint FK_SOLICITUD_DOCUMENTO_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_DOCUMENTO') and o.name = 'FK_SOLICITUD_DOCUMENTO_TIPO_DOCUMENTO')
alter table dbo.SOLICITUD_DOCUMENTO
   drop constraint FK_SOLICITUD_DOCUMENTO_TIPO_DOCUMENTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_DOCUMENTO_ADICIONAL') and o.name = 'FK_SOLICITUD_DOCUMENTO_ADICIONAL_SOLICITUD')
alter table dbo.SOLICITUD_DOCUMENTO_ADICIONAL
   drop constraint FK_SOLICITUD_DOCUMENTO_ADICIONAL_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_HISTORIAL') and o.name = 'FK_SOLICITUD_HISTORIAL_SOLICITUD')
alter table dbo.SOLICITUD_HISTORIAL
   drop constraint FK_SOLICITUD_HISTORIAL_SOLICITUD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('dbo.SOLICITUD_HISTORIAL') and o.name = 'FK_SOLICITUD_HISTORIAL_TIPO_ESTADO')
alter table dbo.SOLICITUD_HISTORIAL
   drop constraint FK_SOLICITUD_HISTORIAL_TIPO_ESTADO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.ACADEMICO')
            and   name  = 'IX_ACADEMICO_DEPARTAMENTO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.ACADEMICO.IX_ACADEMICO_DEPARTAMENTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.ACADEMICO')
            and   type = 'U')
   drop table dbo.ACADEMICO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.CIERRE')
            and   name  = 'UX_CIERRE_FOLIO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.CIERRE.UX_CIERRE_FOLIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.CIERRE')
            and   name  = 'IX_CIERRE_SOL_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.CIERRE.IX_CIERRE_SOL_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CIERRE')
            and   type = 'U')
   drop table dbo.CIERRE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.CIERRE_DOCUMENTO')
            and   name  = 'IX_CIERRE_DOCUMENTO_CIE_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.CIERRE_DOCUMENTO.IX_CIERRE_DOCUMENTO_CIE_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CIERRE_DOCUMENTO')
            and   type = 'U')
   drop table dbo.CIERRE_DOCUMENTO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.CIERRE_DOCUMENTO_ADICIONAL')
            and   name  = 'IX_CIERRE_DOCUMENTO_ADICIONAL_CIE_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.CIERRE_DOCUMENTO_ADICIONAL.IX_CIERRE_DOCUMENTO_ADICIONAL_CIE_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CIERRE_DOCUMENTO_ADICIONAL')
            and   type = 'U')
   drop table dbo.CIERRE_DOCUMENTO_ADICIONAL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.CIERRE_HISTORIAL')
            and   name  = 'IX_CIERRE_HISTORIAL_CIE_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.CIERRE_HISTORIAL.IX_CIERRE_HISTORIAL_CIE_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.CIERRE_HISTORIAL')
            and   type = 'U')
   drop table dbo.CIERRE_HISTORIAL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION')
            and   name  = 'UX_RENOVACION_FOLIO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION.UX_RENOVACION_FOLIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION')
            and   name  = 'IX_RENOVACION_SOL_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION.IX_RENOVACION_SOL_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RENOVACION')
            and   type = 'U')
   drop table dbo.RENOVACION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION_BENEFICIO')
            and   name  = 'UX_RENOVACION_BENEFICIO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION_BENEFICIO.UX_RENOVACION_BENEFICIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RENOVACION_BENEFICIO')
            and   type = 'U')
   drop table dbo.RENOVACION_BENEFICIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION_DOCUMENTO')
            and   name  = 'IX_RENOVACION_DOCUMENTO_REN_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION_DOCUMENTO.IX_RENOVACION_DOCUMENTO_REN_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RENOVACION_DOCUMENTO')
            and   type = 'U')
   drop table dbo.RENOVACION_DOCUMENTO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION_DOCUMENTO_ADICIONAL')
            and   name  = 'IX_RENOVACION_DOCUMENTO_ADICIONAL_REN_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION_DOCUMENTO_ADICIONAL.IX_RENOVACION_DOCUMENTO_ADICIONAL_REN_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RENOVACION_DOCUMENTO_ADICIONAL')
            and   type = 'U')
   drop table dbo.RENOVACION_DOCUMENTO_ADICIONAL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.RENOVACION_HISTORIAL')
            and   name  = 'IX_RENOVACION_HISTORIAL_REN_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.RENOVACION_HISTORIAL.IX_RENOVACION_HISTORIAL_REN_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.RENOVACION_HISTORIAL')
            and   type = 'U')
   drop table dbo.RENOVACION_HISTORIAL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SECUENCIA_FOLIO')
            and   type = 'U')
   drop table dbo.SECUENCIA_FOLIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD')
            and   name  = 'UX_SOLICITUD_FOLIO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD.UX_SOLICITUD_FOLIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD')
            and   name  = 'IX_SOLICITUD_TES_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD.IX_SOLICITUD_TES_CODIGO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD')
            and   name  = 'IX_SOLICITUD_ACA_RUT'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD.IX_SOLICITUD_ACA_RUT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SOLICITUD')
            and   type = 'U')
   drop table dbo.SOLICITUD
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD_BENEFICIO')
            and   name  = 'UX_SOLICITUD_BENEFICIO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD_BENEFICIO.UX_SOLICITUD_BENEFICIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SOLICITUD_BENEFICIO')
            and   type = 'U')
   drop table dbo.SOLICITUD_BENEFICIO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD_DOCUMENTO')
            and   name  = 'IX_SOLICITUD_DOCUMENTO_SOL_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD_DOCUMENTO.IX_SOLICITUD_DOCUMENTO_SOL_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SOLICITUD_DOCUMENTO')
            and   type = 'U')
   drop table dbo.SOLICITUD_DOCUMENTO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD_DOCUMENTO_ADICIONAL')
            and   name  = 'IX_SOLICITUD_DOCUMENTO_ADICIONAL_SOL_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD_DOCUMENTO_ADICIONAL.IX_SOLICITUD_DOCUMENTO_ADICIONAL_SOL_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SOLICITUD_DOCUMENTO_ADICIONAL')
            and   type = 'U')
   drop table dbo.SOLICITUD_DOCUMENTO_ADICIONAL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.SOLICITUD_HISTORIAL')
            and   name  = 'IX_SOLICITUD_HISTORIAL_SOL_CODIGO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.SOLICITUD_HISTORIAL.IX_SOLICITUD_HISTORIAL_SOL_CODIGO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.SOLICITUD_HISTORIAL')
            and   type = 'U')
   drop table dbo.SOLICITUD_HISTORIAL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.TIPO_BENEFICIO')
            and   name  = 'UX_TIPO_BENEFICIO_CODIGO_INTERNO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.TIPO_BENEFICIO.UX_TIPO_BENEFICIO_CODIGO_INTERNO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TIPO_BENEFICIO')
            and   type = 'U')
   drop table dbo.TIPO_BENEFICIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TIPO_DOCUMENTO')
            and   type = 'U')
   drop table dbo.TIPO_DOCUMENTO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('dbo.TIPO_ESTADO')
            and   name  = 'UX_TIPO_ESTADO_CODIGO_INTERNO'
            and   indid > 0
            and   indid < 255)
   drop index dbo.TIPO_ESTADO.UX_TIPO_ESTADO_CODIGO_INTERNO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TIPO_ESTADO')
            and   type = 'U')
   drop table dbo.TIPO_ESTADO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TIPO_GRADO')
            and   type = 'U')
   drop table dbo.TIPO_GRADO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('dbo.TIPO_PERFECCIONAMIENTO')
            and   type = 'U')
   drop table dbo.TIPO_PERFECCIONAMIENTO
go

-- drop schema dbo
go

/*==============================================================*/
/* User: dbo                                                    */
/*==============================================================*/
-- create schema dbo
go

/*==============================================================*/
/* Table: ACADEMICO                                             */
/*==============================================================*/
create table dbo.ACADEMICO (
   aca_rut              VARCHAR(12)          not null,
   aca_apellido_paterno VARCHAR(100)         not null,
   aca_apellido_materno VARCHAR(100)         not null,
   aca_nombres          VARCHAR(150)         not null,
   aca_facultad         VARCHAR(150)         not null,
   aca_departamento     VARCHAR(150)         not null,
   aca_ano_ingreso      INT                  null,
   aca_tipo_jornada     VARCHAR(50)          null,
   aca_email            VARCHAR(150)         null,
   aca_fecha_registro   DATETIME             not null default getdate(),
   constraint PK_ACADEMICO primary key (aca_rut)
)
go

/*==============================================================*/
/* Index: IX_ACADEMICO_DEPARTAMENTO                             */
/*==============================================================*/




create nonclustered index IX_ACADEMICO_DEPARTAMENTO on dbo.ACADEMICO (aca_departamento ASC)
go

/*==============================================================*/
/* Table: CIERRE                                                */
/*==============================================================*/
create table dbo.CIERRE (
   cie_codigo           INT                  identity not null,
   cie_folio            VARCHAR(20)          null,
   sol_codigo           INT                  not null,
   tes_codigo           INT                  not null,
   tgr_codigo           INT                  null,
   cie_tipo             CHAR(1)              not null default 'E',
   cie_fecha_inicio_programa DATE                 not null,
   cie_fecha_termino_programa DATE                 not null,
   cie_fecha_reincorporacion_ubb DATE                 null,
   cie_situacion_actual VARCHAR(4000)        null,
   cie_informacion_adicional VARCHAR(4000)        null,
   cie_ruta_pdf         VARCHAR(500)         null,
   cie_fecha_registro   DATETIME             not null default getdate(),
   cie_fecha_envio      DATETIME             null,
   cie_fecha_actualizacion DATETIME             null,
   cie_login_registro   VARCHAR(100)         not null,
   cie_login_actualizacion VARCHAR(100)         null,
   constraint PK_CIERRE primary key (cie_codigo),
   constraint CK_CIERRE_TIPO check (cie_tipo IN ('E', 'C'))
)
go

/*==============================================================*/
/* Index: IX_CIERRE_SOL_CODIGO                                  */
/*==============================================================*/




create nonclustered index IX_CIERRE_SOL_CODIGO on dbo.CIERRE (sol_codigo ASC)
go

/*==============================================================*/
/* Index: UX_CIERRE_FOLIO                                       */
/*==============================================================*/




create unique nonclustered index UX_CIERRE_FOLIO on dbo.CIERRE (cie_folio ASC)
   where cie_folio IS NOT NULL
go

/*==============================================================*/
/* Table: CIERRE_DOCUMENTO                                      */
/*==============================================================*/
create table dbo.CIERRE_DOCUMENTO (
   cdo_codigo           INT                  identity not null,
   cie_codigo           INT                  not null,
   tdo_codigo           INT                  not null,
   cdo_ruta_archivo     VARCHAR(500)         null,
   cdo_nombre_original  VARCHAR(255)         null,
   cdo_estado           VARCHAR(20)          not null default 'PENDIENTE',
   cdo_ind_bloqueado    BIT                  not null default 0,
   cdo_fecha_subida     DATETIME             null,
   cdo_login_subida     VARCHAR(100)         null,
   constraint PK_CIERRE_DOCUMENTO primary key (cdo_codigo)
)
go

/*==============================================================*/
/* Index: IX_CIERRE_DOCUMENTO_CIE_CODIGO                        */
/*==============================================================*/




create nonclustered index IX_CIERRE_DOCUMENTO_CIE_CODIGO on dbo.CIERRE_DOCUMENTO (cie_codigo ASC)
go

/*==============================================================*/
/* Table: CIERRE_DOCUMENTO_ADICIONAL                            */
/*==============================================================*/
create table dbo.CIERRE_DOCUMENTO_ADICIONAL (
   cda_codigo           INT                  identity not null,
   cie_codigo           INT                  not null,
   cda_nombre_documento VARCHAR(255)         not null,
   cda_ruta_archivo     VARCHAR(500)         not null,
   cda_nombre_original  VARCHAR(255)         not null,
   cda_fecha_subida     DATETIME             not null default getdate(),
   cda_login_subida     VARCHAR(100)         not null,
   constraint PK_CIERRE_DOCUMENTO_ADICIONAL primary key (cda_codigo)
)
go

/*==============================================================*/
/* Index: IX_CIERRE_DOCUMENTO_ADICIONAL_CIE_CODIGO              */
/*==============================================================*/




create nonclustered index IX_CIERRE_DOCUMENTO_ADICIONAL_CIE_CODIGO on dbo.CIERRE_DOCUMENTO_ADICIONAL (cie_codigo ASC)
go

/*==============================================================*/
/* Table: CIERRE_HISTORIAL                                      */
/*==============================================================*/
create table dbo.CIERRE_HISTORIAL (
   chi_codigo           INT                  identity not null,
   cie_codigo           INT                  not null,
   tes_codigo           INT                  not null,
   chi_observacion      VARCHAR(4000)        null,
   chi_fecha_evento     DATETIME             not null default getdate(),
   chi_login_evento     VARCHAR(100)         not null,
   chi_rol_usuario      VARCHAR(30)          not null,
   constraint PK_CIERRE_HISTORIAL primary key (chi_codigo)
)
go

/*==============================================================*/
/* Index: IX_CIERRE_HISTORIAL_CIE_CODIGO                        */
/*==============================================================*/




create nonclustered index IX_CIERRE_HISTORIAL_CIE_CODIGO on dbo.CIERRE_HISTORIAL (cie_codigo ASC)
go

/*==============================================================*/
/* Table: RENOVACION                                            */
/*==============================================================*/
create table dbo.RENOVACION (
   ren_codigo           INT                  identity not null,
   ren_folio            VARCHAR(20)          null,
   sol_codigo           INT                  not null,
   tes_codigo           INT                  not null,
   ren_numero           INT                  not null,
   ren_fecha_inicio_programa DATE                 not null,
   ren_fecha_inicio     DATE                 not null,
   ren_fecha_termino    DATE                 not null,
   ren_financiamiento_becas VARCHAR(300)         null,
   ren_financiamiento_interno VARCHAR(300)         null,
   ren_razones          VARCHAR(4000)        null,
   ren_informacion_adicional VARCHAR(4000)        null,
   ren_ruta_pdf         VARCHAR(500)         null,
   ren_fecha_registro   DATETIME             not null default getdate(),
   ren_fecha_envio      DATETIME             null,
   ren_fecha_actualizacion DATETIME             null,
   ren_login_registro   VARCHAR(100)         not null,
   ren_login_actualizacion VARCHAR(100)         null,
   constraint PK_RENOVACION primary key (ren_codigo)
)
go

/*==============================================================*/
/* Index: IX_RENOVACION_SOL_CODIGO                              */
/*==============================================================*/




create nonclustered index IX_RENOVACION_SOL_CODIGO on dbo.RENOVACION (sol_codigo ASC)
go

/*==============================================================*/
/* Index: UX_RENOVACION_FOLIO                                   */
/*==============================================================*/




create unique nonclustered index UX_RENOVACION_FOLIO on dbo.RENOVACION (ren_folio ASC)
   where ren_folio IS NOT NULL
go

/*==============================================================*/
/* Table: RENOVACION_BENEFICIO                                  */
/*==============================================================*/
create table dbo.RENOVACION_BENEFICIO (
   rbe_codigo           INT                  identity not null,
   ren_codigo           INT                  not null,
   tbe_codigo           INT                  not null,
   rbe_n_horas          INT                  null,
   rbe_monto_mensual    DECIMAL(12,2)        null,
   rbe_monto_total_viaje DECIMAL(12,2)        null,
   rbe_valor_ida        DECIMAL(12,2)        null,
   rbe_valor_regreso    DECIMAL(12,2)        null,
   rbe_valor_ida_regreso DECIMAL(12,2)        null,
   rbe_valor_matricula  DECIMAL(12,2)        null,
   rbe_valor_arancel    DECIMAL(12,2)        null,
   rbe_monto_seguro     DECIMAL(12,2)        null,
   constraint PK_RENOVACION_BENEFICIO primary key (rbe_codigo)
)
go

/*==============================================================*/
/* Index: UX_RENOVACION_BENEFICIO                               */
/*==============================================================*/




create unique nonclustered index UX_RENOVACION_BENEFICIO on dbo.RENOVACION_BENEFICIO (ren_codigo ASC,
  tbe_codigo ASC)
go

/*==============================================================*/
/* Table: RENOVACION_DOCUMENTO                                  */
/*==============================================================*/
create table dbo.RENOVACION_DOCUMENTO (
   rdo_codigo           INT                  identity not null,
   ren_codigo           INT                  not null,
   tdo_codigo           INT                  not null,
   rdo_ruta_archivo     VARCHAR(500)         null,
   rdo_nombre_original  VARCHAR(255)         null,
   rdo_estado           VARCHAR(20)          not null default 'PENDIENTE',
   rdo_ind_bloqueado    BIT                  not null default 0,
   rdo_fecha_subida     DATETIME             null,
   rdo_login_subida     VARCHAR(100)         null,
   constraint PK_RENOVACION_DOCUMENTO primary key (rdo_codigo)
)
go

/*==============================================================*/
/* Index: IX_RENOVACION_DOCUMENTO_REN_CODIGO                    */
/*==============================================================*/




create nonclustered index IX_RENOVACION_DOCUMENTO_REN_CODIGO on dbo.RENOVACION_DOCUMENTO (ren_codigo ASC)
go

/*==============================================================*/
/* Table: RENOVACION_DOCUMENTO_ADICIONAL                        */
/*==============================================================*/
create table dbo.RENOVACION_DOCUMENTO_ADICIONAL (
   rda_codigo           INT                  identity not null,
   ren_codigo           INT                  not null,
   rda_nombre_documento VARCHAR(255)         not null,
   rda_ruta_archivo     VARCHAR(500)         not null,
   rda_nombre_original  VARCHAR(255)         not null,
   rda_fecha_subida     DATETIME             not null default getdate(),
   rda_login_subida     VARCHAR(100)         not null,
   constraint PK_RENOVACION_DOCUMENTO_ADICIONAL primary key (rda_codigo)
)
go

/*==============================================================*/
/* Index: IX_RENOVACION_DOCUMENTO_ADICIONAL_REN_CODIGO          */
/*==============================================================*/




create nonclustered index IX_RENOVACION_DOCUMENTO_ADICIONAL_REN_CODIGO on dbo.RENOVACION_DOCUMENTO_ADICIONAL (ren_codigo ASC)
go

/*==============================================================*/
/* Table: RENOVACION_HISTORIAL                                  */
/*==============================================================*/
create table dbo.RENOVACION_HISTORIAL (
   rhi_codigo           INT                  identity not null,
   ren_codigo           INT                  not null,
   tes_codigo           INT                  not null,
   rhi_observacion      VARCHAR(4000)        null,
   rhi_fecha_evento     DATETIME             not null default getdate(),
   rhi_login_evento     VARCHAR(100)         not null,
   rhi_rol_usuario      VARCHAR(30)          not null,
   constraint PK_RENOVACION_HISTORIAL primary key (rhi_codigo)
)
go

/*==============================================================*/
/* Index: IX_RENOVACION_HISTORIAL_REN_CODIGO                    */
/*==============================================================*/




create nonclustered index IX_RENOVACION_HISTORIAL_REN_CODIGO on dbo.RENOVACION_HISTORIAL (ren_codigo ASC)
go

/*==============================================================*/
/* Table: SECUENCIA_FOLIO                                       */
/*==============================================================*/
create table dbo.SECUENCIA_FOLIO (
   sfo_tipo_proceso     CHAR(1)              not null,
   sfo_ano              INT                  not null,
   sfo_ultimo_numero    INT                  not null default 0,
   constraint PK_SECUENCIA_FOLIO primary key (sfo_tipo_proceso, sfo_ano)
)
go

/*==============================================================*/
/* Table: SOLICITUD                                             */
/*==============================================================*/
create table dbo.SOLICITUD (
   sol_codigo           INT                  identity not null,
   sol_folio            VARCHAR(20)          null,
   aca_rut              VARCHAR(12)          not null,
   tes_codigo           INT                  not null,
   tpe_codigo           INT                  not null,
   tgr_codigo           INT                  null,
   sol_nombre_programa  VARCHAR(200)         not null,
   sol_institucion_destino VARCHAR(200)         not null,
   sol_pais             VARCHAR(100)         not null,
   sol_fecha_inicio     DATE                 not null,
   sol_fecha_termino    DATE                 not null,
   sol_fecha_salida_ubb DATE                 null,
   sol_financiamiento_externo VARCHAR(300)         null,
   sol_razones_patrocinio VARCHAR(4000)        null,
   sol_informacion_adicional VARCHAR(4000)        null,
   sol_ruta_pdf         VARCHAR(500)         null,
   sol_fecha_registro   DATETIME             not null default getdate(),
   sol_fecha_envio      DATETIME             null,
   sol_fecha_actualizacion DATETIME             null,
   sol_login_registro   VARCHAR(100)         not null,
   sol_login_actualizacion VARCHAR(100)         null,
   constraint PK_SOLICITUD primary key (sol_codigo)
)
go

/*==============================================================*/
/* Index: IX_SOLICITUD_ACA_RUT                                  */
/*==============================================================*/




create nonclustered index IX_SOLICITUD_ACA_RUT on dbo.SOLICITUD (aca_rut ASC)
go

/*==============================================================*/
/* Index: IX_SOLICITUD_TES_CODIGO                               */
/*==============================================================*/




create nonclustered index IX_SOLICITUD_TES_CODIGO on dbo.SOLICITUD (tes_codigo ASC)
go

/*==============================================================*/
/* Index: UX_SOLICITUD_FOLIO                                    */
/*==============================================================*/




create unique nonclustered index UX_SOLICITUD_FOLIO on dbo.SOLICITUD (sol_folio ASC)
   where sol_folio IS NOT NULL
go

/*==============================================================*/
/* Table: SOLICITUD_BENEFICIO                                   */
/*==============================================================*/
create table dbo.SOLICITUD_BENEFICIO (
   sbe_codigo           INT                  identity not null,
   sol_codigo           INT                  not null,
   tbe_codigo           INT                  not null,
   sbe_n_horas          INT                  null,
   sbe_monto_mensual    DECIMAL(12,2)        null,
   sbe_monto_total_viaje DECIMAL(12,2)        null,
   sbe_valor_ida        DECIMAL(12,2)        null,
   sbe_valor_regreso    DECIMAL(12,2)        null,
   sbe_valor_ida_regreso DECIMAL(12,2)        null,
   sbe_valor_matricula  DECIMAL(12,2)        null,
   sbe_valor_arancel    DECIMAL(12,2)        null,
   sbe_monto_seguro     DECIMAL(12,2)        null,
   constraint PK_SOLICITUD_BENEFICIO primary key (sbe_codigo)
)
go

/*==============================================================*/
/* Index: UX_SOLICITUD_BENEFICIO                                */
/*==============================================================*/




create unique nonclustered index UX_SOLICITUD_BENEFICIO on dbo.SOLICITUD_BENEFICIO (sol_codigo ASC,
  tbe_codigo ASC)
go

/*==============================================================*/
/* Table: SOLICITUD_DOCUMENTO                                   */
/*==============================================================*/
create table dbo.SOLICITUD_DOCUMENTO (
   sdo_codigo           INT                  identity not null,
   sol_codigo           INT                  not null,
   tdo_codigo           INT                  not null,
   sdo_ruta_archivo     VARCHAR(500)         null,
   sdo_nombre_original  VARCHAR(255)         null,
   sdo_estado           VARCHAR(20)          not null default 'PENDIENTE',
   sdo_ind_bloqueado    BIT                  not null default 0,
   sdo_fecha_subida     DATETIME             null,
   sdo_login_subida     VARCHAR(100)         null,
   constraint PK_SOLICITUD_DOCUMENTO primary key (sdo_codigo)
)
go

/*==============================================================*/
/* Index: IX_SOLICITUD_DOCUMENTO_SOL_CODIGO                     */
/*==============================================================*/




create nonclustered index IX_SOLICITUD_DOCUMENTO_SOL_CODIGO on dbo.SOLICITUD_DOCUMENTO (sol_codigo ASC)
go

/*==============================================================*/
/* Table: SOLICITUD_DOCUMENTO_ADICIONAL                         */
/*==============================================================*/
create table dbo.SOLICITUD_DOCUMENTO_ADICIONAL (
   sda_codigo           INT                  identity not null,
   sol_codigo           INT                  not null,
   sda_nombre_documento VARCHAR(255)         not null,
   sda_ruta_archivo     VARCHAR(500)         not null,
   sda_nombre_original  VARCHAR(255)         not null,
   sda_fecha_subida     DATETIME             not null default getdate(),
   sda_login_subida     VARCHAR(100)         not null,
   constraint PK_SOLICITUD_DOCUMENTO_ADICIONAL primary key (sda_codigo)
)
go

/*==============================================================*/
/* Index: IX_SOLICITUD_DOCUMENTO_ADICIONAL_SOL_CODIGO           */
/*==============================================================*/




create nonclustered index IX_SOLICITUD_DOCUMENTO_ADICIONAL_SOL_CODIGO on dbo.SOLICITUD_DOCUMENTO_ADICIONAL (sol_codigo ASC)
go

/*==============================================================*/
/* Table: SOLICITUD_HISTORIAL                                   */
/*==============================================================*/
create table dbo.SOLICITUD_HISTORIAL (
   shi_codigo           INT                  identity not null,
   sol_codigo           INT                  not null,
   tes_codigo           INT                  not null,
   shi_observacion      VARCHAR(4000)        null,
   shi_fecha_evento     DATETIME             not null default getdate(),
   shi_login_evento     VARCHAR(100)         not null,
   shi_rol_usuario      VARCHAR(30)          not null,
   constraint PK_SOLICITUD_HISTORIAL primary key (shi_codigo)
)
go

/*==============================================================*/
/* Index: IX_SOLICITUD_HISTORIAL_SOL_CODIGO                     */
/*==============================================================*/




create nonclustered index IX_SOLICITUD_HISTORIAL_SOL_CODIGO on dbo.SOLICITUD_HISTORIAL (sol_codigo ASC)
go

/*==============================================================*/
/* Table: TIPO_BENEFICIO                                        */
/*==============================================================*/
create table dbo.TIPO_BENEFICIO (
   tbe_codigo           INT                  not null,
   tbe_codigo_interno   VARCHAR(50)          not null,
   tbe_descripcion      VARCHAR(100)         not null,
   tbe_ind_n_horas      BIT                  not null default 0,
   tbe_ind_monto_mensual BIT                  not null default 0,
   tbe_ind_monto_viaje  BIT                  not null default 0,
   tbe_ind_valor_ida    BIT                  not null default 0,
   tbe_ind_valor_regreso BIT                  not null default 0,
   tbe_ind_valor_ida_regreso BIT                  not null default 0,
   tbe_ind_valor_matricula BIT                  not null default 0,
   tbe_ind_valor_arancel BIT                  not null default 0,
   tbe_ind_monto_seguro BIT                  not null default 0,
   tbe_ind_activo       BIT                  not null default 1,
   constraint PK_TIPO_BENEFICIO primary key (tbe_codigo)
)
go

/*==============================================================*/
/* Index: UX_TIPO_BENEFICIO_CODIGO_INTERNO                      */
/*==============================================================*/




create unique nonclustered index UX_TIPO_BENEFICIO_CODIGO_INTERNO on dbo.TIPO_BENEFICIO (tbe_codigo_interno ASC)
go

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
create table dbo.TIPO_DOCUMENTO (
   tdo_codigo           INT                  not null,
   tdo_nombre           VARCHAR(150)         not null,
   tdo_proceso          CHAR(1)              not null,
   tdo_ind_obligatorio  BIT                  not null default 1,
   tdo_ind_activo       BIT                  not null default 1,
   constraint PK_TIPO_DOCUMENTO primary key (tdo_codigo)
)
go

/*==============================================================*/
/* Table: TIPO_ESTADO                                           */
/*==============================================================*/
create table dbo.TIPO_ESTADO (
   tes_codigo           INT                  not null,
   tes_codigo_interno   VARCHAR(30)          not null,
   tes_descripcion      VARCHAR(100)         not null,
   tes_tipo_proceso     CHAR(1)              not null default '*',
   tes_orden            INT                  not null default 0,
   tes_ind_activo       BIT                  not null default 1,
   constraint PK_TIPO_ESTADO primary key (tes_codigo)
)
go

/*==============================================================*/
/* Index: UX_TIPO_ESTADO_CODIGO_INTERNO                         */
/*==============================================================*/




create unique nonclustered index UX_TIPO_ESTADO_CODIGO_INTERNO on dbo.TIPO_ESTADO (tes_codigo_interno ASC)
go

/*==============================================================*/
/* Table: TIPO_GRADO                                            */
/*==============================================================*/
create table dbo.TIPO_GRADO (
   tgr_codigo           INT                  not null,
   tgr_descripcion      VARCHAR(50)          not null,
   tgr_ind_activo       BIT                  not null default 1,
   constraint PK_TIPO_GRADO primary key (tgr_codigo)
)
go

/*==============================================================*/
/* Table: TIPO_PERFECCIONAMIENTO                                */
/*==============================================================*/
create table dbo.TIPO_PERFECCIONAMIENTO (
   tpe_codigo           INT                  not null,
   tpe_descripcion      VARCHAR(50)          not null,
   tpe_ind_activo       BIT                  not null default 1,
   constraint PK_TIPO_PERFECCIONAMIENTO primary key (tpe_codigo)
)
go

alter table dbo.CIERRE
   add constraint FK_CIERRE_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.CIERRE
   add constraint FK_CIERRE_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

alter table dbo.CIERRE
   add constraint FK_CIERRE_TIPO_GRADO foreign key (tgr_codigo)
      references dbo.TIPO_GRADO (tgr_codigo)
go

alter table dbo.CIERRE_DOCUMENTO
   add constraint FK_CIERRE_DOCUMENTO_CIERRE foreign key (cie_codigo)
      references dbo.CIERRE (cie_codigo)
go

alter table dbo.CIERRE_DOCUMENTO
   add constraint FK_CIERRE_DOCUMENTO_TIPO_DOCUMENTO foreign key (tdo_codigo)
      references dbo.TIPO_DOCUMENTO (tdo_codigo)
go

alter table dbo.CIERRE_DOCUMENTO_ADICIONAL
   add constraint FK_CIERRE_DOCUMENTO_ADICIONAL_CIERRE foreign key (cie_codigo)
      references dbo.CIERRE (cie_codigo)
go

alter table dbo.CIERRE_HISTORIAL
   add constraint FK_CIERRE_HISTORIAL_CIERRE foreign key (cie_codigo)
      references dbo.CIERRE (cie_codigo)
go

alter table dbo.CIERRE_HISTORIAL
   add constraint FK_CIERRE_HISTORIAL_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

alter table dbo.RENOVACION
   add constraint FK_RENOVACION_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.RENOVACION
   add constraint FK_RENOVACION_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

alter table dbo.RENOVACION_BENEFICIO
   add constraint FK_RENOVACION_BENEFICIO_RENOVACION foreign key (ren_codigo)
      references dbo.RENOVACION (ren_codigo)
go

alter table dbo.RENOVACION_BENEFICIO
   add constraint FK_RENOVACION_BENEFICIO_TIPO_BENEFICIO foreign key (tbe_codigo)
      references dbo.TIPO_BENEFICIO (tbe_codigo)
go

alter table dbo.RENOVACION_DOCUMENTO
   add constraint FK_RENOVACION_DOCUMENTO_RENOVACION foreign key (ren_codigo)
      references dbo.RENOVACION (ren_codigo)
go

alter table dbo.RENOVACION_DOCUMENTO
   add constraint FK_RENOVACION_DOCUMENTO_TIPO_DOCUMENTO foreign key (tdo_codigo)
      references dbo.TIPO_DOCUMENTO (tdo_codigo)
go

alter table dbo.RENOVACION_DOCUMENTO_ADICIONAL
   add constraint FK_RENOVACION_DOCUMENTO_ADICIONAL_RENOVACION foreign key (ren_codigo)
      references dbo.RENOVACION (ren_codigo)
go

alter table dbo.RENOVACION_HISTORIAL
   add constraint FK_RENOVACION_HISTORIAL_RENOVACION foreign key (ren_codigo)
      references dbo.RENOVACION (ren_codigo)
go

alter table dbo.RENOVACION_HISTORIAL
   add constraint FK_RENOVACION_HISTORIAL_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

alter table dbo.SOLICITUD
   add constraint FK_SOLICITUD_ACADEMICO foreign key (aca_rut)
      references dbo.ACADEMICO (aca_rut)
go

alter table dbo.SOLICITUD
   add constraint FK_SOLICITUD_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

alter table dbo.SOLICITUD
   add constraint FK_SOLICITUD_TIPO_GRADO foreign key (tgr_codigo)
      references dbo.TIPO_GRADO (tgr_codigo)
go

alter table dbo.SOLICITUD
   add constraint FK_SOLICITUD_TIPO_PERFECCIONAMIENTO foreign key (tpe_codigo)
      references dbo.TIPO_PERFECCIONAMIENTO (tpe_codigo)
go

alter table dbo.SOLICITUD_BENEFICIO
   add constraint FK_SOLICITUD_BENEFICIO_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.SOLICITUD_BENEFICIO
   add constraint FK_SOLICITUD_BENEFICIO_TIPO_BENEFICIO foreign key (tbe_codigo)
      references dbo.TIPO_BENEFICIO (tbe_codigo)
go

alter table dbo.SOLICITUD_DOCUMENTO
   add constraint FK_SOLICITUD_DOCUMENTO_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.SOLICITUD_DOCUMENTO
   add constraint FK_SOLICITUD_DOCUMENTO_TIPO_DOCUMENTO foreign key (tdo_codigo)
      references dbo.TIPO_DOCUMENTO (tdo_codigo)
go

alter table dbo.SOLICITUD_DOCUMENTO_ADICIONAL
   add constraint FK_SOLICITUD_DOCUMENTO_ADICIONAL_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.SOLICITUD_HISTORIAL
   add constraint FK_SOLICITUD_HISTORIAL_SOLICITUD foreign key (sol_codigo)
      references dbo.SOLICITUD (sol_codigo)
go

alter table dbo.SOLICITUD_HISTORIAL
   add constraint FK_SOLICITUD_HISTORIAL_TIPO_ESTADO foreign key (tes_codigo)
      references dbo.TIPO_ESTADO (tes_codigo)
go

