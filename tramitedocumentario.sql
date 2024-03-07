-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-03-2024 a las 14:03:05
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tramitedocumentario`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_BUSCARADMINISTRADOR` (IN `codigo` INT)  BEGIN
SELECT
personal.pers_nombres,
personal.pers_apellidoPate,
personal.pers_apellidoMate,
usuario.usu_foto,
usuario.cod_usuario,
personal.pers_email,
personal.pers_telefono,
personal.pers_movil,
usuario.usu_clave,
personal.pers_direccion,
personal.pers_fechaNacimiento,
personal.pers_dni,
personal.pers_sexo
FROM
usuario
INNER JOIN personal ON personal.usuario_cod = usuario.cod_usuario
where personal.personal_cod = codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARAREA` (IN `CODIGO` INT, IN `AREA` VARCHAR(80), IN `ESTADO` VARCHAR(30))  BEGIN
UPDATE area SET
area_nombre = AREA,
area_estado = ESTADO
WHERE area_cod = CODIGO;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARCIUDADANOTODOS` (IN `codigo` INT, IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `tipopersona` VARCHAR(20), IN `telefo` VARCHAR(9), IN `movil` VARCHAR(9), IN `direc` VARCHAR(300), IN `fecha` DATE, IN `nrodocume` CHAR(8), IN `email` VARCHAR(100))  BEGIN
UPDATE ciudadano SET
ciud_nombres = nombre,
ciud_apellidoPate = apePat,
ciud_apellidoMate = apeMat,
ciud_email = email,
ciud_telefono = telefo,
ciud_movil = movil,
ciud_direccion = direc,
ciud_fechaNacimiento = fecha,
ciud_dni = nrodocume,
ciud_tipo=tipopersona
WHERE ciudadano_cod = codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARINSTITUCION` (IN `codigo` INT, IN `institucion` VARCHAR(150), IN `tipo` VARCHAR(50), IN `estado` VARCHAR(20))  BEGIN
UPDATE institucion SET
inst_nombre = institucion,
inst_tipoinstitucion=tipo,
inst_estado=estado
WHERE institucion_cod = codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARPERSONAL` (IN `codigo` CHAR(10), IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `email` VARCHAR(100), IN `telefo` CHAR(13), IN `movil` CHAR(13), IN `direc` VARCHAR(200), IN `fecha` VARCHAR(20), IN `dni` VARCHAR(13))  BEGIN
UPDATE personal SET
pers_nombres = nombre,
pers_apellidoPate = apePat,
pers_apellidoMate = apeMat,
pers_email = email,
pers_telefono = telefo,
pers_movil = movil,
pers_direccion = direc,
pers_fechaNacimiento = fecha,
pers_dni = dni
WHERE personal_cod = codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARPERSONALTODOS` (IN `codigo` INT, IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `telefo` VARCHAR(9), IN `movil` VARCHAR(9), IN `direc` VARCHAR(300), IN `fecha` DATE, IN `nrodocume` CHAR(8), IN `email` VARCHAR(100), IN `estado` VARCHAR(20))  BEGIN
UPDATE personal SET
pers_nombres = nombre,
pers_apellidoPate = apePat,
pers_apellidoMate = apeMat,
pers_email = email,
pers_telefono = telefo,
pers_movil = movil,
pers_direccion = direc,
pers_fechaNacimiento = fecha,
pers_dni = nrodocume,
pers_estado = estado 
WHERE personal_cod = codigo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARTIPODOCUMENTO` (IN `CODIGO` INT, IN `NOMBRE` VARCHAR(250), IN `ESTADO` VARCHAR(20))  BEGIN
UPDATE tipo_documento 
SET
tipodo_descripcion = NOMBRE,
tipodo_estado = ESTADO
WHERE tipodocumento_cod = CODIGO;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EDITARUSUARIO` (IN `usuario` VARCHAR(30), IN `actual` VARCHAR(30), IN `nueva` VARCHAR(30))  BEGIN
UPDATE usuario u
SET
u.usu_clave = nueva
WHERE u.usu_nombre = usuario AND u.usu_clave = actual;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_MODIFICARDOCUMENTOARCHIVO` (IN `iddocumento` CHAR(13), IN `asunto` VARCHAR(150), IN `idtipodocu` INT, IN `idarea` INT, IN `idremitente` INT, IN `docestado` VARCHAR(12), IN `idusuario` INT, IN `opcion` VARCHAR(10), IN `archivo` VARCHAR(350), IN `cont` INT)  BEGIN
IF cont = 0 THEN
	UPDATE documento SET doc_asunto= asunto, tipoDocumento_cod= idtipodocu, area_cod= idarea, usu_cod=idusuario, doc_estado= docestado, doc_tipo= opcion WHERE documento_cod= iddocumento;
END IF;
IF cont = 1 THEN
	UPDATE documento SET doc_asunto= asunto, tipoDocumento_cod= idtipodocu, area_cod= idarea, usu_cod=idusuario, doc_estado= docestado, doc_tipo= opcion, doc_documento= archivo WHERE documento_cod= iddocumento;
