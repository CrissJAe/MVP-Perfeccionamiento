<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<script src="{$PATH_JS_RECURSOS_DEV}js/funciones_generales.js"></script>
<script src="perfeccionamiento/assets/js/seguimiento.js"></script>

<div id="div_base" class="ubb-container">

    <div class="ubb-container-page-header">
        <header class="page-header">
            <h1 tabindex="0">Seguimiento Postulación</h1>
            <button type="button" class="ubb-btn ubb-filled-btn"
                onclick="onPost_('solicitud_nueva', null, 'perfeccionamiento', null, null, 'btn_nueva')">
                <i class="fa fa-plus icon-left" aria-hidden="true"></i>Nueva solicitud
            </button>
        </header>
    </div>

    {if $solicitudes}
        <section class="content-box">
            <div class="ubb-component-wrapper">
                <div class="ubb-datagrid-typefour" style="--cols: 6;">
                    <div class="ubb-header-row datagrid-row">
                        <div class="data-title">Folio</div>
                        <div class="data-title">Programa</div>
                        <div class="data-title">Institución</div>
                        <div class="data-title">Estado</div>
                        <div class="data-title">Documentos</div>
                        <div class="data-title">Historial</div>
                    </div>

                    {foreach $solicitudes as $sol}
                        <div class="ubb-datagrid-container datagrid-row">
                            <div class="data-row">
                                <div data-title="Folio" class="data-info" tabindex="0">
                                    {$sol.folio|default:'—'}
                                </div>
                                <div data-title="Programa" class="data-info" tabindex="0">
                                    {$sol.nombre_programa}
                                </div>
                                <div data-title="Institución" class="data-info" tabindex="0">
                                    {$sol.institucion_destino}
                                </div>
                                <div data-title="Estado" class="data-info" tabindex="0">
                                    {if $sol.codigo_estado == 'APROBADO'}
                                        <span class="ubb-datatag-success">Aprobada</span>
                                    {elseif $sol.codigo_estado == 'RECHAZADO'}
                                        <span class="ubb-datatag-error">Rechazada</span>
                                    {elseif $sol.codigo_estado == 'OBSERVADO'}
                                        <span class="ubb-datatag-other">Observada</span>
                                    {else}
                                        <span class="ubb-datatag-other">En trámite</span>
                                    {/if}
                                </div>
                                <div data-title="Documentos" class="data-info">
                                    <button type="button" class="ubb-btn ubb-linear-btn btn-documentos"
                                        data-id="{$sol.id_solicitud}" aria-label="Ver documentos de {$sol.folio}">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </button>
                                </div>
                                <div data-title="Historial" class="data-info">
                                    <button type="button" class="ubb-btn ubb-linear-btn btn-historial"
                                        data-id="{$sol.id_solicitud}" data-tipo="S" aria-label="Ver historial de {$sol.folio}">
                                        <i class="fa fa-ellipsis" aria-hidden="true"></i>
                                    </button>
                                    {if $sol.codigo_estado == 'OBSERVADO'}
                                        <a href="perfeccionamiento/solicitud_nueva.php?id={$sol.id_solicitud}"
                                            class="ubb-btn ubb-linear-btn">
                                            <i class="fa fa-pen icon-left" aria-hidden="true"></i>Corregir
                                        </a>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    {/foreach}

                </div>
            </div>
        </section>
    {else}
        <section class="content-box">
            <div class="ubb-component-wrapper">
                <div class="ubb-message info-message search-info-message" role="status">
                    <i class="fa-solid fa-circle-info" aria-hidden="true"></i>
                    <span>No tiene solicitudes enviadas. Puede iniciar una nueva solicitud desde el botón superior.</span>
                </div>
            </div>
        </section>
    {/if}

</div>

<div id="modal_container"></div>