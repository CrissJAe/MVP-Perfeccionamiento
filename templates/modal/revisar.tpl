<link rel="stylesheet" href="perfeccionamiento/assets/css/perfeccionamiento.css">

<div class="modal-overlay" role="dialog" aria-modal="true" aria-labelledby="modal_revisar_titulo"
    {if $mensaje}data-recargar="1" {/if}>
    <div class="modal-box modal-box-lg">

        <div class="modal-header">
            <h2 id="modal_revisar_titulo" tabindex="0">
                Solicitud {$solicitud.folio|default:''}
            </h2>
            <button type="button" class="btn-cerrar-modal" aria-label="Cerrar modal">
                <i class="fa fa-xmark" aria-hidden="true"></i>
            </button>
        </div>

        <div class="modal-body">

            {if $mensaje}
                <div class="ubb-message success-message" role="status">
                    <i class="fa fa-circle-check" aria-hidden="true"></i>
                    <span>{$mensaje}</span>
                </div>
            {/if}

            {if $error}
                <div class="ubb-message error-message" role="alert">
                    <i class="fa fa-circle-xmark" aria-hidden="true"></i>
                    <span>{$error}</span>
                </div>
            {/if}

            {if !$mensaje}
                <p style="margin-bottom: 1rem;">
                    Revise los documentos adjuntos de la postulación y emita su resolución.
                </p>
            {/if}

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
                            <div data-title="#" class="data-info">
                                {$smarty.foreach.docs.iteration}
                            </div>
                            <div data-title="Documento" class="data-info">
                                {$doc.nombre_tipo}
                            </div>
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

            {if !$mensaje}
                <div id="panel_confirmar" style="display:none; margin-top: 1.5rem;">
                    <div class="ubb-message" id="confirmar_aviso" role="status">
                        <i class="fa fa-circle-info" aria-hidden="true"></i>
                        <span id="confirmar_texto"></span>
                    </div>
                    <div class="ubb-input" id="div_observacion" style="margin-top: 0.75rem;">
                        <label for="observacion_revisar" id="label_observacion">Motivo</label>
                        <textarea id="observacion_revisar" rows="3" maxlength="4000"
                            placeholder="Ingrese el motivo de su resolución..."
                            aria-describedby="contador_observacion"></textarea>
                        <span id="contador_observacion" class="character-counter">Caracteres: 0 / 4000</span>
                    </div>
                    <div style="margin-top: 0.75rem;">
                        <button type="button" class="ubb-btn ubb-filled-btn" id="btn_confirmar_visar">
                            <i class="fa fa-check icon-left" aria-hidden="true"></i>
                            <span id="txt_confirmar">Confirmar</span>
                        </button>
                        <button type="button" class="ubb-btn ubb-linear-btn btn-cancelar" id="btn_cancelar_visar">
                            Cancelar
                        </button>
                    </div>
                </div>
            {/if}

        </div>

        <div class="modal-footer">
            {if !$mensaje}
                <div id="acciones_visar">
                    <input type="hidden" id="revisar_id_solicitud" value="{$solicitud.id_solicitud}">
                    <input type="hidden" id="revisar_rol_usuario" value="{$rol_usuario|default:'DDA'}">

                    <button type="button" class="ubb-btn ubb-filled-btn btn-visar" data-accion="aprobar"
                        style="background-color: #146EBE; border-color: #146EBE;">
                        <i class="fa fa-check icon-left" aria-hidden="true"></i>Aprobar
                    </button>
                    <button type="button" class="ubb-btn ubb-filled-btn btn-visar" data-accion="rechazar"
                        style="background-color: #E03131; border-color: #E03131;">
                        <i class="fa fa-xmark icon-left" aria-hidden="true"></i>Rechazar
                    </button>
                    <button type="button" class="ubb-btn ubb-filled-btn btn-visar" data-accion="observar"
                        style="background-color: #FFD43B; border-color: #FFD43B; color: #6b4e00;">
                        <i class="fa fa-rotate-left icon-left" aria-hidden="true"></i>Observar
                    </button>
                </div>
            {/if}
        </div>

    </div>
</div>

<script>
    $(document).ready(function() {

        $('.btn-visar[data-accion="aprobar"]').on('click', function() {
            if (!confirm(
                    '¿Está seguro que desea aprobar esta solicitud? Se derivará a la siguiente etapa de revisión.'
                    )) {
                return;
            }
            ejecutarAccion('aprobar', '', $(this));
        });

        var textosMotivo = {
            rechazar: {
                titulo: 'Motivo de rechazo',
                texto: 'Escriba el motivo de rechazo de la solicitud',
                placeholder: 'Motivo del rechazo...'
            },
            observar: {
                titulo: 'Motivo de observación',
                texto: 'Escriba el motivo de la observación',
                placeholder: 'Motivo de la observación...'
            }
        };

        $('.btn-visar[data-accion="rechazar"], .btn-visar[data-accion="observar"]').on('click', function() {
            var accion = $(this).data('accion');
            var t = textosMotivo[accion];

            $('.btn-motivo-overlay').remove();

            var html = '' +
                '<div class="btn-motivo-overlay">' +
                '  <div class="modal-box">' +
                '    <div class="modal-header">' +
                '      <h2 tabindex="0">' + t.titulo + '</h2>' +
                '      <button type="button" class="btn-motivo-cerrar" aria-label="Cerrar modal"' +
                '          style="background:transparent;border:none;color:#c0392b;font-size:1.1rem;cursor:pointer;padding:4px 8px;">' +
                '        <i class="fa fa-xmark" aria-hidden="true"></i>' +
                '      </button>' +
                '    </div>' +
                '    <div class="modal-body">' +
                '      <p>' + t.texto + '</p>' +
                '      <div class="ubb-input">' +
                '        <textarea id="motivo_texto" rows="4" maxlength="4000" placeholder="' + t
                .placeholder + '"></textarea>' +
                '      </div>' +
                '    </div>' +
                '    <div class="modal-footer">' +
                '      <button type="button" class="ubb-btn ubb-filled-btn" id="btn_guardar_motivo">Guardar comentario</button>' +
                '      <button type="button" class="ubb-btn ubb-linear-btn btn-cancelar btn-motivo-cerrar">Cancelar</button>' +
                '    </div>' +
                '  </div>' +
                '</div>';

            $('#modal_container').append(html);
            $('#motivo_texto').focus();

            $('.btn-motivo-cerrar').on('click', function() {
                $('.btn-motivo-overlay').remove();
            });
            $('.btn-motivo-overlay').on('click', function(e) {
                if ($(e.target).hasClass('btn-motivo-overlay')) {
                    $('.btn-motivo-overlay').remove();
                }
            });

            $('#btn_guardar_motivo').on('click', function() {
                var motivo = $.trim($('#motivo_texto').val());
                if (motivo === '') {
                    $('#motivo_texto').focus().css('border-color', '#E03131');
                    return;
                }
                ejecutarAccion(accion, motivo, $(this));
            });
        });

        function ejecutarAccion(accion, observacion, $btn) {
            $btn.prop('disabled', true);
            $.ajax({
                url: 'perfeccionamiento/modal_revisar.php',
                type: 'POST',
                data: {
                    id_solicitud: $('#revisar_id_solicitud').val(),
                    rol_usuario: $('#revisar_rol_usuario').val(),
                    accion: accion,
                    observacion: observacion
                },
                success: function(html) {
                    $('.btn-motivo-overlay').remove();
                    $('#modal_container').html(html);
                },
                error: function() {
                    $btn.prop('disabled', false);
                    alert('Error al procesar la acción.');
                }
            });
        }

    });
</script>