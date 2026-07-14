<script src="{$PATH_JS_RECURSOS_DEV}js/funciones_generales.js"></script>
<script src="perfeccionamiento/assets/js/solicitud.js"></script>

<div id="div_base" class="ubb-container">

    <div class="ubb-container-page-header">
        <header class="page-header">
            <h1 tabindex="0">Nueva Solicitud de Perfeccionamiento</h1>
            <div class="header-actions">
                <button id="btn_guardar_borrador" type="button" class="ubb-btn ubb-linear-btn">
                    Guardar borrador
                </button>
                <button id="btn_enviar_solicitud" type="button" class="ubb-btn ubb-filled-btn">
                    Enviar solicitud
                </button>
            </div>
        </header>
    </div>

    {if $mensaje}
        <div class="ubb-message {if $errores}error-message{else}success-message{/if}" role="alert">
            <i class="fa {if $errores}fa-circle-xmark{else}fa-circle-check{/if}" aria-hidden="true"></i>
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

    {if $aviso_observacion}
        <div class="ubb-message warning-message" role="alert">
            <i class="fa fa-circle-exclamation" aria-hidden="true"></i>
            <span>{$aviso_observacion}</span>
        </div>
    {/if}

    <form id="form_solicitud" method="POST" action="perfeccionamiento/solicitud_nueva.php">
        <input type="hidden" name="id_solicitud" value="{$id_solicitud|default:''}">
        <input type="hidden" name="accion" id="input_accion" value="">

        <section class="content-box">
            <h2 tabindex="0">Antecedentes del académico/a</h2>
            <div class="ubb-component-wrapper">
                <div class="ubb-input-wrapper">

                    <div class="ubb-input">
                        <label for="ap_paterno">Apellido Paterno</label>
                        <input type="text" id="ap_paterno" class="form-control"
                            value="{$academico.ap_paterno|default:''}" disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="ap_materno">Apellido Materno</label>
                        <input type="text" id="ap_materno" class="form-control"
                            value="{$academico.ap_materno|default:''}" disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="nombres">Nombres</label>
                        <input type="text" id="nombres" class="form-control" value="{$academico.nombres|default:''}"
                            disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="facultad">Facultad</label>
                        <input type="text" id="facultad" class="form-control" value="{$academico.facultad|default:''}"
                            disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="departamento">Departamento</label>
                        <input type="text" id="departamento" class="form-control"
                            value="{$academico.departamento|default:''}" disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="anio_ingreso">Año ingreso UBB</label>
                        <input type="text" id="anio_ingreso" class="form-control"
                            value="{$academico.anio_ingreso|default:''}" disabled>
                    </div>

                    <div class="ubb-input">
                        <label for="tipo_jornada">Tipo de Jornada</label>
                        <select id="tipo_jornada" class="form-control" disabled>
                            <option value="">{$academico.tipo_jornada|default:''}</option>
                        </select>
                    </div>

                    <div class="ubb-input">
                        <label for="email">Email institucional</label>
                        <input type="text" id="email" class="form-control" value="{$academico.email|default:''}"
                            disabled>
                    </div>

                </div>
            </div>
        </section>

        <section class="content-box">
            <h2 tabindex="0">Antecedentes del perfeccionamiento</h2>
            <div class="ubb-component-wrapper">
                <div class="ubb-input-wrapper">

                    <div class="ubb-input">
                        <label for="id_tipo_perfeccionamiento">Tipo de perfeccionamiento</label>
                        <select id="id_tipo_perfeccionamiento" name="id_tipo_perfeccionamiento" class="form-control"
                            required>
                            <option value="">Seleccione...</option>
                            {foreach $tipos_perfeccionamiento as $tipo}
                                <option value="{$tipo.id_tipo}"
                                    {if ($solicitud.id_tipo_perfeccionamiento|default:0) == $tipo.id_tipo}selected{/if}>
                                    {$tipo.descripcion}
                                </option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="ubb-input" id="div_tipo_grado" style="display:none;">
                        <label for="id_tipo_grado">Grado al que postula</label>
                        <select id="id_tipo_grado" name="id_tipo_grado" class="form-control">
                            <option value="">Seleccione...</option>
                            {foreach $tipos_grado as $grado}
                                <option value="{$grado.id_tipo_grado}"
                                    {if ($solicitud.id_tipo_grado|default:0) == $grado.id_tipo_grado}selected{/if}>
                                    {$grado.descripcion}
                                </option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="ubb-input">
                        <label for="nombre_programa">Nombre del programa</label>
                        <input type="text" id="nombre_programa" name="nombre_programa" class="form-control" required
                            value="{$solicitud.nombre_programa|default:''}">
                    </div>

                    <div class="ubb-input">
                        <label for="institucion_destino">Institución de destino</label>
                        <input type="text" id="institucion_destino" name="institucion_destino" class="form-control"
                            required value="{$solicitud.institucion_destino|default:''}">
                    </div>

                    <div class="ubb-input">
                        <label for="pais">País</label>
                        <input type="text" id="pais" name="pais" class="form-control" required
                            value="{$solicitud.pais|default:''}">
                    </div>

                    <div class="ubb-input">
                        <label for="fecha_inicio">Fecha de inicio</label>
                        <div class="input-icon-right">
                            <input type="text" id="fecha_inicio" name="fecha_inicio"
                                class="form-control input-mask-date" data-date-format="dd/mm/yyyy"
                                data-provide="datepicker" placeholder="dd/mm/aaaa" required
                                value="{$solicitud.fecha_inicio|default:''}">
                            <i class="fa fa-calendar input-icon" aria-hidden="true"></i>
                        </div>
                    </div>

                    <div class="ubb-input">
                        <label for="fecha_termino">Fecha de término</label>
                        <div class="input-icon-right">
                            <input type="text" id="fecha_termino" name="fecha_termino"
                                class="form-control input-mask-date" data-date-format="dd/mm/yyyy"
                                data-provide="datepicker" placeholder="dd/mm/aaaa" required
                                value="{$solicitud.fecha_termino|default:''}">
                            <i class="fa fa-calendar input-icon" aria-hidden="true"></i>
                        </div>
                    </div>

                    <div class="ubb-input">
                        <label for="fecha_salida_ubb">Fecha de salida UBB</label>
                        <div class="input-icon-right">
                            <input type="text" id="fecha_salida_ubb" name="fecha_salida_ubb"
                                class="form-control input-mask-date" data-date-format="dd/mm/yyyy"
                                data-provide="datepicker" placeholder="dd/mm/aaaa"
                                value="{$solicitud.fecha_salida_ubb|default:''}">
                            <i class="fa fa-calendar input-icon" aria-hidden="true"></i>
                        </div>
                    </div>

                    <div class="ubb-input">
                        <label for="financiamiento_externo">Financiamiento externo</label>
                        <input type="text" id="financiamiento_externo" name="financiamiento_externo"
                            class="form-control" placeholder="Beca o convenio (si aplica)"
                            value="{$solicitud.financiamiento_externo|default:''}">
                    </div>

                </div>
            </div>
        </section>

        <section class="content-box">
            <h2 tabindex="0">Beneficios solicitados a la Universidad del Bío-Bío</h2>
            <div class="ubb-component-wrapper">
                <div class="ubb-input-wrapper" id="div_beneficios">
                    {foreach $tipos_beneficio as $tipo}
                        {assign var="guardado" value=null}
                        {foreach $beneficios_guardados as $bg}
                            {if $bg.id_tipo_beneficio == $tipo.id_beneficio}
                                {assign var="guardado" value=$bg}
                            {/if}
                        {/foreach}

                        <div class="ubb-input beneficio-item">
                            <div class="selection-control">
                                <input type="checkbox" id="beneficio_{$tipo.id_beneficio}"
                                    name="beneficios_check[{$tipo.id_beneficio}]" value="1" class="beneficio-check"
                                    data-id="{$tipo.id_beneficio}" data-tiene-n-horas="{$tipo.tiene_n_horas}"
                                    data-tiene-monto-mensual="{$tipo.tiene_monto_mensual}"
                                    data-tiene-monto-viaje="{$tipo.tiene_monto_viaje}"
                                    data-tiene-valor-ida="{$tipo.tiene_valor_ida}"
                                    data-tiene-valor-regreso="{$tipo.tiene_valor_regreso}"
                                    data-tiene-valor-ida-regreso="{$tipo.tiene_valor_ida_regreso}"
                                    data-tiene-valor-matricula="{$tipo.tiene_valor_matricula}"
                                    data-tiene-valor-arancel="{$tipo.tiene_valor_arancel}"
                                    data-tiene-monto-seguro="{$tipo.tiene_monto_seguro}" {if $guardado}checked{/if}>
                                <label for="beneficio_{$tipo.id_beneficio}">{$tipo.descripcion}</label>
                            </div>

                            <div class="beneficio-montos" id="montos_{$tipo.id_beneficio}" style="display:none;">
                                {if $tipo.tiene_n_horas}
                                    <div class="ubb-input">
                                        <label for="n_horas_{$tipo.id_beneficio}">N° de horas</label>
                                        <input type="number" id="n_horas_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][n_horas]" class="form-control"
                                            value="{$guardado.n_horas|default:''}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_monto_mensual}
                                    <div class="ubb-input">
                                        <label for="monto_mensual_{$tipo.id_beneficio}">Monto mensual</label>
                                        <input type="number" id="monto_mensual_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][monto_mensual]" class="form-control"
                                            value="{if $guardado.monto_mensual}{$guardado.monto_mensual|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_monto_viaje}
                                    <div class="ubb-input">
                                        <label for="monto_total_viaje_{$tipo.id_beneficio}">Monto total por viaje</label>
                                        <input type="number" id="monto_total_viaje_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][monto_total_viaje]" class="form-control"
                                            value="{if $guardado.monto_total_viaje}{$guardado.monto_total_viaje|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_valor_ida}
                                    <div class="ubb-input">
                                        <label for="valor_ida_{$tipo.id_beneficio}">Valor ida</label>
                                        <input type="number" id="valor_ida_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][valor_ida]" class="form-control"
                                            value="{if $guardado.valor_ida}{$guardado.valor_ida|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_valor_regreso}
                                    <div class="ubb-input">
                                        <label for="valor_regreso_{$tipo.id_beneficio}">Valor regreso</label>
                                        <input type="number" id="valor_regreso_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][valor_regreso]" class="form-control"
                                            value="{if $guardado.valor_regreso}{$guardado.valor_regreso|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_valor_ida_regreso}
                                    <div class="ubb-input">
                                        <label for="valor_ida_regreso_{$tipo.id_beneficio}">Valor ida-regreso</label>
                                        <input type="number" id="valor_ida_regreso_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][valor_ida_regreso]" class="form-control"
                                            value="{if $guardado.valor_ida_regreso}{$guardado.valor_ida_regreso|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_valor_matricula}
                                    <div class="ubb-input">
                                        <label for="valor_matricula_{$tipo.id_beneficio}">Valor matrícula</label>
                                        <input type="number" id="valor_matricula_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][valor_matricula]" class="form-control"
                                            value="{if $guardado.valor_matricula}{$guardado.valor_matricula|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_valor_arancel}
                                    <div class="ubb-input">
                                        <label for="valor_arancel_{$tipo.id_beneficio}">Valor arancel</label>
                                        <input type="number" id="valor_arancel_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][valor_arancel]" class="form-control"
                                            value="{if $guardado.valor_arancel}{$guardado.valor_arancel|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                                {if $tipo.tiene_monto_seguro}
                                    <div class="ubb-input">
                                        <label for="monto_seguro_{$tipo.id_beneficio}">Monto seguro de salud</label>
                                        <input type="number" id="monto_seguro_{$tipo.id_beneficio}"
                                            name="beneficios[{$tipo.id_beneficio}][monto_seguro]" class="form-control"
                                            value="{if $guardado.monto_seguro}{$guardado.monto_seguro|string_format:"%.0f"}{/if}">
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>
        </section>

        <section class="content-box">
            <h2 tabindex="0">Razones que motivan la petición de patrocinio</h2>
            <div class="ubb-component-wrapper">
                <div class="ubb-input-wrapper">
                    <div class="ubb-input">
                        <textarea name="razones_patrocinio" id="razones_patrocinio"
                            placeholder="Ingrese la fundamentación académica y estratégica de su solicitud..."
                            aria-describedby="contador_razones">{$solicitud.razones_patrocinio|default:''}</textarea>
                        <span id="contador_razones" class="character-counter">Caracteres: 0 / 4000</span>
                    </div>
                </div>
            </div>
        </section>

        {if $id_solicitud}
            <section class="content-box">
                <h2 tabindex="0">Adjuntar documentos requeridos</h2>
                <div class="ubb-component-wrapper">
                    <p class="ubb-mb-4">Adjunte los documentos requeridos según el Reglamento.</p>
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
                                        {if !$doc.bloqueado}
                                            <input type="file" name="archivo" accept="application/pdf" class="file-input-doc"
                                                data-id="{$doc.id_sol_documento}">
                                        {else}
                                            {if $doc.estado_doc == 'CARGADO'}
                                                <button type="button" class="ubb-btn ubb-linear-btn btn-ver-doc"
                                                    data-id="{$doc.id_sol_documento}">
                                                    <i class="fa fa-eye icon-left" aria-hidden="true"></i>Ver
                                                </button>
                                            {/if}
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </section>
        {/if}

    </form>

</div>