<!DOCTYPE html>
<html lang="en">

<head>
    <link  rel="icon"   href="https://www.google.com/s2/favicons?domain=polyuprotec.com" type="image/png" />
    <center><img  src="https://media-exp1.licdn.com/dms/image/C4D0BAQGmv8Z0nAOi4w/company-logo_200_200/0/1519952083646?e=2159024400&v=beta&t=NbQFDIKUD5lOwLrqlHUnNmLz0gJvPgqklLMzTy9agdM"  width="200" height="200"></center>
    
    <style>
input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}

div {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

</style>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Eliminar Proceso</title>
</head>
<body>
     <center><p>PRIMER PASO: ELIMINAR PROCESO PARA EL CLIENTE</p></center>
	<form action="eliminar.php" name="Eliminar" method="POST">
		<input type="text" name="id" placeholder="ingrese codigo a eliminar">
		<input type="submit" name="enviar" value="Eliminar Proceso cliente">
	</form>
      <center><p>SEGUNDO PASO: ELIMINAR DATOS DEL PROCESO</p></center>
    <form action="eliminarproceso.php" name="Eliminar" method="POST">
		<input type="text" name="proceso" placeholder="ingrese codigo a eliminar">
		<input type="submit" name="enviar" value="Eliminar Proceso (Cookie)">
	</form>
    <div class="app-footer wrapper b-t bg-light">
      <b>&copy; 2021 Copyright </b>Jeider Buelvas
    </div>
</body>
</html>