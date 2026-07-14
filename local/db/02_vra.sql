USE Vra;
GO

IF OBJECT_ID('dbo.JERARQUIZACION_ANTECEDENTES_PERSONALES') IS NOT NULL
    DROP TABLE dbo.JERARQUIZACION_ANTECEDENTES_PERSONALES;
GO

CREATE TABLE dbo.JERARQUIZACION_ANTECEDENTES_PERSONALES (
    id_tabla             INT           IDENTITY(1,1) NOT NULL,
    mae_rut              VARCHAR(12)   NOT NULL,
    mae_apellido_paterno VARCHAR(100)  NOT NULL,
    mae_apellido_materno VARCHAR(100)  NOT NULL,
    mae_nombre           VARCHAR(150)  NOT NULL,
    facultad             VARCHAR(150)  NOT NULL,
    reparticion          VARCHAR(150)  NOT NULL,
    fecha_ing_ubb        VARCHAR(23)   NULL,  
    jornada              VARCHAR(50)   NULL,
    email                VARCHAR(150)  NULL
);
GO

INSERT INTO dbo.JERARQUIZACION_ANTECEDENTES_PERSONALES
    (mae_rut, mae_apellido_paterno, mae_apellido_materno, mae_nombre, facultad, reparticion, fecha_ing_ubb, jornada, email)
VALUES
    ('15111222', 'Soto',      'Riquelme', 'Andrea Paz',      'Facultad de Ciencias Empresariales', 'Departamento de Sistemas de Información',       '2012-03-01', 'Completa', 'asoto@ubiobio.cl'),
    ('14222333', 'Fuentes',   'Molina',   'Rodrigo Andrés',  'Facultad de Ingeniería',             'Departamento de Ingeniería Civil y Ambiental',  '2010-08-01', 'Completa', 'rfuentes@ubiobio.cl'),
    ('16333444', 'Carrasco',  'Vidal',    'María José',      'Facultad de Educación y Humanidades','Departamento de Ciencias de la Educación',      '2015-03-01', 'Completa', 'mcarrasco@ubiobio.cl'),
    ('13444555', 'Norambuena','Parra',    'Claudio Esteban', 'Facultad de Ciencias',               'Departamento de Ciencias Básicas',              '2008-03-01', 'Media',    'cnorambuena@ubiobio.cl'),
    ('17555666', 'Aravena',   'Sanhueza', 'Valentina Ignacia','Facultad de Arquitectura, Construcción y Diseño', 'Departamento de Diseño y Teoría de la Arquitectura', '2018-03-01', 'Completa', 'varavena@ubiobio.cl');
GO