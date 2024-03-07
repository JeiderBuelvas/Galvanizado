<?php
	class conexion{
		private $servidor;
		private $usuario;
		private $contraseña;
		private $basedatos;
		public $conexion;
		public function __construct(){
			$this->servidor = "localhost";
			$this->usuario = "polyupr1_polyuprotec";
			$this->contrasena = "JBPolyuprotec2021";
			$this->basedatos = "polyupr1_bd_tramite";
		}
		function conectar(){
			$this->conexion = new mysqli($this->servidor,$this->usuario,$this->contrasena,$this->basedatos);
			$this->conexion->set_charset("utf8");
		}
		function cerrar(){
			$this->conexion->close();	
		}
	}
?> 