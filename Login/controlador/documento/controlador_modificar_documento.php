<?php
	$cont=0;

	if (isset($_FILES["id_archivo"]) && !empty($_FILES["id_archivo"]['tmp_name']) ){
        $imagen= uniqid()."-".$_FILES['id_archivo']['name'];
	    $ruta1=$_FILES['id_archivo']['tmp_name'];
	    $destinoImagen='Archivo/'.$imagen;
	    copy($ruta1, $destinoImagen);

	    $cont=1;
	}else{  
	    $destinoImagen="";
	}
    
	$iddocumento= $_POST["documentoid"];
	$asunto     = strtoupper($_POST["asunto"]);
	$idtipodocu = $_POST["idtipodocu"];
	$idarea     = $_POST["idarea"];
	$idremitente= $_POST["idremitente"];
	$idusuario  = $_POST["idusuario"];
	$opcion     = $_POST["opcion"];
    $estado     = $_POST["estado"];
	
	require '../../modelo/modelo_documento.php';
	$MC = new Modelo_documento();
	$consulta = $MC->modificar_documento($iddocumento, $asunto, $idtipodocu, $idarea, $idremitente, $estado, $idusuario, $opcion, $destinoImagen, $cont);
	echo $consulta;
?>