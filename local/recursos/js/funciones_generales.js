//var grafico_conf = "/recursos/dev/js/conf_highchart.js";

/* Reemplazar cadenas de texto (equivalente a str_replace de PHP) -------------------------------------------------*/
function escapeRegExp(string) {
    return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
}
function replaceAll(string, find, replace) {
    return string.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}
/* !-- ------------------------------------------------------------------------ */

/* Comentar esto cuando se suba */
function imprimeModalB() {

    if ($("#modal").length > 0) {
        if ($("#modal").attr('aria-hidden') == 'false') {
            var html = '';
            $('body').css("visibility", "hidden");
            $(this).css("visibility", "visible");

            var $div = $('<div class="col-xs-12"></div>');
            $("#modal").find('.modal-body').each(function () {
                if ($(this).is(":visible")) {
                    html = $(this).html();
                }
            });
            $div.append(html);
            $div.printArea();
            $('#modal').modal("hide");
            $('body').css("visibility", "visible");
        }
        else {
            var div = $("<div></div>");
            div.append($(".page-content").html());
            div.contents(".bs-callout").contents("div[class='row']").contents("div[class='col-xs-12 col-lg-6']").removeClass("col-xs-12 col-lg-6").addClass("col-xs-6 col-lg-6");
            div.find("script").remove();
            imprimeContenido(div);
        }
    }
    else if ($("#modal_post_smart").length > 0) {
        if ($("#modal_post_smart").attr('aria-hidden') == 'false') {
            var html = '';
            $('body').css("visibility", "hidden");
            $(this).css("visibility", "visible");

            var $div = $('<div class="col-xs-12"></div>');
            $("#modal_post_smart").find('.modal-body').each(function () {
                if ($(this).is(":visible")) {
                    html = $(this).html();
                }
            });
            $div.append(html);
            $div.printArea();
            $('#modal_post_smart').modal("hide");
            $('body').css("visibility", "visible");
        }
        else {
            var div = $("<div></div>");
            div.append($(".page-content").html());
            div.contents(".bs-callout").contents("div[class='row']").contents("div[class='col-xs-12 col-lg-6']").removeClass("col-xs-12 col-lg-6").addClass("col-xs-6 col-lg-6");
            div.find("script").remove();
            imprimeContenido(div);
//            window.print();
        }
    }
    else {
        var div = $("<div></div>");
        div.append($(".page-content").html());
        div.contents(".bs-callout").contents("div[class='row']").contents("div[class='col-xs-12 col-lg-6']").removeClass("col-xs-12 col-lg-6").addClass("col-xs-6 col-lg-6");
        div.find("script").remove();
        imprimeContenido(div);
    }
}
/* validacion de rut ---------------------------------------------------------------------------------------------------------------------------*/
function checkRutFieldGeneral(id_rut) {
    var rut = $("#" + id_rut).val();
    var rut_campo = $("#" + id_rut);
    var tmpstr = "";

    for (i = 0; i < rut.length; i++)
        if (rut.charAt(i) != ' ' && rut.charAt(i) != '.' && rut.charAt(i) != '-')
            tmpstr = tmpstr + rut.charAt(i);
    rut = tmpstr;
    largo = rut.length;
    tmpstr = "";
    for (i = 0; rut.charAt(i) == '0'; i++)
        ;
    for (; i < rut.length; i++)
        tmpstr = tmpstr + rut.charAt(i);
    rut = tmpstr;
    largo = rut.length;

    if (largo < 2) {
        // alert("Debe ingresar el rut completo.");
//        mensajes_alert("Alerta", "Debe ingresar el rut completo.", '3');
        mensajes_alert_id('Debe ingresar el rut completo.', false, rut_campo);
        rut_campo.val('');
        rut_campo.focus();
        rut_campo.select();
        return false;
    }
    for (i = 0; i < largo; i++) {
        if (rut.charAt(i) != "0" && rut.charAt(i) != "1" && rut.charAt(i) != "2" && rut.charAt(i) != "3" && rut.charAt(i) != "4" && rut.charAt(i) != "5" && rut.charAt(i) != "6" && rut.charAt(i) != "7" && rut.charAt(i) != "8" && rut.charAt(i) != "9" && rut.charAt(i) != "k" && rut.charAt(i) != "K") {
            // alert("El valor ingresado no corresponde a un R.U.T valido.");
//            mensajes_alert("Alerta", "El valor ingresado no corresponde a un R.U.T valido.", '3');
            mensajes_alert_id('El valor ingresado no corresponde a un R.U.T valido.', id_rut);
            rut_campo.val('');
            rut_campo.focus();
            rut_campo.select();
            return false;
        }
    }
    var invertido = "";
    for (i = (largo - 1), j = 0; i >= 0; i--, j++)
        invertido = invertido + rut.charAt(i);
    var drut = "";
    drut = drut + invertido.charAt(0);
    drut = drut + '-';
    cnt = 0;
    for (i = 1, j = 2; i < largo; i++, j++) {
        if (cnt == 3) {
            drut = drut + '.';
            j++;
            drut = drut + invertido.charAt(i);
            cnt = 1;
        }
        else {
            drut = drut + invertido.charAt(i);
            cnt++;
        }
    }
    invertido = "";
    for (i = (drut.length - 1), j = 0; i >= 0; i--, j++)
        invertido = invertido + drut.charAt(i);
    // document.autorizar_permiso.rut.value = invertido;
    rut_campo.val(invertido);
    if (checkDVGeneral(rut, id_rut))
        return true;
    return false;
}
function checkDVGeneral(crut, id_rut) {
    var rut_campo = $("#" + id_rut);
    largo = crut.length;
    var crut_campo = $("#" + id_rut);
    if (largo < 2) {
        // alert("Debe ingresar el rut completo.");
//        mensajes_alert("Alerta", "Debe ingresar el rut completo.", '3');
        mensajes_alert_id('Debe ingresar el rut completo.', id_rut);
        rut_campo.val('');
        rut_campo.focus();
        rut_campo.select();
        return false;
    }
    if (largo > 2)
        rut = crut.substring(0, largo - 1);
    else
        rut = crut.charAt(0);
    dv = crut.charAt(largo - 1);
    checkCDVGeneral(dv, id_rut);
    if (rut == null || dv == null)
        return 0;
    var dvr = '0';
    suma = 0;
    mul = 2;
    for (i = rut.length - 1; i >= 0; i--) {
        suma = suma + rut.charAt(i) * mul;
        if (mul == 7)
            mul = 2;
        else
            mul++;
    }
    res = suma % 11;
    if (res == 1)
        dvr = 'k';
    else if (res == 0)
        dvr = '0';
    else {
        dvi = 11 - res;
        dvr = dvi + "";
    }
    if (dvr != dv.toLowerCase()) {
        // alert("EL rut es incorrecto.");
        mensajes_alert("Advertencia", "EL rut es incorrecto.", '3');
        crut_campo.val('');
        crut_campo.focus();
        crut_campo.select();
        crut_campo.parent().parent().find('input[type="text"]').val('');
        return false;
    }
    return true;
}
function checkCDVGeneral(dvr, id_rut) {
    var rut_campo = $("#" + id_rut);
    dv = dvr + "";
    if (dv != '0' && dv != '1' && dv != '2' && dv != '3' && dv != '4' && dv != '5' && dv != '6' && dv != '7' && dv != '8' && dv != '9' && dv != 'k' && dv != 'K') {
        // alert("Debe ingresar un digito verificador valido.");
//        mensajes_alert("Debe ingresar un digito verificador valido.", '3');
        mensajes_alert_id('Debe ingresar s\xF3lo numeros', id_rut);
        rut_campo.val('');
        rut_campo.focus();
        rut_campo.select();
        return false;
    }
    return true;
}
//Activa check del buscador Rut
function activaCheckGeneral(rut_id, nombre_id, check_id, btn_buscar_id) {
    if ($('#' + check_id).prop('checked') == true) {
        $('#' + btn_buscar_id).attr('disabled', true);
        $('#' + rut_id).attr('readonly', true);
        $('#' + rut_id).val('');
        $('#' + nombre_id).val('');
    }
    else {
        $('#' + btn_buscar_id).attr('disabled', false);
        $('#' + rut_id).attr('readonly', false);
        $('#' + rut_id).focus();
    }
}
//Busqueda por ajax Nombre asociado al rut
function cargaContenidoGeneral(rut_filtro, nombre_filtro, dir, url, var_rut, texto_rut) {
    if (var_rut == undefined) {
        var_rut = 'rut';
    }
    if (texto_rut == undefined) {
        texto_rut = 'Alumno';
    }
    var rut_aux = $("#" + rut_filtro).val();
    if (checkRutFieldGeneral('' + rut_filtro + '') == false) {
        return;
    }

    rut_aux = rut_aux.split('-');
    var rut = replaceAll(rut_aux[0], '.', '');
    var final_string = '../' + dir + '/' + url + '.php?' + var_rut + '=' + rut;
    // var final_string='../titulos_grados/buscar_alumno_ajax.php?rut='+rut_aux;
    $.ajax({
        url: final_string,
        type: "GET",
        processData: true, // tell jQuery not to process the data
        async: false,
        cache: false,
        success: function (response) {
            if ($.trim(response) == 'error' || $.trim(response) == '') {
//                    mensajes_alert('Alerta', 'no encontrado', '3');
                makeGritter('Advertencia', '' + texto_rut + ' no encontrado', 'warning');
                $('#' + rut_filtro).val('');
                $('#' + nombre_filtro).val('');
                $('#' + rut_filtro).focus();
            }
            else {
                $('#' + nombre_filtro).val($.trim(response));
            }
        }
    });

}
//Valida que sean solo numeros onKeyPress="return soloNumerosGeneral(event);"
function soloNumerosGeneral(evt) {
    //asignamos el valor de la tecla a keynum
    if (window.event) {// IE
        keynum = evt.keyCode;
    } else {
        keynum = evt.which;
    }
    //comprobamos si se encuentra en el rango
    if ((keynum > 47 && keynum < 58) || (keynum == 8) || (keynum == 0) || (keynum == 13)) {
        return true;
    } else {
        var field = '';
        $(":focus").each(function () {
            field = $(this);
        });
//        mensajes_alert("Alerta", "Debe ingresar s\xF3lo numeros", "3");
        mensajes_alert_id('Debe ingresar s\xF3lo numeros', false, field);
        return false;
    }
}


