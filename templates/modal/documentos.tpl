<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<div class="modal-overlay" role="dialog" aria-modal="true" aria-labelledby="modal_docs_titulo">
    <div class="modal-box">

        <div class="modal-header">
            <h2 id="modal_docs_titulo" tabindex="0">
                Documentos {$solicitud.folio|default:''}
            </h2>
            <button type="button" class="btn-cerrar-modal" aria-label="Cerrar modal">
                <i class="fa fa-xmark" aria-hidden="true"></i>
            </button>
        </div>

        <div class="modal-body">
            <div class="ubb-datagrid-typefour" style="--cols: 5;">
                <div class="ubb-header-row datagrid-row">
                    <div class="data-title">#</div>
                    <div class="data-title">Documento</div>
                    <div class="data-title">Formato</div>
                    <div class="data-title">Estado</div>
                    <div class="data-title">Acción</div>
                </div>

                {foreach $documentos as $doc name="docs"}
                    <div class="ubb-datagrid-container datagrid-row">
                        <div class="data-row">
                            <div data-title="#" class="data-info">{$smarty.foreach.docs.iteration}</div>
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
                                    <a href="perfeccionamiento/{if $doc.es_ficha|default:false}solicitud_ver_ficha.php?id={$solicitud.id_solicitud}{else}solicitud_ver_documento.php?id={$doc.id_sol_documento}{/if}"
                                        target="_blank" class="ubb-btn ubb-linear-btn" aria-label="Ver {$doc.nombre_tipo}">
                                        <i class="fa fa-eye" aria-hidden="true"></i>
                                    </a>
                                {else}
                                    —
                                {/if}
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="ubb-btn ubb-filled-btn btn-cerrar-modal">
                <i class="fa fa-xmark icon-left" aria-hidden="true"></i>Cerrar
            </button>
        </div>

    </div>
</div>