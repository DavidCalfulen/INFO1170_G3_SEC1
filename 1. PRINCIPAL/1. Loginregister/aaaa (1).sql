-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-09-2024 a las 02:30:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aaaa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `ID_administrador` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `contraseña` varchar(100) DEFAULT NULL,
  `Rut_empresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `Rut_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(100) DEFAULT NULL,
  `Correo_electronico` varchar(100) DEFAULT NULL,
  `Direccion_sucursal` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informes_emergencias`
--

CREATE TABLE `informes_emergencias` (
  `id` int(11) NOT NULL,
  `id_emergencia` varchar(255) NOT NULL,
  `fecha_actualizacion` date NOT NULL,
  `hora_actualizacion` time NOT NULL,
  `estado_emergencia` varchar(255) NOT NULL,
  `tiempo_estimado_solucion` varchar(255) DEFAULT NULL,
  `tiempo_estimado_llegada` varchar(255) DEFAULT NULL,
  `descripcion_actual` text NOT NULL,
  `acciones_tomadas` text NOT NULL,
  `proximos_pasos` text NOT NULL,
  `evidencia` varchar(255) DEFAULT NULL,
  `comentarios_adicionales` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `informes_emergencias`
--

INSERT INTO `informes_emergencias` (`id`, `id_emergencia`, `fecha_actualizacion`, `hora_actualizacion`, `estado_emergencia`, `tiempo_estimado_solucion`, `tiempo_estimado_llegada`, `descripcion_actual`, `acciones_tomadas`, `proximos_pasos`, `evidencia`, `comentarios_adicionales`) VALUES
(1, '123456', '2005-07-11', '20:10:00', 'suspendido', '2 horas', '30min', 'hola ', 'caca', 'pedo', '', 'hola'),
(2, '1234', '1231-02-11', '12:33:00', 'terminada', '2 dias', '30 minutos', 'dadadasf', 'fgdgd', 'hfj', '', 'fhjfjf'),
(3, '1', '1980-02-11', '20:10:00', 'en_proceso', '2 horas', '30min', 'caca', 'pipi', '123', '', '345'),
(4, '1', '1980-02-11', '20:10:00', 'en_proceso', '2 horas', '30min', 'caca', 'pipi', '123', '', '345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_historico`
--

CREATE TABLE `registro_historico` (
  `Num_operacion` int(11) NOT NULL,
  `Rut_usuario` varchar(9) DEFAULT NULL,
  `Rut_empresa` int(11) DEFAULT NULL,
  `ID_administrador` int(11) DEFAULT NULL,
  `ID_tecnico` int(11) DEFAULT NULL,
  `Fecha` datetime DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  `Estado` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnico`
--

CREATE TABLE `tecnico` (
  `ID_tecnico` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `contraseña` varchar(100) DEFAULT NULL,
  `info_ubicacion` text DEFAULT NULL,
  `estado_actualizado` text DEFAULT NULL,
  `Rut_empresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Rut_usuario` varchar(9) NOT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `contraseña` varchar(100) DEFAULT NULL,
  `numero_cliente` int(10) DEFAULT NULL,
  `Rut_empresa` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Rut_usuario`, `nombre_completo`, `correo_electronico`, `contraseña`, `numero_cliente`, `Rut_empresa`, `id`) VALUES
('', ' Diego Andres Leiva Caballero', 'dleiva1107@gmail.com', '$2y$10$ikRdzqktwDESSEU7gQf2p.y1SbwdbCwIu.OXqg5rgdyTt4HFI5bpG', NULL, NULL, 1),
('', 'Diego Andrés Leiva Caballero', 'lordchicoux25@gmail.com', '$2y$10$zsKgd/hUs3b4XxuBXwmw9.WNWPrmJSaGQF9S3DKPD4rDJm0sjCCF2', 1, NULL, 2),
('', 'pedrito leiva caballero', 'diegoprofe25@gmail.com', '$2y$10$1VfSg9oRPVZYHUOfEVYgYeCBFyF6A7bRwqRwODKfCw627u8Yhf/eK', 2, NULL, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`ID_administrador`),
  ADD KEY `Rut_empresa` (`Rut_empresa`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`Rut_empresa`);

--
-- Indices de la tabla `informes_emergencias`
--
ALTER TABLE `informes_emergencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `registro_historico`
--
ALTER TABLE `registro_historico`
  ADD PRIMARY KEY (`Num_operacion`),
  ADD KEY `ID_tecnico` (`ID_tecnico`),
  ADD KEY `ID_administrador` (`ID_administrador`),
  ADD KEY `Rut_empresa` (`Rut_empresa`),
  ADD KEY `Rut_usuario` (`Rut_usuario`);

--
-- Indices de la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD PRIMARY KEY (`ID_tecnico`),
  ADD KEY `Rut_empresa` (`Rut_empresa`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_cliente` (`numero_cliente`),
  ADD KEY `Rut_empresa` (`Rut_empresa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `informes_emergencias`
--
ALTER TABLE `informes_emergencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`Rut_empresa`) REFERENCES `empresa` (`Rut_empresa`);

--
-- Filtros para la tabla `registro_historico`
--
ALTER TABLE `registro_historico`
  ADD CONSTRAINT `registro_historico_ibfk_1` FOREIGN KEY (`ID_tecnico`) REFERENCES `tecnico` (`ID_tecnico`),
  ADD CONSTRAINT `registro_historico_ibfk_2` FOREIGN KEY (`ID_administrador`) REFERENCES `administrador` (`ID_administrador`),
  ADD CONSTRAINT `registro_historico_ibfk_3` FOREIGN KEY (`Rut_empresa`) REFERENCES `empresa` (`Rut_empresa`),
  ADD CONSTRAINT `registro_historico_ibfk_4` FOREIGN KEY (`Rut_usuario`) REFERENCES `usuario` (`Rut_usuario`);

--
-- Filtros para la tabla `tecnico`
--
ALTER TABLE `tecnico`
  ADD CONSTRAINT `tecnico_ibfk_1` FOREIGN KEY (`Rut_empresa`) REFERENCES `empresa` (`Rut_empresa`);

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`Rut_empresa`) REFERENCES `empresa` (`Rut_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
