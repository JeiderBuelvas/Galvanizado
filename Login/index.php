<?php
session_start();
  if (isset($_SESSION['usuario'])) {
    header('Location: ../vistas/admin.php');
  } 
?>
<!DOCTYPE HTML>
<html lang="zxx">
<head>
    
	<title>Iniciar Sesion</title>
<link  rel="icon"   href="https://www.google.com/s2/favicons?domain=polyuprotec.com" type="image/png" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Full Screen Enroll Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
	<link rel="stylesheet" href="bootstrap.min.css" crossorigin="anonymous">
	</script>
	<link rel="stylesheet" href="_plantilla/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="_plantilla/css/fontawesome-all.css">
	<!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">-->
	<link rel="stylesheet" href="_plantilla/js/sweetalert.css">
</head>
<body>
	<div class="main-w3ls">
		<div class="left-content" style="text-align: center;" align="center">
			<br><br><br><br><br><br><br><br><br>
			<!--<img  style="width: 60%;" src="_plantilla/images/logo_1.png" />-->
			<img  style="width: 90%;" src="images/digital.gif" />
			<div class="copyright">
			</div>
		</div>
		<div class="right-form-agile">
			<div class="sub-main-w3">
				<br>
				<br>
				<br>				
				<br>					
				<h3>INICIAR SESION </h3>
				<br>
				<div class="form-style-agile">
					<label style="color:#000000;">Usurname</label>
					<br>							
					<div class="input-group mb-3">
					    <div class="input-group-prepend" >
					    <span class="input-group-text" id="basic-addon1" style="background-color: white"><span style="color:#0047E0" class="fas fa-user"></span></span>
				        </div>
						<input type="text" class="form-control" placeholder="Username" id="txt_usuario">
					</div>
				</div>
				<div class="form-style-agile">
					<label style="color:#000000;">Password</label>
					<br>	
					<div class="input-group mb-3">
					    <div class="input-group-prepend" >
					  	    <br>
					        <span class="input-group-text" id="basic-addon1" style="background-color: white"><span style="color:#0047E0" class="fa  fa-unlock-alt"></span></span>
					    </div>
						<input type="password" class="form-control" placeholder="Password" aria-label="Password" id="txt_pass">
					</div>
				</div>
				<a href="seguimiento.php" class="btn btn-default" style="box-shadow: 0 0 0 .2rem rgba(0,0,0,0);">Seguimiento de Pedido</a><br><br>
				<button onclick="VerificarUsuario()" style="background: #0047E0;border-top-color: rgb(232, 70, 1);border-bottom-color:rgb(232, 70, 1);border-left-color:rgb(232, 70, 1);border-right-color:rgb(232, 70, 1);color: white;" class="btn btn-warning btn-block btn-lg" >Entrar</button>
			</div>
		</div>
	</div>
</body>
<script src="../vistas/_recursos/js/jquery.min.js"></script>
<script src="../vistas/_recursos/js/consola_usuario.js"></script>
<script src="_plantilla/js/sweetalert.min.js"></script>
</html>