<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<div class="modal-overlay" role="dialog" aria-modal="true" aria-labelledby="modal_hist_titulo">
    <div class="modal-box modal-box-lg">

        <div class="modal-header">
            <h2 id="modal_hist_titulo" tabindex="0">
                Historial — {$solicitud.folio|default:''}
            </h2>
            <button type="button" class="btn-cerrar-modal" aria-label="Cerrar modal">
                <i class="fa fa-xmark" aria-hidden="true"></i>
            </button>
        </div>

        <div class="modal-body">

            <div class="ubb-steps-progressbar">
                <div class="progressbar-container" id="progress-bar-container">
                    <div class="progressbar-line-container progressbar-grey-line" role="progressbar"
                        aria-label="Progreso de la solicitud">
                        <div class="progressbar-blue-line" aria-hidden="true"></div>
                    </div>
                    <div class="progressbar-steps" role="list" aria-label="Etapas de la solicitud">
                        {foreach $etapas as $etapa}
                            <div class="progress-step {if $etapa.completado}completed{elseif $etapa.en_curso}active{elseif $etapa.alerta}alert-step{/if}"
                                role="listitem"
                                aria-label="Etapa {$etapa.numero}: {$etapa.label}{if $etapa.completado} — Completada{elseif $etapa.en_curso} — En curso{elseif $etapa.alerta}{if $etapa.tipo_alerta == 'OBSERVADO'} — Observada{else} — Rechazada{/if}{else} — Pendiente{/if}">
                                {if $etapa.completado}
                                    <i class="fa fa-check" aria-hidden="true"></i>
                                {elseif $etapa.alerta}
                                    <i class="fa {if $etapa.tipo_alerta == 'OBSERVADO'}fa-exclamation{else}fa-xmark{/if}"
                                        aria-hidden="true"></i>
                                {else}
                                    {$etapa.numero}
                                {/if}
                            </div>
                        {/foreach}
                    </div>
                </div>
                <div class="progressbar-labels">
                    {foreach $etapas as $etapa}
                        <div
                            class="step-label {if $etapa.completado}completed{elseif $etapa.en_curso}active{elseif $etapa.alerta}alert{/if}">
                            <span>{$etapa.label}</span>
                            {if $etapa.en_curso}
                                <small>En curso</small>
                            {elseif $etapa.alerta}
                                <small>{if $etapa.tipo_alerta == 'OBSERVADO'}Observada{else}Rechazada{/if}</small>
                            {elseif $etapa.completado}
                                <small>Aprobada</small>
                            {else}
                                <small>Pendiente</small>
                            {/if}
                        </div>
                    {/foreach}
                </div>
            </div>

            <div class="ubb-datagrid-typeseven" style="margin-top: 1.5rem;">
                <div class="ubb-datagrid-container">
                    <h2 tabindex="0">Detalle</h2>
                    <div class="data-row">
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">FOLIO</dt>
                                <dd class="data-info">{$solicitud.folio|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">ESTADO</dt>
                                <dd class="data-info">
                                    {if $solicitud.codigo_estado == 'APROBADO'}
                                        <span class="ubb-datatag-success">{$solicitud.estado}</span>
                                    {elseif $solicitud.codigo_estado == 'RECHAZADO'}
                                        <span class="ubb-datatag-error">{$solicitud.estado}</span>
                                    {elseif $solicitud.codigo_estado == 'OBSERVADO'}
                                        <span class="ubb-datatag-other">{$solicitud.estado}</span>
                                    {else}
                                        <span class="ubb-datatag-other">En trámite</span>
                                    {/if}
                                </dd>
                            </div>
                        </dl>
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">ACADÉMICO/A</dt>
                                <dd class="data-info">{$solicitud.nombre_academico|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">PROGRAMA</dt>
                                <dd class="data-info">{$solicitud.nombre_programa|default:'—'}</dd>
                            </div>
                        </dl>
                        <dl class="data-column">
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">INSTITUCIÓN</dt>
                                <dd class="data-info">{$solicitud.institucion_destino|default:'—'}</dd>
                            </div>
                            <div class="data-field" tabindex="0">
                                <dt class="data-title">PERÍODO</dt>
                                <dd class="data-info">
                                    {$solicitud.fecha_inicio|default:'—'} — {$solicitud.fecha_termino|default:'—'}
                                </dd>
                            </div>
                        </dl>
                    </div>
                </div>
            </div>

            {if $historial}
                <div style="margin-top: 1.5rem;">
                    <div class="header-row">
                        <h3 class="header-title" tabindex="0">Eventos de la solicitud</h3>
                        <span class="header-line"></span>
                    </div>
                    <div class="ubb-datagrid-typefour" style="--cols: 4; margin-top: 0.75rem;">
                        <div class="ubb-header-row datagrid-row">
                            <div class="data-title">Fecha</div>
                            <div class="data-title">Evento</div>
                            <div class="data-title">Responsable</div>
                            <div class="data-title">Observación</div>
                        </div>
                        {foreach $historial as $evento}
                            <div class="ubb-datagrid-container datagrid-row">
                                <div class="data-row">
                                    <div data-title="Fecha" class="data-info">{$evento.fecha_evento}</div>
                                    <div data-title="Evento" class="data-info">{$evento.estado}</div>
                                    <div data-title="Responsable" class="data-info">{$evento.rol_label}</div>
                                    <div data-title="Observación" class="data-info">
                                        {$evento.observacion|default:'—'}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/if}

        </div>

        <div class="modal-footer">
            <button type="button" class="ubb-btn ubb-filled-btn btn-cerrar-modal">
                <i class="fa fa-xmark icon-left" aria-hidden="true"></i>Cerrar
            </button>
        </div>

    </div>
</div>