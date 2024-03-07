<?php
	$nombre = $_POST["nombre"];
	$tipope = $_POST["tipopersona"];
	$telefo = $_POST["telefono"];
	$movil  = $_POST["movil"];
	$direcc = $_POST["direccion"];
	$fecnac = $_POST["fecha"];
	$dni    = $_POST["nrodocume"];
	$email  = $_POST["email"];
	include '../../modelo/modelo_ciudadano.php';
	$MC = new Modelo_ciuadano();
	$consulta = $MC->Registrar_ciudadano($nombre,$tipope,$telefo,$movil,$direcc,$fecnac,$dni,$email);
	echo $consulta;
?>