<script type="text/javascript" src="_recursos/js/console_documento.js"></script>
<link type="text/css" rel="stylesheet" href="_recursos/input-file/css/disenio_input2.css">

<div class="contendor_kn">
  <div class="panel panel-default">
    <div class="panel-heading">
        <h2><b>PEDIDOS REGISTRADOS</b></h2>
    </div>
    <div class="panel-body">
        <div class="col-md-10">
          <div class=" input-group">
            <input id="txt_documento_vista" type="text" class="form-control"  placeholder="Ingrese el c&oacute;digo del documento a buscar ">
            <span class="input-group-addon"><i class="fa fa-search"></i></span>
          </div>
        </div>
        <div class="col-md-2">
          <button class="btn btn-danger" onclick="cargar_contenido('main-content','Documento/vista_documento_registrar.php');"><i class="fa fa-file-text" ></i> &nbsp;&nbsp;<strong>Nuevo Registro</strong></button>    
        </div>
        <div class="col-md-12">
          <div class="box-body table-responsive" style="text-align: center;"><br>
          	<label>LISTADO DE PEDIDOS REGISTRADOS</label>
              <div id="listar_documento_tabla" class=" icon-loading">
                <i id="loading_almacen" style="margin:auto;display:block; margin-top:60px;"></i>
                <div id="nodatos"></div>
              </div>
              <p id="paginador_documento_tabla" style="text-align:right" class="mi_paginador"></p>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- INICIO MODAL -->
<script type="text/javascript">
  listar_documento_vista("","1");
</script>
<script type="text/javascript">TraerCodigoDocumento();</script>
<script type="text/javascript">Listar_tipodocumento_combo();</script>
<script type="text/javascript">Listar_areas_combo();</script>
<!--FIN MODAL -->

<style type="text/css">
	.contendor_kn{
		padding: 10px;
	}
</style>

<!-- Modal N.o 1 -->
<div class="modal fade bs-example-modal-lg" id="modal_editar_documento">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title" id="myModalLabel"><b>Editar Pedido</b></h4>
         </div>
        <div class="modal-body">
        <div class="panel-body">
          <form method="POST" id="mod-form-documento">
            <div class="form-group">
              <input type="text" value="1" style="display: none"  name="idusuario">
              <input type="hidden" value="1" style="display: none" id="documentoid" name="documentoid">
              <div class="col-md-6">
                <input type="text" id="txtiddocumento" name="iddocumento" hidden>
                <label>Asunto</label>
                <textarea class="form-control" rows="5" style="resize: none" style="color: rgb(25,25,51); background-color: rgb(255,255,255);solid 5px;" placeholder="Ingresar Asunto ..." id="txtasunto_documento" name="asunto"></textarea>
              </div> 
            </div>
            <div class="form-group">
              <div class="col-md-6">
                <label>Estado</label> <br/>
                <select id="combo_estado" name="estado" class="form-control select2" style="width:100%;">
                    <option value="EN PROCESO">EN PROCESO</option>
                    <option value="RECIBIDO">RECIBIDO</option>
                    <option value="TERMINADO">TERMINADO</option>
                    <option value="ENTREGADO">ENTREGADO</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-6">
                <label>SEDE</label>
                <select id="combo_tipodocumento" name="idtipodocu" class="form-control select2" style="width:100%;"></select>
              </div>
              <div class="col-md-6">
                <label>&Aacute;rea de Destino</label>
                <select id="combo_area" name="idarea"  class="form-control select2" style="width:100%;"></select>
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-6">
                <br/>
                <input type="text" name="opcion" hidden id="txttipo">
                <label>C&oacute;digo Remitente</label>
                <input type="text" id="txtidremitente" name="idremitente" readonly style="color: rgb(25,25,51); background-color: rgb(255,255,255);solid 5px;color:#9B0000; text-align:center;font-weight: bold;" class="form-control">
              </div>
              <div class="col-md-5"><br>
                <label>Datos Remitente</label>
                <input type="text" id="txtdatosremitente" name="txtdatosremitente" readonly style="color: rgb(25,25,51); background-color: rgb(255,255,255);solid 5px;color:#9B0000; text-align:center;font-weight: bold;" class="form-control">
              </div>
              <div class="col-md-4"><br><label>&nbsp;</label>
                <a role="button" class="btn btn-primary col-sm-12" style="width: 100%"  onClick="AbrirModalRemitente()"><i class="fa fa-search"></i> <b>Seleccionar Remitente</b></a>
                <br> 
              </div>
              <div class="form-group">
                 <label>Seleccionar Documento</label>
                 <input type="file" name="id_archivo[]" id="id_archivo" class="file-upload-default" multiple accept=".pdf">
                 <div class="input-group col-sm-12" style="width: 94%">
                 <input type="text" class="form-control file-upload-info" disabled placeholder="Seleccionar Documento">
                 <span class="input-group-append">
                 <button class="file-upload-browse btn btn-info" type="button"><strong>Cargar</strong></button>
               </span>
             </div>
           <!--ACA SE DEBE CARGAR LOS ARCHIVOS QUE TRAE LA CADENA-->
           <small><b>Archivo subido:</b></small>
           <div class="col-md-12" id="files_pdf"></div>
           
           <!--<a href="#" id="eliminarArchivo" onclick="eliminarArchivo()">Eliminar</a>-->
           <input type="hidden" id="old_archivo" name="old_archivo">
           </div>
 
            </div>
            <div class="form-group">
              <div class="col-md-12" style="text-align: center;"><br>
                <button class="btn btn-success" type="submit" onclick="modificar_documento_post()" id="btnModificar"><strong> Modificar Documento</strong></button>
              </div>
            </div>
          </form>  
        </div>         
        </div> 
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp;<b>Cancelar</b></button>
        </div> 
    </div>
  </div> 
