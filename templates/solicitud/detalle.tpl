<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<script src="{$PATH_JS_RECURSOS_DEV}js/funciones_generales.js"></script>

<div id="div_base" class="ubb-container">

    <div class="ubb-container-page-header">
        <header class="page-header">
            <h1 tabindex="0">
                Solicitud
                {if $solicitud.folio}
                    {$solicitud.folio}
                {/if}
            </h1>
            <button type="button" class="ubb-btn ubb-linear-btn"
                onclick="onPost_('solicitud_seguimiento', null, 'perfeccionamiento', null, null, null)">
                <i class="fa fa-arrow-left icon-left" aria-hidden="true"></i>Volver
            </button>
        </header>
    </div>

    {if $mensaje}
        <div class="ubb-message success-message" role="status">
            <i class="fa fa-circle-check" aria-hidden="true"></i>
            <span>{$mensaje}</span>
        </div>
    {/if}

    {if $errores}
        {foreach $errores as $error}
            <div class="ubb-message error-message" role="alert">
                <i class="fa fa-circle-xmark" aria-hidden="true"></i>
                <span>{$error}</span>
            </div>
        {/foreach}
    {/if}

    <section class="content-box">
        <h2 tabindex="0">Antecedentes del perfeccionamiento</h2>
        <div class="ubb-component-wrapper">
            <div class="ubb-datagrid-typeseven">
                <div class="ubb-datagrid-container">
                    <div class="data-row">
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Folio</dt>
                                <dd class="data-info">{$solicitud.folio|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Estado</dt>
                                <dd class="data-info">
                                    {if $solicitud.codigo_estado == 'APROBADO'}
                                        <span class="ubb-datatag-success">{$solicitud.estado}</span>
                                    {elseif $solicitud.codigo_estado == 'RECHAZADO'}
                                        <span class="ubb-datatag-error">{$solicitud.estado}</span>
                                    {elseif $solicitud.codigo_estado == 'OBSERVADO'}
                                        <span class="ubb-datatag-other">{$solicitud.estado}</span>
                                    {else}
                                        <span class="ubb-datatag-other">{$solicitud.estado}</span>
                                    {/if}
                                </dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Tipo de perfeccionamiento</dt>
                                <dd class="data-info">{$solicitud.tipo_perfeccionamiento|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Grado al que postula</dt>
                                <dd class="data-info">{$solicitud.tipo_grado|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Nombre del programa</dt>
                                <dd class="data-info">{$solicitud.nombre_programa|default:'—'}</dd>
                            </div>
                        </dl>
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Institución de destino</dt>
                                <dd class="data-info">{$solicitud.institucion_destino|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">País</dt>
                                <dd class="data-info">{$solicitud.pais|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Fecha de inicio</dt>
                                <dd class="data-info">{$solicitud.fecha_inicio|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Fecha de término</dt>
                                <dd class="data-info">{$solicitud.fecha_termino|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Fecha de salida UBB</dt>
                                <dd class="data-info">{$solicitud.fecha_salida_ubb|default:'—'}</dd>
                            </div>
                        </dl>
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Financiamiento externo</dt>
                                <dd class="data-info">{$solicitud.financiamiento_externo|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Fecha de envío</dt>
                                <dd class="data-info">{$solicitud.fecha_envio|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Académico/a</dt>
                                <dd class="data-info">{$solicitud.nombre_academico|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">Departamento</dt>
                                <dd class="data-info">{$solicitud.departamento|default:'—'}</dd>
                            </div>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </section>

    {if $solicitud.razones_patrocinio}
        <section class="content-box">
            <h2 tabindex="0">Razones que motivan la petición de patrocinio</h2>
            <div class="ubb-component-wrapper">
                <p>{$solicitud.razones_patrocinio}</p>
            </div>
        </section>
    {/if}

    {if $beneficios}
        <section class="content-box">
            <h2 tabindex="0">Beneficios solicitados</h2>
            <div class="ubb-component-wrapper">
                <div class="ubb-datagrid-typefour" style="--cols: 3;">
                    <div class="ubb-header-row datagrid-row">
                        <div class="data-title">Beneficio</div>
                        <div class="data-title">Detalle</div>
                        <div class="data-title">Monto</div>
                    </div>
                    {foreach $beneficios as $ben}
                        <div class="ubb-datagrid-container datagrid-row">
                            <div class="data-row">
                                <div data-title="Beneficio" class="data-info">{$ben.descripcion}</div>
                                <div data-title="Detalle" class="data-info">
                                    {if $ben.n_horas}N° horas: {$ben.n_horas}{/if}
                                    {if $ben.valor_ida}Ida: ${$ben.valor_ida|number_format:0:',':'.'}
                                        / Regreso: ${$ben.valor_regreso|number_format:0:',':'.'}
                                    {/if}
                                    {if $ben.valor_matricula}Matrícula: ${$ben.valor_matricula|number_format:0:',':'.'}
                                        / Arancel: ${$ben.valor_arancel|number_format:0:',':'.'}
                                    {/if}
                                    {if !$ben.n_horas && !$ben.valor_ida && !$ben.valor_matricula}—{/if}
                                </div>
                                <div data-title="Monto" class="data-info">
                                    {if $ben.monto_mensual}${$ben.monto_mensual|number_format:0:',':'.'}/mes{/if}
                                    {if $ben.monto_total_viaje}${$ben.monto_total_viaje|number_format:0:',':'.'}(viaje){/if}
                                    {if $ben.monto_seguro}${$ben.monto_seguro|number_format:0:',':'.'}(seguro){/if}
                                    {if !$ben.monto_mensual && !$ben.monto_total_viaje && !$ben.monto_seguro}—{/if}
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </section>
    {/if}

    <section class="content-box">
        <h2 tabindex="0">Documentos adjuntos</h2>
        <div class="ubb-component-wrapper">
            <div class="ubb-datagrid-typefour" style="--cols: 4;">
                <div class="ubb-header-row datagrid-row">
                    <div class="data-title">Documento</div>
                    <div class="data-title">Formato</div>
                    <div class="data-title">Estado</div>
                    <div class="data-title">Acción</div>
                </div>
                {foreach $documentos as $doc}
                    <div class="ubb-datagrid-container datagrid-row">
                        <div class="data-row">
                            <div data-title="Documento" class="data-info">{$doc.nombre_tipo}</div>
                            <div data-title="Formato" class="data-info">
                                <span class="ubb-tag info-tag">PDF</span>
                            </div>
                            <div data-title="Estado" class="data-info">
                                {if $doc.estado_doc == 'CARGADO'}
                                    <span class="ubb-datatag-success">Cargado</span>
                                {else}
                                    <span class="ubb-datatag-error">Pendiente</span>
                                {/if}
                            </div>
                            <div data-title="Acción" class="data-info">
                                {if $doc.estado_doc == 'CARGADO'}
                                    <a href="{$doc.ruta_archivo}" target="_blank" class="ubb-btn ubb-linear-btn">
                                        <i class="fa fa-eye icon-left" aria-hidden="true"></i>Ver
                                    </a>
                                {/if}
                                {if !$doc.bloqueado}
                                    <form method="POST" action="perfeccionamiento/solicitud_detalle.php"
                                        enctype="multipart/form-data" style="display:inline;">
                                        <input type="hidden" name="accion" value="subir_documento">
                                        <input type="hidden" name="id_solicitud" value="{$id_solicitud}">
                                        <input type="hidden" name="id_documento" value="{$doc.id_sol_documento}">
                                        <input type="file" name="archivo" accept="application/pdf" style="display:none;"
                                            id="file_{$doc.id_sol_documento}" onchange="this.form.submit()">
                                        <button type="button" class="ubb-btn ubb-linear-btn"
                                            onclick="document.getElementById('file_{$doc.id_sol_documento}').click()">
                                            <i class="fa fa-upload icon-left" aria-hidden="true"></i>Subir
                                        </button>
                                    </form>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </section>

</div>