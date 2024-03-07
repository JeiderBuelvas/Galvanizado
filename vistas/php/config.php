<?php
  $hostname = "localhost";
  $username = "polyupr1_polyuprotec";
  $password = "JBPolyuprotec2021";
  $dbname = "polyupr1_chat";

  $conn = mysqli_connect($hostname, $username, $password, $dbname);
  if(!$conn){
    echo "Database connection error".mysqli_connect_error();
  }
?>
