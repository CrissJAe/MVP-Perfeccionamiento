USE Perfeccionamiento;
GO

DELETE FROM dbo.RENOVACION_BENEFICIO;
DELETE FROM dbo.RENOVACION_DOCUMENTO;
DELETE FROM dbo.RENOVACION_DOCUMENTO_ADICIONAL;
DELETE FROM dbo.RENOVACION_HISTORIAL;
DELETE FROM dbo.RENOVACION;
DELETE FROM dbo.CIERRE_DOCUMENTO;
DELETE FROM dbo.CIERRE_DOCUMENTO_ADICIONAL;
DELETE FROM dbo.CIERRE_HISTORIAL;
DELETE FROM dbo.CIERRE;
DELETE FROM dbo.SOLICITUD_BENEFICIO;
DELETE FROM dbo.SOLICITUD_DOCUMENTO;
DELETE FROM dbo.SOLICITUD_DOCUMENTO_ADICIONAL;
DELETE FROM dbo.SOLICITUD_HISTORIAL;
DELETE FROM dbo.SOLICITUD;
DELETE FROM dbo.ACADEMICO;
DELETE FROM dbo.TIPO_DOCUMENTO;
DELETE FROM dbo.TIPO_BENEFICIO;
DELETE FROM dbo.TIPO_ESTADO;
DELETE FROM dbo.TIPO_GRADO;
DELETE FROM dbo.TIPO_PERFECCIONAMIENTO;
DELETE FROM dbo.SECUENCIA_FOLIO;
GO

INSERT INTO dbo.TIPO_ESTADO (tes_codigo, tes_codigo_interno, tes_descripcion, tes_tipo_proceso, tes_orden, tes_ind_activo) VALUES
(1,  'BORRADOR',          'Borrador',              '*', 1,  1),
(2,  'EN_TRAMITE',        'En trámite',            '*', 2,  1),
(3,  'REVISION_DEPTO',    'Revisión Departamento', '*', 3,  1),
(4,  'REVISION_FACULTAD', 'Revisión Facultad',     '*', 4,  1),
(5,  'REVISION_COMITE',   'Revisión Comité',       '*', 5,  1),
(6,  'SIAPER',            'SIAPER',                '*', 6,  1),
(7,  'DECRETACION',       'Decretación',           '*', 7,  1),
(8,  'DECRETADO',         'Decretado',             '*', 8,  1),
(9,  'APROBADO',          'Aprobado',              '*', 9,  1),
(10, 'RECHAZADO',         'Rechazado',             '*', 10, 1),
(11, 'OBSERVADO',         'Observado',             '*', 11, 1),
(12, 'CERRADO',           'Cerrado',               '*', 12, 1);
GO

INSERT INTO dbo.TIPO_GRADO (tgr_codigo, tgr_descripcion, tgr_ind_activo) VALUES
(1, 'Magíster', 1),
(2, 'Doctorado', 1),
(3, 'Postdoctorado', 0),      -- inactivo: no aplica a "grado al que postula"
(4, 'Especialidad Médica', 0),-- inactivo
(5, 'Postítulo', 0);          -- inactivo
GO

INSERT INTO dbo.TIPO_PERFECCIONAMIENTO (tpe_codigo, tpe_descripcion, tpe_ind_activo) VALUES
(1, 'Postgrado', 1),
(2, 'Curso', 1),
(3, 'Diplomado', 1),
(4, 'Pasantía / Estadía', 1),
(5, 'Postdoctorado', 1);
GO

INSERT INTO dbo.TIPO_BENEFICIO
(tbe_codigo, tbe_codigo_interno, tbe_descripcion, tbe_ind_n_horas, tbe_ind_monto_mensual, tbe_ind_monto_viaje, tbe_ind_valor_ida, tbe_ind_valor_regreso, tbe_ind_valor_ida_regreso, tbe_ind_valor_matricula, tbe_ind_valor_arancel, tbe_ind_monto_seguro, tbe_ind_activo) VALUES
(1, 'MANTENCION_REMUNERACIONES', 'Mantención Total de Remuneraciones', 0,0,0,0,0,0,0,0,0,1),
(2, 'LIBERACION_JORNADA',        'Liberación de Jornada',              1,0,0,0,0,0,0,0,0,1),
(3, 'BECA_UBB',                  'Beca UBB',                           0,1,1,0,0,0,0,0,0,1),
(4, 'PASAJES',                   'Pasajes',                            0,0,0,1,1,1,0,0,0,1),
(5, 'MATRICULA_ARANCEL',         'Matrículas y Aranceles',             0,0,0,0,0,0,1,1,0,1),
(6, 'SEGURO_SALUD',              'Seguro de Salud',                    0,0,0,0,0,0,0,0,1,1),
(7, 'REEMPLAZO_DOCENTE',         'Reemplazo Docente',                  0,0,0,0,0,0,0,0,0,1);
GO