</div>
<div class="modal fade" id="modal_asunto_documento_modal">
  <div class="modal-dialog">
    <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title" id="myModalLabel"><b>Asunto del Documento Nro: </b><label id="txtiddocumento_modal"></label></h4>
         </div>
        <div class="modal-body">
      <div class="panel-body">
          <div class="col-md-12">
            <label>ASUNTO</label>
            <textarea class="form-control" rows="8"  style="resize: none" readonly="" style="color: rgb(25,25,51); background-color: rgb(255,255,255);solid 5px;" placeholder="Ingresar Asunto ..." id="txtasunto_documento_modal"></textarea>
          </div> 
      </div>         
        </div> 
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp;<b>Close</b></button>
        </div> 
    </div>
  </div> 
</div>
<div class="modal fade" id="modal_datos_remitente_documento_modal">
  <div class="modal-dialog">
    <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title" id="myModalLabel"><b>Datos del Remitente del Documento Nro: </b><label id="txtiddocumento1_modal"></label></h4>
         </div>
        <div class="modal-body">
      <div class="panel-body">
          <div class="col-md-12">
            <label>DATOS REMITENTE</label>
            <input type="text" id="txtdatosremitenteciudadano" class="form-control"><br>
          </div> 
          <div class="col-md-6">
            <label>DNI</label>
            <input type="text" id="txtdniremitente" class="form-control">
          </div> 
          <div class="col-md-6">
            <label>TELEFONO</label>
            <input type="text" id="txttelefonoremitente" class="form-control">
          </div> 
      </div>         
        </div> 
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp;<b>Close</b></button>
        </div> 
    </div>
  </div> 
</div>
<div class="modal fade" id="modal_datos_remitenteinstitucion_documento_modal">
  <div class="modal-dialog">
    <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title" id="myModalLabel"><b>Datos del Remitente del Documento Nro: </b><label id="txtiddocumento1_modal"></label></h4>
         </div>
        <div class="modal-body">
          <div class="panel-body">
              <div class="col-md-12">
                <label>DATOS REMITENTE</label>
                <input type="text" id="txtdatosremitenteinstitucion" class="form-control"><br>
              </div> 
              <div class="col-md-12">
                <label>TIPO INSTITUCI&Oacute;N</label>
                <input type="text" id="txttipoinstitucion" class="form-control">
              </div> 
          </div>         
        </div> 
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp;<b>Close</b></button>
        </div> 
    </div>
  </div> 
</div>
<div class="modal fade bs-example-modal-lg" id="modal_archivo_documento" role="dialog" aria-labelledby="myModalLabel">  
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <div class="kv-zoom-actions pull-right">
            <button type="button" class="btn btn-default btn-close" title="Close detailed preview" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          <h4 class="modal-title" id="myModalLabel"><b>ARCHIVO DEL DOCUMENTO: </b><label id="txtiddocumento1_modal"></label></h4>
        </div>
        <div class="modal-body">
          <div class="floating-buttons"></div>
          
            <div class="kv-zoom-body file-zoom-content" style="text-align:center; " >
            <div id="id_archivodocumento"></div>
          
        </div>
        </div>
      </div>
    </div>
</div>
<!-- Fin Modal N.o 1 -->

