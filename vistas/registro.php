
<?php 
  session_start();
  if(isset($_SESSION['unique_id'])){
    header("location: users.php");
  }
?>
<?php include_once "header.php"; ?>
<body>
  <div class="wrapper">
    <section class="form signup">
      <img src="PortadaChat/Poly.png" width="120" height="60"><center>Consulta Y Soporte</center>
      <form action="#" method="POST" enctype="multipart/form-data" autocomplete="off">
        <div class="error-text"></div>
        <div class="name-details">
          <div class="field input">
            <label>Primer nombre</label>
            <input type="text" name="fname" placeholder="Nombre..." required>
          </div>
          <div class="field input">
            <label>Apellido</label>
            <input type="text" name="lname" placeholder="Apellido..." required>
          </div>
        </div>
        <div class="field input">
          <label>Dirección de correo electrónico</label>
          <input type="text" name="email" placeholder="Corro electronico..." required>
        </div>
        <div class="field input">
          <label>Contraseña</label>
          <input type="password" name="password" placeholder="Contraseña..." required>
          <i class="fas fa-eye"></i>
        </div>
        <div class="field image">
          <label>Seleccionar imagen</label>
          <input type="file" name="image" accept="image/x-png,image/gif,image/jpeg,image/jpg" required>
        </div>
        <div class="field button">
          <input type="submit" name="submit" value="Continuar Chat">
        </div>
      </form>
      <div class="link">¿Ya te registraste? <a href="login.php">Inicia sesión ahora</a></div>
    </section>
  </div>

  <script src="javascript/pass-show-hide.js"></script>
  <script src="javascript/signup.js"></script>

</body>
</html>
