<!DOCTYPE HTML>
<?php
include('conexion.php');

$tmp = array();
$res = array();

$sel = $con->query("SELECT * FROM files");
while ($row = $sel->fetch_assoc()) {
    $tmp = $row;
    array_push($res, $tmp);
}
?>
<html lang="zxx">
<head>
    <!---Inicio elementos de Whatsapp----> 
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="estilos.css">
    <script src="https://kit.fontawesome.com/eb496ab1a0.js" crossorigin="anonymous"></script>
    <!---Fin elementos de Whatsapp----> 
    
    <!--- MODAL SUBIR PROFORMA--->
     <link  rel="icon"   href="https://www.google.com/s2/favicons?domain=polyuprotec.com" type="image/png" />
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <div class="container">
            <div class="row justify-content-md-center">
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nuevo archivo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form enctype="multipart/form-data" id="form1">
                            <div class="form-group">
                                <label for="title">Cliente</label>
                                <input type="text" class="form-control" id="title" name="title">
                            </div>
                            <div class="form-group">
                                <label for="description">Descripción</label>
                                <input type="text" class="form-control" id="description" name="description">
                            </div>
                            <div class="form-group">
                                <label for="description">Cargar archivo</label>
                                <input type="file" class="form-control" id="file" name="file">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="onSubmitForm()">Enviar</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="modalPdf" tabindex="-1" aria-labelledby="modalPdf" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ver archivo</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <iframe id="iframePDF" frameborder="0" scrolling="no" width="100%" height="500px"></iframe>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>

                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <script>
                            function onSubmitForm() {
                                var frm = document.getElementById('form1');
                                var data = new FormData(frm);
                                var xhttp = new XMLHttpRequest();
                                xhttp.onreadystatechange = function () {
                                    if (this.readyState == 4) {
                                        var msg = xhttp.responseText;
                                        if (msg == 'success') {
                                            alert(msg);
                                            $('#exampleModal').modal('hide')
                                        } else {
                                            alert(msg);
                                        }

                                    }
                                };
                                xhttp.open("POST", "upload.php", true);
                                xhttp.send(data);
                                $('#form1').trigger('reset');
                            }
                            function openModelPDF(url) {
                                $('#modalPdf').modal('show');
                                $('#iframePDF').attr('src','<?php echo 'http://' . $_SERVER['HTTP_HOST'] . '/Login/'; ?>'+url);
                            }
        </script>
           <!----------------------------- FINAL MODAL SUBIR PROFORMA ---------------------------------------------------------------->
         
         
	<title>Seguimiento de Pedidos</title>
  <img style="padding: 9px; margin: 9px; float: left; width: 200px;" src="Poly.png"  width="210" height="90">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Full Screen Enroll Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
	<link rel="stylesheet" href="_plantilla/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="_plantilla/css/fontawesome-all.css">
	<script src="../vistas/_recursos/js/jquery.min.js"></script>

	<link rel="stylesheet" href="bootstrap.min.css" crossorigin="anonymous">
	<link rel="stylesheet" href="_plantilla/js/sweetalert.css">
	 <link href="../vistas/_recursos/css/customs.css" rel="stylesheet">
	   <link rel="stylesheet" href="../vistas/_recursos/css/bootstrap.css" type="text/css" />
     

</head>
<body>
	<div style="text-align: center;" class="row">
		<div class="col-md-12" style="text-align: center;">
			<br><br>
			<label>SEGUIMIENTO DE PEDIDO</label><br><br>
		</div>
		<div class="col-md-4">
		</div>
		<div class="col-md-4">
			<input type="text" id="txtdocumento" class="form-control">
		</div>
		<div class="col-md-1">
			<button  class="btn btn-primary" onclick="buscardocumento()"><i class="fa fa-search"></i>&nbsp;BUSCAR</button>  <br><br>
		</div>	
		 <div  class="col-md-3">
         <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal"><i class="fa fa-file"></i>  CARGAR PROFORMA</button>
         </div>
	</div>
	<div class="main-w3ls">
		<div class="left-content" style="text-align: center;flex: 0 0 100%;max-width: 100%;">			
			<div class="center-content form-style-agile">
				<div class="input-group mb-12 col-md-12">
					<table id="tabla_horario" class="table table-condensed jambo_table">
		                <thead>
		                    <tr>
		                        <th style = 'text-align: center;width: 80px;word-wrap: break-word;font-weight: bold;'>O.T</th>
            								<th style = 'text-align: center;width: 50px;word-wrap: break-word;font-weight: bold;'>OBSERVACIÓNES</th>
            								<th style = 'text-align: center;width: 130px;word-wrap: break-word;font-weight: bold;'>FECHA RECEPCI&OacuteN</th>
            								<th style = 'text-align: center;width: 150px;word-wrap: break-word;font-weight: bold;'>&Aacute;REA ASIGNADA</th>
            								<th style = 'text-align: center;width: 150px;word-wrap: break-word;font-weight: bold;'>SEDE</th>
                            <th style = 'text-align: center;width: 20px;word-wrap: break-word;font-weight: bold;'>ARCHIVO</th>
            								<th style = 'text-align: center;width: 30px;word-wrap: break-word;font-weight: bold;'>ESTADO</th>
		                    </tr>
		                </thead>
		                <tbody id="tbody_tabla_seguimiento">
		                </tbody>
		            </table>
		        </div>
	        </div>
        </div>
	</div>
	<div>
	<div class="input-group mb-12 col-md-12" style="text-align: right;">
		<a href="https://polyuprotec.com/consulte-su-pedido/" class="btn btn-default" style="box-shadow: 0 0 0 .2rem rgba(0,0,0,0);">Regresar</a><br><br>
	</div>
	</div>
<style type="text/css">
	label{
      font-weight:bold;
    }
    .select2{
      font-weight:bold;
      text-align-last:center;
    }
    button{
    font-weight:bold;
    
    }
    select{
       font-weight:bold;
      text-align-last:center;
    }
    .select2-container--default.select2-container--disabled .select2-selection--single{
      color: rgb(25,25,51); background-color: rgb(255,255,255);solid 5px;
      }
    .modal-open .select2-container--open { z-index: 999999 !important; width:100% !important; }
</style>
<div class="modal fade" id="modal_asunto_documento_modal">
  <div class="modal-dialog">
    <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title" id="myModalLabel"><b>Asunto del Pedido Nro: </b><label id="txtiddocumento_modal"></label></h4>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
           <h4 class="modal-title" id="myModalLabel"><b>Datos del Remitente del Pedido Nro: </b><label id="txtiddocumento1_modal"></label></h4>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         </div>
        <div class="modal-body">
      <div class="panel-body">
          <div class="col-md-12">
            <label>DATOS DEL CLIENTE</label>
            <input type="text" id="txtdatosremitente" class="form-control"><br>
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
           <h4 class="modal-title" id="myModalLabel"><b>Datos del Remitente del Pedido Nro: </b><label id="txtiddocumento1_modal"></label></h4>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
          <h4 class="modal-title" id="myModalLabel"><b>ARCHIVOS: </b><label id="txtiddocumento1_modal"></label></h4>
          <div class="kv-zoom-actions pull-right">
            <button type="button" class="btn btn-default btn-close" title="Close detailed preview" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times"></i></button>
          </div>
          
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
<script src="../vistas/_recursos/js/jquery.min.js"></script>
<script type="text/javascript" src="js/console_seguimiento.js"></script>
<script src="../vistas/_recursos/js/consola_usuario.js"></script>
<script src="_plantilla/js/sweetalert.min.js"></script>
  <script src="../vistas/_recursos/js/bootstrap.min.js"></script>
  
  <!--- BOTON DE WHATSAPP ----->
  <a href="https://wa.link/nib145" class="btn-wsp" target="_blank">
  <i class="fa fa-whatsapp icono"></i>
  </a>
  <!--- FIN BOTON DE WHATSAPP ----->

  
  
</body>
</html>