END IF;
IF opcion = 'C' THEN
		INSERT INTO detalle_ciudadano (ciudadano_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
IF opcion = 'I' THEN
		INSERT INTO detalle_institucion(institucion_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARAREA` (IN `NOMBRE` VARCHAR(50))  BEGIN
INSERT INTO area (area_nombre,area_estado) VALUES(NOMBRE,'ACTIVO');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARCIUDADANO` (IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `tipope` VARCHAR(50), IN `telefo` CHAR(9), IN `movil` CHAR(9), IN `direcc` VARCHAR(250), IN `fecnac` DATE, IN `dni` CHAR(8), IN `email` VARCHAR(30), IN `genero` CHAR(1))  BEGIN
INSERT INTO ciudadano(ciud_nombres,ciud_apellidoPate,ciud_apellidoMate,ciud_dni,ciud_sexo,ciud_fechaNacimiento,ciud_direccion,ciud_telefono,ciud_movil,ciud_email,ciud_estado,ciud_tipo) VALUES
(nombre,apePat,apeMat,dni,genero,fecnac,direcc,telefo,movil,email,'ACTIVO',tipope);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARDOCUMENTO` (IN `iddocumento` CHAR(13), IN `asunto` VARCHAR(150), IN `idtipodocu` INT, IN `idarea` INT, IN `idremitente` INT, IN `idusuario` INT, IN `opcion` VARCHAR(10))  BEGIN
INSERT INTO documento (documento_cod,doc_asunto,tipoDocumento_cod,area_cod,usu_cod,doc_estado,doc_tipo) VALUES
(iddocumento,asunto,idtipodocu,idarea,idusuario,'PENDIENTE',opcion);
IF opcion = 'C' THEN
INSERT INTO detalle_ciudadano (ciudadano_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
IF opcion = 'I' THEN
INSERT INTO detalle_institucion(institucion_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARDOCUMENTOARCHIVO` (IN `iddocumento` CHAR(13), IN `asunto` VARCHAR(150), IN `idtipodocu` INT, IN `idarea` INT, IN `idremitente` INT, IN `idusuario` INT, IN `opcion` VARCHAR(10), IN `archivo` VARCHAR(350), IN `cont` INT)  BEGIN
IF cont = 0 THEN
	INSERT INTO documento (documento_cod,doc_asunto,tipoDocumento_cod,area_cod,usu_cod,doc_estado,doc_tipo) VALUES
(iddocumento,asunto,idtipodocu,idarea,idusuario,'EN PROCESO',opcion);
END IF;
IF cont = 1 THEN
	INSERT INTO documento (documento_cod,doc_asunto,tipoDocumento_cod,area_cod,usu_cod,doc_estado,doc_tipo,doc_documento) VALUES
(iddocumento,asunto,idtipodocu,idarea,idusuario,'EN PROCESO',opcion,archivo);
END IF;
IF opcion = 'C' THEN
		INSERT INTO detalle_ciudadano (ciudadano_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
IF opcion = 'I' THEN
		INSERT INTO detalle_institucion(institucion_cod,documento_cod) VALUES (idremitente,iddocumento);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARINSTITUCION` (IN `institucion` VARCHAR(150), IN `tipo` VARCHAR(50))  BEGIN
INSERT INTO institucion(inst_nombre,inst_tipoinstitucion,inst_estado) VALUES(institucion,tipo,'ACTIVO');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARPERSONAL` (IN `nombre` VARCHAR(100), IN `apePat` VARCHAR(50), IN `apeMat` VARCHAR(50), IN `telefo` CHAR(9), IN `movil` CHAR(9), IN `direcc` VARCHAR(250), IN `fecnac` DATE, IN `dni` CHAR(8), IN `email` VARCHAR(30), IN `genero` CHAR(1), IN `usuario` VARCHAR(50), IN `clave` VARCHAR(50), IN `tipousario` INT, IN `puesto` VARCHAR(30))  BEGIN
INSERT INTO usuario (usu_nombre,usu_clave,usu_estado,cod_tipousuario,usu_foto) VALUES(usuario,clave,'ACTIVO',tipousario,'Fotos/admin.png');
INSERT INTO personal(pers_nombres,pers_apellidoPate,pers_apellidoMate,pers_dni,pers_sexo,pers_fechaNacimiento,pers_direccion,pers_telefono,pers_movil,pers_email,pers_estado,usuario_cod,pers_puesto) VALUES
(nombre,apePat,apeMat,dni,genero,fecnac,direcc,telefo,movil,email,'ACTIVO',(SELECT MAX(cod_usuario) from usuario),puesto);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_REGISTRARTIPODOCUMENTO` (IN `NOMBRE` VARCHAR(250))  BEGIN
INSERT INTO tipo_documento (tipodo_descripcion,tipodo_estado) VALUES (NOMBRE,"ACTIVO");
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_VERIFICARUSUARIO` (IN `_usu` VARCHAR(30), IN `_pass` VARCHAR(30))  SELECT
usuario.usu_nombre,
usuario.usu_clave,
CONCAT_WS(' ',personal.pers_nombres,personal.pers_apellidoPate,personal.pers_apellidoMate),
tipo_usuario.cod_tipousuario,
usuario.usu_foto,
personal.personal_cod,
tipo_usuario.tipusu_descripcion,
usuario.cod_usuario
FROM
personal
INNER JOIN usuario ON personal.usuario_cod = usuario.cod_usuario
INNER JOIN tipo_usuario ON usuario.cod_tipousuario = tipo_usuario.cod_tipousuario
WHERE usuario.usu_nombre = _usu AND usuario.usu_clave = _pass$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `area_cod` int(11) NOT NULL COMMENT 'Codigo auto-incrementado del movimiento del area',
  `area_nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'nombre del area',
  `area_fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'fecha del registro del movimiento',
  `area_estado` enum('ACTIVO','INACTIVO') COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del area'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Entidad Area';

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`area_cod`, `area_nombre`, `area_fecha_registro`, `area_estado`) VALUES
(1, 'CENTRIFUGADO', '2018-11-21 07:54:25', 'ACTIVO'),
(2, 'GALVANIZADO', '2018-11-21 08:41:19', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudadano`
--

CREATE TABLE `ciudadano` (
  `ciudadano_cod` int(11) NOT NULL,
  `ciud_nombres` varchar(100) NOT NULL,
  `ciud_dni` varchar(15) NOT NULL,
  `ciud_sexo` varchar(30) NOT NULL,
  `ciud_fechaNacimiento` date NOT NULL,
  `ciud_direccion` varchar(250) NOT NULL,
  `ciud_telefono` char(10) NOT NULL,
  `ciud_movil` char(10) NOT NULL,
  `ciud_email` varchar(80) NOT NULL,
  `ciud_fecharegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `ciud_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  `ciud_tipo` enum('NATURAL','JURIDICA') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ciudadano`
--

INSERT INTO `ciudadano` (`ciudadano_cod`, `ciud_nombres`, `ciud_dni`, `ciud_sexo`, `ciud_fechaNacimiento`, `ciud_direccion`, `ciud_telefono`, `ciud_movil`, `ciud_email`, `ciud_fecharegistro`, `ciud_estado`, `ciud_tipo`) VALUES
(36, 'DE LA ROSA PACHECO JOSE                                     ', '5049218', '', '0000-00-00', 'CARRERA 6  37 21                                                                                    ', '3114226198', '', 'josedavid393@hotmail.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(40, 'AGUADO RAMOS HONORATO FELIPE                                ', '8719609', '', '0000-00-00', 'CR 8 38 20                                                                                          ', '7814997', '0', 'abrafelh@yahoo.es                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(41, 'PINTO VILLALOBOS JOSE DE JESUS                              ', '10943043', '', '0000-00-00', 'CALLE 98B  6C 67 BARRIO LA CORDIALIDAD                                                              ', '3014724644', '', 'josepintovillalobos@gmail.com                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(42, 'PAVA AGUDELO YONIS                                          ', '19752635', '', '0000-00-00', 'CR 12D 69 42                                                                                        ', '3104613932', '', 'JHONNYSPABA@YAHOO.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(43, 'DAVID MARTINEZ LOURDES MARIA                                ', '32746592', '', '0000-00-00', 'CR 24 37 16                                                                                         ', '3230174', '', 'GERENCIA@MAZURCA.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(44, 'BEDOYA OVIEDO MARTHA CECILIA                                ', '32890021', '', '0000-00-00', 'CL 45 G 1 E 296 BL 166 AP 101                                                                       ', '3004494303', '', 'bedoyamartha1026@gmail.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(45, 'DE LA HOZ HERNANDEZ HORACIO                                 ', '72013716', '', '0000-00-00', 'CALLE 36 B No 17 - 48                                                                               ', '6053623550', '', 'horacio.express@gmail.com                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(46, 'HARRIS OSORIO ALBERTO LUIS                                  ', '72127207', '', '0000-00-00', 'CL 48 23 17                                                                                         ', '3467980', '', 'betoharris72@hotmail.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(47, 'ANGARITA RUEDA LUIS ALFREDO                                 ', '72136862', '', '0000-00-00', 'CL 87 50 50                                                                                         ', '3574454', '', 'MIHERMANITO2@HOTMAIL.COM                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(48, 'ELIECER AREVALO EBRATT                                      ', '72436442', '', '0000-00-00', 'CRA 35 No 30 - 75                                                                                   ', '3122178111', '', 'eliecer-arevalo@hotmail.com                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(49, 'BORRERO GOMEZ JORGE ENRIQUE                                 ', '79132017', '', '0000-00-00', 'CR 38 127 165                                                                                       ', '3560482', '', 'METALICASBORRERO@HOTMAIL.COM                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(50, 'SEPULVEDA CAMPUZANO JOSE WERNELIO                           ', '94502491', '', '0000-00-00', 'CLL 90 27D 116                                    1                                                 ', '4222657', '310554076', 'estrucmetalicas_js@hotmail.com                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'NATURAL'),
(51, 'METALTECO S.A.S.                                            ', '800042867', '', '0000-00-00', 'KM 6 VIA GIRON                                                                                      ', '6469411', '', 'DIAZ@METALTECO.COM                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(52, 'NEUMATICA DEL CARIBE S.A.                                   ', '800062591', '', '0000-00-00', 'VIA 40 73 06                                                                                        ', '3362100', '', 'FACTURACION@NEUCARIBE.COM                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(53, 'MEGA INGENIERIA S.A.                                        ', '800077014', '', '0000-00-00', 'AV 3D 43N-12                                                                                        ', '6650909', '', 'ccomercial@assemtec.co                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(54, 'CIVALCO S.A.S.                                              ', '800078300', '', '0000-00-00', 'CR 17 No 36 38                                                                                      ', '2853857', '317403507', 'cartagena@civalco.co                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(55, 'INACAR S.A.                                                 ', '800086042', '', '0000-00-00', 'CL 94 A 11 A 73 P 6                                                                                 ', '6236698', '', 'NRAMIREZ@INACAR.COM                                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(56, 'ARQUITECTURA Y CONCRETO S.A.S                               ', '800093117', '', '0000-00-00', 'CLL  3 SUR 43 A 52 OF 1801                                                                          ', '3123618', '', 'recepcionfacturacion@arquitecturayconcreto.com                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(57, 'COOPERATIVA DE TECNICOS DEL COLOMBO ALEMAN                  ', '800124015', '', '0000-00-00', 'CRA 10 SUR CLLE 4A  67                                                                              ', '3707719', '', 'COOPETECA@GMAIL.COM                                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(58, 'AUTONORTE S.A.S.                                            ', '800165694', '', '0000-00-00', 'CALLE 110 43 C 91                                                                                   ', '3670100', '', 'administrativo@autonorte.com.co                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(59, 'METAL - PREST S.A.S.                                        ', '800171244', '', '0000-00-00', 'BRR BOSQUE TV .54N 28 100                                                                           ', '6673777', '', 'compras@metalprest.com.co                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(60, 'ESTAHL INGENIERIA SOCIEDAD POR ACCIONES SIMPLIFICADAS       ', '800186250', '', '0000-00-00', 'KM 2 VIA FUNA SIBERIA                                                                               ', '8219140', '', 'administra@estahl.com.co                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(61, 'IMERC LTDA INGENIERIA METALMECANICA DE REFRIGERACION Y CIVIL', '800192185', '', '0000-00-00', 'BRR STA CLARA MZ K LT 4                                                                             ', '6770040', '', 'recursoshumanos@imercltda.com                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(62, 'CONSTRUCCIONES METALICAS DEL CARIBE S.A.S                   ', '800197527', '', '0000-00-00', 'CR BAYUNCA K  16 CARR LA CORDIALIDAD                                                                ', '6295203', '', 'FINANCIERA@COMECARIBE.COM                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(63, 'CONSTRUCTORA LANDA S A S                                    ', '800206723', '', '0000-00-00', 'CR 46 94 36 BRR LA CASTELLANA                                                                       ', '7442360', '', 'contadorlanda@landa.com.co                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(64, 'RESTREPO CHEBAIR CONSTRUCTORES ASOCIADOS S.A.S              ', '800208210', '', '0000-00-00', 'CR 7 No 127 - 28 OFC 701                                                                            ', '6476900', '0', 'CONTACTO@RCHCONSTRUCTORES.COM                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(65, 'ASESORIAS FABRICACION INGENIERIA ALFERING S.A.S.            ', '800210569', '', '0000-00-00', 'CR 20 52 161 VIA TRONCAL DEL CARIBE                                                                 ', '4305444', '', 'compras@alfering.com                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(66, 'CENTRO ACEROS DEL CARIBE LTDA                               ', '800221591', '', '0000-00-00', 'CL 31  28 62                                                                                        ', '3703260', '', 'GERENCIA@CENTROACEROSDELCARIBE.COM                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(67, 'GRES CARIBE S.A.                                            ', '800228676', '', '0000-00-00', 'KM 7VIA JUAN MINA                                                                                   ', '3608153', '', 'contabilidad@grescaribe.com                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(68, 'FERRETERIA IGNACIO SIERRA SUCESORES S.A.S.                  ', '800231751', '', '0000-00-00', 'BRR BOSQUE CL LA GIRALDA TV 53 53 16                                                                ', '6742533', '', 'gerencia2@fissas.com                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(69, 'MEGA INGENIERIA SAS                                         ', '800236763', '', '0000-00-00', 'CRA 53B 46 28                                                                                       ', '3793121', '', 'MEGAINGLTDA@TELECOM.COM.CO                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(70, 'DIMECAR S.A.S. INGENIEROS ASOCIADOS                         ', '800253103', '', '0000-00-00', 'URB BELLAVISTA CR 57B 5A 101                                                                        ', '6769349', '', 'GERENCIA@DIMECAR.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(71, 'JACUR S.A.S                                                 ', '802000666', '', '0000-00-00', 'CR 59 64 125                                                                                        ', '3682818', '', 'PROVEEDORES@GRUPOJACUR.COM                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(72, 'CONSTRUTEL S. A.                                            ', '802000969', '', '0000-00-00', 'CL 93 B 13 92 OF 405                                                                                ', '7123567', '', 'contabilidad@construtel.com.co                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(73, 'SUPERBRIX S.A.                                              ', '802000989', '', '0000-00-00', 'CR 2 CLLE 5A MZ 14 BOD 188 ZF ZOFIA                                                                 ', '3799641', '', 'ABASTECIMIENTO@SUPERBRIX.COM                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(74, 'SEMAPI LTDA                                                 ', '802001065', '', '0000-00-00', 'VIA 40  82  39                                                                                      ', '3788848', '', 'gerenteservicios@semapicolombia.com                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(75, 'DUNAR METALMECANICA S.A.S.                                  ', '802002152', '', '0000-00-00', 'VIA 40 No 85 - 470 BG 3 B                                                                           ', '3773253', '', 'dunar@dunar.info                                                                ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(76, 'GRUAS MANIOBRAS Y MONTAJES SAS                              ', '802003363', '', '0000-00-00', 'VIA 40 53 57                                                                                        ', '3744849', '', 'JGONGORA1982@HOTMAIL.COM                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(77, 'HERRAJES ANDINA S.A.S.                                      ', '802003931', '', '0000-00-00', 'CR 53 42 08                                                                                         ', '3490864', '', 'compras@herrajesandina.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(78, 'INGENIERIA CANAC S.A.S                                      ', '802004619', '', '0000-00-00', 'CRA 6  92 03 VIA LA CORDIALIDAD                                                                     ', '6053288028', '', 'contabilidad@canac.com.co                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(79, 'MIGUEL GAMERO S.A.S.                                        ', '802008417', '', '0000-00-00', 'CL 75 70 11 P2                                                                                      ', '3607844', '', 'MIGUELGAMEROBARRIOS@HOTMAIL.COM                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(81, 'QUARK UP S.A.S                                              ', '802008760', '', '0000-00-00', 'CRA 64 86 189 BRR ANDALUCIA                                                                         ', '3730293', '', 'FACTURACIONELECTRONICA@QUARKUP.COM.CO                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(82, 'ACERO & MALLAS S A S                                        ', '802009629', '', '0000-00-00', 'CL 52 36 47                                                                                         ', '350042', '', 'gerencia@aceromallas.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(83, 'PROYMETAL S.A.                                              ', '802011046', '', '0000-00-00', 'CRA 38 123 3017 KM 4 VIA JUAN MINA                                                                  ', '3445748', '', 'compras@proymetal.com.co                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(84, 'FC LIMITADA 2                                               ', '802012115', '', '0000-00-00', 'CR 25 13 A 42 BRR SALCEDO                                                                           ', '3427462', '', 'gerencia@fclimitada2.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(85, 'DOLMEN S.A. E.S.P.                                          ', '802012179', '', '0000-00-00', 'CR 64B 85 80                                                                                        ', '3185900', '', 'auxiliar.compras1@dolmen.co                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(86, 'SERVICIOS Y COMERCIALIZADORA EXPRESS Y COMPAÑÍA LIMITADA    ', '802014165', '', '0000-00-00', 'CALLE 19 No 8 - 07                                                                                  ', '3043959345', '', 'contabilidad@cvexpress.co                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(87, 'JASSIR SAIEH SAS                                            ', '802014704', '', '0000-00-00', 'CL 76 No 73 - 40 LC 3                                                                               ', '3093278', '', '802014704@factureinbox.co                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(88, 'ASTILLEROS UNIDOS S.A.                                      ', '802017093', '', '0000-00-00', 'VIA 40 CR 67 BG 10 50                                                                               ', '3607980', '', 'FACTURACION@AUSA.COM.CO                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(89, 'SEGURIDAD Y SERVICIOS SEÑALIZACION S. A.                    ', '802017424', '', '0000-00-00', 'CRA 33 53C 48                                                                                       ', '3705195', '', 'compras.sanjuan@seguridadyservicios.com                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(90, 'CONSTRUCCIONES CIVILES METALICAS MONTAJES Y MANTENIMIENTO IN', '802018039', '', '0000-00-00', 'CL 42 46 175 LC BRR ABAJO                                                                           ', '3553809', '', 'cmieu@hotmail.com                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(91, 'CENTRAL DE SERVICIOS E.U.                                   ', '802022022', '', '0000-00-00', 'CL 30 28 03 ESQ                                                                                     ', '3709660', '', 'CONTABILIDAD@CENTRALDESERVICIOSEU.COM                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(92, 'INTELPRO S.A.S                                              ', '802025044', '', '0000-00-00', 'CRA 45 62 42                                                                                        ', '3336547', '0', 'INFO@INTELPROSAS.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(93, 'M.R. INGENIEROS S.A.S.                                      ', '804004100', '', '0000-00-00', 'EDS TEXACO LAS OLAS LC 205 MAMONAL                 KM 6 DESPUES DEL PEAJE PARQUE AMERICAS           ', '3163801914', '0', 'facturacion@mringenieros.com                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(94, 'SERVICIOS INDUSTRIALES Y METALMECANICOS  SAS                ', '806005516', '', '0000-00-00', 'BOSQUE TV 54 25 53                                                                                  ', '6694756', '311 53113', 'SERIDME@GMAIL.COM                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(95, 'ROTOFIBRA LTDA                                              ', '806008091', '', '0000-00-00', 'CRA 56 12 87 CARR MAMONAL KM 1                                                                      ', '6670933', '314 39394', 'ROTOFIBRA@ROTOFIBRA.NET                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(96, 'CORPORACION DE CIENCIA Y TECNONOLOGIA PARA EL DESARROLLO DE ', '806008873', '', '0000-00-00', 'KM 9 VIA A MAMONAL                                                                                  ', '6685033', '7560077', 'lrojas@cotecmar.com                                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(97, 'INVERSIONES GUERRERO PUELLO & CIA  S. EN C.                 ', '806010810', '', '0000-00-00', 'CARRETERA LA CORDIALIDAD CRA 54 91 95                                                               ', '6610006', '2376104', 'facturas@moviconsa.com                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(98, 'TUVACOL S.A.                                                ', '806014553', '', '0000-00-00', 'VIA 40 3 67 240                                                                                     ', '3619797', '320836966', 'asisdespachosbq2@tuvacol.com                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(99, 'TUBOS Y METALES SAS                                         ', '806016321', '', '0000-00-00', 'BRR BOSQUE TV 54 23 35                                                                              ', '6695270', '0', 'GERENCIA@TUBOSYMETALES.COM                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(100, 'PAHT CONTRUCCIONES S.A.S                                    ', '811032022', '', '0000-00-00', 'CRA 59 C CALLE 50 - 42 INT 301                                                                      ', '4521154', '0', 'CONTABILIDAD@PAHT.COM.CO                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(101, 'ACUARIO Y MUSEO DEL MAR FOSPINA S.A.S                       ', '819005753', '', '0000-00-00', 'ED FUENTEMAR A- 3 SEC RODADERO                                                                      ', '4224905', '', 'acuariorodadero@gmail.com                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(102, 'ASOCIACION RADIO MARIA DE COLOMBIA                          ', '830017812', '', '0000-00-00', 'CR 21 A 151 23                                                                                      ', '7460067', '310777069', 'coordinator.col@radiomaria.org                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(103, 'INTERPESAJE S.A.                                            ', '830051764', '', '0000-00-00', 'AV EL DORADO 84A  55 L E 35                                                                         ', '5402222', '', 'mantenimiento@pesaje.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(104, 'DISEÑOS E INGENIERIA DE PROYECTOS LIMITADA                  ', '830504134', '', '0000-00-00', 'CL 42 46 146                                                                                        ', '3705020', '', 'DISELMECLTDA@HOTMAIL.COM                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(105, 'AGROPECUARIA SANTACRUZ LIMITADA                             ', '830505537', '', '0000-00-00', 'CL 4 2 21                                                                                           ', '3766701', '', 'FRIGORIFICOSANTACRUZ@HOTMAIL.COM                                                ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(106, 'INGENIERIA Y CONSTRUCCIONES A S LTDA                        ', '830506222', '', '0000-00-00', 'CL 51 9 D 116                                                                                       ', '3661554', '', 'arlessm1124@hotmail.com                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(107, 'TEAM FOODS COLOMBIA S.A.                                    ', '860000006', '', '0000-00-00', 'CL 45 A SUR 56 21                                                                                   ', '7709000', '', 'DAVILA@ALIANZATEAM.COM                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(108, 'HMV INGENIEROS LTDA                                         ', '860000656', '', '0000-00-00', 'CR 43 11A  80 POBLADO                                                                               ', '3766666', '', 'impuestoshmv@h-mv.com                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(109, 'CORPACERO S.A.S.                                            ', '860001899', '', '0000-00-00', 'VIA 40 76 188                                                                                       ', '4469100', '301368213', 'FACTURA.PROVEEDORES@CORPACERO.COM                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(110, 'IMOCOM S A S                                                ', '860003168', '', '0000-00-00', 'CL 17 50 24 BRR PUENTE ARANDA                                                                       ', '4137755', '312562037', 'notificacionlegal@imocom.com.co                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(111, 'METALICAS Y ELECTRICAS MELEC S.A. EN REORGANIZACION         ', '860026958', '', '0000-00-00', 'AUT MEDELLIN 3.5 CENTRO EMP. METROP BG 44 MOD 4   1                                                 ', '8764343', '', 'MELEC@MELEC.COM.CO                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(112, 'PERALTA PERFILERIA S.A.S                                    ', '860513360', '', '0000-00-00', 'CR 15 100 21 OF 303                                                                                 ', '3905397', '', 'contador@peraltaperfileria.com                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(113, 'CAMAGUEY S.A.                                               ', '890100026', '', '0000-00-00', 'CLL 15 CR 19 ESQ GALAPA                                                                             ', '3717000', '', 'facturacion.electronica@camaguey.com.co                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(114, 'IMPUCHE S.A.S                                               ', '890100814', '', '0000-00-00', 'CL 10 32 137 CRT CORDIALIDAD GALAPA                                                                 ', '3770070', '', 'recepcionfacturasproveedor@impuche.com                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(115, 'PFV & COMPAÑIA LIMITADA                                     ', '890101130', '', '0000-00-00', 'CRA 45 No 53 - 75                                                                                   ', '3146410342', '', 'contable@pfv.com.co                                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(116, 'GELCO S.A.S.                                                ', '890101692', '', '0000-00-00', 'CR 42 2 100                                                                                         ', '3446444', '', 'GVERGARA@GELCO-S-A-.COM                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(117, 'CASA DE LA VALVULA S.A.                                     ', '890106278', '', '0000-00-00', 'VIA 40 71 299                                                                                       ', '3197373', '', 'CONTABILIDADBQ1@CASAVAL.NET                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(118, 'RODOLFO STECKERL SUCESORES & COMPAÑIA LIMITADA              ', '890107069', '', '0000-00-00', 'VIA 40 85 470 OF 12                                                                                 ', '3551818', '', 'subgerencia@rodolfosteckerl.org                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(119, 'A MENENDEZ Y CIA LTDA                                       ', '890107388', '', '0000-00-00', 'CR 82 111 890 ZN PROLONGACION VIA 40                                                                ', '3106653069', '', 'gmorales@amenendez.com                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(120, 'CENTRO INDUSTRIAL MECANICO CIMEC SAS                        ', '890112276', '', '0000-00-00', 'CL 41 46 52                                                                                         ', '6053402999', '', 'administracion@cimecltda.com.co                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(121, 'TECNO FUEGO S.A.S.                                          ', '890114157', '', '0000-00-00', 'CRA 9G 110 187 BOG 82 PQ IND CARIBE VERDE                                                           ', '3790444', '', 'DALVAREZ@TECNO-FUEGO.COM.CO                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(122, 'A CONSTRUIR SA                                              ', '890115406', '', '0000-00-00', 'CL 77 B 59 61 OF 203                                                                                ', '3195527', '', 'FACTURAS@ACONSTRUIR.CO                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(123, 'GARCIA VEGA S.A.S                                           ', '890211614', '', '0000-00-00', 'CRA 15 23 15                                                                                        ', '6303303', '', 'martha.duarte@garciavega.co                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(124, 'FERROCEM - ALQUIMAR S. A. S.                                ', '890401842', '', '0000-00-00', 'ALBORNOZ  KM 3 VIA MAMONAL  CARTAGENA                                                               ', '6685726', '', 'compras@ferroalquimar.com                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(126, 'INDUSTRIAS DEL HIERRO S.A.S                                 ', '890940621', '', '0000-00-00', 'VEREDA PORTACHUELO PQ IND LOS BUCAROS             1                                                 ', '4445702', '0', 'INHIERRO@INHIERRO.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(129, 'REMEC S.A.S                                                 ', '891000156', '', '0000-00-00', 'CL 41 1 152                                                                                         ', '7823602', '0', 'GERENCIAGENERAL@REMEC.COM.CO                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(130, 'INVERSIONES MARINA TURISTICA SA                             ', '900025233', '', '0000-00-00', 'CRA 1 CLL 223 ESQ                                                                                   ', '3156253594', '0', 'MGAITAN@MARINASANTAMARTA.COM.CO                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(131, 'INGENIERIA Y MECANIZADOS DE LA COSTA LIMITADA               ', '900049717', '', '0000-00-00', 'CALLE 37 12A  29 MANUELA BELTRAN                                                                    ', '3458885', '', 'imcdelacostaltda@yahoo.com.ar                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(132, 'ILK INGENIERIA SOCIEDAD POR ACCIONES SIMPLIFICADA - ILK INGE', '900089212', '', '0000-00-00', 'BR BELLAVISTA CL 6 56A 57                                                                           ', '3174380075', '315313693', 'logistica1@ilkingenieria.com                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(133, 'SMART STEEL S.A.S.                                          ', '900115708', '', '0000-00-00', 'KM 4 VIA GALAPA PARQUE INDUSTRIAL LT 57                                                             ', '3852837', '', 'FACTURACION@SMARTSTEEL.COM.CO                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(134, 'ICF INVERSIONES CON FUTURO S.A.S.                           ', '900135270', '', '0000-00-00', 'CR 59 75 109                                                                                        ', '3587202', '', 'jura.icf@gmail.com                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(135, 'DINACOL S.A.S                                               ', '900138369', '', '0000-00-00', 'CEBALLOS DIAGONAL 30 54 124                                                                         ', '6673001', '0', 'ARODRIGUEZ@DINACOLSA.COM                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(136, 'ASSEMTEC SAS                                                ', '900140188', '', '0000-00-00', 'BRR BOSQUE CL LAS ACACIAS TRV 51 19 158                                                             ', '6694944', '0', 'LUISE_ORDONEZ@YAHOO.COM                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(137, 'CERCAR ENERGY S.A.S.                                        ', '900144159', '', '0000-00-00', 'CLLE 77B 57 103 OF 304                                                                              ', '3684301', '0', 'AALMAZA@GRUPOCERCAR.COM                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(138, 'BBC INGENIEROS S.A.S                                        ', '900148675', '', '0000-00-00', 'CR 128 14 95                                                                                        ', '4217975', '0', 'administrativo2@bbcingenieros.com.co                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(139, 'INGENIERIA SERVICIOS PROYECTOS DE COLOMBIA LTDA             ', '900181815', '', '0000-00-00', 'CALLE 55 28 25 APTO 901 EDIFICIO OPUS                                                               ', '6799802', '0', 'ISERPRO@ISERPRO.COM                                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(140, 'IMEIM LTDA  EN REORGANIZACION EMPRESARIAL                   ', '900189239', '', '0000-00-00', 'CL 6 56 B 57 BRR BELLAVISTA                                                                         ', '6451514', '0', 'FMONTES@IMEIMLTDA.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(141, 'SERVICIOS INTEGRADOS OUTSOURCING S.A.S                      ', '900214748', '', '0000-00-00', 'CR 5 136 ESQ BRR BELLO HORIZONTE                                                                    ', '4380422', '0', 'YUDIS.FONTALVO@SERVICIOSINTEGRADOS.COM                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(142, 'ESTRUCTURAS Y MONTAJES DE COLOMBIA                          ', '900237590', '', '0000-00-00', 'DG 21 49 121 LC 1                                                                                   ', '6604656', '0', 'facturacion@emdecol.com                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(143, 'MECAFABRICACIONES E.U.                                      ', '900239710', '', '0000-00-00', 'CL 21 26 188                                                                                        ', '3749967', '0', 'MECAFABRICACIONES@YAHOO.COM                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(144, 'STEELWORK SAS                                               ', '900240176', '', '0000-00-00', 'CRA 32 10 99                                                                                        ', '9087505', '318209635', 'INFO@STEELWORK.COM.CO                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(145, 'DISEÑOS Y ACABADOS DEL NORTE S.A.S                          ', '900277109', '', '0000-00-00', 'CL 53C 24 50                                                                                        ', '3701510', '0', 'lestervidal@disanorteltda.com                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(146, 'SICMECI S.A.S                                               ', '900293698', '', '0000-00-00', 'AV CRISANTO LUQUE BRR BOSQUE DG 22 51 75                                                            ', '6604338', '0', 'UBALDO.HERNANDEZ@SICMECI.COM                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(147, 'CVC SAS                                                     ', '900318263', '', '0000-00-00', 'TV 54 21 A 120 OF 809                                                                               ', '6746175', '0', 'anamariamendoza@coveco.com.co                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(148, 'WB INGENIERIA DE PROYECTOS S.A.S                            ', '900340610', '', '0000-00-00', 'CR 53 46 49                                                                                         ', '3443512', '0', 'GERENCIA@WBINGENIERIA.CO                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(149, 'SUZ ESTRUCTURAS SAS                                         ', '900349185', '', '0000-00-00', 'CR 48 72 25 ED FLAGER OF 406                                                                        ', '3567634', '0', 'suzzestructurassas@gmail.com                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(150, 'INDUSTRIAS VIMAR S.A.S                                      ', '900351208', '', '0000-00-00', 'CL 37 46 112                                                                                        ', '3043891681', '0', 'INDUSTRIA_VIMAR@HOTMAIL.COM                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(151, 'DEO GRATIAS S.A.S.                                          ', '900354803', '', '0000-00-00', 'BRR POLICARPA CR 67 No 75 09                                                                        ', '6796383', '0', 'deofacturaciones@gmail.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(152, 'METALINDUSTRIAL H&H LTDA                                    ', '900355555', '', '0000-00-00', 'CL 43 43 156                                                                                        ', '3791258', '0', 'HYHLTDA@YAHOO.COM                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(153, 'ENGIMET S.A.S.                                              ', '900367564', '', '0000-00-00', 'CR 73 82 150                                                                                        ', '3023117', '310763175', 'ENGIMET@GMAIL.COM                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(154, 'BOCCARD PIPING COLOMBIA S.A.S.                              ', '900376521', '', '0000-00-00', 'CARRETERA LA CORDIALIDAD KM 18                                                                      ', '6341500', '0', 'ahernandez@boccard.com                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(155, 'SMART CHOICE TECHNOLOGIES LATINOAMERICA S.A.S.              ', '900379809', '', '0000-00-00', 'AV CRISANTO LUQUE SEC EL OLIVO 52 28                                                                ', '6446792', '0', 'gcarvajal@smartchoicetec.com.co                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(156, 'INVERSIONES SERRANO MILLAN S.A.S.                           ', '900391505', '', '0000-00-00', 'KM 3 VIA ORIENTAL                                                                                   ', '3721488', '0', 'produccion@cfsantacruz.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(157, 'CONSTRUVALEL S.A.S                                          ', '900400732', '', '0000-00-00', 'CR 44 95 A 57 CA 15                                                                                 ', '3157228050', '', 'elforzoli2@hotmail.com                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(158, 'ACERTEK S.A.S.                                              ', '900406436', '', '0000-00-00', 'CRA SECTOR AGUAS PRIETAS ZONA FRANCA PARQUE CENTRA                                                  ', '6424950', '311212266', 'KELLY.ORTIZ@ACERTEK.COM.CO                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(159, 'INGENIERIA ELECTRICA Y ELECTRONICA AVANZADA S.A.S           ', '900414329', '', '0000-00-00', 'CL 66 46 87 OF 05                                 1                                                 ', '3583524', '318427789', 'ADRIANAORTIZR@IEEA.COM.CO                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(160, 'INVERSIONES LUTOTANO S.A.S.                                 ', '900416173', '', '0000-00-00', 'CR 25 3 45 P 3                                                                                      ', '4480029', '315670134', 'manuela.villa@elcondor.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(161, 'PINTOMART FERRECONSTRUCCIONES S.A.S.                        ', '900417932', '', '0000-00-00', 'TV 27 111 30                                                                                        ', '3686165', '', 'FERRETERIAPINTOMART@HOTMAIL.COM3                                                ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(162, 'MEDIA ART S.A.S.                                            ', '900428735', '', '0000-00-00', 'CL 113 7 45 ED.TELEPORT BUSSINES TO B P 5 OF 511                                                    ', '7424122', '316 23718', 'facturacionelectronica@mediaart.com.co                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(163, 'SOLUCIONES MECANICAS SOMECA S.A.S                           ', '900429316', '', '0000-00-00', 'VIA AEROPUERTO KM 7                                                                                 ', '3126914743', '(1)286951', 'SOLUCIONESMECANICASSAS@GMAIL.COM                                                ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(164, 'CONSTRUCCIONES IN SITU S.A.S                                ', '900429500', '', '0000-00-00', 'TV 51 32 57 URB ANITA                                                                               ', '6430594', '310568617', 'oscar.maza@construccionesinsitu.co                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(165, 'DPS INGENIERIA  SAS                                         ', '900431698', '', '0000-00-00', 'CL 56 46 30                                                                                         ', '3044100', '', 'facturaelectronica@dpsingenieria.com                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(166, 'CLEAN GARDESN & GREENS SAS                                  ', '900448104', '', '0000-00-00', 'CALLE 99B 6 142                                                                                     ', '3286985', '', 'facturacion@cleangardensgreens.com                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(167, 'INSER EQUIPOS S.A.S                                         ', '900448239', '', '0000-00-00', 'PASACABALLOS CL 18 4 35                                                                             ', '3107062392', '', 'MARCO.GARCIA@INSERSAS.COM                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(168, 'TOTBUILDING BODEGAS INDUSTRIALES SAS                        ', '900452274', '', '0000-00-00', 'AV CIRCUNVALAR 10 427 BODEGA 3                                                                      ', '3106363533', '', 'totbuilding@yahoo.com                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(169, 'CONSTRUCCIONES EQUIPOS Y MONTAJES SOLUCIONES DE INGENIERIA S', '900467823', '', '0000-00-00', 'CR 13 A No. 5 A 20 BG 12                                                                            ', '8934962', '', 'GERENCIA.TECNICA@CEMSOLUCIONES.COM                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(170, 'ESCENARIOS DEPORTIVOS S.A.S.                                ', '900470679', '', '0000-00-00', 'CL 77 59 61 OF 904 ED LAS AMERICAS II                                                               ', '3177816', '', 'cesar@escenariosdeportivos.com                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(171, 'M & O INTEGRA S.A.S.                                        ', '900471119', '', '0000-00-00', 'CR 43 90 160 AP 101                                                                                 ', '3028440839', '(1)564306', 'contabilidad@mointegra.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(172, 'INGRESOS COMERCIALES S.A.S.                                 ', '900471147', '', '0000-00-00', 'CR 17B 68A 71                                                                                       ', '3148914739', '314385464', 'INGRECOMERFELECTRONICA@GMAIL.COM                                                ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(173, 'ENGINEERING CONSULTING AND CONSTRUCTION & COMPAÑIA LTDA     ', '900473861', '', '0000-00-00', 'CALLE 85 CRA 50 159 OF 516                                                                          ', '3185589601', '', 'FACTURACION@ECCLTDA.COM                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(174, 'PERFORMANCE CARIBE S.A.S.                                   ', '900490651', '', '0000-00-00', 'CRA 34 107 79 BG 3                                                                                  ', '3808421', '', 'PERFORMANCE.ZONANORTE@GMAIL.COM                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(175, 'COHERGOS S.A.S.                                             ', '900491379', '', '0000-00-00', 'CL 60B 16 51                                                                                        ', '3724714', '', 'erickgomez09@hotmail.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(176, 'ARCHITECTURE & ACERO SAS BIC                                ', '900505661', '', '0000-00-00', 'BRR CRESPO CR 8A 70 66                                                                              ', '6458807', '', 'administracion@arcero.com.co                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(177, 'SUPERTEK S.A.S.                                             ', '900506665', '', '0000-00-00', 'VIA AEROPUERTO KM 7                                                                                 ', '3435500', '(1)301889', 'ADMINISTRACION@SUPERTEK.COM.CO                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(178, 'DISEÑOS Y CONSTRUCCIONES J&E S.A.S.                         ', '900510963', '', '0000-00-00', 'CR 55 91 60                                                                                         ', '3008047146', '8661961', 'contabilidad@estructurasjye.com                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(179, 'MONTAJES Y MANTENIMIENTO MARRIAGA INGENIERIA SAS            ', '900511970', '', '0000-00-00', 'VIA 40 85 1495                                                                                      ', '3093066', '315 53849', 'E_MARRIAGA@HOTMAIL.COM                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(180, 'CSP DE COLOMBIA LTDA.                                       ', '900517378', '', '0000-00-00', 'KM 7 VARIANTE MALAMBO - CARACOLI                                                                    ', '3610441', '8052668', 'FacturacionElectronica@t360.com.co                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(181, 'GALVAMET INVERSIONES S A S                                  ', '900523538', '', '0000-00-00', 'CALLE 6 57 32  MAMONAL SECTOR BELLAVISTA                                                            ', '3174420379', '', 'AUX.CONTABLE@GALVAMETYOLTA.COM.CO                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(182, 'PETRO GAS DEL LLANO S.A.S.                                  ', '900533892', '', '0000-00-00', 'CARRERA 6 No 16 65 OFC 101                                                                          ', '3205216316', '', 'petrogasdelllanosas@hotmail.com                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(183, 'P&A PROYECTOS ARQUITECTONICOS S.A.S.                        ', '900534972', '', '0000-00-00', 'CL 21 9 65                                                                                          ', '3006338121', '310870159', 'parquitectonicos@hotmail.com                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(184, 'CONTRATISTA INDUSTRIAL DE SERVICIOS S.A.S                   ', '900547454', '', '0000-00-00', 'CR 83 107 204 P 2 BRR LAS FLORES                                                                    ', '3853536', '311495142', 'cissas.gerencia@gmail.com                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA');
INSERT INTO `ciudadano` (`ciudadano_cod`, `ciud_nombres`, `ciud_dni`, `ciud_sexo`, `ciud_fechaNacimiento`, `ciud_direccion`, `ciud_telefono`, `ciud_movil`, `ciud_email`, `ciud_fecharegistro`, `ciud_estado`, `ciud_tipo`) VALUES
(185, 'OBB SOLUCIONES ESTRUCTURALES S.A.S                          ', '900560256', '', '0000-00-00', 'CL 17 105 06                                                                                        ', '5415471', '312523317', 'CONTABILIDADOBB@GMAIL.COM                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(186, 'PRODUCCIONES RANDOM S.A.S.                                  ', '900581357', '', '0000-00-00', 'CL 40 No 26B 46 OFC 202                                                                             ', '3706349', '', 'produccionesrandomsas@gmail.com                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(187, 'ALEMAN CONSTRUCTORES S.A.S.                                 ', '900583541', '', '0000-00-00', 'CR 43 75 B 187 OF 35                                                                                ', '6053458760', '320300148', 'aconstructores01@gmail.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(188, 'CONSTRUCTORA DIMAC S.A.S                                    ', '900585336', '', '0000-00-00', 'BRR MEMBRILLAL CR  2 MZ Y19                                                                         ', '3116575481', '', 'admondimac@outlook.com                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(189, 'HC TANKOL SAS                                               ', '900604519', '', '0000-00-00', 'BRR MAMONAL CR 30 ASTILLERO 1 SEC TEJADILLO CORR P                                                  ', '3176373152', '311898801', 'ADMINISTRACION@HCTANKOL.COM                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(190, 'H.D.F. PROYECTOS Y SOLUCIONES S.A.S.                        ', '900613601', '', '0000-00-00', 'CR 46 52 54                                                                                         ', '3005468', '318254377', 'servicios@proyectoshdf.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(191, 'KANGUR S.A.S.                                               ', '900631158', '', '0000-00-00', 'CL 73 24 53 BRR BELLA VISTA                                                                         ', '3205413215', '321275116', 'CONTABILIDAD@KANGURGROUP.COM                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(192, 'SISTEMAS SOLUCIONES Y SUMINISTROS S.A.S                     ', '900640865', '', '0000-00-00', 'CRA 62 76 95 TO 9 APTO 401                                                                          ', '3107237821', '315332351', 'sissolsu@gmail.com                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(193, 'VALLAS Y MONTAJES SAS                                       ', '900643904', '', '0000-00-00', 'CRA 16 61 5                                                                                         ', '3095339', '320803340', 'edwin.bq@gmail.com                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(194, 'CONSMAG S.A.S                                               ', '900655777', '', '0000-00-00', 'BRR BELLA VISTA CR 57 6 38                                                                          ', '6768341', '310259954', 'CONSMAG2004@GMAIL.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(195, 'SUMINISTROS Y ASESORIAS INDUSTRIALES DE LA COSTA S.A.S.     ', '900670906', '', '0000-00-00', 'CL 92 71 A 90 OF 602 A                                                                              ', '3027977', '', 'gerencia@sumyind.com                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(196, 'MANTENIMIENTO INDUSTRIAL LICAS S.A.S.                       ', '900673133', '', '0000-00-00', 'CR 54 19 21                                                                                         ', '3754579', '', 'LICAS1@HOTMAIL.ES                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(197, 'LST INGENIERIA S.A.S                                        ', '900691999', '', '0000-00-00', 'BRR LOS ALPES CL 31 E 71 B 89 AP 107                                                                ', '3012347896', '320439153', 'gerencia@lstingenieria.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(198, 'SUMINISTROS Y SERVICIOS INTEGRALES DE COLOMBIA S.A.S.       ', '900699754', '', '0000-00-00', 'CR 22 75 C 11                                                                                       ', '3922104', '', 'suseincosas@gmail.com                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(199, 'ESCORCIA ORTEGA & CIA SCA                                   ', '900701052', '', '0000-00-00', 'CRA 43 No 87 - 103                                                                                  ', '3854334', '', 'a.e@aeingenieros.com                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(200, 'INGENIERÍA  CONSTRUCCIONES Y ESTRUCTURAS METÁLICAS S.A.S.   ', '900718227', '', '0000-00-00', 'CL 3 12 57 BRR PESCADITO                                                                            ', '4366382', '310764594', 'contabilidad@incometalicas.com                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(201, 'INGSERMAP S.A.S.                                            ', '900730770', '', '0000-00-00', 'CALLE 74 3E 06                                                                                      ', '3657694', '', 'GERENCIA@INGSERMAT.COM.CO                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(202, 'INPRO INGENIERIA INTEGRAL DE PROYECTOS S.A.S                ', '900735728', '', '0000-00-00', 'CL 43 52 71                                       1                                                 ', '3013285779', '', 'administracion@inpro-ingenieria.com                                             ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(203, 'INGENDES SAS                                                ', '900751692', '', '0000-00-00', 'CALLE 16A CRA 28A 0 78                                                                              ', '3187077603', '304 57613', 'GERENCIA@INGENDES.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(204, 'HCL INGENIERIA S.A.S.                                       ', '900765398', '', '0000-00-00', 'CR 61 58 108                                                                                        ', '3014104798', '320488086', 'gerencia@hclingenieria.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(205, 'SISTEMA DE CABLE VIA Y METALICAS S.A.S.                     ', '900772907', '', '0000-00-00', 'DIAGONAL 38A 5 66 CASA 9 ALTOS DE MAMATOCO                                                          ', '3114312944', '320 34747', 'CABLEVIAYMETALICAS@OUTLOOK.COM                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(206, 'A GROUP SAS                                                 ', '900773149', '', '0000-00-00', 'AK 9 103 A 36 OF 404                                                                                ', '4674891', '315811096', 'PAULA.D@AGROUPSAS.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(207, 'TALLERES INDUSTRIALES LOS BLANCOS S.A.S.                    ', '900775451', '', '0000-00-00', 'ZF CAYENA KM 8 LT 15 MNZ E                                                                          ', '3188041848', '321282071', 'compras@losblancoscm.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(208, 'WBS CONSTRUCCIONES SAS                                      ', '900787031', '', '0000-00-00', 'CALLE 113 30 04 ESQUINA                                                                             ', '3157310201', '', 'GERENCIA@WBSCONSTRUCCIONES.COM                                                  ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(209, 'METCON COLOMBIA S.A.S.                                      ', '900798155', '', '0000-00-00', 'CALLE 15 CRA 26A 50 BODEGA 5                                                                        ', '3204089', '304417827', 'CONTABILIDAD@METCONCOLOMBIA.COM                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(210, 'TALLER INDUSTRIAL SIERRA S.A.S.                             ', '900809422', '', '0000-00-00', 'BRR SAN FERNANDO CR 81 25 15                                                                        ', '6900258', '', 'sierrametalmecanica123@hotmail.com                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(211, 'SERVICIOS ELECTROMECANICOS E INGENIERIA S.A.S.              ', '900811737', '', '0000-00-00', 'CR 10 SUR 50 A 04                                                                                   ', '3668238', '', 'seingrb@gmail.com                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(212, 'INGENIERIA Y ARQUITECTURA METALICA SAS                      ', '900822244', '', '0000-00-00', 'CRR 57 75 130 AP 304                                                                                ', '3042574', '', 'rng_juanortiz@yahoo.com                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(213, 'SOLAR PLUS SAS                                              ', '900823820', '', '0000-00-00', 'C L 98 51 B 80 P 6                                                                                  ', '3215386830', '', 'GERENCIA@SOLARPLUS.COM.CO                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(214, 'SOLDACONSTRUCCIONES TUYFA S.A.S                             ', '900830907', '', '0000-00-00', 'CR 14 69 69                                                                                         ', '3013661519', '', 's.construccionestuyfa@gmail.com                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(215, 'FORMACEROS S.A.S.                                           ', '900841815', '', '0000-00-00', 'CL 41 50 50                                                                                         ', '3013858991', '', 'auxiliar@formaceros.com                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(216, 'MAYCOTEC S.A.S.                                             ', '900853188', '', '0000-00-00', 'CR 35 No 76 35 P2                                                                                   ', '3008848', '', 'maycotecsas@gmail.com                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(217, 'SIMICS GROUP SAS                                            ', '900853554', '', '0000-00-00', 'CRA 53 96 24 OF 3D                                                                                  ', '7504911', '314490893', 'CARLOS.ECHEVERRY@simicsingenieria.com                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(218, 'S Y L CONSTRUCCIONES E INGENIERIA S.A.S.                    ', '900859501', '', '0000-00-00', 'CRA 1A 42 34 BRR SUCRE                                                                              ', '7852339', '', 'GERENCIA@SYLCOIN.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(219, 'SOLUCIONES METALMECANICAS OLFRE S.A.S.                      ', '900886321', '', '0000-00-00', 'CR 8 A SUR 42 37 BRR 20 JULIO 4 ET                                                                  ', '3208232513', '', 'solucionesmetalmecanicasolfre@gmail.com                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(220, 'INGENIERIA SUPERIOR S.A.S.                                  ', '900897594', '', '0000-00-00', 'CL 50 35 179                                                                                        ', '3227222055', '', 'ingenieriasuperiorsas@gmail.com                                                 ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(221, 'DISEÑOS ARQUITECTONICOS NOVEDOSOS DEL CARIBE S.A.S.         ', '900931361', '', '0000-00-00', 'DG 61 B TV 1D 15                                                                                    ', '3007632713', '301790902', 'd_arquinovedosos@outlook.es                                                     ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(222, 'BIABLE INGENIERIA Y SERVICIOS SAS                           ', '900938433', '', '0000-00-00', 'CALLE 105 14 A 65 MZ B BG 7 EC BARLOVENTO                                                           ', '3187828199', '', 'BIABLE.SAS@GMAIL.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(223, 'PORCICASTILLO G SAS                                         ', '900940037', '', '0000-00-00', 'CARR A PITAL DEL CARLIN KM 1 501                                                                    ', '3106676226', '312395512', 'porcicastillogsas@hotmail.com                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(224, 'RR MANTENIMIENTOS Y METALMECANICA DE LA COSTA S.A.S.        ', '900940473', '', '0000-00-00', 'CR 5 S 48 B 92                                                                                      ', '3002454813', '33', 'facturacion@ryrmantenimientos.com                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(225, 'CONSUFLIX S.A.S                                             ', '900958976', '', '0000-00-00', 'CRA 65 No 71 - 77 OFC. 208                                                                          ', '3155955366', '320853059', 'info@susternergy.com.co                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(226, 'METALMECANICA PROMOAMBIENTAL SAS                            ', '900974517', '', '0000-00-00', 'BRR EL BOSQUE TV 54 27 126                        1                                                 ', '6455220', '', 'contabilidad@metalprom.cO                                                       ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(227, 'ENVOLVENTES Y PAQUETIZADOS MILEM S.A.S BIC                  ', '900975258', '', '0000-00-00', 'CRA 27 106 70                                                                                       ', '3013955528', '320368135', 'eypmilem@redsolvers.com                                                         ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(228, 'CONSORCIO DESARROLLO ESCOLAR                                ', '900980711', '', '0000-00-00', 'CRA 2 11 41                                       1                                                 ', '3222103442', '317434067', 'CONHEMUR@HOTMAIL.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(229, 'FRIGORIFICO DEL MAGDALENA MEDIO S.A.S.                      ', '900994578', '', '0000-00-00', 'CALLE 64 36 B 161 BRR ESPERANZA                                                                     ', '6024951', '300272032', 'FACTURAELECTRONICA@FRIGOMAG.COM.CO                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(230, 'SOLFICAR SOLUCIONES SAS                                     ', '901003976', '', '0000-00-00', 'CR 38 113 31                                                                                        ', '3820862', '', 'solficar@hotmail.com                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(231, 'CARIBBEAN YARD SAS                                          ', '901015370', '', '0000-00-00', 'CL 104 51B 154 CA 52                                                                                ', '3123181212', '319641621', 'GAMMIVII@GMAIL.COM                                                              ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(232, 'GRUPO EMPRESARIAL NAPE S.A.S                                ', '901016777', '', '0000-00-00', 'CRA 71 No 80 - 57                                                                                   ', '3106355575', '316526362', 'genpsas@gmail.com                                                               ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(233, 'AGROJEQUIP S.A.S.                                           ', '901017948', '', '0000-00-00', 'CR 51 #84 - 184 AP 1104C                                                                            ', '3135455267', '', 'facturacion@agrojequip.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(234, 'INGENIERIA EN GALVANIZADOS DE OCCIDENTE SAS                 ', '901020151', '', '0000-00-00', 'CR 31 10 301 ARROYOHONDO                                                                            ', '3872566', '', 'gerencia@ingaldeoccidente.com                                                   ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(235, 'JCM ESTRUCTURAS & MONTAJES S.A.S.                           ', '901022363', '', '0000-00-00', 'BRR TRECE DE JUNIO CR 63 31 B 62                                                                    ', '3126184694', '322397909', 'jc_martelo47@hotmail.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(236, 'SERVIQUIN S.A.S.                                            ', '901028460', '', '0000-00-00', 'BRR BOSQUE AV BOSQUE TV 54 27 91                  1                                                 ', '6695137', '320516490', 'servicortes@une.net.co                                                          ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(237, 'ESCALA CONSTRUCTORA DHZ SAS                                 ', '901039450', '', '0000-00-00', 'CL 37 23 67                                                                                         ', '3148741700', '', 'contabilidad@escaladhz.com                                                      ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(238, 'MECANICOS DE LA COSTA S.A.S.                                ', '901068348', '', '0000-00-00', 'BRR TORICES SEC SAN PEDRO Y LIBERTAD CR 17 55 13                                                    ', '3116510182', '', 'nelson-v2009@hotmail.com                                                        ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(239, 'SOLUCIONES EN INGENIERIA Y SOLDADURA LTDA                   ', '901069246', '', '0000-00-00', 'CR 45 69 73 AP 22 A                                                                                 ', '3106422205', '322833153', 'SOLIWELLTDA@GMAIL.COM                                                           ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(240, 'SERVICIO INTEGRAL DE CONSTRUCCIÓN Y PROPIEDAD HORIZONTAL SAS', '901081983', '', '0000-00-00', 'CL 76 56 29 A P 1504                                                                                ', '317377527', '310563535', 'CONTABILIDADSICOPH@GMAIL.COM                                                    ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(241, 'METALMECANICA BELTRAN SAS                                   ', '901082181', '', '0000-00-00', 'CLLE 51 13B1 34                                                                                     ', '3729468', '', 'ADAN2503@HOTMAIL.COM                                                            ', '0000-00-00 00:00:00', 'ACTIVO', 'JURIDICA'),
(242, 'STEPUP ANDAMIOS MANUFACTURING S.A.S ', '901558844', '', '2024-03-04', 'KM 8 VIA TUBARA-BARRANQUILLA, ZONA FR', '', '11', 'stepup@gmail.com', '2024-03-04 20:35:24', 'ACTIVO', 'JURIDICA'),
(243, 'MAKING INDUSTRY S.A.S                ', '901486868', '', '2024-03-05', 'CL 42 51 10 BG 1 ', '605401038', '', 'INFO@MAKING-ENG.COM', '2024-03-05 21:29:19', 'ACTIVO', 'NATURAL');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ciudadano`
--

CREATE TABLE `detalle_ciudadano` (
  `detalleciudadano_cod` int(11) NOT NULL,
  `ciudadano_cod` int(11) NOT NULL,
  `documento_cod` char(13) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ciudadano`
--

INSERT INTO `detalle_ciudadano` (`detalleciudadano_cod`, `ciudadano_cod`, `documento_cod`) VALUES
(45, 37, '000001'),
(46, 37, '000002'),
(47, 36, '000001'),
(48, 36, '000002'),
(49, 36, '000003'),
(50, 41, '000001'),
(51, 41, '000002'),
(52, 43, '000002'),
(53, 44, '000003'),
(54, 36, '000004'),
(55, 45, '000005'),
(56, 46, '000006'),
(57, 47, '000007'),
(58, 48, '000008'),
(59, 49, '000009'),
(60, 50, '000010'),
(61, 51, '000011'),
(62, 52, '000012'),
(63, 53, '000013'),
(64, 54, '000014'),
(65, 44, '000015'),
(66, 44, '000016'),
(67, 36, '000017'),
(68, 55, '000018'),
(69, 48, '000019'),
(70, 56, '000020'),
(71, 57, '000021'),
(73, 58, '000022'),
(74, 59, '000023'),
(75, 45, '000024'),
(76, 60, '000025'),
(77, 61, '000026'),
(78, 62, '000027'),
(79, 36, '000028'),
(80, 44, '000029'),
(81, 63, '000030'),
(82, 64, '000031'),
(84, 48, '000032'),
(85, 65, '000033'),
(86, 66, '000034'),
(87, 67, '000035'),
(88, 68, '000036'),
(89, 69, '000037'),
(90, 41, '000038'),
(91, 36, '000039'),
(92, 54, '000040'),
(93, 45, '000041'),
(94, 62, '000042'),
(95, 36, '000043'),
(96, 70, '000044'),
(97, 71, '000045'),
(98, 72, '000046'),
(99, 73, '000047'),
(100, 74, '000048'),
(101, 36, '000049'),
(102, 75, '000050'),
(105, 60, '000051'),
(106, 76, '000052'),
(107, 77, '000053'),
(108, 78, '000054'),
(109, 48, ''),
(113, 74, '000056'),
(114, 59, '000057'),
(115, 45, '000058'),
(116, 48, '000059'),
(117, 79, '000060'),
(118, 81, '000061'),
(119, 82, '000062'),
(120, 83, '000063'),
(123, 84, '000064'),
(124, 46, '000065'),
(125, 85, '000066'),
(126, 86, '000067'),
(127, 87, '000068'),
(128, 45, '000069'),
(129, 69, '000070'),
(130, 88, '000071'),
(131, 89, '000072'),
(132, 81, '000073'),
(133, 54, '000074'),
(134, 60, '000075'),
(135, 90, '000076'),
(136, 59, '000077'),
(137, 83, '000078'),
(138, 91, '000079'),
(139, 92, '000080'),
(140, 94, '000081'),
(143, 95, '000082'),
(144, 96, '000083'),
(145, 97, '000084'),
(146, 98, '000085'),
(147, 81, '000086'),
(148, 45, '000087'),
(149, 89, '000088'),
(150, 54, '000089'),
(151, 98, '000090'),
(152, 41, '000091'),
(153, 99, '000092'),
(154, 74, '000093'),
(155, 75, '000094'),
(156, 54, '000095'),
(157, 45, '000096'),
(158, 44, '000097'),
(159, 96, '000098'),
(160, 68, '000099'),
(161, 100, '000100'),
(162, 54, '000101'),
(163, 83, '000102'),
(164, 101, '000103'),
(165, 102, '000104'),
(166, 36, '000105'),
(167, 59, '000106'),
(168, 93, '000107'),
(169, 81, '000108'),
(170, 68, '000109'),
(171, 45, '000110'),
(172, 74, '000111'),
(173, 41, '000112'),
(174, 48, '000113'),
(175, 59, '000114'),
(176, 54, '000115'),
(177, 103, '000116'),
(178, 104, '000117'),
(179, 76, '000118'),
(180, 105, '000119'),
(181, 36, '000120'),
(182, 106, '000121'),
(183, 83, '000122'),
(184, 107, '000123'),
(185, 45, '000124'),
(186, 81, '000125'),
(188, 108, '000126'),
(189, 75, '000127'),
(190, 54, '000128'),
(191, 86, '000129'),
(192, 109, '000130'),
(193, 110, '000131'),
(194, 41, '000132'),
(195, 104, '000133'),
(196, 54, '000134'),
(197, 72, '000135'),
(198, 59, '000136'),
(199, 48, '000137'),
(200, 83, '000138'),
(201, 45, '000139'),
(202, 81, '000140'),
(203, 111, '000141'),
(204, 77, '000142'),
(205, 98, '000143'),
(206, 36, '000144'),
(207, 104, '000145'),
(208, 112, '000146'),
(209, 113, '000147'),
(210, 62, '000148'),
(211, 74, '000149'),
(212, 75, '000150'),
(213, 74, '000151'),
(214, 114, '000152'),
(215, 69, '000153'),
(216, 115, '000154'),
(217, 59, '000155'),
(218, 76, '000156'),
(219, 41, '000157'),
(220, 116, '000158'),
(221, 48, '000159'),
(222, 117, '000160'),
(223, 68, '000161'),
(224, 115, '000162'),
(225, 118, '000163'),
(227, 83, '000164'),
(228, 66, '000165'),
(229, 45, '000166'),
(230, 119, '000167'),
(231, 118, '000168'),
(232, 81, '000169'),
(233, 121, '000170'),
(234, 60, '000171'),
(235, 45, '000172'),
(236, 122, '000173'),
(237, 88, '000174'),
(238, 59, '000175'),
(239, 85, '000176'),
(240, 36, '000177'),
(241, 41, '000178'),
(242, 124, '000180'),
(243, 98, '000181'),
(244, 45, '000182'),
(245, 62, '000183'),
(246, 126, '000184'),
(247, 129, '000185'),
(248, 75, '000186'),
(249, 111, '000187'),
(250, 36, '000188'),
(251, 42, '000189'),
(252, 54, '000190'),
(253, 130, '000191'),
(254, 100, '000192'),
(255, 131, '000193'),
(256, 93, '000194'),
(257, 132, '000195'),
(258, 75, '000196'),
(259, 133, '000197'),
(260, 134, '000198'),
(261, 36, '000199'),
(262, 59, '000200'),
(263, 74, '000201'),
(264, 45, '000202'),
(265, 135, '000203'),
(266, 76, '000204'),
(267, 81, '000205'),
(268, 81, '000206'),
(269, 81, '000205'),
(270, 83, '000206'),
(271, 102, '000207'),
(272, 47, '000208'),
(273, 59, '000209'),
(274, 136, '000210'),
(275, 69, '000211'),
(276, 137, '000212'),
(277, 68, '000213'),
(278, 138, '000214'),
(279, 139, '000215'),
(280, 123, '000216'),
(281, 140, '000217'),
(282, 74, '000218'),
(283, 59, '000219'),
(284, 48, '000220'),
(285, 141, '000221'),
(286, 54, '000222'),
(287, 45, '000223'),
(288, 89, '000224'),
(289, 115, '000225'),
(290, 81, '000226'),
(291, 142, '000227'),
(292, 74, '000228'),
(293, 48, '000229'),
(294, 76, '000230'),
(295, 69, '000231'),
(296, 143, '000232'),
(297, 144, '000233'),
(298, 81, '000234'),
(299, 103, '000235'),
(300, 59, '000236'),
(301, 89, '000237'),
(302, 36, '000238'),
(303, 36, '000239'),
(304, 41, '000240'),
(305, 139, '000241'),
(306, 145, '000242'),
(307, 59, '000243'),
(308, 45, '000244'),
(309, 81, '000245'),
(310, 69, '000246'),
(311, 69, '000247'),
(312, 54, '000248'),
(313, 68, '000249'),
(314, 146, '000250'),
(315, 74, '000251'),
(316, 36, '000252'),
(317, 76, '000253'),
(318, 89, '000254'),
(319, 96, '000255'),
(320, 59, '000256'),
(321, 143, '000257'),
(322, 86, '000258'),
(323, 45, '000259'),
(324, 69, '000260'),
(325, 54, '000261'),
(326, 97, '000262'),
(327, 102, '000263'),
(328, 60, '000264'),
(329, 48, '000265'),
(330, 83, '000266'),
(331, 74, '000267'),
(332, 41, '000268'),
(333, 147, '000269'),
(334, 148, '000270'),
(335, 36, '000271'),
(336, 93, '000272'),
(337, 146, '000273'),
(338, 68, '000274'),
(339, 45, '000275'),
(340, 74, '000276'),
(341, 81, '000277'),
(342, 86, '000278'),
(343, 59, '000279'),
(344, 75, '000280'),
(345, 74, '000281'),
(346, 41, '000282'),
(347, 149, '000283'),
(348, 69, '000284'),
(349, 76, '000285'),
(350, 150, '000286'),
(351, 102, '000287'),
(352, 96, '000288'),
(353, 151, '000289'),
(354, 74, '000290'),
(355, 121, '000291'),
(356, 115, '000292'),
(357, 152, '000293'),
(358, 86, '000294'),
(359, 60, '000295'),
(360, 96, '000296'),
(361, 74, '000297'),
(362, 54, '000298'),
(363, 153, '000299'),
(364, 69, '000300'),
(365, 36, '000301'),
(366, 59, '000302'),
(367, 154, '000307'),
(368, 154, '000303'),
(369, 115, '000304'),
(370, 145, '000305'),
(371, 70, '000306'),
(372, 63, '000307'),
(373, 45, '000308'),
(374, 50, '000309'),
(375, 93, '000310'),
(376, 41, '000311'),
(377, 81, '000312'),
(378, 121, '000313'),
(379, 155, '000314'),
(380, 36, '000315'),
(381, 59, '000316'),
(382, 135, '000317'),
(383, 156, '000318'),
(384, 45, '000319'),
(385, 48, '000320'),
(386, 81, '000321'),
(387, 60, '000322'),
(388, 62, '000323'),
(389, 54, '000324'),
(390, 137, '000325'),
(391, 75, '000326'),
(392, 155, '000327'),
(393, 59, '000328'),
(394, 83, '000329'),
(395, 69, '000330'),
(396, 86, '000331'),
(397, 41, '000332'),
(398, 36, '000333'),
(399, 36, '000334'),
(400, 157, '000335'),
(401, 76, '000336'),
(402, 83, '000337'),
(403, 36, '000338'),
(404, 146, '000339'),
(405, 45, '000340'),
(406, 155, '000341'),
(407, 158, '000342'),
(408, 98, '000343'),
(409, 59, '000344'),
(410, 81, '000345'),
(411, 36, '000346'),
(412, 74, '000347'),
(413, 41, '000348'),
(414, 41, '000349'),
(415, 159, '000350'),
(416, 59, '000351'),
(417, 160, '000352'),
(418, 104, '000353'),
(419, 45, '000354'),
(420, 155, '000355'),
(421, 54, '000356'),
(422, 132, '000357'),
(423, 155, '000358'),
(424, 93, '000359'),
(425, 161, '000360'),
(426, 48, '000361'),
(427, 76, '000362'),
(428, 45, '000363'),
(429, 162, '000364'),
(430, 83, '000367'),
(431, 83, '000365'),
(432, 96, '000366'),
(433, 163, '000367'),
(434, 41, '000368'),
(435, 160, '000369'),
(436, 74, '000370'),
(437, 74, '000371'),
(438, 98, '000372'),
(439, 69, '000373'),
(440, 54, '000374'),
(441, 164, '000375'),
(442, 165, '000376'),
(443, 41, '000377'),
(444, 74, '000378'),
(445, 59, '000379'),
(446, 44, '000380'),
(447, 81, '000381'),
(448, 45, '000382'),
(449, 83, '000383'),
(450, 166, '000384'),
(451, 64, '000385'),
(452, 62, '000386'),
(453, 83, '000387'),
(454, 74, '000388'),
(455, 75, '000389'),
(456, 45, '000390'),
(457, 60, '000391'),
(458, 86, '000392'),
(459, 69, '000393'),
(460, 54, '000394'),
(461, 88, '000395'),
(462, 59, '000396'),
(463, 83, '000397'),
(464, 167, '000398'),
(465, 70, '000399'),
(466, 83, '000400'),
(467, 96, '000401'),
(468, 100, '000402'),
(469, 74, '000403'),
(470, 76, '000404'),
(471, 136, '000405'),
(472, 136, '000406'),
(473, 159, '000406'),
(474, 159, '000407'),
(475, 160, '000408'),
(476, 164, '000409'),
(477, 168, '000410'),
(478, 136, '000411'),
(479, 45, '000412'),
(480, 81, '000413'),
(481, 48, '000414'),
(482, 169, '000415'),
(483, 93, '000416'),
(484, 74, '000417'),
(485, 170, '000418'),
(486, 135, '000419'),
(487, 159, '000420'),
(488, 41, '000421'),
(489, 171, '000422'),
(490, 160, '000423'),
(491, 59, '000424'),
(492, 60, '000425'),
(493, 159, '000426'),
(494, 159, '000427'),
(495, 172, '000427'),
(496, 58, '000428'),
(497, 136, '000429'),
(498, 74, '000430'),
(499, 159, '000431'),
(500, 67, '000432'),
(501, 45, '000433'),
(502, 134, '000434'),
(503, 63, '000435'),
(504, 173, '000436'),
(505, 119, '000437'),
(506, 160, '000438'),
(507, 74, '000439'),
(508, 60, '000440'),
(509, 174, '000441'),
(510, 96, '000442'),
(511, 70, '000443'),
(512, 175, '000444'),
(513, 176, '000445'),
(514, 81, '000446'),
(515, 59, '000447'),
(516, 83, '000448'),
(517, 75, '000449'),
(518, 159, '000450'),
(519, 41, '000451'),
(520, 160, '000452'),
(521, 83, '000453'),
(522, 98, '000454'),
(523, 69, '000455'),
(524, 177, '000456'),
(525, 178, '000457'),
(526, 160, '000458'),
(527, 54, '000459'),
(528, 48, '000460'),
(529, 159, '000461'),
(530, 60, '000462'),
(531, 45, '000463'),
(532, 179, '000464'),
(533, 59, '000465'),
(534, 180, '000466'),
(535, 176, '000467'),
(536, 159, '000468'),
(537, 98, '000469'),
(538, 88, '000470'),
(539, 86, '000471'),
(540, 41, '000472'),
(541, 60, '000473'),
(542, 181, '000474'),
(543, 159, '000475'),
(544, 54, '000476'),
(545, 182, '000477'),
(546, 50, '000478'),
(547, 171, '000479'),
(548, 51, '000480'),
(549, 76, '000481'),
(550, 48, '000482'),
(551, 126, '000483'),
(552, 96, '000484'),
(553, 45, '000485'),
(554, 183, '000486'),
(555, 81, '000487'),
(556, 54, '000488'),
(557, 74, '000489'),
(558, 48, '000490'),
(559, 154, '000491'),
(560, 59, '000492'),
(561, 83, '000493'),
(562, 45, '000494'),
(563, 136, '000495'),
(564, 69, '000496'),
(565, 96, '000497'),
(566, 149, '000498'),
(567, 61, '000499'),
(568, 54, '000500'),
(569, 69, '000501'),
(570, 209, '000001'),
(571, 209, '000002'),
(572, 210, '000003'),
(573, 211, '000004'),
(574, 212, '000001'),
(575, 213, '000001'),
(576, 213, '001002'),
(577, 212, '009993'),
(578, 211, '009994'),
(579, 212, '009995'),
(580, 211, '009996'),
(581, 212, '009997'),
(582, 211, '009998'),
(583, 212, '009999'),
(584, 211, '009910'),
(585, 212, '009911'),
(586, 212, '009912'),
(587, 212, '009913'),
(588, 212, '009991'),
(589, 212, '009992'),
(590, 212, '009993'),
(591, 212, '009994'),
(592, 212, '009995'),
(593, 212, '009996'),
(594, 213, '009997'),
(595, 212, '009998'),
(596, 212, '009999'),
(597, 213, '009910'),
(598, 214, '000001'),
(599, 214, '000001'),
(600, 159, '000002'),
(601, 159, '000003'),
(602, 222, '000004'),
(603, 221, '000005'),
(604, 83, '000006'),
(605, 83, '000001'),
(606, 222, '000002'),
(607, 222, '000005'),
(608, 220, '000006'),
(609, 185, '000002'),
(610, 186, '000003'),
(611, 60, '000004'),
(612, 219, '000005'),
(613, 221, '000006'),
(614, 199, '000007'),
(615, 215, '000008'),
(616, 223, '008508'),
(617, 222, '008509'),
(618, 221, '010009'),
(619, 221, '010010'),
(620, 222, '008553'),
(621, 222, '008554'),
(622, 159, '008500'),
(623, 83, '008501'),
(624, 83, '008502'),
(625, 45, '008503'),
(626, 74, '008504'),
(627, 169, '008505'),
(628, 36, '008506'),
(629, 59, '008507'),
(630, 184, '008508'),
(631, 185, '008509'),
(632, 83, '008510'),
(633, 36, '008511'),
(634, 79, '008512'),
(635, 159, '008513'),
(636, 59, '008514'),
(637, 45, '008515'),
(638, 186, '008516'),
(639, 60, '008517'),
(640, 59, '008518'),
(641, 159, '008519'),
(642, 187, '008520'),
(643, 159, '008521'),
(644, 74, '008522'),
(645, 188, '008523'),
(646, 224, '008524'),
(647, 191, '008525'),
(648, 44, '008526'),
(649, 74, '008527'),
(650, 190, '008528'),
(651, 199, '008529'),
(652, 59, '008530'),
(653, 225, '008531'),
(654, 74, '008532'),
(655, 45, '008533'),
(656, 83, '008534'),
(657, 66, '008535'),
(658, 204, '008536'),
(659, 223, '008537'),
(660, 74, '008538'),
(661, 58, '008539'),
(662, 97, '008540'),
(663, 59, '008541'),
(664, 219, '008542'),
(665, 169, '008543'),
(666, 199, '008544'),
(667, 186, '008545'),
(668, 226, '008546'),
(669, 48, '008547'),
(670, 44, '008548'),
(671, 79, '008549'),
(672, 74, '008550'),
(673, 58, '008551'),
(674, 48, '008552'),
(675, 96, '008553'),
(676, 59, '008554'),
(677, 36, '008555'),
(678, 60, '008556'),
(679, 173, '008557'),
(680, 48, '008558'),
(681, 77, '008559'),
(682, 48, '008560'),
(683, 36, '008561'),
(684, 204, '008562'),
(685, 59, '008563'),
(686, 216, '008564'),
(687, 69, '008565'),
(688, 74, '008566'),
(689, 62, '008567'),
(690, 47, '008568'),
(691, 227, '008569'),
(692, 226, '008570'),
(693, 195, '008571'),
(694, 221, '008572'),
(695, 227, '008573'),
(696, 59, '008572'),
(697, 74, '008573'),
(698, 44, '008574'),
(699, 114, '008575'),
(700, 228, '008576'),
(701, 83, '008577'),
(702, 36, '008578'),
(703, 210, '008579'),
(704, 199, '008580'),
(705, 75, '008581'),
(706, 114, '008582'),
(707, 134, '008583'),
(708, 229, '008584'),
(709, 96, '008585'),
(710, 230, '008586'),
(711, 230, '008585'),
(712, 62, '008585'),
(713, 85, '008586'),
(714, 44, '008587'),
(715, 230, '008588'),
(716, 187, '008589'),
(717, 59, '008590'),
(718, 45, '008591'),
(719, 36, '008592'),
(720, 36, '008593'),
(721, 231, '008594'),
(722, 69, '008595'),
(723, 48, '008596'),
(724, 199, '008597'),
(725, 74, '008598'),
(726, 36, '008599'),
(727, 59, '008600'),
(728, 48, '008601'),
(729, 219, '008602'),
(730, 232, '008603'),
(731, 233, '008604'),
(732, 74, '008605'),
(733, 36, '008606'),
(734, 234, '008607'),
(735, 235, '008608'),
(736, 236, '008609'),
(737, 98, '008610'),
(738, 110, '008611'),
(739, 59, '008612'),
(740, 237, '008613'),
(741, 96, '008614'),
(742, 36, '008615'),
(743, 199, '008616'),
(744, 193, '008617'),
(745, 238, '008618'),
(746, 74, '008619'),
(747, 44, '008620'),
(748, 36, '008621'),
(749, 48, '008622'),
(750, 60, '008623'),
(751, 186, '008624'),
(752, 214, '008625'),
(753, 74, '008626'),
(754, 109, '008627'),
(755, 69, '008628'),
(756, 239, '008629'),
(757, 59, '008630'),
(758, 199, '008631'),
(759, 240, '008632'),
(760, 117, '008633'),
(761, 75, '008634'),
(762, 214, '008635'),
(763, 190, '008636'),
(764, 69, '008637'),
(765, 96, '008638'),
(766, 45, '008639'),
(767, 83, '008640'),
(768, 117, '008641'),
(769, 75, '008642'),
(770, 241, '008643'),
(771, 159, '008644'),
(772, 83, '008645'),
(773, 241, '008500'),
(774, 241, '008500'),
(775, 202, '008501'),
(776, 241, '028734'),
(777, 202, '028733'),
(778, 135, '028734'),
(779, 242, '028735'),
(780, 83, '028736'),
(781, 242, '028737'),
(782, 242, '0028738'),
(783, 242, '008505'),
(784, 242, '008743'),
(785, 242, '008744'),
(786, 242, '028738'),
(787, 242, '028739'),
(788, 241, '0028740'),
(789, 241, '028738'),
(790, 243, '000NaN'),
(791, 241, '008506'),
(792, 243, '028740'),
(793, 243, '028738'),
(794, 243, '008739');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_institucion`
--

CREATE TABLE `detalle_institucion` (
  `detalleinstitucion_cod` int(11) NOT NULL,
  `institucion_cod` int(11) NOT NULL,
  `documento_cod` char(13) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `documento_cod` char(13) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Codigo auto-incrementado del documento',
  `doc_asunto` varchar(150) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Asunto del documento',
  `doc_fecha_recepcion` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'fecha del registro del documento',
  `tipoDocumento_cod` int(11) NOT NULL COMMENT 'codigo del tipo de documentos',
  `area_cod` int(11) NOT NULL COMMENT 'Destino del documento',
  `usu_cod` int(11) NOT NULL COMMENT 'Codigo de Usuario',
  `doc_estado` enum('EN PROCESO','RECIBIDO','TERMINADO','ENTREGADO') COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del documento',
  `doc_tipo` enum('I','C') COLLATE utf8_unicode_ci NOT NULL,
  `doc_documento` varchar(350) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Entidad Documento';

--
-- Volcado de datos para la tabla `documento`
--

INSERT INTO `documento` (`documento_cod`, `doc_asunto`, `doc_fecha_recepcion`, `tipoDocumento_cod`, `area_cod`, `usu_cod`, `doc_estado`, `doc_tipo`, `doc_documento`) VALUES
('008739', 'DADAD', '2024-03-06 21:22:51', 4, 1, 1, 'EN PROCESO', 'C', NULL),
('028733', 'REMISIÓN: 28733 GB\r\nPESO: 550 KG \r\n3 VIGAS, 4 CANALES Y 2 MARCOS EN VIGA (FALTA PERF)', '2024-03-04 20:01:10', 4, 2, 1, 'EN PROCESO', 'C', NULL),
('028734', 'REMISIÓN: 28734 GB\r\nPESO: 360 KG \r\n 3 SOPORTES Y 3 LAMINAS ', '2024-03-04 20:10:51', 4, 2, 1, 'EN PROCESO', 'C', 'Archivo/65e62acbd8052-CamScanner 04-03-2024 15.06.pdf'),
('028735', 'REMISIÓN: 28735 GB\r\nPESO: 6630 KG\r\nPESO NETO: 6280 KG \r\nEMBALAJE: 350 KG\r\n408 UNDS (SHL-8)\r\n100 UNDS (SVP 30)\r\n100 UNDS (SHL-4)\r\n248 UNDS (SHL-3)\r\n7 R', '2024-03-04 20:50:34', 4, 2, 1, 'EN PROCESO', 'C', NULL),
('028736', 'REMISIÓN: 28736 GB \r\nPESO: 1790 KG \r\n10 CERCHAS (FALTA PERF) PROYECTO SPRB\r\n', '2024-03-04 21:17:30', 4, 2, 1, 'EN PROCESO', 'C', 'Archivo/65e63a6a8548c-CamScanner 04-03-2024 16.12 (1)_protected.pdf'),
('028737', 'FECHA DE ENTRADA 4/03/2024\r\nREMISIÓN: 28737 GB\r\nPESO: 6330 KG\r\nPESO NETO: 6080 KG \r\nEMBALAJE: 250 KG \r\n100 UNDS (SVP-30), 300 UNDS( S-HL8) Y 300 UNDS ', '2024-03-05 12:13:32', 4, 2, 1, 'EN PROCESO', 'C', 'Archivo/65e70c6bf3da8-baq20240305_protected.pdf'),
('028738', 'REMISIÓN: 28738 GB \r\nPESO: 4300 KG \r\n100 PARRILLAS Y 100 POSTES', '2024-03-06 20:17:05', 4, 2, 1, 'RECIBIDO', 'C', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `files`
--

INSERT INTO `files` (`id`, `title`, `description`, `url`, `type`) VALUES
(8, '', '', '', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion`
--

CREATE TABLE `institucion` (
  `institucion_cod` int(11) NOT NULL,
  `inst_nombre` varchar(150) NOT NULL,
  `inst_tipoinstitucion` varchar(50) NOT NULL,
  `inst_estado` enum('ACTIVO','INACTIVO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal`
--

CREATE TABLE `personal` (
  `personal_cod` int(11) NOT NULL,
  `pers_nombres` varchar(100) NOT NULL,
  `pers_apellidoPate` varchar(50) NOT NULL,
  `pers_apellidoMate` varchar(50) NOT NULL,
  `pers_dni` char(15) NOT NULL,
  `pers_sexo` char(1) NOT NULL,
  `pers_fechaNacimiento` date NOT NULL,
  `pers_direccion` varchar(250) NOT NULL,
  `pers_telefono` char(10) NOT NULL,
  `pers_movil` char(10) NOT NULL,
  `pers_email` varchar(80) NOT NULL,
  `pers_fecharegistro` timestamp NOT NULL DEFAULT current_timestamp(),
  `pers_estado` enum('ACTIVO','INACTIVO') NOT NULL,
  `usuario_cod` int(11) NOT NULL,
  `pers_puesto` enum('JEFE','AUXILIAR','PROGRAMADOR','USUARIO','FACTURACION') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `personal`
--

INSERT INTO `personal` (`personal_cod`, `pers_nombres`, `pers_apellidoPate`, `pers_apellidoMate`, `pers_dni`, `pers_sexo`, `pers_fechaNacimiento`, `pers_direccion`, `pers_telefono`, `pers_movil`, `pers_email`, `pers_fecharegistro`, `pers_estado`, `usuario_cod`, `pers_puesto`) VALUES
(1, 'JEIDER ', 'BUELVAS', ' ARIAS', '1002324418', 'M', '1999-01-04', 'CALLE 81 SUR #81-90', '3134512321', '3134512321', 'jbuelvas@polyuprotec.com', '2018-11-14 07:27:52', 'ACTIVO', 1, ''),
(15, 'JOHANNA ', 'MABEL', 'ALVARADO', '10306056', 'M', '1992-02-15', 'CRA 81 G #87B-22 SUR ', '3214187844', '3214187844', 'jalvarado@polyuprotec.com', '2021-06-23 13:55:19', 'INACTIVO', 17, 'JEFE'),
(17, 'JENNY', 'MILENA ', 'GONZALEZ', '00000010', 'F', '2021-07-27', 'CARRERA 123 ', '0000000000', '3203225843', 'jgonzalez@polyuprotec.com', '2021-07-27 15:43:59', 'INACTIVO', 19, 'FACTURACION'),
(18, 'RAFAEL', 'SOTO', 'SOTO', '11282268', 'M', '2001-03-19', 'CALLE 52 SUR #95- A30 ', '', '3213372785', 'despachosbogota@polyuprotec.com', '2021-08-10 14:20:53', 'INACTIVO', 20, 'AUXILIAR'),
(19, 'RAFAEL ANTONIO', 'SOTO', 'CASTELLANOS', '11282268', 'M', '1981-06-25', 'CRA 123 14A 11 ', '', '3212013098', 'despachosbogota@polyuprotec.co', '2024-01-11 13:08:07', 'ACTIVO', 21, 'USUARIO'),
(20, 'ALEXANDER ', 'CARPIO', 'TURIZO', '10005148', 'M', '2000-10-27', 'CRA 123 14A 11', '', '3194531762', 'despachosbogota@polyuprotec.co', '2024-01-11 13:27:23', 'ACTIVO', 22, 'AUXILIAR'),
(21, 'JENNY MILENA', 'GONZáLEZ', 'PALACIO', '52965496', 'F', '1983-09-16', 'CRA 123 # 14 A 11', '3203225843', '', 'jgonzalez@polyuprotec.com', '2024-01-17 14:15:27', 'ACTIVO', 23, 'USUARIO'),
(22, 'JEIDER', 'BUELVAS', 'ARIAS', '1000', 'M', '2024-01-18', 'CALLE 123 ', '33', '33', 'XXX@GMAIL.COM', '2024-01-18 12:24:15', 'ACTIVO', 24, 'PROGRAMADOR'),
(23, 'JOHANNA MABEL', 'ALVARADO', 'ALVARADO', '52519245', 'F', '1977-10-20', 'CARRERA 123  14A-11', '3138527988', '3138527988', 'jalvarado@polyuprotec.com', '2024-01-19 16:09:28', 'ACTIVO', 25, 'JEFE'),
(24, 'INGRY ', 'PéREZ', ' RúA', '10456846', 'F', '2024-01-29', 'AV. ORIENTAL NO. 5 – 56', '', '3228801363', 'iperezr@polyuprotec.com', '2024-01-29 16:16:23', 'ACTIVO', 26, 'USUARIO'),
(25, 'ABIGAIL ', 'PACHECO', 'PAEZ', '10431234', 'F', '2024-01-29', 'AV. ORIENTAL NO. 5 – 56', '', '3147837785', 'asistentedespachomalambo@polyu', '2024-01-29 16:19:06', 'ACTIVO', 27, 'USUARIO'),
(26, 'JENNIFER ', 'POLO', 'ALMEIDA', '10436049', 'F', '2024-01-29', 'AV. ORIENTAL NO. 5 – 56', '', '3208531275', 'jpolo@polyuprotec.com', '2024-01-29 16:20:49', 'ACTIVO', 28, 'USUARIO'),
(27, 'MIGUEL ', 'MARTINEZ', 'MARTINEZ', ' 7675438', 'M', '2024-01-29', 'AV. ORIENTAL NO. 5 – 56', '', '313285347', 'mmartinez@polyuprotec.com', '2024-01-29 16:22:33', 'ACTIVO', 29, 'USUARIO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `tipodocumento_cod` int(11) NOT NULL COMMENT 'Codigo auto-incrementado del tipo documento',
  `tipodo_descripcion` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'Descripcion del  tipo documento',
  `tipodo_estado` enum('ACTIVO','INACTIVO') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT 'estado del tipo de documento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Entidad Documento';

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`tipodocumento_cod`, `tipodo_descripcion`, `tipodo_estado`) VALUES
(3, 'BOGOTÁ', 'INACTIVO'),
(4, 'MALAMBO', 'ACTIVO'),
(5, 'MADRID', 'INACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_usuario`
--

CREATE TABLE `tipo_usuario` (
  `cod_tipousuario` int(11) NOT NULL,
  `tipusu_descripcion` varchar(40) NOT NULL,
  `tipusu_estado` enum('ACTIVO','INACTIVO') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_usuario`
--

INSERT INTO `tipo_usuario` (`cod_tipousuario`, `tipusu_descripcion`, `tipusu_estado`) VALUES
(1, 'ADMINISTRADOR', 'ACTIVO'),
(2, 'AUXILIAR ', 'ACTIVO'),
(3, 'PROGRAMADOR', 'ACTIVO'),
(4, 'USUARIO', 'ACTIVO'),
(5, 'JEFE', 'ACTIVO'),
(6, 'FACTURACION', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `cod_usuario` int(11) NOT NULL,
  `usu_nombre` varchar(30) NOT NULL,
  `usu_clave` varchar(30) NOT NULL,
  `usu_estado` enum('ACTIVO','INACTIVO') DEFAULT NULL,
  `cod_tipousuario` int(11) NOT NULL,
  `usu_foto` varchar(350) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`cod_usuario`, `usu_nombre`, `usu_clave`, `usu_estado`, `cod_tipousuario`, `usu_foto`) VALUES
(1, 'Jeider', '123456789', 'ACTIVO', 1, 'Fotos/admin.png'),
(26, 'iperezr@polyuprotec.com', 'iperezr2024@', 'ACTIVO', 4, 'Fotos/admin.png'),
(27, 'asistentedespachomalambo@polyu', 'asistented2024@', 'ACTIVO', 4, 'Fotos/admin.png'),
(28, 'jpolo@polyuprotec.com', 'jpolo2024@', 'ACTIVO', 6, 'Fotos/admin.png'),
(29, 'mmartinez@polyuprotec.com', 'mmartinez2024@', 'ACTIVO', 4, 'Fotos/admin.png');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`area_cod`),
  ADD UNIQUE KEY `unico` (`area_nombre`);

--
-- Indices de la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  ADD PRIMARY KEY (`ciudadano_cod`),
  ADD KEY `cod_ciudona` (`ciud_nombres`);

--
-- Indices de la tabla `detalle_ciudadano`
--
ALTER TABLE `detalle_ciudadano`
  ADD PRIMARY KEY (`detalleciudadano_cod`),
  ADD KEY `ciudadano_cod` (`ciudadano_cod`),
  ADD KEY `fd` (`documento_cod`);

--
-- Indices de la tabla `detalle_institucion`
--
ALTER TABLE `detalle_institucion`
  ADD PRIMARY KEY (`detalleinstitucion_cod`),
  ADD KEY `institucion_cod` (`institucion_cod`),
  ADD KEY `sd` (`documento_cod`);

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`documento_cod`),
  ADD KEY `area_cod` (`area_cod`),
  ADD KEY `tipoDocumento_cod` (`tipoDocumento_cod`),
  ADD KEY `usu_cod` (`usu_cod`);

--
-- Indices de la tabla `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `institucion`
--
ALTER TABLE `institucion`
  ADD PRIMARY KEY (`institucion_cod`),
  ADD UNIQUE KEY `unico` (`inst_nombre`) USING BTREE;

--
-- Indices de la tabla `personal`
--
ALTER TABLE `personal`
  ADD PRIMARY KEY (`personal_cod`),
  ADD KEY `cod_persona` (`pers_nombres`),
  ADD KEY `personal_ibfk_1` (`usuario_cod`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`tipodocumento_cod`),
  ADD UNIQUE KEY `IU_COD_TIPDOCUMENTO` (`tipodocumento_cod`) USING BTREE COMMENT 'EL CODIGO SERA UNICO',
  ADD KEY `IX_NOMBRE` (`tipodo_descripcion`) USING BTREE COMMENT 'SE ORDENARA LOS DATOS POR LA DESCRIPCION';

--
-- Indices de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  ADD PRIMARY KEY (`cod_tipousuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`cod_usuario`),
  ADD KEY `cod_tipousuario` (`cod_tipousuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `area_cod` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Codigo auto-incrementado del movimiento del area', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  MODIFY `ciudadano_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT de la tabla `detalle_ciudadano`
--
ALTER TABLE `detalle_ciudadano`
  MODIFY `detalleciudadano_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=795;

--
-- AUTO_INCREMENT de la tabla `detalle_institucion`
--
ALTER TABLE `detalle_institucion`
  MODIFY `detalleinstitucion_cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `institucion`
--
ALTER TABLE `institucion`
  MODIFY `institucion_cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personal`
--
ALTER TABLE `personal`
  MODIFY `personal_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `tipodocumento_cod` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Codigo auto-incrementado del tipo documento', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_usuario`
--
ALTER TABLE `tipo_usuario`
  MODIFY `cod_tipousuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `cod_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_institucion`
--
ALTER TABLE `detalle_institucion`
  ADD CONSTRAINT `detalle_institucion_ibfk_1` FOREIGN KEY (`institucion_cod`) REFERENCES `institucion` (`institucion_cod`),
  ADD CONSTRAINT `detalle_institucion_ibfk_2` FOREIGN KEY (`documento_cod`) REFERENCES `documento` (`documento_cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