INSERT INTO dbo.TIPO_DOCUMENTO (tdo_codigo, tdo_nombre, tdo_proceso, tdo_ind_obligatorio, tdo_ind_activo) VALUES
(1, 'Constancia de aceptación / invitación',      'S', 1, 1),
(2, 'Antecedentes del programa',                  'S', 1, 1),
(3, 'Beca o financiamiento externo',              'S', 0, 1),
(4, 'Otros',                                      'S', 0, 1),
(5, 'Informe de avance académico',                'R', 1, 1),
(6, 'Certificado de notas o avance curricular',   'R', 1, 1),
(7, 'Certificado o diploma del grado obtenido',   'C', 1, 1),
(8, 'Informe final de actividades',               'C', 1, 1);

INSERT INTO dbo.SECUENCIA_FOLIO (sfo_tipo_proceso, sfo_ano, sfo_ultimo_numero) VALUES
('S', 2026, 3),
('R', 2026, 0),
('C', 2026, 0);
GO

INSERT INTO dbo.ACADEMICO (aca_rut, aca_apellido_paterno, aca_apellido_materno, aca_nombres, aca_facultad, aca_departamento, aca_ano_ingreso, aca_tipo_jornada, aca_email) VALUES
('15111222', 'Soto',       'Riquelme', 'Andrea Paz',        'Facultad de Ciencias Empresariales',  'Departamento de Sistemas de Información',      2012, 'Completa', 'asoto@ubiobio.cl'),
('14222333', 'Fuentes',    'Molina',   'Rodrigo Andrés',    'Facultad de Ingeniería',              'Departamento de Ingeniería Civil y Ambiental', 2010, 'Completa', 'rfuentes@ubiobio.cl'),
('16333444', 'Carrasco',   'Vidal',    'María José',        'Facultad de Educación y Humanidades', 'Departamento de Ciencias de la Educación',     2015, 'Completa', 'mcarrasco@ubiobio.cl'),
('13444555', 'Norambuena', 'Parra',    'Claudio Esteban',   'Facultad de Ciencias',                'Departamento de Ciencias Básicas',             2008, 'Media',    'cnorambuena@ubiobio.cl');
GO


/* 1) BORRADOR de Andrea Soto: sirve para demostrar edición + envío*/
INSERT INTO dbo.SOLICITUD (sol_folio, aca_rut, tes_codigo, tpe_codigo, tgr_codigo, sol_nombre_programa, sol_institucion_destino, sol_pais, sol_fecha_inicio, sol_fecha_termino, sol_fecha_salida_ubb, sol_financiamiento_externo, sol_razones_patrocinio, sol_login_registro)
VALUES (NULL, '15111222', 1, 1, 2, 'Doctorado en Ingeniería Informática', 'Universidad de Chile', 'Chile', '2027-03-01', '2031-01-31', '2027-02-15', NULL, 'Fortalecer la línea de investigación en sistemas inteligentes del departamento.', 'asoto');

/* 2) ENVIADA de Rodrigo Fuentes: aparece en la bandeja lista para revisar */
INSERT INTO dbo.SOLICITUD (sol_folio, aca_rut, tes_codigo, tpe_codigo, tgr_codigo, sol_nombre_programa, sol_institucion_destino, sol_pais, sol_fecha_inicio, sol_fecha_termino, sol_fecha_salida_ubb, sol_financiamiento_externo, sol_razones_patrocinio, sol_fecha_envio, sol_login_registro)
VALUES ('PA-2026-001', '14222333', 2, 1, 2, 'Doctorado en Ingeniería Civil', 'Universidad Politécnica de Madrid', 'España', '2026-09-01', '2030-06-30', '2026-08-15', 'Beca ANID Doctorado en el Extranjero (parcial)', 'Consolidar competencias en modelación estructural avanzada para el plan de desarrollo de la facultad.', DATEADD(day, -5, GETDATE()), 'rfuentes');

