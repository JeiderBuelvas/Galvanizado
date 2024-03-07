//---------------------------------------------FIN PRUEBAS----------------------------------------------------------------
function listar_documento_vista(valor,pagina){
	var pagina = Number(pagina);
	$.ajax({
		url: '../controlador/documento/controlador_ListarBuscar_documento.php',
		type: 'POST',
		data: 'valor='+valor+'&pagina='+pagina+'&boton=buscar',
		beforeSend: function(){
			$("#loading_almacen").addClass("fa fa-refresh fa-spin fa-3x fa-fw");
		},
	    complete: function(){
	      $("#loading_almacen").removeClass("fa fa-refresh fa-spin fa-3x fa-fw");
	    },
		success: function(resp){
			var datos = resp.split("*");
			var valores = eval(datos[0]);
			if(valores.length>0){
				var cadena = "";
				cadena += "<table border='0' class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center;width: 80px;word-wrap: break-word;'>O.T</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>OBSERVACIONES</th>";
				cadena += "<th style = 'text-align: center;width: 150px;word-wrap: break-word;'>FECHA RECEPCI&OacuteN</th>";
				cadena += "<th style = 'text-align: center;width: 150px;word-wrap: break-word;'>&Aacute;REA ASIGNADA</th>"
				cadena += "<th style = 'text-align: center;width: 120px;word-wrap: break-word;''>SEDE</th>";
				cadena += "<th style = 'text-align: center;width: 30px;word-wrap: break-word;'>REMITENTE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ARCHIVO</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ESTADO</th>";
				cadena += "<th style = 'text-align: center;width: 10px;word-wrap: break-word;''>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				console.log("---");
				console.log(valores);
				console.log("---");
				for(var i = 0 ; i<valores.length; i++){
					cadena += "<tr>";			
					cadena += "<td  style = 'width: 80px;word-wrap: break-word;color:#9B0000; text-align:center;font-weight: bold;'>"+valores[i][0]+"</td>";
					cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'><button name='"+valores[i][0]+"*"+valores[i][1]+"' class='btn btn-info' title='Vista previa del asunto' style='background-color: #ffffff ; border-color: #ffffff' onclick='AbrirModalAsuntoDocumento(this)'><span class='fa fa-eye' style='color: #000000'></span>";
					cadena += "&nbsp;</button> </td>";
					cadena += "<td style = 'text-align: center;width: 150px;word-wrap: break-word;'>"+valores[i][2]+"</td>";
					cadena += "<td style = 'text-align: center;width: 150px;word-wrap: break-word;'>"+valores[i][4]+"</td>";
					cadena += "<td style = 'text-align: center;width: 120px;word-wrap: break-word;'>"+valores[i][3]+"</td>";
					cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'><button name='"+valores[i][0]+"*"+valores[i][1]+"*"+valores[i][6]+"' class='btn btn-info' title='Vista previa de los Datos del remitente' style='background-color: #ffffff ; border-color: #ffffff' onclick='AbrirModalVerRemitente(this)'><span class='fa fa-eye' style='color: #000000'></span>";
					cadena += "&nbsp;</button> </td>";
					cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'><button name='"+valores[i][9]+"' class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#fff' title='Ver documento Cargado' onclick='AbrirModalArchivo_documento(this)'><i class='fa  fa-folder-open' style='color:orange;'></i></button></td>";
					if (valores[i][5]=="INACTIVO") {
						cadena += "<tdstyle = 'text-align: center;width: 20px;word-wrap: break-word;'> <span class='badge bg-danger' style='color:White;'>"+valores[i][5]+"</span> </td>";
					}else if (valores[i][5]=="EN PROCESO") {
						cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'> <span class='badge bg-warning' style='color:White;'>"+valores[i][5]+"</span> </td>";
					}else
					{
						cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'> <span class='badge bg-success' style='color:White;'>"+valores[i][5]+"</span> </td>";
					}
					cadena += "<td style = 'text-align: center;width: 10px;word-wrap: break-word;'><button name='"+btoa(JSON.stringify(valores[i]))+"' class='btn btn-primary' onclick='AbrirModalDocumento(this)'><span class='glyphicon glyphicon-pencil'></span>";
					cadena += "</button></td> ";
					cadena += "</tr>";
				}
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_documento_tabla").html(cadena);
				var totaldatos = datos[1];
				var numero_paginas = Math.ceil(totaldatos/5); 
				var paginar = "<ul class='pagination'>";
				if(pagina>1){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_documento_vista("+'"'+valor+'","'+1+'"'+")'>&laquo;</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_documento_vista("+'"'+valor+'","'+(pagina-1)+'"'+")'>Anterior</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&laquo;</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Anterior</a></li>";
				}
				limite = 10;
				div = Math.ceil(limite/2);
				pagina_inicio = (pagina > div) ? (pagina - div):1;
				if(numero_paginas > div){
					pagina_restante = numero_paginas - pagina;
					pagina_fin = (pagina_restante > div) ? (pagina + div) : numero_paginas;
				}
				else{
					pagina_fin = numero_paginas;
				}
				for(i = pagina_inicio;i<=pagina_fin;i++){
					if(i==pagina){
						paginar +="<li class='active'><a href='javascript:void(0)'>"+i+"</a></li>";
					}
					else{
						paginar += "<li><a href='javascript:void(0)' onclick='listar_documento_vista("+'"'+valor+'","'+i+'"'+")'>"+i+"</a></li>";
					}
				}
				if(pagina < numero_paginas){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_documento_vista("+'"'+valor+'","'+(pagina+1)+'"'+")'>Siguiente</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_documento_vista("+'"'+valor+'","'+numero_paginas+'"'+")'>&raquo;</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Siguiente</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&raquo;</a></li>";
				}
				paginar += "</ul>";
				$("#paginador_documento_tabla").html(paginar);
			}else{
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center;width: 80px;word-wrap: break-word;'>O.T</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>OBSERVACIONES</th>";
				cadena += "<th style = 'text-align: center;width: 150px;word-wrap: break-word;'>FECHA RECEPCI&OacuteN</th>";
				cadena += "<th style = 'text-align: center;width: 150px;word-wrap: break-word;'>&Aacute;REA ASIGNADA</th>"
				cadena += "<th style = 'text-align: center;width: 120px;word-wrap: break-word;''>SEDE</th>";
				cadena += "<th style = 'text-align: center;width: 30px;word-wrap: break-word;'>REMITENTE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ARCHIVO</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ESTADO</th>";
				cadena += "<th style = 'text-align: center;width: 10px;word-wrap: break-word;''>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				cadena +="<tr style = 'text-align: center'><td colspan='8'><strong>No se encontraron registros</strong></td></tr>";
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_documento_tabla").html(cadena);
				$("#paginador_documento_tabla").html("");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown, jqXHR){
			alert("SE PRODUJO UN ERROR");
		}
	});
}
function AbrirModalArchivo_documento(control){

	$('#modal_archivo_documento').modal({backdrop: 'static', keyboard: false})
	$("#modal_archivo_documento").modal('show');
	var datos = control.name;
	var datos_split = datos.split("|");
	var cadena = '';
	if(datos_split.length > 0){
	    console.log(datos_split);
	    if(datos_split[0] == ""){
	        cadena =  '<br><br><label>NO EXISTE ARCHIVO</label><br><br><br>'; 
	    }else{
	       datos_split.forEach(function(item){
			cadena += '<object class="d-block mb-4 border" data="../controlador/documento/'+item+'"#zoom=100" type="application/pdf" style="width: 100%; height: 100%; min-height: 480px;"></object>';
		    }); 
	    }
		
	}else{
		 cadena =  '<br><br><label>NO EXISTE ARCHIVO</label><br><br><br>';
	}
	$("#id_archivodocumento").html(cadena);
}
function AbrirModalAsuntoDocumento(control){
	var datos = control.name;
	var datos_split = datos.split("*");
	$('#modal_asunto_documento_modal').modal({backdrop: 'static', keyboard: false})
	$('#modal_asunto_documento_modal').modal('show');
	$('#txtiddocumento_modal').html(datos_split[0]);
	$('#txtasunto_documento_modal').val(datos_split[1]);
	$('#cmb_estado').val(datos_split[3]).trigger("change");	
}

function AbrirModalDocumento(control){
	var datos = atob(control.name);
		datos = JSON.parse(datos);
	console.log(datos);
	
	$('#modal_editar_documento').modal({backdrop: 'static', keyboard: false})
	$('#modal_editar_documento').modal('show');

	$('#documentoid').val(datos.documento_cod);
	$('#txtasunto_documento').val(datos.doc_asunto);

	$('#combo_estado').val(datos.doc_estado);
	$('#combo_estado').select2().trigger('change');

	setTimeout(function(){
		$('#combo_tipodocumento').val(datos.tipodocumento_cod);
		$('#combo_tipodocumento').select2().trigger('change');
	}, 500);

	$('#combo_area').val(datos.area_cod);
	$('#combo_area').select2().trigger('change');

	const plasmarInfo = function(response){
	    for (var i = 0; i < response.length; i++) {
            $('#txtdatosremitente').val(response[i][0]);
		    $('#txtidremitente').val(response[i][3]);
		}
	}
 
    // SOLICITA BUSCAR REMITENTE SEGUN TIPO DE DOCUMENTE-----------------------------------------------------
    
    console.log("DOC COD: " + datos.documento_cod);
    console.log("DOC TIPO: " + datos.doc_tipo);
	if(datos.doc_tipo == "C"){
		BuscarRemitenteCiudadanoME(datos.documento_cod, plasmarInfo);
	}
	if(datos.doc_tipo == "I"){
		BuscarRemitenteInstitucionME(datos.documento_cod, plasmarInfo);
	}

	$('#archivoprevio').text(datos[9]); 
	$('#old_archivo').val(datos[9]);
	
	console.log('CADENA SEPARADA');
	var cadena = datos[9].split('|');
	cadena.forEach(function(cadena){
	    var htmlpdf =`<p>${cadena} <button class="btn btn-sm btn-danger"  onclick="eliminarArchivo(${cadena})">Eliminar</button></p>`;
	    $('#files_pdf').append(htmlpdf);
	});
	
}
 // FIN DE PRUEBA------------------------------------------------------------------------------------------------------------------->

function AbrirModalVerRemitente(control){

	var datos = control.name;
	var datos_split = datos.split("*");
	$('#txtiddocumento1_modal').html(datos_split[0]);
	$('#txtiddocumento2_modal').html(datos_split[0]);
// 	console.log(datos_split);
	console.log("COD: " + datos_split[0]);
	if (datos_split[2]=="C") {
		BuscarRemitenteCiudadano(datos_split[0]);
	}	
	if (datos_split[2]=="I") {
		BuscarRemitenteInstitucion(datos_split[0]);
	}	
}

function BuscarRemitenteCiudadanoME(documentoCod, callback){
	$.ajax({
		url:'../controlador/documento/controlador_documento_traeremitenteciudadano.php',
		type:'POST',
		data:{ codigo: documentoCod }
	})
	.done(function(response){
		console.log(response);
		response= JSON.parse(response);
		return callback(response);
// 		return;
	});
}

function BuscarRemitenteInstitucionME(documentoCod, callback){
	$.ajax({
		url:'../controlador/documento/controlador_documento_traeremitenteinstitucion.php',
		type:'POST',
		data:{ codigo: documentoCod }
	})
	.done(function(response) {
		response= JSON.parse(response);
		callback(response);
		return;
		
	});
}

function BuscarRemitenteCiudadano(control, callback=function(){}) {
	$.ajax({
		url:'../controlador/documento/controlador_documento_traeremitenteciudadano.php',
		type:'POST',
		data:{
			codigo:control
		}
	})
	.done(function(resp) {
		var data = JSON.parse(resp);
		callback(data);
// 		console.log(data);
		if (data.length > 0) {
				$('#modal_datos_remitente_documento_modal').modal({backdrop: 'static', keyboard: false})
				$('#modal_datos_remitente_documento_modal').modal('show');
			var cadena="";
			for (var i = 0; i < data.length; i++) {
				$('#txtdatosremitenteciudadano').val(data[i][0]);
				$('#txtdniremitente').val(data[i][1]);
				$('#txttelefonoremitente').val(data[i][2]);	
			}			
		}else{
			swal("Documento sin remitente","","info");
		}
	})
}
function BuscarRemitenteInstitucion(control, callback=function(){}){
	$.ajax({
		url:'../controlador/documento/controlador_documento_traeremitenteinstitucion.php',
		type:'POST',
		data:{
			codigo:control
		}
	})
	.done(function(resp) {
		var data = JSON.parse(resp);
		callback(data);
		if (data.length > 0) {
				$('#modal_datos_remitenteinstitucion_documento_modal').modal({backdrop: 'static', keyboard: false})
				$('#modal_datos_remitenteinstitucion_documento_modal').modal('show');
			var cadena="";
			for (var i = 0; i < data.length; i++) {
				$('#txtdatosremitenteinstitucion').val(data[i][0]);
				$('#txttipoinstitucion').val(data[i][1]);
			}			
		}else{
			swal("Documento sin remitente","","info");
		}
	})
}
function Listar_tipodocumento_combo() {
	$.ajax({
		url:'../controlador/tipo_documento/controlador_combolistar_tipodocumento.php',
		type:'POST'
	})
	.done(function(resp) {
		var data = JSON.parse(resp);
		console.log("aqui");
		console.log(data);
		console.log("fin");
		if (data.length > 0) {
			var cadena = "";
				cadena += "<option value='otro'>"+"SELECCIONAR SEDE"+"</option>";
			for (var i = 0; i < data.length; i++) {
				cadena += "<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
			}
			$("#combo_tipodocumento").html(cadena);	
		}
		else{
			var cadena = "<option value='otro'>no se encontraron tipo de documentos Disponibles</option>";
			$("#combo_tipodocumento").html(cadena);
		}
	})
}
function Listar_areas_combo() {
	$.ajax({
		url:'../controlador/area/controlador_combolistar_area.php',
		type:'POST'
	})
	.done(function(resp) {
		var data = JSON.parse(resp);
		if (data.length > 0) {
			var cadena = "";
				cadena += "<option value='otro'>"+"SELECCIONAR &Aacute;REA"+"</option>";
			for (var i = 0; i < data.length; i++) {
				cadena += "<option value='"+data[i][0]+"'>"+data[i][1]+"</option>";
			}
			$("#combo_area").html(cadena);	
		}
		else{
			var cadena = "<option value='otro'>no se encontraron areas Disponibles</option>";
			$("#combo_area").html(cadena);
		}
	})
}
function AbrirModalRemitente(){
	$('#modal_remitente').modal({backdrop: 'static', keyboard: false})
	$("#modal_remitente").modal("show");
	listar_ciudadanoremitente_vista('','1');
	listar_institucionremitente_vista('','1');
}
function listar_ciudadanoremitente_vista(valor,pagina){
	var pagina = Number(pagina);
	$.ajax({
		url:'../controlador/ciudadano/controlador_ListarBuscar_ciudadano_remitente_modal.php',
		type: 'POST',
		data:'valor='+valor+'&pagina='+pagina+'&boton=buscar',
		beforeSend: function(){
			$("#loading_almacen").addClass("fa fa-refresh fa-spin fa-3x fa-fw");
		},
	    complete: function(){
	      $("#loading_almacen").removeClass("fa fa-refresh fa-spin fa-3x fa-fw");
	    },
		success: function(resp){
			var datos = resp.split("*"); 
			var valores = eval(datos[0]); 
			console.log(valores);
			if(valores.length>0){
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center' hidden='true' >ID</th>";
				cadena += "<th style = 'text-align: center'>EMPRESA O CLIENTE</th>";
				cadena += "<th style = 'text-align: center'>NIT</th>";
				cadena += "<th style = 'text-align: center'>DIRECCIÓN</th>";
				cadena += "<th style = 'text-align: center'>ESTADO</th>";
				cadena += "<th>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				for(var i = 0 ; i<valores.length; i++){
					var datoscompletos;
					datoscompletos = valores[i][1]+" "+valores[i][2]+" "+valores[i][3];
					cadena += "<tr>";			
					cadena += "<td align='center' hidden>"+valores[i][0]+"</td>";
					cadena += "<td>"+valores[i][1]+"</td>";
					cadena += "<td align='center'>"+valores[i][2]+"</td>";
					cadena += "<td align='center'>"+valores[i][4]+"</td>";
					if (valores[i][10]=="INACTIVO") {
						cadena += "<td style = 'text-align: center'> <span class='badge bg-danger' style='color:White;'>"+valores[i][10]+"</span> </td>";
					}else{
						cadena += "<td  style = 'text-align: center'> <span class='badge bg-success' style='color:White;'>"+valores[i][10]+"</span> </td>";
					}
					cadena += "<td><button name='"+valores[i][0]+"*"+datoscompletos+"*"+"C"+"' class='btn btn-primary' onclick='EnviarDatosRemitente(this)'><span class='glyphicon glyphicon-pencil'></span>";
					cadena += "</button></td> ";
					cadena += "</tr>";
				}
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_ciudadanosdisponibles_remitente").html(cadena);
				var totaldatos = datos[1];
				var numero_paginas = Math.ceil(totaldatos/5); 
				var paginar = "<ul class='pagination'>";
				if(pagina>1){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_ciudadanoremitente_vista("+'"'+valor+'","'+1+'"'+")'>&laquo;</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_ciudadanoremitente_vista("+'"'+valor+'","'+(pagina-1)+'"'+")'>Anterior</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&laquo;</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Anterior</a></li>";
				}
				limite = 10;
				div = Math.ceil(limite/2);
				pagina_inicio = (pagina > div) ? (pagina - div):1;
				if(numero_paginas > div){
					pagina_restante = numero_paginas - pagina;
					pagina_fin = (pagina_restante > div) ? (pagina + div) : numero_paginas;
				}
				else{
					pagina_fin = numero_paginas;
				}
				for(i = pagina_inicio;i<=pagina_fin;i++){
					if(i==pagina){
						paginar +="<li class='active'><a href='javascript:void(0)'>"+i+"</a></li>";
					}
					else{
						paginar += "<li><a href='javascript:void(0)' onclick='listar_ciudadanoremitente_vista("+'"'+valor+'","'+i+'"'+")'>"+i+"</a></li>";
					}
				}
				if(pagina < numero_paginas){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_ciudadanoremitente_vista("+'"'+valor+'","'+(pagina+1)+'"'+")'>Siguiente</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_ciudadanoremitente_vista("+'"'+valor+'","'+numero_paginas+'"'+")'>&raquo;</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Siguiente</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&raquo;</a></li>";
				}
				paginar += "</ul>";
				$("#paginador_ciudadanosdisponibles_remitente").html(paginar);
			}else{
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center' hidden='true' >ID</th>";
				cadena += "<th style = 'text-align: center'>NOMBRE Y APELLIDOS</th>";
				cadena += "<th style = 'text-align: center'>NIT</th>";
				cadena += "<th style = 'text-align: center'>DIRECCIÓN</th>";
				cadena += "<th style = 'text-align: center'>ESTADO</th>";
				cadena += "<th>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				cadena +="<tr style = 'text-align: center'><td colspan='7'><strong>No se encontraron registros</strong></td></tr>";
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_ciudadanosdisponibles_remitente").html(cadena);
				$("#paginador_ciudadanosdisponibles_remitente").html("");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown, jqXHR){
			alert("SE PRODUJO UN ERROR");
		}
	});
}
function listar_institucionremitente_vista(valor,pagina){
	var pagina = Number(pagina);
	$.ajax({
		url:'../controlador/institucion/controlador_ListarBuscar_institucionremitente_modal.php',
		type: 'POST',
		data:'valor='+valor+'&pagina='+pagina+'&boton=buscar',
		beforeSend: function(){
			$("#loading_almacen").addClass("fa fa-refresh fa-spin fa-3x fa-fw");
		},
	    complete: function(){
	      $("#loading_almacen").removeClass("fa fa-refresh fa-spin fa-3x fa-fw");
	    },
		success: function(resp){
			var datos = resp.split("*"); 
			var valores = eval(datos[0]); 
			if(valores.length>0){
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center' hidden='true' >O.T</th>";
				cadena += "<th style = 'text-align: center'>INSTITUCI&Oacute;N</th>";
				cadena += "<th style = 'text-align: center'>TIPO INSTITUCI&Oacute;N</th>";
				cadena += "<th style = 'text-align: center'>ESTADO</th>";
				cadena += "<th style = 'text-align: center'>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				for(var i = 0 ; i<valores.length; i++){
					cadena += "<tr>";			
					cadena += "<td align='center' hidden>"+valores[i][0]+"</td>";
					cadena += "<td>"+valores[i][1]+"</td>";
					cadena += "<td align='center'>"+valores[i][2]+"</td>";
					if (valores[i][3]=="INACTIVO") {
						cadena += "<td style = 'text-align: center'> <span class='badge bg-danger' style='color:White;'>"+valores[i][3]+"</span> </td>";
					}else{
						cadena += "<td style = 'text-align: center'> <span class='badge bg-success' style='color:White;'>"+valores[i][3]+"</span> </td>";
					}
					cadena += "<td style = 'text-align: center'><button name='"+valores[i][0]+"*"+valores[i][1]+"*"+"I"+"' class='btn btn-primary' onclick='EnviarDatosRemitente(this)'><span class='glyphicon glyphicon-pencil'></span>";
					cadena += "</button></td> ";
					cadena += "</tr>";
				}
				cadena += "</tbody>";
				cadena += "</table>";
				$("#div_listar_instituciondisponible_remitente").html(cadena);
				var totaldatos = datos[1];
				var numero_paginas = Math.ceil(totaldatos/5); 
				var paginar = "<ul class='pagination'>";
				if(pagina>1){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_institucionremitente_vista("+'"'+valor+'","'+1+'"'+")'>&laquo;</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_institucionremitente_vista("+'"'+valor+'","'+(pagina-1)+'"'+")'>Anterior</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&laquo;</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Anterior</a></li>";
				}
				limite = 10;
				div = Math.ceil(limite/2);
				pagina_inicio = (pagina > div) ? (pagina - div):1;
				if(numero_paginas > div){
					pagina_restante = numero_paginas - pagina;
					pagina_fin = (pagina_restante > div) ? (pagina + div) : numero_paginas;
				}
				else{
					pagina_fin = numero_paginas;
				}
				for(i = pagina_inicio;i<=pagina_fin;i++){
					if(i==pagina){
						paginar +="<li class='active'><a href='javascript:void(0)'>"+i+"</a></li>";
					}
					else{
						paginar += "<li><a href='javascript:void(0)' onclick='listar_institucionremitente_vista("+'"'+valor+'","'+i+'"'+")'>"+i+"</a></li>";
					}
				}
				if(pagina < numero_paginas){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_institucionremitente_vista("+'"'+valor+'","'+(pagina+1)+'"'+")'>Siguiente</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_institucionremitente_vista("+'"'+valor+'","'+numero_paginas+'"'+")'>&raquo;</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Siguiente</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&raquo;</a></li>";
				}
				paginar += "</ul>";
				$("#paginador_instituciondisponible_remitente").html(paginar);
			}else{
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center' hidden='true' >O.T</th>";
				cadena += "<th style = 'text-align: center'>INSTITUCI&Oacute;N</th>";
				cadena += "<th style = 'text-align: center'>TIPO INSTITUCI&Oacute;N</th>";
				cadena += "<th style = 'text-align: center'>ESTADO</th>";
				cadena += "<th style = 'text-align: center'>ACCI&Oacute;N</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				cadena +="<tr style = 'text-align: center'><td colspan='4'><strong>No se encontraron registros</strong></td></tr>";
				cadena += "</tbody>";
				cadena += "</table>";
				$("#div_listar_instituciondisponible_remitente").html(cadena);
				$("#paginador_instituciondisponible_remitente").html("");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown, jqXHR){
			alert("SE PRODUJO UN ERROR");
		}
	});
}
function EnviarDatosRemitente(control){
	var datos = control.name;
	var datos_split = datos.split("*");
	$("#txtidremitente").val(datos_split[0]);
	$("#txtdatosremitente").val(datos_split[1]);
	$("#txttipo").val(datos_split[2]);
	$("#modal_remitente").modal("hide");
}
function TraerCodigoDocumento(){
	$.ajax({
		url:'../controlador/documento/controlador_codigodocumento_listar.php',
		type:'POST'
	})
	.done(function (resp) {
        var data = JSON.parse(resp);
        if (data.length > 0) {
            var cant = parseInt(data[0][0]);
            var newCode = cant + 8733;  // Se resta 1 ya que el código original comienza en 1, no en 0
            $("#txtiddocumento").val(newCode.toString().padStart(6, '0'));
        } else {
            $("#txtiddocumento").val("008533");
        }
    })
}
function Registrar_documento(){
	var iddocumento = $("#txtiddocumento").val();
	var idremitente = $("#txtidremitente").val();
	var opcion      = $("#txttipo").val();
	var idtipodocu  = $("#combo_tipodocumento").val();
	var idarea      = $("#combo_area").val();
	var asunto      = $("#txtasunto_documento").val();
	var idusuario   = $("#txtnombre_codigo_usuario").val();
	if (idarea=='asunto' ) {
		return swal("Falta seleccionar las observaciónes del pedido","","error");
	}
	if (idarea=='otro' && idtipodocu=='otro') {
		return swal("Falta seleccionar el area de destino y el tipo de Sede","","error");
	}
	if (idarea=='otro' ) {
		return swal("Falta seleccionar el area de destino","","error");
	}
	if (idtipodocu=='otro') {
		return swal("Falta seleccionar el tipo de Sede","","error");
	}
	if (idremitente.length==0) {
		return swal("Falta seleccionar el tipo de Sede","","error");
	}	
	//return alert(iddocumento+" - "+ asunto +" - "+ idtipodocu +" - "+idarea +" - "+ idremitente +" - "+ idusuario +" - "+opcion);
	$.ajax({
		url:'../controlador/documento/controlador_registrar_documento.php',
		type:'POST',
		data:{
			iddocumento:iddocumento,
			asunto:asunto,
			idtipodocu:idtipodocu,
			idarea:idarea,
			idremitente:idremitente,
			idusuario:idusuario,
			opcion:opcion
		}
	})
	.done(function(resp){
		if (resp > 0) {
			swal("Proceso Registrado!", "", "success")
			.then ( ( value ) =>  { 
				  $("#main-content").load("Documento/vista_documento_listar.php"); 
			});
			
		}
		else{
			swal("! Lo sentimos el pedido no fue Registrado!", "", "error");	
		}
	})
	.fail(function( jqXHR, textStatus, errorThrown){
		if (jqXHR.status === 0) {

	    alert('Not connect: Verify Network.');

	  } else if (jqXHR.status == 404) {

	    alert('Requested page not found [404]');

	  } else if (jqXHR.status == 500) {

	    alert('Internal Server Error [500].');

	  } else if (textStatus === 'parsererror') {

	    alert('Requested JSON parse failed.');

	  } else if (textStatus === 'timeout') {

	    alert('Time out error.');

	  } else if (textStatus === 'abort') {

	    alert('Ajax request aborted.');

	  } else {

	    alert('Uncaught Error: ' + jqXHR.responseText);

	  }
	})			
}
function Registrar_documento_post(e){

	
	$(document).on('submit', '#create-form-documento', function(e) {
		
		e.preventDefault();
      var data = $(this).serialize();
      
      if($("#id_archivo")[0].files.length == 0 || $("#id_archivo")[0].files.length <= 4){
      	console.log("ok");
      	$("#btnRegistrar").attr('disabled',true);
      	$.ajax({  
      	        type : 'POST',
      	        mimeType: "multipart/form-data",
      	        url:'../controlador/documento/controlador_registrar_documento.php',
      	        data:  new FormData(this),
      	        contentType: false,
      	        cache: false,
      	        processData:false,
      	        success:function(response) {
      	          if(response > 0){
      	          	document.getElementById("create-form-documento").reset();
      	            swal("Proceso Registrado!", "", "success")
      				.then ( ( value ) =>  { 
      					  $("#main-content").load("Documento/vista_documento_listar.php"); 
      				});
      	          }else{
      	          	
      				var idremitente = $("#txtidremitente").val();
      				var idtipodocu  = $("#combo_tipodocumento").val();
      				var idarea      = $("#combo_area").val();
      				var asunto      = $("#txtasunto_documento").val();
      				if (asunto.length==0 ) {
      					return swal("Proceso Registrado!","","success")
      					.then ( ( value ) =>  { 
      					  $("#main-content").load("Documento/vista_documento_listar.php"); 
      					});
      					
      				}
      				if (idarea=='otro' && idtipodocu=='otro') {
      					return swal("Falta seleccionar el area de destino y el Tipo Documento","","error");
      				}
      				if (idarea=='otro' ) {
      					return swal("Falta seleccionar el area de destino","","error");
      				}
      				if (idtipodocu=='otro') {
      					return swal("Falta seleccionar el tipo de documento","","error");
      				}
      				if (idremitente.length==0) {
      					return swal("Falta seleccionar el tipo de documento","","error");
      				}
      	          }

      	          traer_administrador();
      	        }  
      	      });

      }else{
      	return swal("Sólo se pueden seleccionar hasta 4 archivos","","error");
      }  
      return false;
    }); 
}

function modificar_documento_post(){
	$(document).on('submit', '#mod-form-documento', function(e){
		e.preventDefault();
		if($("#id_archivo")[0].files.length == 0 || $("#id_archivo")[0].files.length <= 4){
			$("#btnModificar").attr('disabled',true);
			$.ajax({
				type: 'POST',
				mimeType: 'multipart/form-data',
				url: '../controlador/documento/controlador_modificar_documento.php',
				data:  new FormData(this),
				contentType: false,
				cache: false,
				processData:false,
				success:function(response){
					if(response > 0){
						document.getElementById("modal_editar_documento").style.display= 'none';
						document.getElementsByClassName("modal-backdrop")[0].remove();
						document.getElementById("mod-form-documento").reset();
						swal("Documento Modificado!", "", "success")
						.then ( ( value ) =>  {
							$("#main-content").load("Documento/vista_documento_listar.php");
						});
					}else{
						$("#btnModificar").attr('disabled',false);
						var idremitente = $("#txtidremitente").val();
						var idtipodocu  = $("#combo_tipodocumento").val();
						var idarea      = $("#combo_area").val();
						var asunto      = $("#txtasunto_documento").val();
						if (asunto.length==0){
							return swal("Falta seleccionar el asunto del documento","","error");
						}
						if (idarea=='otro' && idtipodocu=='otro') {
							return swal("Falta seleccionar el area de destino y el Tipo de sede","","error");
						}
						if (idarea=='otro'){
							return swal("Falta seleccionar el area de destino","","error");
						}
						if (idtipodocu=='otro'){
							return swal("Falta seleccionar el tipo de sede","","error");
						}
						if (idremitente.length==0){
							return swal("Falta seleccionar el tipo de sede","","error");
						}
					}

					traer_administrador();
				}
			});
		}else{
			return swal("Sólo se pueden seleccionar hasta 4 archivos","","error");
		}
		

		return false;
	});
}

//=============================================================================================================================
//=============================================================================================================================
//===================================================VERIFICAR DOCUMENTO EN PROCESO=============================================
//=============================================================================================================================
//=============================================================================================================================

function listar_verificardocumento_vista(valor,pagina){
	var pagina = Number(pagina);
	$.ajax({
		url:'../controlador/documento/controlador_ListarBuscar_documentopendiente.php',
		type: 'POST',
		data:'valor='+valor+'&pagina='+pagina+'&boton=buscar',
		beforeSend: function(){
			$("#loading_almacen").addClass("fa fa-refresh fa-spin fa-3x fa-fw");
		},
	    complete: function(){
	      $("#loading_almacen").removeClass("fa fa-refresh fa-spin fa-3x fa-fw");
	    },
		success: function(resp){
			var datos = resp.split("*"); 
			var valores = eval(datos[0]); 
			if(valores.length>0){
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center;width: 80px;word-wrap: break-word;'>O.T</th>";
				cadena += "<th style = 'text-align: center;width: 50px;word-wrap: break-word;'>ASUNTO</th>";
				cadena += "<th style = 'text-align: center;width: 130px;word-wrap: break-word;'>FECHA RECEPCI&OacuteN</th>";
				cadena += "<th style = 'text-align: center;width: 100px;word-wrap: break-word;'>&Aacute;REA ASIGNADA</th>"
				cadena += "<th style = 'text-align: center;width: 100px;word-wrap: break-word;''>SEDE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>REMITENTE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ARCHIVO</th>";
				cadena += "<th style = 'text-align: center;width: 200px;word-wrap: break-word;'>ESTADO</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				for(var i = 0 ; i<valores.length; i++){
					cadena += "<tr>";			
					cadena += "<td  style = 'width: 80px;word-wrap: break-word;color:#9B0000; text-align:center;font-weight: bold;'>"+valores[i][0]+"</td>";
					cadena += "<td style = 'text-align: center;width: 50px;word-wrap: break-word;'><button name='"+valores[i][0]+"*"+valores[i][1]+"' class='btn btn-info' title='Vista previa del asunto' style='background-color: #ffffff ; border-color: #ffffff' onclick='AbrirModalAsuntoDocumento(this)'><span class='fa fa-eye' style='color: #000000'></span>";
					cadena += "&nbsp;</button> </td>";
					cadena += "<td style = 'text-align: center;width: 130px;word-wrap: break-word;'>"+valores[i][2]+"</td>";
					cadena += "<td style = 'text-align: center;width: 100px;word-wrap: break-word;'>"+valores[i][4]+"</td>";
					cadena += "<td style = 'text-align: center;width: 100px;word-wrap: break-word;'>"+valores[i][3]+"</td>";
					cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'><button name='"+valores[i][0]+"*"+valores[i][1]+"*"+valores[i][6]+"' class='btn btn-info' title='Vista previa de los Datos del remitente' style='background-color: #ffffff ; border-color: #ffffff' onclick='AbrirModalVerRemitente(this)'><span class='fa fa-eye' style='color: #000000'></span>";
					cadena += "&nbsp;</button> </td>";
					cadena += "<td style = 'text-align: center;width: 20px;word-wrap: break-word;'><button name='"+valores[i][9]+"' class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#fff' title='Ver pedido Cargado' onclick='AbrirModalArchivo_documento(this)'><i class='fa  fa-folder-open' style='color:orange;'></i></button></td>";
					if (valores[i][5]=="TERMINADO") {
						cadena += "<td style = 'text-align: center;width: 80px;word-wrap: break-word;'><button disabled class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#000;color:#000 !important;'  title='Aceptar pedido' onclick='AbrirfuncionAceptarSolicitud(this)'><i class='fa fa-check' style='color:green;'></i>";
						cadena += "<b> Terminado</b></button></td>";
					}else if (valores[i][5]=="RECIBIBO") {
						cadena += "<td style = 'text-align: center;width: 80px;word-wrap: break-word;'><button disabled class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#000;color:#000 !important;'  title='Aceptar pedido' onclick='AbrirfuncionAceptarSolicitud(this)'><i class='fa fa-check' style='color:green;'></i>";
						cadena += "<b> Recibido</b></button></td>";
					}else
					{
						cadena += "<td style = 'text-align: center;width: 200px;word-wrap: break-word;'><button  name='"+valores[i][0]+"'  class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#000;color:#000 !important;'  title='Aceptar pedido' onclick='AbrirfuncionAceptarSolicitud(this)'><i class='fa fa-check' style='color:green;'></i>";
						cadena += "<b> Recibir</b></button>&nbsp;<button  name='"+valores[i][0]+"'  class='btn btn-primary btn-sx' style='background-color:#fff;border-color:#000;color:#000 !important;'  title='Termianr Pedido' onclick='AbrirfuncionRechazarSolicitud(this)'><i class='fa fa-close' style='color:green;'></i>";
						cadena += "<b> Terminar</b></button></td>";
					}
					cadena += "</tr>";
				}
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_documentopendiente_tabla").html(cadena);
				var totaldatos = datos[1];
				var numero_paginas = Math.ceil(totaldatos/5); 
				var paginar = "<ul class='pagination'>";
				if(pagina>1){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_verificardocumento_vista("+'"'+valor+'","'+1+'"'+")'>&laquo;</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_verificardocumento_vista("+'"'+valor+'","'+(pagina-1)+'"'+")'>Anterior</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&laquo;</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Anterior</a></li>";
				}
				limite = 10;
				div = Math.ceil(limite/2);
				pagina_inicio = (pagina > div) ? (pagina - div):1;
				if(numero_paginas > div){
					pagina_restante = numero_paginas - pagina;
					pagina_fin = (pagina_restante > div) ? (pagina + div) : numero_paginas;
				}
				else{
					pagina_fin = numero_paginas;
				}
				for(i = pagina_inicio;i<=pagina_fin;i++){
					if(i==pagina){
						paginar +="<li class='active'><a href='javascript:void(0)'>"+i+"</a></li>";
					}
					else{
						paginar += "<li><a href='javascript:void(0)' onclick='listar_verificardocumento_vista("+'"'+valor+'","'+i+'"'+")'>"+i+"</a></li>";
					}
				}
				if(pagina < numero_paginas){
					paginar += "<li><a href='javascript:void(0)' onclick='listar_verificardocumento_vista("+'"'+valor+'","'+(pagina+1)+'"'+")'>Siguiente</a></li>";
					paginar += "<li><a href='javascript:void(0)' onclick='listar_verificardocumento_vista("+'"'+valor+'","'+numero_paginas+'"'+")'>&raquo;</a></li>";
				}
				else{
					paginar += "<li class='disabled'><a href='javascript:void(0)'>Siguiente</a></li>";
					paginar += "<li class='disabled'><a href='javascript:void(0)'>&raquo;</a></li>";
				}
				paginar += "</ul>";
				$("#paginador_documentopendiente_tabla").html(paginar);
			}else{
				var cadena = "";
				cadena += "<table  class='table table-condensed jambo_table'>";
				cadena += "<thead  class=''>";
				cadena += "<tr >";
				cadena += "<th style = 'text-align: center;width: 80px;word-wrap: break-word;'>O.T</th>";
				cadena += "<th style = 'text-align: center;width: 50px;word-wrap: break-word;'>ASUNTO</th>";
				cadena += "<th style = 'text-align: center;width: 130px;word-wrap: break-word;'>FECHA RECEPCI&OacuteN</th>";
				cadena += "<th style = 'text-align: center;width: 100px;word-wrap: break-word;'>&Aacute;REA ASIGNADA</th>"
				cadena += "<th style = 'text-align: center;width: 100px;word-wrap: break-word;''>SEDE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>REMITENTE</th>";
				cadena += "<th style = 'text-align: center;width: 20px;word-wrap: break-word;'>ARCHIVO</th>";
				cadena += "<th style = 'text-align: center;width: 200px;word-wrap: break-word;'>ESTADO</th>";
				cadena += "</tr>";
				cadena += "</thead>";
				cadena += "<tbody>";
				cadena +="<tr style = 'text-align: center'><td colspan='8'><strong>No se encontraron registros</strong></td></tr>";
				cadena += "</tbody>";
				cadena += "</table>";
				$("#listar_documentopendiente_tabla").html(cadena);
				$("#paginador_documentopendiente_tabla").html("");
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown, jqXHR){
			alert("SE PRODUJO UN ERROR");
		}
	});
}

function AbrirfuncionAceptarSolicitud(control){
	var datos       = control.name;
	var datos_split = datos.split("*");
	swal({
	  title: "¿Seguro que desea Aceptar el Pedido?",
	  icon: "success",
	  buttons: true,
	  dangerMode: true,
	})
	.then((willDelete) => {
	  if (willDelete) {
	  	$.ajax({
	  		url:'../controlador/documento/controlador_documento_aceptado.php',
	  		type:'POST',
	  		data:{
	  			codigo:datos_split[0]
	  		}
	  	})
	  	.done(function(resp){
	  		 listar_verificardocumento_vista('EN PROCESO','1');
	  		if (resp>0) {
	  			 swal("Solicitud Aceptada","", {
				      icon: "success",
				    });
	  		}else{
	  			swal("No se pudo Aceptar la solicitud","","error");
	  		}
	  	})
	   
	  } else {
	    swal("Proceso Cancelado","","warning");
	  }
	});
}

function AbrirfuncionRechazarSolicitud(control){
	var datos       = control.name;
	var datos_split = datos.split("*");
	swal({
	  title: "¿Seguro que desea Terminar el Pedido?",
	  icon: "warning",
	  buttons: true,
	  dangerMode: true,
	})
	.then((willDelete) => {
	  if (willDelete) {
	     	$.ajax({
		  		url:'../controlador/documento/controlador_documento_rechazado.php',
		  		type:'POST',
		  		data:{
		  			codigo:datos_split[0]
		  		}
		  	})
		  	.done(function(resp){alert(resp);
		  		 listar_verificardocumento_vista('EN PROCESO','1');
		  		if (resp>0) {
		  			 swal("Pedido Terminado","", {
					      icon: "success",
					    });
		  		}else{
		  			swal("No se pudo Terminar la solicitud","","error");
		  		}
		  	})
	  } else {
	   swal("Proceso Cancelado","","warning");
	  }
	});
}

/**
 * Funciones y Eventos para añadir mas archivos a un documento
 */

$('.add-another-file button').click(function(){
	return false;
});

$('.add-another-file button[type="increment"]').click(function(){
	console.log('incrementar');
});

$('.add-another-file button[type="decrement"]').click(function(){
	console.log('decrementar');
});
