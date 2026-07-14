$(document).ready(function () {

    var POSTGRADO_DESC = 'Postgrado';

    function toggleGrado() {
        var texto = $('#id_tipo_perfeccionamiento option:selected').text().trim();
        if (texto === POSTGRADO_DESC) {
            $('#div_tipo_grado').show();
            $('#id_tipo_grado').prop('required', true);
        } else {
            $('#div_tipo_grado').hide();
            $('#id_tipo_grado').prop('required', false).val('');
        }
    }

    toggleGrado();
    $('#id_tipo_perfeccionamiento').on('change', toggleGrado);

    function toggleMontos(checkbox) {
        var id = $(checkbox).data('id');
        var div = $('#montos_' + id);
        if ($(checkbox).is(':checked')) {
            div.show();
        } else {
            div.hide();
            div.find('input').val('');
        }
    }

    $('.beneficio-check').each(function () {
        toggleMontos(this);
    });

    $('.beneficio-check').on('change', function () {
        toggleMontos(this);
    });

    $('#razones_patrocinio').on('input', function () {
        var len = $(this).val().length;
        $('#contador_razones').text('Caracteres: ' + len + ' / 4000');
    }).trigger('input');

    $('#btn_guardar_borrador').on('click', function () {
        $('#input_accion').val('borrador');
        var form = document.getElementById('form_solicitud');
        if (!form.reportValidity()) return;
        form.submit();
    });

    $('#btn_enviar_solicitud').on('click', function () {
        $('#input_accion').val('enviar');
        var form = document.getElementById('form_solicitud');
        if (!form.reportValidity()) return;
        form.submit();
    });

    $('.input-mask-date').datepicker({
        format: 'dd/mm/yyyy',
        language: 'es',
        autoclose: true
    });

    $(document).on('change', '.file-input-doc', function () {
        if (this.files.length === 0) return;
        var fd = new FormData();
        fd.append('id_documento', $(this).data('id'));
        fd.append('archivo', this.files[0]);
        $.ajax({
            url: 'perfeccionamiento/solicitud_subir_documento.php',
            type: 'POST',
            data: fd,
            processData: false,
            contentType: false,
            success: function () {
                var id = $('input[name="id_solicitud"]').val();
                window.location = 'perfeccionamiento/solicitud_nueva.php?id=' + id;
            }
        });
    });

    if ($('.success-message').length && $('input[name="id_solicitud"]').val()) {
        $('.ubb-datagrid-typefour').closest('.content-box')[0]?.scrollIntoView({ behavior: 'smooth' });
    }

    // Ver documento cargado en una pestaña nueva
    $(document).on('click', '.btn-ver-doc', function () {
        window.open('perfeccionamiento/solicitud_ver_documento.php?id=' + $(this).data('id'), '_blank');
    });

});