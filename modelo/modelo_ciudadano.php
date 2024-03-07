<?php
	class Modelo_ciuadano
	{
		private $conexion;
		function __construct()
		{
			require_once('modelo_conexion.php');
			$this->conexion = new conexion();
			$this->conexion->conectar();
		}
		function Registrar_ciudadano($nombre,$tipope,$telefo,$movil,$direcc,$fecnac,$dni,$email){
			$sql = "call PA_REGISTRARCIUDADANO('$nombre','$tipope','$telefo','$movil','$direcc','$fecnac','$dni','$email')";
			if ($resultado = $this->conexion->conexion->query($sql)){
				return 1;
			}
			else{
				return $this->conexion->conexion->error;
			}
			$this->conexion->Cerrar_Conexion();
		}
		function Editar_ciudadano($codigo,$nombre,$tipopersona,$telefo,$movil,$direc,$fecha,$nrodocume,$email){
			$sql = "call PA_EDITARCIUDADANOTODOS('$codigo','$nombre','$tipopersona','$telefo','$movil','$direc','$fecha','$nrodocume','$email')";
			if ($resultado = $this->conexion->conexion->query($sql)){
				return 1;
			}
			else{
				return 0;
			}
			$this->conexion->Cerrar_Conexion();
		}
		function listar_ciudadano($valor, $inicio=FALSE,$limite=FALSE){
			if ($inicio!==FALSE && $limite!==FALSE) {
			    $sql = "SELECT ciudadano.ciudadano_cod,ciudadano.ciud_nombres,ciudadano.ciud_dni,ciudadano.ciud_fechaNacimiento,ciudadano.ciud_direccion,ciudadano.ciud_telefono,ciudadano.ciud_movil,ciudadano.ciud_email,ciudadano.ciud_fecharegistro,ciudadano.ciud_estado,ciudadano.ciud_tipo FROM ciudadano where ciudadano.ciud_nombres like '".$valor."%' ORDER BY ciudadano.ciudadano_cod DESC LIMIT $inicio,$limite";
			}else{
			    $sql = "SELECT ciudadano.ciudadano_cod,ciudadano.ciud_nombres,ciudadano.ciud_dni,ciudadano.ciud_fechaNacimiento,ciudadano.ciud_direccion,ciudadano.ciud_telefono,ciudadano.ciud_movil,ciudadano.ciud_email,ciudadano.ciud_fecharegistro,ciudadano.ciud_estado,ciudadano.ciud_tipo FROM ciudadano where ciudadano.ciud_nombres like '".$valor."%' ORDER BY ciudadano.ciudadano_cod DESC";
			}
			$resultado =  $this->conexion->conexion->query($sql);
			$arreglo = array();
			while($consulta_VU=mysqli_fetch_array($resultado)){ ///MYSQL_BOTH, MYSQL_ASSOC, MYSQL_NUM
			    $arreglo[] = $consulta_VU;
			}
			return $arreglo;
			$this->conexion->cerrar();	
 		}
 		function buscar_dni($dni){
			$sql = "SELECT * from ciudadano where ciud_dni = '$dni'";			
			$arreglo = array();
			if ($consulta = $this->conexion->conexion->query($sql)) {
				while ($consulta_VU = mysqli_fetch_array($consulta)) {
					$arreglo[] = $consulta_VU;
				}
				return $arreglo;
				$this->conexion->cerrar();	
			}
		}
		function listar_ciudadanoremitente($valor, $inicio=FALSE,$limite=FALSE){
			if ($inicio!==FALSE && $limite!==FALSE) {
			    $sql = "SELECT ciudadano.ciudadano_cod,ciudadano.ciud_nombres,ciudadano.ciud_dni,ciudadano.ciud_fechaNacimiento,ciudadano.ciud_direccion,ciudadano.ciud_telefono,ciudadano.ciud_movil,ciudadano.ciud_email,ciudadano.ciud_fecharegistro,ciudadano.ciud_estado,ciudadano.ciud_tipo FROM ciudadano where ciudadano.ciud_estado = 'ACTIVO' and ciudadano.ciud_nombres like '".$valor."%' ORDER BY ciudadano.ciudadano_cod DESC LIMIT $inicio,$limite";
			}else{
			    $sql = "SELECT ciudadano.ciudadano_cod,ciudadano.ciud_nombres,ciudadano.ciud_dni,ciudadano.ciud_fechaNacimiento,ciudadano.ciud_direccion,ciudadano.ciud_telefono,ciudadano.ciud_movil,ciudadano.ciud_email,ciudadano.ciud_fecharegistro,ciudadano.ciud_estado,ciudadano.ciud_tipo FROM ciudadano where ciudadano.ciud_estado = 'ACTIVO'  AND ciudadano.ciud_nombres like '".$valor."%' ORDER BY ciudadano.ciudadano_cod DESC";
			}
			$resultado =  $this->conexion->conexion->query($sql);
			$arreglo = array();
			while($consulta_VU=mysqli_fetch_array($resultado)){ ///MYSQL_BOTH, MYSQL_ASSOC, MYSQL_NUM
			    $arreglo[] = $consulta_VU;
			}
			return $arreglo;
			$this->conexion->cerrar();	
 		}
	}
?>