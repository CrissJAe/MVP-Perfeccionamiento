$(document).ready(function () {

    function recargarBandeja() {
        var form = document.getElementById('form_filtros');
        if (form) {
            form.submit();
        } else {
            window.location.reload();
        }
    }

    function cerrarModal() {
        var recargar = $('#modal_container .modal-overlay').data('recargar') === 1;
        $('#modal_container').html('');
        if (recargar) {
            recargarBandeja();
        }
    }

    $('#btn_limpiar').on('click', function () {
        $('#nombre').val('');
        $('#departamento').val('');
        $('#estado').val('');
        recargarBandeja();
    });

    $(document).on('click', '.btn-revisar', function () {
        var idSolicitud = $(this).data('id');
        var rolUsuario = $(this).data('rol') || 'DDA';

        $.ajax({
            url: 'perfeccionamiento/modal_revisar.php',
            type: 'POST',
            data: { id_solicitud: idSolicitud, rol_usuario: rolUsuario },
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
                alert('Error al cargar la solicitud.');
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
            cerrarModal();
        }
    });

    $(document).on('click', '.btn-cerrar-modal', function () {
        cerrarModal();
    });

    $(document).on('bandeja:recargar', function () {
        recargarBandeja();
    });

});