<?php
// Conexi車n a la base de datos (ajusta seg迆n tu configuraci車n)
$servername = "localhost";
$username = "polyupr1_polyuprotec";
$password = "JBPolyuprotec2021";
$dbname = "polyupr1_bd_tramite";

$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar la conexi車n
if ($conn->connect_error) {
    die("Conexi車n fallida: " . $conn->connect_error);
}

// Obtener el nombre del archivo a eliminar desde la solicitud POST
$archivoAEliminar = $_POST['archivo'];

// Eliminar el registro en la base de datos
$sql = "DELETE FROM tu_tabla WHERE nombre_archivo" = ?;

if ($stmt = $conn->prepare($sql)) {
    $stmt->bind_parm("s", $archivoAEliminar);
    if($stmt->execute()){
      echo "Archivo eliminado de la base de datos correctamente";
    } else {
      echo "Error al eliminar el archivo: " . $conn->error;
    }
  }

$stmt->close();
$conn->close();
?>