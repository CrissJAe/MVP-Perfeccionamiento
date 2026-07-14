<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<script src="{$PATH_JS_RECURSOS_DEV}js/funciones_generales.js"></script>
<script src="perfeccionamiento/assets/js/bandeja.js"></script>

<div id="div_base" class="ubb-container">

    <div class="ubb-container-page-header">
        <header class="page-header">
            <h1 tabindex="0">Bandeja Postulación</h1>
            <button type="button" class="ubb-btn ubb-linear-btn" id="btn_exportar" aria-label="Exportar bandeja">
                <i class="fa fa-download icon-left" aria-hidden="true"></i>Exportar
            </button>
        </header>
    </div>

    <section class="content-box">
        <div class="ubb-component-wrapper">
            <form id="form_filtros" method="POST" action="perfeccionamiento/bandeja_postulacion.php">
                <div class="ubb-filtros-inline">

                    <div class="ubb-input ubb-filtro-campo">
                        <label for="nombre">Nombre académico/a</label>
                        <input type="text" id="nombre" name="nombre" class="form-control"
                            placeholder="Buscar por nombre" value="{$filtros.nombre|default:''}">
                    </div>

                    <div class="ubb-input ubb-filtro-campo">
                        <label for="departamento">Departamento</label>
                        <select id="departamento" name="departamento" class="form-control">
                            <option value="">Todas</option>
                            {foreach $departamentos as $depto}
                                <option value="{$depto.departamento}"
                                    {if $filtros.departamento == $depto.departamento}selected{/if}>
                                    {$depto.departamento}
                                </option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="ubb-input ubb-filtro-campo">
                        <label for="estado">Estado</label>
                        <select id="estado" name="estado" class="form-control">
                            <option value="">Todos</option>
                            <option value="EN_TRAMITE" {if $filtros.estado == 'EN_TRAMITE'}selected{/if}>Pendiente
                            </option>
                            <option value="OBSERVADO" {if $filtros.estado == 'OBSERVADO'}selected{/if}>Observada
                            </option>
                            <option value="APROBADO" {if $filtros.estado == 'APROBADO'}selected{/if}>Aprobada</option>
                            <option value="RECHAZADO" {if $filtros.estado == 'RECHAZADO'}selected{/if}>Rechazada
                            </option>
                        </select>
                    </div>

                    <div class="ubb-filtro-botones">
                        <button type="submit" class="ubb-btn ubb-filled-btn">
                            <i class="fa fa-search icon-left" aria-hidden="true"></i>Buscar
                        </button>
                        <button type="button" class="ubb-btn ubb-linear-btn" id="btn_limpiar">
                            Limpiar
                        </button>
                    </div>

                </div>
            </form>
        </div>
    </section>

    <section class="content-box">
        <div class="ubb-component-wrapper">

            {if $solicitudes}
                <div class="ubb-datagrid-typefour" style="--cols: 7;">
                    <div class="ubb-header-row datagrid-row">
                        <div class="data-title">Folio</div>
                        <div class="data-title">RUT</div>
                        <div class="data-title">Académico/a</div>
                        <div class="data-title">Programa</div>
                        <div class="data-title">Estado</div>
                        <div class="data-title">Revisar</div>
                        <div class="data-title">Historial</div>
                    </div>

                    {foreach $solicitudes as $sol}
                        <div class="ubb-datagrid-container datagrid-row">
                            <div class="data-row">
                                <div data-title="Folio" class="data-info" tabindex="0">
                                    {$sol.folio|default:'—'}
                                </div>
                                <div data-title="RUT" class="data-info" tabindex="0">
                                    {$sol.rut_academico}
                                </div>
                                <div data-title="Académico/a" class="data-info" tabindex="0">
                                    {$sol.nombre_academico}
                                </div>
                                <div data-title="Programa" class="data-info" tabindex="0">
                                    {$sol.nombre_programa}
                                </div>
                                <div data-title="Estado" class="data-info" tabindex="0">
                                    {if $sol.codigo_estado == 'APROBADO'}
                                        <span class="ubb-datatag-success">Aprobada</span>
                                    {elseif $sol.codigo_estado == 'RECHAZADO'}
                                        <span class="ubb-datatag-error">Rechazada</span>
                                    {elseif $sol.codigo_estado == 'OBSERVADO'}
                                        <span class="ubb-datatag-other">Observada</span>
                                    {else}
                                        <span class="ubb-datatag-other">Pendiente</span>
                                    {/if}
                                </div>
                                <div data-title="Revisar" class="data-info">
                                    <button type="button" class="ubb-btn ubb-linear-btn btn-revisar"
                                        data-id="{$sol.id_solicitud}" data-rol="{$rol_usuario}"
                                        aria-label="Revisar solicitud {$sol.folio}">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </button>
                                </div>
                                <div data-title="Historial" class="data-info">
                                    <button type="button" class="ubb-btn ubb-linear-btn btn-historial"
                                        data-id="{$sol.id_solicitud}" data-tipo="S" aria-label="Ver historial de {$sol.folio}">
                                        <i class="fa fa-ellipsis" aria-hidden="true"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    {/foreach}

                </div>
            {else}
                <div class="ubb-message info-message search-info-message" role="status">
                    <i class="fa-solid fa-circle-info" aria-hidden="true"></i>
                    <span>No se encontraron solicitudes con los filtros aplicados.</span>
                </div>
            {/if}

        </div>
    </section>

</div>

<div id="modal_container"></div>