/*  ---------------------------------------------------------------------------------------------------------------------------*/







/*---------------------------------------------------------------------*/

//Imprimir un div
function PrintContent(id)
{
    $("#" + id).printArea();
}
//Imprimir de forma anidada mas de un div, enviado el id separado por |
function PrintContentPlus(id, id_imprimir)
{
    var ids = id.split("|");
    var html = '';
    for (var i = 0; i < ids.length; i++) {
        html += $("#" + ids[i]).html();
        html + '<br><br>';
    }
    var $div = $('<div class="col-xs-12"></div>');
    $div.html(html);
    $div.printArea();
    // $("#"+id_imprimir).html(html);
    // $("#"+id_imprimir).printArea();
}
function PrintModal(id_modal) {
    var html = '<h3 class="h3 lighter blue">' + $("#modal-title").html() + '</h3>';
    var $div = $('<div class="col-xs-12"></div>');
    $div.html(html + $("#modal-body").html());
    $div.printArea();


}

//Enviar formulario por ajax
function enviar_form(uri, div, section, name_form, id_buscar) {

    uri = $.trim(uri);
    var inicio_string = (parseInt(uri.length) - 4);
    var final_string = parseInt(uri.length);
    var uri_php = uri.substring(inicio_string, final_string);
    if (uri_php != '.php') {
        uri = uri + '.php';
    }
    var data_array = $('form[name="' + name_form + '"]').serialize();
    onPost_(uri, null, section, data_array, null, id_buscar);

    /*
    var final_string = "../" + section + "/" + uri;

    //Cargando
    if (id_buscar != '') {
        var icono = $('#' + id_buscar).find('i');
        var icono_ant = icono.attr('class');
        $('#' + id_buscar).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }

    $.ajax({
        url: final_string,
        type: "POST",
        data: data_array,
        processData: true, // tell jQuery not to process the data
        //  contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        success: function (response) {
            if (div.search("modal") > 0) { //es modal? Es requerimiento que la clase del modal se concatene con -body
                $(div + '-body').html(response);
                $(div).modal('show');
            } else {
                $(".page-content").html(response);
                if (id_buscar != '') {
                    //Limpiar cargando
                    $('#' + id_buscar).attr('disabled', false);
                    icono.attr('class', '' + icono_ant + '');
                }


            }
        }
    });
    */
}
//Guardar o enviar
function enviar_form_action(uri, div, section, name_form, btn_action, method) {
    if (method == undefined) {
        method = "POST";
    }

    uri = $.trim(uri);
    var inicio_string = (parseInt(uri.length) - 4);
    var final_string = parseInt(uri.length);
    var uri_php = uri.substring(inicio_string, final_string);
    if (uri_php != '.php') {
        uri = uri + '.php';
    }
    var data_array = $('form[name="' + name_form + '"]').serialize();
    if(div=='')
        div =null;
    else
        div='#'+div;
    if(method=='POST'){
         onPost_(uri, div, section, data_array, null, btn_action);
    }
    else{
       onGet(uri, div, section, data_array,null,null,btn_action);
    }
    /*
    var final_string = "../" + section + "/" + uri;
    //Cargando
    if (btn_action != '') {
        var icono = $('#' + btn_action).find('i');
        var icono_ant = icono.attr('class');
        $('#' + btn_action).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }

    $.ajax({
        url: final_string,
        type: method,
        data: data_array,
        processData: true, // tell jQuery not to process the data
        // mimeType:'text/html; charset=iso-8859-10',
        // contentType: 'text/x-javascript; charset:ISO-8859-1',
        // contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1',   // tell jQuery not to set contentType, text/html; charset=iso-8859-1
        async: false,
        cache: false,
        success: function (response) {
            if (div != '') {
                $("#" + div).html(response);
            }
            else {
                $(".page-content").html(response);
            }
            if (btn_action != '') {
                //Limpiar cargando
                $('#' + btn_action).attr('disabled', false);
                icono.attr('class', '' + icono_ant + '');
            }
        }
    }); */
}

/*
 * POST especial para enviar archivos adjuntos
 * Requerimientos: El formulario debe tener ID
 * EL Formulario debe tener el atributo enctype="multipart/form-data"
 */
function enviar_form_action_file(uri, div, section, name_form, btn_action) {
    uri = $.trim(uri);
//        alert(uri);
    var inicio_string = (parseInt(uri.length) - 4);
    var final_string = parseInt(uri.length);
    var uri_php = uri.substring(inicio_string, final_string);
    if (uri_php != '.php') {
        uri = uri + '.php';
    }
    var final_string = "../" + section + "/" + uri;
    /*Cargando */
    if (btn_action != '') {
        var icono = $('#' + btn_action).find('i');
        var icono_ant = icono.attr('class');
        $('#' + btn_action).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }
    var data_array = new FormData(document.getElementById("" + name_form + ""));
    $.ajax({
        url: final_string,
        type: "POST",
        data: data_array,
        mimeType: "multipart/form-data",
        contentType: false,
        cache: false,
        processData: false,
        async: false,
        success: function (response, textStatus, jqXHR) {
            // Handle the complete event
            if (div.search("modal") > 0) { //es modal? Es requerimiento que la clase del modal se concatene con -body
                $(div + '-body').html(response);
                $(div).modal('show');
            } else {
                $(".page-content").html(response);
                if (btn_action != '') {
                    //Limpiar cargando
                    $('#' + btn_action).attr('disabled', false);
                    icono.attr('class', '' + icono_ant + '');
                }
            }
        }
    });

}
//Cerrar modal
function cerrarModal(modal) {
    if (modal == undefined) {
        modal = 'modal';
    }
    $('#' + modal).modal('hide');
}
function cerrarModalID(modal_body, esconder) {
    if (modal_body == 'modal-body' && esconder == 1) {
        $("#modal-body").slideUp(300, function () {
            $("#modal-homo").slideDown(300);
        });
    }
    else if (modal_body == 'modal-homo') {
        $("#modal-homo").slideUp(300, function () {
            $("#modal-body").slideDown(300);
        });
    }
    else if (modal_body == 'modal-body') {
        $('#modal').modal('hide');
    }
}
function mostrar_modal_body_homo(id_modal, modal_body_mostrar, modal_body_esconder) {
    $('#' + id_modal + ' #' + modal_body_esconder).slideUp(300, function () {
        $('#' + id_modal + ' #' + modal_body_mostrar).slideDown(300);
    });
}

//Cargar datos modal
function cargar_datos_modal(titulo, datos_id, datos_val, dir, url_pag, btn_action) {

    if (btn_action == undefined) {
        btn_action = '';
    }
    var final_string = "../" + dir + "/" + url_pag + ".php";

    //Descomprimo datos
    var param = datos_id.split("|");
    var val_param = datos_val.split("|");
    var myArray = {};

    //Combino Arrays
    for (var i = 0; i < param.length; i++) {
        myArray[param[i]] = val_param[i];
    }
    $('#modal #modal-body').html('');
    /*Cargando */
    if (btn_action != '') {
        var icono = $('#' + btn_action).find('i');
        var icono_ant = icono.attr('class');
        $('#' + btn_action).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin  fa-2x');
    }
setTimeout(function () {
    $.ajax({
        url: final_string,
        type: "GET",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        success: function (response) {
            $("#modal .modal-header").attr('class', "hidden");
            $("#modal #modal-title").attr('class', "h3 lighter blue");
            $('#modal #modal-title').html(titulo);
            $('#modal #modal-body').html(response);
            $("#modal .modal-footer").html('');
            $("#modal .modal-footer").html('<button type="button" class="btn btn-xs btn-white no-radius btn-info" data-dismiss="modal" onclick="cerrarModal();"><label class="box-title pull-right margenbtnsuperior dark"><span class="btn btn-xs btn-danger no-radius "><i class="glyphicon glyphicon-remove"></i></span> Cerrar</label></button>');
            $("#modal-homo").slideUp(100, function () {
                $("#modal-body ").slideDown(100);
            });
            $('#modal').modal('show');
            if (btn_action != '') {
                //Limpiar cargando
                $('#' + btn_action).attr('disabled', false);
                icono.attr('class', '' + icono_ant + '');
            }
        }
    });
}, 100);
}
//Llamar un modal sin parametros de botones. Botones seteados en pagina llamada modal footer.
function cargar_datos_modal_set(titulo, datos_id, datos_val, dir, url_pag) {
    var final_string = "../" + dir + "/" + url_pag + ".php";

    //Descomprimo datos
    var param = datos_id.split("|");
    var val_param = datos_val.split("|");
    var myArray = {};

    //Combino Arrays
    for (var i = 0; i < param.length; i++) {
        myArray[param[i]] = val_param[i];
    }
    $('#modal-body').html('');
setTimeout(function () {
    $.ajax({
        url: final_string,
        type: "GET",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        success: function (response) {
            $("#modal .modal-header").attr('class', "hidden");
            $("#modal #modal-title").attr('class', "h3 lighter blue");
            $('#modal #modal-title').html(titulo);
            $('#modal-body').html(response);
            $("#modal-homo").slideUp(100, function () {
                $("#modal-body").slideDown(100);
            });
            // $('#modal').modal('show');
        }
    });
}, 100);
}
function cargar_datos_modal_mod(titulo, datos_id, datos_val, dir, url_pag) {
    var final_string = "../" + dir + "/" + url_pag + ".php";
    //Descomprimo datos
    var param = datos_id.split("|");
    var val_param = datos_val.split("|");
    var myArray = {};

    //Combino Arrays
    for (var i = 0; i < param.length; i++) {
        myArray[param[i]] = val_param[i];
    }
    if (id_modal == '') {
        var id_modal = 'modal';
    }
     setTimeout(function () {
    $.ajax({
        url: final_string,
        type: "GET",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        success: function (response) {
            $("#modal .modal-header").attr('class', "hidden");
            $("#modal_mod #modal-title").attr('class', "h3 lighter blue");
            $('#modal_mod #modal-title').html(titulo);
            $('#modal_mod-body').html(response);
            $("#modal_mod .modal-footer").html('');
            $("#modal_mod .modal-footer").html('<button type="button" class="btn btn-xs btn-white no-radius btn-info" data-dismiss="modal" onclick="cerrarModal();"><label class="box-title pull-right margenbtnsuperior dark"><span class="btn btn-xs btn-danger no-radius "><i class="glyphicon glyphicon-remove"></i></span> Cerrar</label></button>');

            $("#modal-homo").slideUp(100, function () {
                $("#modal-body").slideDown(100);
            });
            $('#modal_mod').modal('show');
        }
    });
}, 100);
}

