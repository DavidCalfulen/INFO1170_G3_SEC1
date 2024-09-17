-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2024 a las 02:38:30
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
-- Base de datos: `luzalert`
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

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`ID_administrador`, `nombre`, `correo_electronico`, `contraseña`, `Rut_empresa`) VALUES
(1, 'Juan Pérez', 'jperez@empresaabc.com', 'password123', 1),
(2, 'Ana Gómez', 'agomez@empresaxyz.com', 'passwordxyz', 2),
(3, 'Diego Pérez', 'dcaballero@empresaabc.com', 'password234', 1),
(4, 'Martin Gómez', 'mgomez@empresaxyz.com', 'password123', 2),
(5, 'Marcos Diaz', 'mdiaz@serviciosglobales.com', 'passglobales', 3),
(6, 'Lucía Rojas', 'lrojas@techsolutions.com', 'passtec', 4),
(7, 'Carlos Fuentes', 'cfuentes@inversionesfuturo.com', 'passfuturo', 5);

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

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`Rut_empresa`, `nombre_empresa`, `Correo_electronico`, `Direccion_sucursal`) VALUES
(1, 'Empresa ABC', 'contacto@empresaabc.com', 'Av. Central 123, Ciudad'),
(2, 'Empresa XYZ', 'info@empresaxyz.com', 'Calle Falsa 456, Ciudad'),
(3, 'Empresa CBD', 'contacto@empresaabc.com', 'Av. Colon 666, Ciudad'),
(4, 'Empresa TOP', 'info@empresaxyz.com', 'Calle Obly 436, Ciudad'),
(5, 'Servicios Globales', 'contacto@serviciosglobales.com', 'Av. del Mar 789, Ciudad'),
(6, 'Tech Solutions', 'contacto@techsolutions.com', 'Calle Nueva 101, Ciudad'),
(7, 'Inversiones Futuro', 'info@inversionesfuturo.com', 'Av. Norte 202, Ciudad');

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

--
-- Volcado de datos para la tabla `registro_historico`
--

INSERT INTO `registro_historico` (`Num_operacion`, `Rut_usuario`, `Rut_empresa`, `ID_administrador`, `ID_tecnico`, `Fecha`, `Descripcion`, `Estado`) VALUES
(1, '123456789', 1, 1, 1, '2024-09-15 10:30:00', 'Reparación de cableado subterráneo', 'Completado'),
(2, '987654321', 2, 2, 2, '2024-09-16 14:00:00', 'Mantenimiento de transformador', 'En progreso'),
(3, '192837465', 3, 3, 3, '2024-09-17 09:00:00', 'Inspección de línea de alta tensión', 'Pendiente'),
(4, '876543219', 4, 4, 4, '2024-09-18 11:00:00', 'Instalación de medidores inteligentes', 'Completado'),
(5, '345678901', 5, 5, 5, '2024-09-19 08:30:00', 'Revisión de sistema de respaldo eléctrico', 'En progreso'),
(6, '234567890', 1, 1, 1, '2024-09-20 13:00:00', 'Reemplazo de fusibles en subestación', 'Completado'),
(7, '678901234', 2, 2, 2, '2024-09-21 15:00:00', 'Inspección y ajuste de paneles solares', 'Pendiente'),
(8, '345789123', 3, 3, 3, '2024-09-22 09:45:00', 'Reparación de postes eléctricos dañados', 'En progreso');

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

--
-- Volcado de datos para la tabla `tecnico`
--

INSERT INTO `tecnico` (`ID_tecnico`, `nombre`, `correo_electronico`, `contraseña`, `info_ubicacion`, `estado_actualizado`, `Rut_empresa`) VALUES
(1, 'Carlos López', 'clopez@empresaabc.com', 'passabc', 'Sucursal Norte', 'En servicio', 1),
(2, 'María González', 'mgonzalez@empresaxyz.com', 'passxyz', 'Sucursal Sur', 'En servicio', 2),
(3, 'Juan Ortega', 'jortega@serviciosglobales.com', 'passglobal', 'Sucursal Este', 'En servicio', 3),
(4, 'Raúl Martínez', 'rmartinez@techsolutions.com', 'passtec', 'Sucursal Oeste', 'Mantenimiento', 4),
(5, 'Ana Villanueva', 'avillanueva@inversionesfuturo.com', 'passfuturo', 'Sucursal Central', 'En servicio', 5);

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
  `Rut_empresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Rut_usuario`, `nombre_completo`, `correo_electronico`, `contraseña`, `numero_cliente`, `Rut_empresa`) VALUES
('123456789', 'Pedro Rojas', 'projas@cliente.com', 'cliente123', 1001, 1),
('192837465', 'Jorge Ramírez', 'jramirez@cliente.com', 'cliente789', 1003, 3),
('234567890', 'Sofía Sánchez', 'ssanchez@cliente.com', 'cliente678', 1006, 1),
('345678901', 'Miguel Hernández', 'mhernandez@cliente.com', 'cliente345', 1005, 5),
('345789123', 'Carolina Pérez', 'cperez@cliente.com', 'cliente234', 1008, 3),
('678901234', 'Felipe Vargas', 'fvargas@cliente.com', 'cliente901', 1007, 2),
('876543219', 'Claudia Medina', 'cmedina@cliente.com', 'cliente012', 1004, 4),
('987654321', 'Luisa Martínez', 'lmartinez@cliente.com', 'cliente456', 1002, 2);

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
-- Indices de la tabla `registro_historico`
--
ALTER TABLE `registro_historico`
  ADD PRIMARY KEY (`Num_operacion`),
  ADD KEY `ID_tecnico` (`ID_tecnico`),
  ADD KEY `ID_administrador` (`ID_administrador`),
  ADD KEY `Rut_empresa` (`Rut_empresa`),
  ADD KEY `Rut_usuario` (`Rut_usuario`),
  ADD KEY `idx_fecha_descripcion_estado` (`Fecha`,`Descripcion`(100),`Estado`);

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
  ADD PRIMARY KEY (`Rut_usuario`),
  ADD KEY `Rut_empresa` (`Rut_empresa`);

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
