-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para optyma
CREATE DATABASE IF NOT EXISTS `optyma` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `optyma`;

-- Volcando estructura para tabla optyma.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `nickname` varchar(50) NOT NULL DEFAULT 'id',
  `email` varchar(50) NOT NULL,
  `passwrd` varchar(255) NOT NULL,
  PRIMARY KEY (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla optyma.admins: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`nickname`, `email`, `passwrd`) VALUES
	('Itzco', 'itzcoatlpv@gmail.com', 'ac9689e2272427085e35b9d3e3e8bed88cb3434828b43b86fc0596cad4c6e270');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Volcando estructura para tabla optyma.plantillas
CREATE TABLE IF NOT EXISTS `plantillas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_admins` varchar(50) NOT NULL,
  `tema` varchar(50) NOT NULL,
  `plantilla` varchar(250) NOT NULL,
  `sentencia` varchar(250) DEFAULT NULL,
  `dificultad` varchar(50) NOT NULL DEFAULT 'Facil',
  `fechaSubida` timestamp NULL DEFAULT NULL,
  `tiempoCerrada` int(10) unsigned NOT NULL DEFAULT '30',
  `tiempoAbierta` int(10) unsigned NOT NULL DEFAULT '30',
  PRIMARY KEY (`id`),
  KEY `FK__admins` (`id_admins`),
  CONSTRAINT `FK__admins` FOREIGN KEY (`id_admins`) REFERENCES `admins` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla optyma.plantillas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `plantillas` DISABLE KEYS */;
/*!40000 ALTER TABLE `plantillas` ENABLE KEYS */;

-- Volcando estructura para tabla optyma.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `email` varchar(250) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `escolaridad` varchar(50) DEFAULT NULL,
  `passwrd` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla con usuarios comunes de la aplicacion\r\n';

-- Volcando datos para la tabla optyma.usuarios: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`email`, `nickname`, `escolaridad`, `passwrd`, `created_at`) VALUES
	('itzcoatlpv@gmail.com', 'Itzco', 'Licenciatura', 'ac9689e2272427085e35b9d3e3e8bed88cb3434828b43b86fc0596cad4c6e270', NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla optyma.usuarios_copy
CREATE TABLE IF NOT EXISTS `usuarios_copy` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `escolaridad` varchar(50) DEFAULT NULL,
  `passwrd` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='Tabla con usuarios comunes de la aplicacion\r\n';

-- Volcando datos para la tabla optyma.usuarios_copy: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios_copy` DISABLE KEYS */;
INSERT INTO `usuarios_copy` (`id`, `email`, `nickname`, `escolaridad`, `passwrd`, `created_at`) VALUES
	(1, 'itzcoatlpv@gmail.com', 'Itzco', 'Licenciatura', 'ac9689e2272427085e35b9d3e3e8bed88cb3434828b43b86fc0596cad4c6e270', NULL),
	(2, 'test1@gmail.com', 'Test', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(3, 'test@test.com', 'Prueba', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(4, 'test2@test.com', 'Prueba2', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(5, 'frank@test.com', 'Frank', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(6, 'Edd@test.com', 'Edd', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(7, 'Eddy@test.com', 'Eddy', NULL, '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(8, 'juan@optyma.com', 'Juan', 'Licenciatura', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(11, 'Rodrigo@optyma.com', 'Rodrigo', 'Licenciatura', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', NULL),
	(12, 'alex@optyma.com', 'Alex', 'Licenciatura', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', NULL),
	(14, 'prueba@optyma.com', 'Jonh', 'Licenciatura', '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5', '2021-03-17 18:04:38'),
	(15, 'aragon@optyma.com', 'Aragon', 'Licenciatura', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2021-03-18 11:14:27'),
	(16, 'pepe@optyma.com', 'Pepe1234', 'Primaria', '9626c7444717aab7a3bbdd509bcafa35a7491e9478d421b38e539a621f695edd', '2021-03-24 20:04:53'),
	(17, 'legolas@optyma.com', 'Legolas', 'Preparatoria', 'ac9689e2272427085e35b9d3e3e8bed88cb3434828b43b86fc0596cad4c6e270', '2021-03-30 13:14:10');
/*!40000 ALTER TABLE `usuarios_copy` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