//Cargar html de un elemento en un modal solo texto
function cargar_datos_modal_elemento(titulo, id_elemento) {
    //accion al plugin
    var html = $("#" + id_elemento).html();
    $("#modal .modal-header").attr('class', "hidden");
    $("#modal #modal-title").attr('class', "h3 lighter blue");
    $('#modal #modal-title').html('');
    $('#modal #modal-title').html(titulo);
    $('#modal-body').html('<div class="box-header  pull-right hidden-print"><button class="btn btn-xs btn-white no-radius btn-info " onclick="imprimeModalB();"><label class="box-title pull-right margenbtnsuperior dark"><span class="btn btn-xs btn-info no-radius"  ><i class="glyphicon glyphicon-print"></i></span>Imprimir</label></button></div><div class="page-header"><h1>' + titulo + '</h1></div>' + html);
    $("#modal .modal-footer").html('');
    $("#modal .modal-footer").html('<button type="button" class="btn btn-xs btn-white no-radius btn-info" data-dismiss="modal" onclick="cerrarModal();"><label class="box-title pull-right margenbtnsuperior dark"><span class="btn btn-xs btn-danger no-radius "><i class="glyphicon glyphicon-remove"></i></span> Cerrar</label></button>');
    $("#modal-homo").slideUp(300, function () {
        $("#modal-body").slideDown(300);
    });
    $('#modal').modal('show');
}
//Cargar html de un elemento en un modal input, select o textarea
function cargar_datos_modal_elemento_input(titulo, id_elemento) {
    //accion al plugin
    $("#modal .modal-header").attr('class', "hidden");
    $("#modal #modal-title").attr('class', "h3 lighter blue");
    $('#modal #modal-title').html('');
    $('#modal #modal-title').html(titulo);
    var title = '<div class="page-header"><h1>' + titulo + '</h1></div>';
    $('#modal #modal-body').html(title + '<div class="bs-callout bs-callout-info no-bottom"><div class="row" id="modal_elemento_html"></div></div>');
    $("#modal .modal-footer").html('');
    $("#modal .modal-footer").html('<button type="button" class="btn btn-xs btn-white no-radius btn-info" data-dismiss="modal" onclick="cerrarModal();"><label class="box-title pull-right margenbtnsuperior dark"><span class="btn btn-xs btn-danger no-radius "><i class="glyphicon glyphicon-remove"></i></span> Cerrar</label></button>');
    $("#modal-homo").slideUp(100, function () {
        $("#modal-body").slideDown(100);
    });

    $('#modal').one('shown.bs.modal', function (e) {
        var cur_value = '';
        $("#" + id_elemento, window.parent.document).find('input[type="text"],input[type="hidden"],textarea,select').each(function () {
            if ($(this).prop("tagName") == 'INPUT') {
                $(this).attr('value', ($(this).val()));
            }
            else if ($(this).prop("tagName") == 'TEXTAREA') {
                $(this).html($(this).val());
            }
            else if ($(this).prop("tagName") == 'SELECT') {
                cur_value = $(this).val();
                $(this).find('option').removeAttr("selected");
                $(this).find('option[value="' + cur_value + '"]').attr('selected', true);
            }
        });
        var html_cargar = $("#" + id_elemento, window.parent.document).html();
        $('#modal_elemento_html').html(html_cargar);
    });

    $('#modal').one('hide.bs.modal', function (e) {
        var val_select = '';
        $("#modal #modal_elemento_html").find('input[type="text"],textarea,select').each(function () {
            if ($(this).prop("tagName") == 'INPUT') {
                $(this).attr('value', ($(this).val()));
            }
            else if ($(this).prop("tagName") == 'TEXTAREA') {
                $(this).html($(this).val());
            }
            else if ($(this).prop("tagName") == 'SELECT') {
                val_select = $(this).val();
                $(this).find('option').removeAttr("selected");
                $(this).find('option[value="' + val_select + '"]').attr('selected', true);
                // $(this).find('option[value='+val_select+']').attr('selected',true);
            }
        });

        var html_asignar = $("#modal #modal_elemento_html").html();
        $("#" + id_elemento, window.parent.document).html(html_asignar);
        $("#modal #modal-body").html('');
    });

    $('#modal').modal('show').trigger('shown');
    return false;
}

//Post en modal
function enviar_modal_post(url_pag, dir, id_modal, name_form, btn_action) {
    var myArray = $('form[name="' + name_form + '"]').serialize();
    var final_string = "../" + dir + "/" + url_pag + ".php";

    if (id_modal == '') {
        var id_modal = 'modal';
    }

     if (btn_action != '') {
        var icono = $('#' + btn_action).find('i');
        var icono_ant = icono.attr('class');
        $('#' + btn_action).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }

 setTimeout(function () {

    $.ajax({
        url: final_string,
        type: "POST",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        //mimeType:'text/html; charset=iso-8859-1',
        //contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1',
        success: function (response) {
            $('#' + id_modal + ' #modal-body').html(response);
            $('#' + 'id_modal').modal('show');
            if (btn_action != '') {
                //Limpiar cargando
                $('#' + btn_action).attr('disabled', false);
//                icono.attr('class', '' + icono_ant + '');
            }
        }
    });
}, 100);
}

function enviar_modal_post_homo(url_pag, dir, id_modal, modal_body, name_form, btn_action) {
    var myArray = $('form[name="' + name_form + '"]').serialize();
    var final_string = "../" + dir + "/" + url_pag + ".php";

    if (id_modal == '') {
        var id_modal = 'modal';
    }
    if (btn_action != '') {
        var icono = $('#' + btn_action).find('i');
        var icono_ant = icono.attr('class');
        $('#' + btn_action).attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }

    $.ajax({
        url: final_string,
        type: "POST",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        //mimeType:'text/html; charset=iso-8859-1',
        //contentType: 'application/x-www-form-urlencoded; charset=iso-8859-1',
        success: function (response) {
            $('#' + id_modal + ' #' + modal_body + '').html(response);

            // $('#'+'id_modal').modal('show');
            if (btn_action != '') {
                //Limpiar cargando
                $('#' + btn_action).attr('disabled', false);
                icono.attr('class', '' + icono_ant + '');
            }
        }
    });
}

//Post en modal file
function enviar_modal_post_file(uri, dir, id_modal, name_form, btn_modal) {
    uri = $.trim(uri);
    var inicio_string = (parseInt(uri.length) - 4);
    var final_string = parseInt(uri.length);
    var uri_php = uri.substring(inicio_string, final_string);
    if (uri_php != '.php') {
        uri = uri + '.php';
    }
    var final_string = "../" + dir + "/" + uri;
    if (id_modal == '') {
        var id_modal = 'modal';
    }

    var data_array = new FormData(document.getElementById("" + name_form + ""));
    $.ajax({
        url: final_string,
        type: "POST",
        data: data_array,
        mimeType: "multipart/form-data",
        contentType: false,
        cache: false,
        processData: false,
        async: false,
        success: function (data, textStatus, jqXHR) {
            // Handle the complete event
            //accion al plugin
            $('#' + id_modal + ' #modal-body').html(data);
            $('#' + 'id_modal').modal('show');
        }
    });

}
//Enviar link directo por get
function buscar_url(url_sin_extension, dir, datos_id, datos_val) {
    var final_string = '';
    if (dir != '') {
        final_string = "../" + dir + "/" + url_sin_extension + ".php";
        //Descomprimo datos
        var param = datos_id.split("|");
        var val_param = datos_val.split("|");
        var myArray = {};
        //Combino Arrays
        for (var i = 0; i < param.length; i++) {
            myArray[param[i]] = val_param[i];
        }
        $.ajax({
            url: final_string,
            type: "GET",
            data: myArray,
            processData: true, // tell jQuery not to process the data
            cache: false,
            //contentType: false,   // tell jQuery not to set contentType,
            async: false,
            success: function (response) {
                // Handle the complete event
                //accion al plugin
//                 response = " <script src='"+grafico_conf+"'><\/script>"+response;
                $(".page-content").html(response);
            }
        });

    }
    else {
        final_string = url_sin_extension;
        $.ajax({
            url: final_string,
            type: "GET",
            processData: true, // tell jQuery not to process the data
            cache: false,
            async: false,
            success: function (response) {
                $(".page-content").html(response);
            }
        });
    }
}
//Buscar url y asignar a un div
function buscar_url_div(url_sin_extension, dir, datos_id, datos_val, id_div) {
    var final_string = "../" + dir + "/" + url_sin_extension + ".php";

    //Descomprimo datos
    var param = datos_id.split("|");
    var val_param = datos_val.split("|");
    var myArray = {};

    //Combino Arrays
    for (var i = 0; i < param.length; i++) {
        myArray[param[i]] = val_param[i];
    }
    $.ajax({
        url: final_string,
        type: "GET",
        data: myArray,
        processData: true, // tell jQuery not to process the data
        //contentType: false,   // tell jQuery not to set contentType,
        async: false,
        cache: false,
        success: function (response) {
            // Handle the complete event
            //accion al plugin
            $("#" + id_div).html(response);
        }
    });
}

