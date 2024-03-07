<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
</head>
<body>
	<?php

			$servidor = "localhost";
			$usuario = "polyupr1_polyuprotec";
			$contrasena = "JBPolyuprotec2021";
			$basedatos = "polyupr1_barranquilla";
		
		

	
			$conexion = new mysqli($servidor,$usuario,$contrasena,$basedatos);
			$conexion->set_charset("utf8");

		    $eliminarproceso=$_POST['proceso'];
			mysqli_query($conexion, "DELETE from documento WHERE documento_cod = '$eliminarproceso'");

			mysqli_close($conexion);
			echo "Proceso eliminado con exito para el cliente!";

			
	?>
</body>
</html>