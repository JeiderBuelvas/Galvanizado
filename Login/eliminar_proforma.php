<?php

  include"conexion.php";
  
  Eliminarproducto($_GET['id']);
  
  function Eliminarproducto($id){
      $sentencia="DELETE FROM files WHERE id='".$id."'";
      mysql_query($sentencia) or die (mysql_error());
  }
  
  ?>