//Nuevo formato de alert, se envia el titulo de la ventana, texto a mostrar y clase: gritter-info, gritter-success o gritter-danger
function mensajes_alert(title, text, tipo_clase) {
//    $.gritter.removeAll();
    if (tipo_clase == '1') { //exito
        var clase = 'success';
    }
    if (tipo_clase == '2') { //info
        var clase = 'warning';
    }
    if (tipo_clase == '3') { //error
        var clase = 'warning';
    }
    if (tipo_clase == '4') { //warning
        var clase = 'warning';
    }
    if (tipo_clase == '5') { //info
        var clase = 'info';
    }
    makeGritter('' + title + '', '' + text + '', '' + clase + '');
//
//    //--Mensajes
//    setTimeout(function () {
//
//        $.gritter.add({
//            title: title,
//            text: text,
//            sticky: false,
//            time: '3500',
//            class_name: clase + ' gritter-center'  //'gritter-info gritter-light gritter-center'
//        });
//    }, 450);


}
//Tootip en elemento
function mensajes_alert_id(message, id, elemento) {
    if (elemento != undefined) {
        var field = elemento;
    }
    else if (id != undefined) {
        var field = $("#" + id);
    }
    field.attr("data-toggle", "tooltip");
    field.attr("data-original-title", message);
    field.tooltip({
        placement: 'bottom',
        trigger: 'focus',
        template: '<div class="tooltip tooltip-info"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    });
    field.tooltip('show');
    setTimeout(function () {
        field.focus();
    }, 180);
//    field.focus();

    setTimeout(function () {
        field.tooltip('destroy');
        field.attr("data-original-title", '');
    }, 4000);

    return false;
}

function confirmar(message, callback) {
    /*
     * Se debe declarar la funcion callback antes de llamar a confirmar, la idea es que se ejecute esa funcion al momento de que el usuario presione ok
     * var x=function callback(){
     $('form[name="frm_datos"]').submit();
     }
     confirmar('Esta seguro de enviar el formulario',x);
     */

    alertify.set({
        labels: {
            ok: "Aceptar",
            cancel: "Cancelar"
        },
        buttonReverse: true
    });


    alertify.confirm(message, function (e) {
        if (e) {
            callback();
        }
    });


}

//validacion generica en formularios
function validar_formulario(form) {
    var valido = true;
    var funciones = '';
    var messages = '';
    $('form[name="' + form + '"]').find("textarea,input,select").each(function () {
        if (valido == true) {
            if ($(this).prop('required')) {
                if (($(this).prop('disabled') == false)) {
                    if (!validateField($(this), 'El campo es obligatorio', 'es_vacio', valido, true)) {
                        valido = false;
                    }
                    else if ($(this).data('funcvalid') != '') {
                        if (!validateField($(this), $(this).data('textvalid'), $(this).data('funcvalid'), valido, true)) {
                            valido = false;
                        }
                        else {
                            $(this).tooltip('hide');
                            $(this).attr("data-original-title", '');
                        }
                    }
                    else {
                        $(this).tooltip('hide');
                        $(this).attr("data-original-title", '');
                    }
                }
            }
            else if (($(this).prop('disabled') == false) && (($(this).prop('readonly') == false) || $(this).prop('readonly') == undefined)) {
                if (!$(this).prop('required')) {
                    if($.trim($(this).val())!=''){
                        if ($(this).data('funcvalid')) {
                            funciones = $(this).data('funcvalid');
                            funciones = funciones.split('|');
                            messages = $(this).data('textvalid');
                            messages = messages.split('|');
                            for (var i = 0; i < funciones.length; i++) {
                                if (valido == true) {
                                    if (!validateField($(this), messages[i], funciones[i], valido, true)) {
                                        valido = false;
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }
    });
    return valido;

}
function no_editar(id) {
    if(id==undefined){
        $(document).find('input[type="text"],textarea,select,input[type="checkbox"],input[type="radio"]').each(function () {
            if (($(this).prop("disabled") == false) || ($(this).prop("readonly") == false)) {
                $(this).attr("disabled", true);
            }
        });
    }
    else{
            $('#'+id).find('input[type="text"],textarea,select,input[type="checkbox"],input[type="radio"]').each(function () {
                if (($(this).prop("disabled") == false) || ($(this).prop("readonly") == false)) {
                    $(this).attr("disabled", true);
                }
            });

    }
}

//Paginacion
function setPluginPaginacionIrPagina(pagina, form_name, input_pagina)
{
    if (form_name == 'undefined') {
        form_name = $('#setPluginPaginarForm').val();
    }
    var pagina_asignada = $('form[name="' + form_name + '"] #' + input_pagina + "").val();

    var directorio = $('form[name="' + form_name + '"] #setPluginPaginarDirec').val();
    var php = $('form[name="' + form_name + '"] #setPluginPaginarPhp').val();
    var modal = $('form[name="' + form_name + '"] #setPluginPaginarModal').val();
    var btn_buscar = $('form[name="' + form_name + '"] #setPluginPaginarBtnBuscar').val();
    var id_div = $('form[name="' + form_name + '"] #setIdDivPaginar').val();
    var boton = null;
    var icono = null;
    if (parseInt(pagina) == (parseInt(pagina_asignada) - 1)) {
        boton = 'setPluginPaginarBtnAnt';
        icono = $('form[name="' + form_name + '"] #' + boton + '').find('i');
        icono.attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin ');
    }
    else if (parseInt(pagina) == (parseInt(pagina_asignada) + 1)) {
        boton = 'setPluginPaginarBtnSig';
        icono = $('form[name="' + form_name + '"] #' + boton + '').find('i');
        icono.attr('disabled', true);
        icono.attr('class', 'ace-icon fa fa-refresh fa-spin');

    }
    else {
        boton = btn_buscar;
    }


    $('form[name="' + form_name + '"] #' + input_pagina + "").val(pagina);
    if (modal == true) {
        onPostSmart('' + php + '', '' + directorio + '', $('form[name="' + form_name + '"]').serialize(), null, '' + boton + '');
    }
    else {
        onPost_('' + php + '', $('' + id_div + ''), '' + directorio + '', $('form[name="' + form_name + '"]').serialize(), null, '' + boton + '');
    }

}

function setPluginPaginacionValidar(pag_max, form_name, input_pagina, pagina){
    if (parseInt(pagina) > parseInt(pag_max)){
        makeGritter('Advertencia', 'El rango de paginas es ' + pag_max , 'warning');
        $('form[name="' + form_name + '"] #setPluginPaginarVisible').val(pag_max);
        pagina = pag_max;
    }
    if (parseInt(pagina) < 1){
        $('form[name="' + form_name + '"] #setPluginPaginarVisible').val(1);
        pagina = 1;
    }
    setPluginPaginacionIrPagina(pagina, form_name, input_pagina)
}

function contar_caracteres_textarea(idTextarea,idContador,max_caracteres) {
//Contar caracteres
    var total_caracteres = $("#"+idTextarea).val().length;
    total_caracteres = (max_caracteres - parseInt(total_caracteres));
    $("#"+idContador).html(total_caracteres+'&nbsp;');
    if (parseInt($("#"+idTextarea).val().length) > max_caracteres) {
        $("#"+idContador).addClass("badge-danger");
        $("#"+idContador).removeClass("badge-info");
    }
    else {
        $("#"+idContador).removeClass("badge-danger");
        $("#"+idContador).addClass("badge-info");
    }
}

//Activa tooltip en las paginas data-toggle="tooltip"
$(function () {

    $('form').on('blur', 'input', function () {
        var valido = true;
        if ($(this).data('focusvalid') != '') {
            if (!validateField($(this), $(this).data('textvalid'), $(this).data('focusvalid'), valido, true)) {
                valido = false;
            }
        }
        return valido;
    });

    $('body').tooltip({
        selector: '[data-rel=tooltip]',
        placement: 'bottom',
        // delay: { show: 100, hide: 100 },
        // trigger: 'focus',
        template: '<div class="tooltip tooltip-info"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    });
    $('body').tooltip({
        selector: '[data-rel=tooltip-danger]',
        placement: 'bottom',
        // delay: { show: 100, hide: 100 },
        // trigger: 'focus',
        template: '<div class="tooltip tooltip-danger"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    });
    $('body').tooltip({
        selector: '[data-rel=tooltip-warning]',
        placement: 'bottom',
        // delay: { show: 100, hide: 100 },
        // trigger: 'focus',
        template: '<div class="tooltip tooltip-danger"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    });
    $('body').tooltip({
        selector: '[data-rel=tooltip-success]',
        placement: 'bottom',
        // delay: { show: 100, hide: 100 },
        // trigger: 'focus',
        template: '<div class="tooltip tooltip-success"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>'
    });

    $(document).on('submit', 'form', function () {
        return false;
    });

    /*
     $(document).keypress('form', function (e) {
     if (e.which == 13) {
     e.preventDefault();
     return false;
     }
     }); */
});

/* ###--Codigo valido para jquery UI datepicker --####################################################################

 $( '#fecha_ini').datepicker({
 language:'es',
 autoclose: true,
 setValue: $(this).val()
 }).on('changeDate', function (selected) {
 var startDate = new Date(selected.date.valueOf());
 startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
 $('#fecha_ter').datepicker('setStartDate', startDate);
 });

 $( '#fecha_ter' ).datepicker({
 language:'es',
 autoclose: true,
 setValue: $(this).val()
 }).on('changeDate', function (selected) {
 var endtDate = new Date(selected.date.valueOf());
 endtDate.setDate(endtDate.getDate(new Date(selected.date.valueOf())));
 $('#fecha_ini').datepicker('setEndDate', endtDate);
 });
 */


/* ###--TIPS MODALS--####################################################################
 var test  = $('body').find('#modal').html();
 if($.trim(test)!=''){ //Existe modal
 $("#botones_accion").attr("style","display: none;"); //OCULTO BOTONES DE NAVEGACION
 $("#titulo_pagina").attr("style","display: none;");//OCULTO TITULO DE PAGINA
 }
 else{ //NO Existe modal
 alert('NO existe modal');
 }

 //Buscar elementos en ventana padre
 //$(window.parent.document).find('#btn_buscar').html()
 */
// Activar collapse en grilla de datos: 3, 4 y 5
function initDatagridCollapse(context) {
    var $context = context ? $(context) : $(document);
    var $rows = $context.find('[class^="ubb-datagrid-type"] .data-row-collapse');
    var $buttons = $context.find('[class^="ubb-datagrid-type"] button[class^="togglebutton-gridtype"]');

    $rows.hide().attr('aria-hidden', 'true');
    $buttons.removeClass('active').attr('aria-expanded', 'false');
    $buttons.find('i').removeClass('rotate'); 
}

$(function() {
    initDatagridCollapse(document);

    // Delegado para soportar contenido cargado/reemplazado por AJAX.
    $(document)
        .off('click.datagridCollapse', 'button[class^="togglebutton-gridtype"]')
        .on('click.datagridCollapse', 'button[class^="togglebutton-gridtype"]', function() {
            var $button = $(this);
            var $icon = $button.find('i');
            var $container = $button.closest('.ubb-datagrid-container');
            var $content = $container.find('.data-row-collapse').first();
            var $grid = $button.closest('[class^="ubb-datagrid-type"]');

            $grid.find('.ubb-datagrid-container').not($container).each(function() {
                $(this).find('.data-row-collapse').slideUp(300).attr('aria-hidden', 'true');
                $(this).find('button[class^="togglebutton-gridtype"]').removeClass('active').attr('aria-expanded', 'false');
                $(this).find('button[class^="togglebutton-gridtype"] i').removeClass('rotate');
            });

            if ($content.is(':visible')) {
                $content.slideUp(300).attr('aria-hidden', 'true');
                $button.removeClass('active').attr('aria-expanded', 'false');
                $icon.removeClass('rotate');
            } else {
                $content.slideDown(300).attr('aria-hidden', 'false');
                $button.addClass('active').attr('aria-expanded', 'true');
                $icon.addClass('rotate');
            }
        });
});

// Skeleton para cargar contenido en un div
function showSkeleton(wrapperSelector, dataSelector, noResultsSelector) {
    wrapperSelector   = wrapperSelector   || '#skeleton-wrapper';
    dataSelector      = dataSelector      || '.ubb-datagrid-container .data-row';
    noResultsSelector = noResultsSelector || '#no-results';

    $(dataSelector).hide();
    $(noResultsSelector).hide();
    $(wrapperSelector).show();
}

function hideSkeleton(wrapperSelector, dataSelector) {
    wrapperSelector = wrapperSelector || '#skeleton-wrapper';
    dataSelector    = dataSelector    || '.ubb-datagrid-container .data-row';

    $(wrapperSelector).hide();
    $(dataSelector).show();
}

// Multi-step progress bar — llamar con initStepsProgressbar('#mi-contenedor') o sin parámetro
function initStepsProgressbar(containerSelector) {
    var $ctx = containerSelector ? $(containerSelector) : $(document);
    var currentStep = 0;
    var $steps = $ctx.find('.step-panel');
    var $circles = $ctx.find('.progress-step');
    var $progressContainer = $ctx.find('#progress-bar-container');
    var isUserAction = false;

    // Sincronizar aria-checked en switches dentro del contenedor
    $ctx.find('input[role="switch"]').on('change', function() {
        $(this).attr('aria-checked', this.checked ? 'true' : 'false');
    });

    function showStep(index) {
        $steps.removeClass('active').attr('aria-hidden', 'true');
        $steps.eq(index).addClass('active').attr('aria-hidden', 'false');

        $circles.removeClass('active').removeAttr('aria-current').each(function(i) {
            if (i <= index && i < $circles.length) {
                $(this).addClass('active');
            }
        });
        $circles.eq(Math.min(index, $circles.length - 1)).attr('aria-current', 'step');

        var total = $circles.length - 1;
        var percent = (Math.min(index, total) / total) * 100;
        $ctx.find('#progressbar-line').css('width', percent + '%');
        $ctx.find('#progress-status').attr('aria-valuenow', Math.round(percent));

        var totalPasos = $steps.length - 1;
        if (index < totalPasos) {
            $ctx.find('#step-announcer').text('Paso ' + (index + 1) + ' de ' + totalPasos);
        }

        if (isUserAction) {
            $steps.eq(index).focus();
        }

        $ctx.find('#previous-button').toggle(index > 0 && index < $steps.length - 1);

        if (index === $steps.length - 2) {
            $ctx.find('#next-button').html('Finalizar<i class="fa fa-arrow-right icon-right" aria-hidden="true"></i>');
        } else if (index >= $steps.length - 1) {
            $ctx.find('#progress-bar-buttons').hide();
            $ctx.find('#final-step-message').show();
            $progressContainer.addClass('hidden');
            $ctx.find('#step-announcer').text('Proceso finalizado');
        } else {
            $ctx.find('#next-button').html('Siguiente<i class="fa fa-arrow-right icon-right" aria-hidden="true"></i>');
            $ctx.find('#progress-bar-buttons').show();
            $progressContainer.removeClass('hidden');
        }
    }

    $ctx.find('#next-button').on('click', function() {
        if (currentStep < $steps.length - 1) {
            isUserAction = true;
            currentStep++;
            showStep(currentStep);
        }
    });

    $ctx.find('#previous-button').on('click', function() {
        if (currentStep > 0) {
            isUserAction = true;
            currentStep--;
            showStep(currentStep);
        }
    });

    $ctx.find('#reset-button').on('click', function() {
        isUserAction = true;
        currentStep = 0;
        $ctx.find('#final-step-message').hide();
        showStep(currentStep);
    });

    showStep(currentStep);
}

// Accordion - llamar con initAccordion('#mi-contenedor') o sin parametro
function initAccordion(containerSelector) {
    var $ctx = containerSelector ? $(containerSelector) : $(document);
    var animationDuration = 300;

    $ctx.find('.ubb-accordion').each(function() {
        var $accordion = $(this);
        $accordion.attr('aria-multiselectable', 'false');

        // Sincronizar IDs y estados para lectores de pantalla.
        $accordion.find('.ubb-accordion-toggle').each(function(index) {
            var $button = $(this);
            var targetId = $button.attr('data-target');
            if (!targetId || targetId.charAt(0) !== '#') {
                return;
            }

            var panelId = targetId.substring(1);
            var $panel = $accordion.find('#' + panelId).first();
            if ($panel.length === 0) {
                return;
            }

            var buttonId = $button.attr('id');
            if (!buttonId) {
                buttonId = panelId + '-toggle-' + index;
                $button.attr('id', buttonId);
            }

            $button.attr('aria-controls', panelId);
            $panel.attr('aria-labelledby', buttonId);
        });

        // Estado inicial: solo visible el panel marcado como abierto.
        $accordion.find('.ubb-accordion-content').each(function() {
            var $panel = $(this);
            var panelId = $panel.attr('id');
            var $button = $accordion.find('.ubb-accordion-toggle[data-target="#' + panelId + '"]');
            var isOpen = $panel.hasClass('ubb-accordion-content--show');

            if (isOpen) {
                $panel.show().attr('aria-hidden', 'false').removeAttr('hidden');
                $button.attr('aria-expanded', 'true');
                $button.find('.ubb-accordion-icon').addClass('active');
                $button.find('.ubb-accordion-icon i').addClass('rotate');
            } else {
                $panel.hide().attr('aria-hidden', 'true').attr('hidden', 'hidden');
                $button.attr('aria-expanded', 'false');
                $button.find('.ubb-accordion-icon').removeClass('active');
                $button.find('.ubb-accordion-icon i').removeClass('rotate');
            }
        });
    });

    // Delegado global: soporta contenido recargado por AJAX.
    $(document)
        .off('click.accordion', '.ubb-accordion .ubb-accordion-toggle')
        .on('click.accordion', '.ubb-accordion .ubb-accordion-toggle', function(e) {
            e.preventDefault();

            var $button = $(this);
            var $accordion = $button.closest('.ubb-accordion');
            var targetId = $button.attr('data-target');
            var $targetPanel = $accordion.find(targetId).first();

            if ($targetPanel.length === 0) {
                $targetPanel = $(targetId).first();
            }
            if ($targetPanel.length === 0) {
                return;
            }

            var $currentIcon = $button.find('.ubb-accordion-icon i');
            var $currentIconContainer = $button.find('.ubb-accordion-icon');
            var isExpanded = $targetPanel.hasClass('ubb-accordion-content--show');

            if (isExpanded) {
                $targetPanel
                    .stop(true, true)
                    .slideUp(animationDuration, function() {
                        $targetPanel.attr('hidden', 'hidden');
                    })
                    .removeClass('ubb-accordion-content--show')
                    .attr('aria-hidden', 'true');
                $currentIcon.removeClass('rotate');
                $currentIconContainer.removeClass('active');
                $button.attr('aria-expanded', 'false');
            } else {
                $accordion.find('.ubb-accordion-content.ubb-accordion-content--show').each(function() {
                    var $openPanel = $(this);
                    $openPanel
                        .stop(true, true)
                        .slideUp(animationDuration, function() {
                            $openPanel.attr('hidden', 'hidden');
                        })
                        .removeClass('ubb-accordion-content--show')
                        .attr('aria-hidden', 'true');
                });

                $accordion.find('.ubb-accordion-icon i.rotate').removeClass('rotate');
                $accordion.find('.ubb-accordion-icon.active').removeClass('active');
                $accordion.find('.ubb-accordion-toggle[aria-expanded="true"]').attr('aria-expanded', 'false');

                $targetPanel
                    .removeAttr('hidden')
                    .hide()
                    .stop(true, true)
                    .slideDown(animationDuration)
                    .addClass('ubb-accordion-content--show')
                    .attr('aria-hidden', 'false');
                $currentIcon.addClass('rotate');
                $currentIconContainer.addClass('active');
                $button.attr('aria-expanded', 'true');
            }
        })
        .off('keydown.accordion', '.ubb-accordion .ubb-accordion-toggle')
        .on('keydown.accordion', '.ubb-accordion .ubb-accordion-toggle', function(e) {
            var key = e.key;
            var $button = $(this);
            var $accordion = $button.closest('.ubb-accordion');
            var $buttons = $accordion.find('.ubb-accordion-toggle');
            var index = $buttons.index($button);
            var lastIndex = $buttons.length - 1;

            if (key === 'ArrowDown' || key === 'ArrowRight') {
                e.preventDefault();
                $buttons.eq(index === lastIndex ? 0 : index + 1).focus();
            } else if (key === 'ArrowUp' || key === 'ArrowLeft') {
                e.preventDefault();
                $buttons.eq(index === 0 ? lastIndex : index - 1).focus();
            } else if (key === 'Home') {
                e.preventDefault();
                $buttons.eq(0).focus();
            } else if (key === 'End') {
                e.preventDefault();
                $buttons.eq(lastIndex).focus();
            } else if (key === 'Enter' || key === ' ') {
                e.preventDefault();
                $button.trigger('click');
            }
        });
}

// Carousel accesible - llamar con initCarouselA11y('#mi-contenedor') o sin parametro
function initCarouselA11y(containerSelector) {
    var $ctx = containerSelector ? $(containerSelector) : $(document);

    $ctx.find('.carousel').each(function() {
        var $carousel = $(this);
        var carouselId = $carousel.attr('id') || 'carousel';
        var carouselLabel = $.trim($carousel.closest('.content-box').find('h2').first().text()) || 'Carrusel';

        $carousel
            .attr('role', 'region')
            .attr('aria-roledescription', 'carousel')
            .attr('aria-label', carouselLabel)
            .attr('tabindex', '0');

        var $inner = $carousel.find('.carousel-inner').first();
        var $items = $inner.find('.item');

        $items.each(function(index) {
            var $item = $(this);
            $item
                .attr('role', 'group')
                .attr('aria-roledescription', 'slide')
                .attr('aria-label', 'Slide ' + (index + 1) + ' de ' + $items.length)
                .attr('aria-hidden', $item.hasClass('active') ? 'false' : 'true');

            if ($item.hasClass('active')) {
                $item.removeAttr('hidden');
            } else {
                $item.attr('hidden', 'hidden');
            }
        });

        var $indicators = $carousel.find('.carousel-indicators li');
        $indicators.each(function(index) {
            var $indicator = $(this);
            $indicator
                .attr('role', 'button')
                .attr('tabindex', '0')
                .attr('aria-label', 'Ir al slide ' + (index + 1))
                .attr('aria-controls', carouselId)
                .attr('aria-current', $indicator.hasClass('active') ? 'true' : 'false');
        });

        $carousel.find('.left.carousel-control')
            .attr('aria-label', 'Slide anterior')
            .attr('aria-controls', carouselId);
        $carousel.find('.right.carousel-control')
            .attr('aria-label', 'Slide siguiente')
            .attr('aria-controls', carouselId);

        if ($carousel.find('.carousel-live').length === 0) {
            $carousel.append('<div class="sr-only carousel-live" aria-live="polite" aria-atomic="true"></div>');
        }

        var activeIndex = $items.index($items.filter('.active').first());
        if (activeIndex >= 0) {
            $carousel.find('.carousel-live').text('Slide ' + (activeIndex + 1) + ' de ' + $items.length);
        }
    });

    $(document)
        .off('keydown.carouselA11y', '.carousel')
        .on('keydown.carouselA11y', '.carousel', function(e) {
            var $carousel = $(this);
            if (e.key === 'ArrowLeft') {
                e.preventDefault();
                if ($.fn.carousel) {
                    $carousel.carousel('prev');
                }
            } else if (e.key === 'ArrowRight') {
                e.preventDefault();
                if ($.fn.carousel) {
                    $carousel.carousel('next');
                }
            }
        })
        .off('keydown.carouselA11y', '.carousel .carousel-indicators li')
        .on('keydown.carouselA11y', '.carousel .carousel-indicators li', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                e.preventDefault();
                $(this).trigger('click');
            }
        })
        .off('slide.bs.carousel.carouselA11y', '.carousel')
        .on('slide.bs.carousel.carouselA11y', '.carousel', function(e) {
            var $carousel = $(this);
            var $items = $carousel.find('.carousel-inner .item');
            var $indicators = $carousel.find('.carousel-indicators li');
            var nextIndex = $items.index(e.relatedTarget);

            $items.attr('aria-hidden', 'true').attr('hidden', 'hidden');
            if (nextIndex >= 0) {
                $items.eq(nextIndex).attr('aria-hidden', 'false').removeAttr('hidden');
            }

            $indicators.attr('aria-current', 'false');
            if (nextIndex >= 0) {
                $indicators.eq(nextIndex).attr('aria-current', 'true');
                $carousel.find('.carousel-live').text('Slide ' + (nextIndex + 1) + ' de ' + $items.length);
            }
        });
}

// Mostrar/ocultar codigo HTML bajo cada componente (tal cual renderizado en el DOM).
function initComponentCodeViewer(containerSelector) {
    var $ctx = containerSelector ? $(containerSelector) : $(document);
    var voidTags = {
        area: true,
        base: true,
        br: true,
        col: true,
        embed: true,
        hr: true,
        img: true,
        input: true,
        link: true,
        meta: true,
        param: true,
        source: true,
        track: true,
        wbr: true
    };

    function formatAttributes(node) {
        var attributes = [];

        $.each(node.attributes || [], function(_, attr) {
            attributes.push(attr.name + '="' + attr.value.replace(/"/g, '&quot;') + '"');
        });

        return attributes.length ? ' ' + attributes.join(' ') : '';
    }

    function formatNode(node, level) {
        var indent = new Array(level + 1).join('    ');

        if (node.nodeType === 3) {
            var text = node.nodeValue.replace(/\s+/g, ' ').trim();
            return text ? indent + text : '';
        }

        if (node.nodeType !== 1) {
            return '';
        }

        var tagName = node.tagName.toLowerCase();
        var openingTag = indent + '<' + tagName + formatAttributes(node) + '>';

        if (voidTags[tagName]) {
            return openingTag;
        }

        var childLines = [];
        $.each(node.childNodes, function(_, childNode) {
            var formattedChild = formatNode(childNode, level + 1);
            if (formattedChild) {
                childLines.push(formattedChild);
            }
        });

        if (childLines.length === 0) {
            return openingTag + '</' + tagName + '>';
        }

        if (childLines.length === 1 && childLines[0].indexOf(new Array(level + 2).join('    ') + '<') !== 0) {
            return openingTag + childLines[0].replace(new Array(level + 2).join('    '), '') + '</' + tagName + '>';
        }

        return openingTag + '\n' + childLines.join('\n') + '\n' + indent + '</' + tagName + '>';
    }

    function formatHtmlFromNodes(nodes) {
        var formattedNodes = [];

        $.each(nodes, function(_, node) {
            var formattedNode = formatNode(node, 0);
            if (formattedNode) {
                formattedNodes.push(formattedNode);
            }
        });

        return formattedNodes.join('\n');
    }

    function escapeHtmlCode(html) {
        return String(html)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }

    function resolveSnippetLabel($element, index) {
        var label = '';

        if ($element.hasClass('ubb-input')) {
            label = $.trim($element.children('label').first().text());
        } else if ($element.hasClass('ubb-message')) {
            label = $.trim($element.find('span').first().text());
        } else {
            label = $.trim($element.attr('aria-label') || $element.text());
        }

        label = label.replace(/\s+/g, ' ');

        if (label.length > 60) {
            label = label.substring(0, 57) + '...';
        }

        return label || ('Componente ' + (index + 1));
    }

    function collectCodeSnippets($wrapper) {
        var snippets = [];
        var $inputs = $wrapper.children('.ubb-input-wrapper').children('.ubb-input');

        if ($inputs.length > 1) {
            $inputs.each(function(index) {
                var $input = $(this);
                snippets.push({
                    label: resolveSnippetLabel($input, index),
                    html: formatHtmlFromNodes([$input.get(0)])
                });
            });
            return snippets;
        }

        var $elementItems = $wrapper.children('.elements-wrapper').children().filter(function() {
            return this.nodeType === 1;
        });

        if ($elementItems.length > 1) {
            $elementItems.each(function(index) {
                var $item = $(this);
                snippets.push({
                    label: resolveSnippetLabel($item, index),
                    html: formatHtmlFromNodes([$item.get(0)])
                });
            });
            return snippets;
        }

        snippets.push({
            label: 'Componente',
            html: formatHtmlFromNodes($wrapper.contents())
        });

        return snippets;
    }

    $ctx.find('.content-box').each(function(index) {
        var $box = $(this);

        if ($box.attr('data-codeviewer-ready') === 'true') {
            return;
        }

        var $wrapper = $box.children('.ubb-component-wrapper').first();
        if ($wrapper.length === 0) {
            return;
        }

        var uniqueId = 'component-code-' + index + '-' + Date.now();
        var buttonId = uniqueId + '-button';
        var panelId = uniqueId + '-panel';
        var snippets = collectCodeSnippets($wrapper);

        var toggleHtml = '' +
            '<button id="' + buttonId + '" class="ubb-btn ubb-linear-btn ubb-code-viewer-toggle-btn" type="button" aria-pressed="false" aria-controls="' + panelId + '" style="margin-left:12px; vertical-align:middle;">Mostrar codigo</button>';

        var $codePanel = $('<div id="' + panelId + '" class="ubb-component-wrapper ubb-code-viewer-panel" role="region" aria-label="Codigo del componente" hidden></div>');

        $.each(snippets, function(index, snippet) {
            var snippetId = uniqueId + '-snippet-' + index;
            var copyButtonId = snippetId + '-copy-button';
            var copyStatusId = snippetId + '-copy-status';
            var escapedHtml = escapeHtmlCode(snippet.html);
            var $snippet = $('<div class="ubb-code-viewer-snippet" style="margin-bottom:24px;"></div>');
            var $actions = $('<div class="ubb-code-viewer-actions" style="display:flex; justify-content:space-between; align-items:end; gap:12px; margin-bottom:30px; margin-top:-5px; flex-wrap:wrap;"></div>');
            var $snippetTitle = $('<strong class="ubb-code-viewer-snippet-title"></strong>').text(snippet.label);
            var $copyGroup = $('<div class="ubb-code-viewer-copy-group" style="display:flex; align-items:center; gap:8px;"></div>');
            var $copyButton = $('<button id="' + copyButtonId + '" class="ubb-btn ubb-linear-btn ubb-code-viewer-copy-btn" type="button"><i class="fa-solid fa-copy icon-left" aria-hidden="true"></i>Copiar</button>');
            var $copyStatus = $('<span id="' + copyStatusId + '" class="sr-only" aria-live="polite"></span>');
            var $codeBlock = $('<pre class="ubb-code-block"><code>' + escapedHtml + '</code></pre>');

            $copyButton.data('copyContent', snippet.html);
            $copyButton.attr('aria-describedby', copyStatusId);

            $copyGroup.append($copyButton);
            $copyGroup.append($copyStatus);
            $actions.append($snippetTitle);
            $actions.append($copyGroup);
            $snippet.append($actions);
            $snippet.append($codeBlock);
            $codePanel.append($snippet);
        });

        $wrapper.after($codePanel);
        $box.attr('data-codeviewer-ready', 'true');

        var $title = $box.children('h2').first();
        if ($title.length === 0) {
            $title = $box.find('h2, h3').first();
        }

        if ($title.length > 0) {
            var $titleRow = $('<div class="ubb-code-viewer-title-row" style="display:flex; align-items:center; justify-content:space-between; gap:12px; flex-wrap:wrap;"></div>');
            $title.before($titleRow);
            $titleRow.append($title);
            $titleRow.append($(toggleHtml));
        } else {
            $wrapper.before($('<div class="ubb-code-viewer-toggle ubb-mb-3">' + toggleHtml + '</div>'));
        }

        var $toggleButton = $('#' + buttonId);
        var isCodeVisible = false;

        function copyCodeToClipboard(textToCopy) {

            if (navigator.clipboard && window.isSecureContext) {
                return navigator.clipboard.writeText(textToCopy);
            }

            return new Promise(function(resolve, reject) {
                var textarea = document.createElement('textarea');
                textarea.value = textToCopy;
                textarea.setAttribute('readonly', 'readonly');
                textarea.style.position = 'fixed';
                textarea.style.left = '-9999px';
                document.body.appendChild(textarea);
                textarea.select();

                try {
                    var successful = document.execCommand('copy');
                    document.body.removeChild(textarea);
                    if (successful) {
                        resolve();
                    } else {
                        reject(new Error('No se pudo copiar el codigo'));
                    }
                } catch (error) {
                    document.body.removeChild(textarea);
                    reject(error);
                }
            });
        }

        $codePanel.on('click', '.ubb-code-viewer-copy-btn', function() {
            var $copyButton = $(this);
            var $copyStatus = $('#' + ($copyButton.attr('aria-describedby') || ''));
            var textToCopy = $copyButton.data('copyContent') || '';

            copyCodeToClipboard(textToCopy)
                .then(function() {
                    $copyButton.html('<i class="fa-solid fa-check icon-left" aria-hidden="true"></i>Copiado');
                    $copyStatus.text('Codigo copiado al portapapeles');
                    setTimeout(function() {
                        $copyButton.html('<i class="fa-solid fa-copy icon-left" aria-hidden="true"></i>Copiar');
                    }, 1500);
                })
                .catch(function() {
                    $copyStatus.text('No fue posible copiar el codigo');
                });
        });

        $toggleButton.on('click', function() {
            isCodeVisible = !isCodeVisible;

            if (isCodeVisible) {
                $wrapper.hide().attr('aria-hidden', 'true');
                $codePanel.show().removeAttr('hidden').attr('aria-hidden', 'false');
                $toggleButton.text('Mostrar componente').attr('aria-pressed', 'true');
            } else {
                $codePanel.hide().attr('hidden', 'hidden').attr('aria-hidden', 'true');
                $wrapper.show().attr('aria-hidden', 'false');
                $toggleButton.text('Mostrar codigo').attr('aria-pressed', 'false');
            }
        });
    });
}

function initRegisteredComponentCodeViewers(context) {
    var $ctx = context ? $(context) : $(document);

    $ctx.find('[data-component-code-viewer="true"]').each(function() {
        initComponentCodeViewer(this);
    });
}

// Pestañas reutilizables - llamar con initTabs(context) o sin parametro
function initTabs(context) {
    var $ctx = context ? $(context) : $(document);

    function resolveTargetId($tab) {
        var targetId = $tab.attr('data-target');

        if (!targetId) {
            var href = $tab.attr('href') || '';
            if (href.charAt(0) === '#') {
                targetId = href.substring(1);
            }
        }

        return targetId;
    }

    function activateTab($tabsContainer, $tab, focusTab) {
        var targetId = resolveTargetId($tab);
        var $tabLinks = $tabsContainer.find('a[data-target], a[role="tab"]');
        var $content = $tabsContainer.siblings('.ubb-tab-content').first();

        if ($content.length === 0) {
            $content = $tabsContainer.parent().find('.ubb-tab-content').first();
        }

        $tabLinks.each(function() {
            var $link = $(this);
            var isCurrent = $link.is($tab);
            $link.toggleClass('active', isCurrent);
            $link.attr('aria-selected', isCurrent ? 'true' : 'false');
            $link.attr('tabindex', isCurrent ? '0' : '-1');
        });

        if (focusTab) {
            $tab.focus();
        }

        if ($content.length === 0) {
            return;
        }

        var $panes = $content.find('.tab-pane');
        $panes.removeClass('active').attr('aria-hidden', 'true').attr('hidden', 'hidden');

        if (!targetId) {
            return;
        }

        var $targetPane = $content.find('#' + targetId).first();
        if ($targetPane.length === 0) {
            $targetPane = $('#' + targetId).first();
        }

        if ($targetPane.length > 0) {
            $targetPane.addClass('active').attr('aria-hidden', 'false').removeAttr('hidden');
        }
    }

    $ctx.find('.ubb-tabs').each(function() {
        var $tabsContainer = $(this);
        var $tabLinks = $tabsContainer.find('a[data-target], a[role="tab"]');

        if ($tabsContainer.attr('data-tabs-initialized') === 'true') {
            return;
        }

        $tabsContainer.attr('data-tabs-initialized', 'true');
        $tabsContainer.attr('role', 'tablist');

        $tabLinks.each(function(index) {
            var $tab = $(this);
            var targetId = resolveTargetId($tab);
            var tabId = $tab.attr('id');

            if (!tabId) {
                tabId = 'ubb-tab-' + Date.now() + '-' + index;
                $tab.attr('id', tabId);
            }

            $tab.attr('role', 'tab');

            if (targetId) {
                $tab.attr('aria-controls', targetId);
                var $panel = $('#' + targetId).first();
                if ($panel.length > 0) {
                    $panel.attr('role', 'tabpanel');
                    $panel.attr('aria-labelledby', tabId);
                }
            }
        });

        var $initialTab = $tabLinks.filter('.active').first();
        if ($initialTab.length === 0) {
            $initialTab = $tabLinks.first();
        }

        activateTab($tabsContainer, $initialTab, false);

        $tabsContainer
            .find('a[data-target], a[role="tab"]')
            .on('click.tabs', function(e) {
                e.preventDefault();
                activateTab($tabsContainer, $(this), true);
            })
            .on('keydown.tabs', function(e) {
                var key = e.key;
                var $tabs = $tabsContainer.find('a[data-target], a[role="tab"]');
                var currentIndex = $tabs.index(this);
                var nextIndex = currentIndex;

                if (key === 'ArrowRight' || key === 'ArrowDown') {
                    e.preventDefault();
                    nextIndex = (currentIndex + 1) % $tabs.length;
                    activateTab($tabsContainer, $tabs.eq(nextIndex), true);
                } else if (key === 'ArrowLeft' || key === 'ArrowUp') {
                    e.preventDefault();
                    nextIndex = (currentIndex - 1 + $tabs.length) % $tabs.length;
                    activateTab($tabsContainer, $tabs.eq(nextIndex), true);
                } else if (key === 'Home') {
                    e.preventDefault();
                    activateTab($tabsContainer, $tabs.eq(0), true);
                } else if (key === 'End') {
                    e.preventDefault();
                    activateTab($tabsContainer, $tabs.eq($tabs.length - 1), true);
                } else if (key === 'Enter' || key === ' ') {
                    e.preventDefault();
                    activateTab($tabsContainer, $(this), true);
                }
            });
    });
}

$(function() {
    // Reaplicar estado/handlers del acordeon cuando el contenido cambia por AJAX.
    initAccordion(document);
    $(document).off('ajaxComplete.accordion').on('ajaxComplete.accordion', function() {
        initAccordion(document);
    });

    // Reaplicar estado/handlers del carrusel cuando el contenido cambia por AJAX.
    initCarouselA11y(document);
    $(document).off('ajaxComplete.carouselA11y').on('ajaxComplete.carouselA11y', function() {
        initCarouselA11y(document);
    });

    // Activar pestañas en contenido inicial y recargado por AJAX.
    initTabs(document);
    $(document).off('ajaxComplete.tabs').on('ajaxComplete.tabs', function() {
        initTabs(document);
    });

    // Agregar acordeon "Codigo" solo en contenedores marcados para la pagina de ejemplos.
    initRegisteredComponentCodeViewers(document);
    $(document).off('ajaxComplete.componentCode').on('ajaxComplete.componentCode', function() {
        initRegisteredComponentCodeViewers(document);
    });

    // Tooltip CSS puro: convierte data-toggle="tooltip" (Bootstrap) a data-tooltip para CSS puro.
    initTooltips(document);
    $(document).off('ajaxComplete.tooltips').on('ajaxComplete.tooltips', function() {
        initTooltips(document);
    });

    // Popovers CSS/JS puro: activa los botones con data-toggle="popover".
    initPopovers(document);
    $(document).off('ajaxComplete.popovers').on('ajaxComplete.popovers', function() {
        initPopovers(document);
    });
});

// Tooltip CSS puro — llamar con initTooltips(context) o sin parametro
function initTooltips(context) {
    var ctx = context || document;
    $(ctx).find('[data-toggle="tooltip"]').each(function() {
        var $el = $(this);
        // Mover title a data-tooltip para evitar el tooltip nativo del navegador
        var title = $el.attr('title') || $el.attr('data-original-title');
        if (title && !$el.attr('data-tooltip')) {
            $el.attr('data-tooltip', title);
        }
        $el.removeAttr('title');
    });
}

var ubbPopoverObserverStarted = false;

// Popover CSS/JS puro — llamar con initPopovers(context) o sin parametro
function initPopovers(context) {
    var root = context || document;
    var scope = root.querySelectorAll ? root : document;
    var triggers = scope.querySelectorAll('[data-toggle="popover"], [data-rel="popover"]');

    triggers.forEach(function(trigger) {
        if (trigger.getAttribute('data-popover-initialized') === 'true') {
            return;
        }

        trigger.setAttribute('data-popover-initialized', 'true');

        var title = trigger.getAttribute('title') || trigger.getAttribute('data-original-title') || '';
        var content = trigger.getAttribute('data-content') || '';
        var placement = (trigger.getAttribute('data-placement') || 'top').toLowerCase();
        var triggerType = (trigger.getAttribute('data-trigger') || 'click').toLowerCase();
        var useHtml = (trigger.getAttribute('data-html') || '').toLowerCase() === 'true';
        var popover = null;
        var isVisible = false;
        var hideTimer = null;

        trigger.removeAttribute('title');
        trigger.removeAttribute('data-original-title');

        function getPlacement() {
            return ['top', 'bottom', 'left', 'right'].indexOf(placement) >= 0 ? placement : 'top';
        }

        function escapeHtml(text) {
            return String(text)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function buildPopover() {
            if (popover) {
                return popover;
            }

            popover = document.createElement('div');
            popover.className = 'ubb-popover';
            popover.setAttribute('role', 'tooltip');
            popover.dataset.placement = getPlacement();

            var arrow = document.createElement('div');
            arrow.className = 'ubb-popover-arrow';

            var hasTitle = title.trim().length > 0;
            if (hasTitle) {
                var titleNode = document.createElement('div');
                titleNode.className = 'ubb-popover-title';
                titleNode.textContent = title;
                popover.appendChild(titleNode);
            } else {
                popover.classList.add('no-title');
            }

            var contentNode = document.createElement('div');
            contentNode.className = 'ubb-popover-content';
            if (useHtml) {
                contentNode.innerHTML = content;
            } else {
                contentNode.innerHTML = escapeHtml(content).replace(/\n/g, '<br>');
            }

            popover.appendChild(arrow);
            popover.appendChild(contentNode);
            document.body.appendChild(popover);
            return popover;
        }

        function computePosition(el, pop) {
            var spacing = 10;
            var arrowOffset = 11;
            var rect = el.getBoundingClientRect();
            var popRect = pop.getBoundingClientRect();
            var chosen = getPlacement();

            if (chosen === 'top' && rect.top < popRect.height + spacing) {
                chosen = 'bottom';
            } else if (chosen === 'bottom' && (window.innerHeight - rect.bottom) < popRect.height + spacing) {
                chosen = 'top';
            } else if (chosen === 'left' && rect.left < popRect.width + spacing) {
                chosen = 'right';
            } else if (chosen === 'right' && (window.innerWidth - rect.right) < popRect.width + spacing) {
                chosen = 'left';
            }

            pop.dataset.placement = chosen;

            var top = 0;
            var left = 0;

            if (chosen === 'top') {
                top = rect.top - popRect.height - arrowOffset;
                left = rect.left + (rect.width / 2) - (popRect.width / 2);
            } else if (chosen === 'bottom') {
                top = rect.bottom + arrowOffset;
                left = rect.left + (rect.width / 2) - (popRect.width / 2);
            } else if (chosen === 'left') {
                top = rect.top + (rect.height / 2) - (popRect.height / 2);
                left = rect.left - popRect.width - arrowOffset;
            } else {
                top = rect.top + (rect.height / 2) - (popRect.height / 2);
                left = rect.right + arrowOffset;
            }

            left = Math.max(8, Math.min(left, window.innerWidth - popRect.width - 8));
            top = Math.max(8, Math.min(top, window.innerHeight - popRect.height - 8));

            pop.style.left = left + 'px';
            pop.style.top = top + 'px';
        }

        function showPopover() {
            clearTimeout(hideTimer);
            var pop = buildPopover();
            computePosition(trigger, pop);
            pop.classList.add('is-visible');
            isVisible = true;
        }

        function hidePopover() {
            clearTimeout(hideTimer);
            hideTimer = setTimeout(function() {
                if (!popover) {
                    return;
                }
                popover.classList.remove('is-visible');
                isVisible = false;
            }, 80);
        }

        function togglePopover() {
            if (isVisible) {
                hidePopover();
            } else {
                showPopover();
            }
        }

        if (triggerType === 'hover') {
            trigger.addEventListener('mouseenter', showPopover);
            trigger.addEventListener('mouseleave', hidePopover);
            trigger.addEventListener('focus', showPopover);
            trigger.addEventListener('blur', hidePopover);
        } else if (triggerType === 'focus') {
            trigger.addEventListener('focus', showPopover);
            trigger.addEventListener('blur', hidePopover);
        } else {
            trigger.addEventListener('click', function(event) {
                event.preventDefault();
                event.stopPropagation();
                togglePopover();
            });
        }

        document.addEventListener('click', function(event) {
            if (!popover || !isVisible) {
                return;
            }
            if (trigger.contains(event.target) || popover.contains(event.target)) {
                return;
            }
            hidePopover();
        });

        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                hidePopover();
            }
        });

        window.addEventListener('resize', function() {
            if (popover && isVisible) {
                computePosition(trigger, popover);
            }
        });

        window.addEventListener('scroll', function() {
            if (popover && isVisible) {
                computePosition(trigger, popover);
            }
        }, true);
    });

    if (!ubbPopoverObserverStarted && typeof MutationObserver !== 'undefined') {
        ubbPopoverObserverStarted = true;
        var observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                mutation.addedNodes.forEach(function(node) {
                    if (node.nodeType !== 1) {
                        return;
                    }
                    initPopovers(node);
                });
            });
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
}