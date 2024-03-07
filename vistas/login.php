<?php 
  session_start();
  if(isset($_SESSION['unique_id'])){
    header("location: users.php");
  }
?>
 <link  rel="icon"   href="img-icon/iconpanel.png" type="image/png" />
<?php include_once "header.php"; ?>
<body>
  <div class="wrapper">
    <section class="form login">
      <img src="PortadaChat/Poly.png" width="120" height="60"><center>Soporte En Linea 
      (CHAT DEMO)</center></img>
      <form action="#" method="POST" enctype="multipart/form-data" autocomplete="off">
        <div class="error-text"></div>
        <div class="field input">
          <label>Correo Electronico</label>
          <input type="text" name="email" placeholder="Correo" required>
        </div>
        <div class="field input">
          <label>Contraseña</label>
          <input type="password" name="password" placeholder="Clave" required>
          <i class="fas fa-eye"></i>
        </div>
        <div class="field button">
          <input type="submit" name="submit" value="Continuar Chat">
        </div>
      </form>
      <div class="link">¿Aún no te has registrado? <a href="registro.php">Regístrate ahora</a></div>
    </section>
  </div> 

  
  <script src="javascript/pass-show-hide.js"></script>
  <script src="javascript/login.js"></script>
  
</body>
</html>
