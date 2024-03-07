<?php
$i = 0;
$cont= 0;
$nombres = [];
$total_files = count($_FILES["id_archivo"]["name"]);
if($_FILES['id_archivo']['name'][0] != '' && $total_files > 0){
	$cont=0;
	for($i = 0; $i < $total_files; $i++){
		$imagen=uniqid()."-".$_FILES['id_archivo']['name'][$i];
		$ruta=$_FILES['id_archivo']['tmp_name'][$i];
		$destino = 'Archivo/'.$imagen;
		$nombres[] = $destino;
		copy($ruta, $destino);
		$cont=1;
	}
	$destinoImagen = implode("|",$nombres);
}else{
	$destinoImagen="-";
}
$iddocumento= $_POST["iddocumento"];
$asunto     = strtoupper($_POST["asunto"]);
$idtipodocu = $_POST["idtipodocu"];
$idarea     = $_POST["idarea"];
$idremitente= $_POST["idremitente"];
$idusuario  = $_POST["idusuario"];
$opcion     = $_POST["opcion"];


	/*echo "<script>'alert($iddocumento)'</script>";
	echo "<script>'alert($asunto)'</script>";
	echo "<script>'alert($idtipodocu)'</script>";
	echo "<script>'alert($idarea)'</script>";
	echo "<script>'alert($idremitente)'</script>";
	echo "<script>'alert($idusuario)'</script>";
	echo "<script>'alert($opcion)'</script>";
	echo "<script>'alert($destinoImagen)'</script>";
	echo "<script>'alert($cont)'</script>";
	echo "<script>'alert($destinoImagen)'</script>";
	echo "<script>'alert($cont)'</script>";*/


	require '../../modelo/modelo_documento.php';
	$MC = new Modelo_documento();
	$consulta = $MC->Registrar_documento($iddocumento,$asunto,$idtipodocu,$idarea,$idremitente,$idusuario,$opcion,$destinoImagen,$cont);
	echo $consulta;
?>