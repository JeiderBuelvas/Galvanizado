<?php
$i = 0;
$cont = 0;
$nombres = explode("|", $_POST['old_archivo']);
$nombres = ($nombres[0] == "") ? [] : $nombres;
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
$iddocumento= $_POST["documentoid"];
$asunto     = strtoupper($_POST["asunto"]);
$idtipodocu = $_POST["idtipodocu"];
$idarea     = $_POST["idarea"];
$idremitente= $_POST["idremitente"];
$idusuario  = $_POST["idusuario"];
//$opcion     = $_POST["opcion"];
$estado     = $_POST["estado"];

require '../../modelo/modelo_documento.php';
$MC = new Modelo_documento();
$consulta = $MC->modificar_documento($iddocumento, $asunto, $idtipodocu, $idarea, $idremitente, $estado, $idusuario, $destinoImagen, $cont);
echo $consulta;

?>