<!-- Modal N.o 2 -->
<div class="modal fade bs-example-modal-lg" id="modal_remitente">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           <h4 class="modal-title" id="myModalLabel"><b>Remitentes Disponibles</b></h4>
         </div>
        <div class="modal-body">
          <div class="panel-body">
               <div class="box-body">
                  <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs pull-right">
                      <li class="active"><a href="#tab_1-1" data-toggle="tab"><strong> CLIENTES </strong>  </a></li>
                      <!--<li><a href="#tab_2-2" data-toggle="tab"><strong> INSTITUCIONES</strong></a></li>-->
                    </ul>
                    <div class="tab-content" style="width: 100%">
                      <div class="tab-pane active" id="tab_1-1"><BR><BR>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DNI del cliente remitente:</label>
                        <br>
                        <div class="col-md-12"> 
                          <div class=" input-group">
                            <input type="text" class="form-control" placeholder="Ingresar dni del cliente remitente a buscar" id="txtbuscar_dniremitente" onkeypress="">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                          </div>
                          <br>
                        </div>
                        <div id="listar_ciudadanosdisponibles_remitente" class="icon-loading col-md-12 table-responsive">
                          <i id="loading_nivel"></i>
                          <div id="nodatos">          
                          </div>
                        </div>
                        <p id="paginador_ciudadanosdisponibles_remitente" style="text-align:right" class="mi_paginador"></p>
                      </div>
                      <div class="tab-pane" id="tab_2-2"><br><br>
                        <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nombre de la instituci&oacute;n:</label>
                        <br>
                        <div class="col-md-12"> 
                          <div class=" input-group">
                            <input type="text" class="form-control" placeholder="Ingresar nombre de la instituci&oacute;n a buscar" id="txtbuscar_institucionremiten" onkeypress="return soloLetras(event)">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                          </div>
                          <br>
                        </div>
                        <div id="div_listar_instituciondisponible_remitente" class="icon-loading col-md-12 table-responsive">
                          <i id="loading_nivel"></i>
                          <div id="nodatos">          
                          </div>
                        </div>
                        <p id="paginador_instituciondisponible_remitente" style="text-align:right" class="mi_paginador "></p>
                      </div>
                    </div>
                  </div>        
                </div>
          </div>         
        </div> 
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i>&nbsp;<b>Cancelar</b></button>
        </div> 
    </div>
  </div> 
</div>
<!-- Fin Modal N.o 2 -->

<script src="_recursos/input-file/js/bootstrap-uploader/file-upload.js"></script>
<script type="text/javascript">
	$("#txt_documento_vista").keyup(function(){
		var dato_buscar = $("#txt_documento_vista").val();
		listar_documento_vista(dato_buscar,'1');
	});
</script>
<script>
    $(function () {
        $('.select2').select2();
    })
</script>  
<script>
    function soloLetras(e){
       key = e.keyCode || e.which;
       tecla = String.fromCharCode(key).toLowerCase();
       letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
       especiales = "8-37-39-46";

       tecla_especial = false
       for(var i in especiales){
            if(key == especiales[i]){
                tecla_especial = true;
                break;
            }
        }

        if(letras.indexOf(tecla)==-1 && !tecla_especial){
            return false;
        }
    }
    function soloNumeros(e){
        tecla = (document.all) ? e.keyCode : e.which;

        //Tecla de retroceso para borrar, siempre la permite
        if (tecla==8){
            return true;
        }
            
        // Patron de entrada, en este caso solo acepta numeros
        patron =/[0-9]/;
        tecla_final = String.fromCharCode(tecla);
        return patron.test(tecla_final);
    }
</script>

<script type="text/javascript">
  //var f = new Date();
  //txtfecharegistro.value= f.getFullYear() + "-" + (f.getMonth() +1) + "-" + f.getDate();
</script>
<script type="text/javascript">
	$("#txtbuscar_dniremitente").keyup(function(){
		var dato_buscar = $("#txtbuscar_dniremitente").val();
		listar_ciudadanoremitente_vista(dato_buscar,'1');
	});
  $("#txtbuscar_institucionremiten").keyup(function(){
    var dato_buscar = $("#txtbuscar_institucionremiten").val();
    listar_institucionremitente_vista(dato_buscar,'1');
  });
</script>
<script>
    $(function () {
        $('.select2').select2();
    })
</script>  
<script>
    function soloLetras(e){
       key = e.keyCode || e.which;
       tecla = String.fromCharCode(key).toLowerCase();
       letras = " áéíóúabcdefghijklmnñopqrstuvwxyz";
       especiales = "8-37-39-46";

       tecla_especial = false
       for(var i in especiales){
            if(key == especiales[i]){
                tecla_especial = true;
                break;
            }
        }

        if(letras.indexOf(tecla)==-1 && !tecla_especial){
            return false;
        }
    }
    function soloNumeros(e){
        tecla = (document.all) ? e.keyCode : e.which;

        //Tecla de retroceso para borrar, siempre la permite
        if (tecla==8){
            return true;
        }
            
        // Patron de entrada, en este caso solo acepta numeros
        patron =/[0-9]/;
        tecla_final = String.fromCharCode(tecla);
        return patron.test(tecla_final);
    }
</script>