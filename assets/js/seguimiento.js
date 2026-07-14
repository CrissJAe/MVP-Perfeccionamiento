$(document).ready(function () {

    $(document).on('click', '.btn-documentos', function () {
        var idSolicitud = $(this).data('id');

        $.ajax({
            url: 'perfeccionamiento/modal_documentos.php',
            type: 'POST',
            data: { id_solicitud: idSolicitud },
            beforeSend: function () {
                $('#modal_container').html(
                    '<div class="modal-overlay">' +
                    '<div class="modal-box">' +
                    '<i class="fa fa-spin fa-spinner fa-2x" aria-hidden="true"></i>' +
                    '</div></div>'
                );
            },
            success: function (html) {
                $('#modal_container').html(html);
            },
            error: function () {
                $('#modal_container').html('');
                alert('Error al cargar los documentos.');
            }
        });
    });

    $(document).on('click', '.btn-historial', function () {
        var idSolicitud = $(this).data('id');
        var tipo = $(this).data('tipo');

        $.ajax({
            url: 'perfeccionamiento/modal_historial.php',
            type: 'POST',
            data: { id_proceso: idSolicitud, tipo_proceso: tipo },
            beforeSend: function () {
                $('#modal_container').html(
                    '<div class="modal-overlay">' +
                    '<div class="modal-box">' +
                    '<i class="fa fa-spin fa-spinner fa-2x" aria-hidden="true"></i>' +
                    '</div></div>'
                );
            },
            success: function (html) {
                $('#modal_container').html(html);
            },
            error: function () {
                $('#modal_container').html('');
                alert('Error al cargar el historial.');
            }
        });
    });

    $(document).on('click', '.modal-overlay', function (e) {
        if ($(e.target).hasClass('modal-overlay')) {
            $('#modal_container').html('');
        }
    });

    $(document).on('click', '.btn-cerrar-modal', function () {
        $('#modal_container').html('');
    });

});