/* 3) OBSERVADA de María Carrasco: demuestra el ciclo de observación */
INSERT INTO dbo.SOLICITUD (sol_folio, aca_rut, tes_codigo, tpe_codigo, tgr_codigo, sol_nombre_programa, sol_institucion_destino, sol_pais, sol_fecha_inicio, sol_fecha_termino, sol_razones_patrocinio, sol_fecha_envio, sol_login_registro)
VALUES ('PA-2026-002', '16333444', 11, 1, 1, 'Magíster en Educación mención Gestión', 'Universidad de Concepción', 'Chile', '2026-08-01', '2028-07-31', 'Actualización disciplinar vinculada a acreditación de carrera.', DATEADD(day, -10, GETDATE()), 'mcarrasco');

/* 4) EN REVISIÓN FACULTAD de Claudio Norambuena: ya aprobada por el Departamento */
INSERT INTO dbo.SOLICITUD (sol_folio, aca_rut, tes_codigo, tpe_codigo, tgr_codigo, sol_nombre_programa, sol_institucion_destino, sol_pais, sol_fecha_inicio, sol_fecha_termino, sol_razones_patrocinio, sol_fecha_envio, sol_login_registro)
VALUES ('PA-2026-003', '13444555', 4, 1, 2, 'Doctorado en Ciencias Físicas', 'Pontificia Universidad Católica de Chile', 'Chile', '2026-08-01', '2030-07-31', 'Línea prioritaria de investigación institucional.', DATEADD(day, -20, GETDATE()), 'cnorambuena');
GO

DECLARE @sol2 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio = 'PA-2026-001');
DECLARE @sol4 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio = 'PA-2026-003');

INSERT INTO dbo.SOLICITUD_BENEFICIO (sol_codigo, tbe_codigo, sbe_n_horas, sbe_monto_mensual, sbe_monto_total_viaje, sbe_valor_ida, sbe_valor_regreso, sbe_valor_ida_regreso, sbe_valor_matricula, sbe_valor_arancel, sbe_monto_seguro) VALUES
(@sol2, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),                       -- Mantención remuneraciones
(@sol2, 3, NULL, 850000.00, 1200000.00, NULL, NULL, NULL, NULL, NULL, NULL),            -- Beca UBB
(@sol2, 4, NULL, NULL, NULL, 780000.00, 780000.00, NULL, NULL, NULL, NULL),             -- Pasajes
(@sol2, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 45000.00),                   -- Seguro de salud
(@sol4, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),                       -- Mantención remuneraciones
(@sol4, 5, NULL, NULL, NULL, NULL, NULL, NULL, 350000.00, 3200000.00, NULL);            -- Matrícula y arancel
GO

DECLARE @s2 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio = 'PA-2026-001');
DECLARE @s3 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio = 'PA-2026-002');
DECLARE @s4 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio = 'PA-2026-003');

INSERT INTO dbo.SOLICITUD_HISTORIAL (sol_codigo, tes_codigo, shi_observacion, shi_fecha_evento, shi_login_evento, shi_rol_usuario) VALUES
(@s2, 2, NULL, DATEADD(day, -5, GETDATE()), 'rfuentes', 'ACADEMICO'),
(@s3, 2, NULL, DATEADD(day, -10, GETDATE()), 'mcarrasco', 'ACADEMICO'),
(@s3, 11, 'Falta adjuntar la carta de aceptación definitiva del programa. Favor regularizar.', DATEADD(day, -7, GETDATE()), 'director.demo', 'DIRECTOR'),
(@s4, 2, NULL, DATEADD(day, -20, GETDATE()), 'cnorambuena', 'ACADEMICO'),
(@s4, 4, 'Solicitud pertinente al plan de desarrollo del departamento. Se aprueba y deriva a Facultad.', DATEADD(day, -15, GETDATE()), 'director.demo', 'DIRECTOR');
GO

DECLARE @d1 INT = (SELECT sol_codigo FROM dbo.SOLICITUD WHERE sol_folio IS NULL AND aca_rut = '15111222');

INSERT INTO dbo.SOLICITUD_DOCUMENTO (sol_codigo, tdo_codigo) VALUES
(@d1, 1), (@d1, 2), (@d1, 3);
GO

PRINT 'Seed cargado correctamente.';
GO