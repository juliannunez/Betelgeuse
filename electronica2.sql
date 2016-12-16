-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-06-2016 a las 16:56:10
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `electronica1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_curso_profesor`
--

CREATE TABLE `asignacion_curso_profesor` (
  `cod_curso` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `grupo_cur` int(3) NOT NULL,
  `semestre` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_doc_profe` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nro_doc_profe` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_vinc` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `cant_horas` int(3) NOT NULL,
  `nro_aula` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `profesor_finalizo` varchar(2) COLLATE utf8_spanish_ci NOT NULL,
  `tupo_de_curso` varchar(20) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `numero` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `capacidad` int(4) DEFAULT NULL,
  `tipo_aula` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula_asignada`
--

CREATE TABLE `aula_asignada` (
  `codigo_mat` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `grupo_mat` int(3) NOT NULL,
  `semestre` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `nro_aula` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `hora_desde` int(11) NOT NULL,
  `hora_hasta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `codigo` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nro_creditos` int(2) DEFAULT NULL,
  `intensidad_horaria` int(2) DEFAULT NULL,
  `version_pensum` varchar(3) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos_interes`
--

CREATE TABLE `cursos_interes` (
  `tipo_doc` varchar(50) NOT NULL,
  `nro_doc` varchar(20) NOT NULL,
  `codigo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_programado`
--

CREATE TABLE `curso_programado` (
  `codigo` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `grupo` int(3) NOT NULL,
  `semestre` varchar(6) COLLATE utf8_spanish_ci NOT NULL,
  `est_matriculados` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibilidad`
--

CREATE TABLE `disponibilidad` (
  `tipo_doc` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nro_doc` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `dia` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `hora_desde` int(2) NOT NULL,
  `hora_hasta` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `microcurriculo`
--

CREATE TABLE `microcurriculo` (
  `semestre` varchar(6) NOT NULL,
  `cod_curso` varchar(10) NOT NULL,
  `link` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `tipo_doc` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nro_doc` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(1024) COLLATE utf8_spanish_ci NOT NULL,
  `link_cv` varchar(1024) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vinculo_profesor`
--

CREATE TABLE `vinculo_profesor` (
  `tipo_doc` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nro_doc` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` varchar(100) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion_curso_profesor`
--
ALTER TABLE `asignacion_curso_profesor`
  ADD PRIMARY KEY (`cod_curso`,`grupo_cur`,`semestre`,`tipo_doc_profe`,`nro_doc_profe`,`tipo_vinc`),
  ADD KEY `fk_vinc_profe` (`tipo_doc_profe`,`nro_doc_profe`,`tipo_vinc`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`numero`);

--
-- Indices de la tabla `aula_asignada`
--
ALTER TABLE `aula_asignada`
  ADD PRIMARY KEY (`codigo_mat`,`grupo_mat`,`semestre`,`nro_aula`,`hora_desde`,`hora_hasta`),
  ADD KEY `fk_aulas` (`nro_aula`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `cursos_interes`
--
ALTER TABLE `cursos_interes`
  ADD PRIMARY KEY (`tipo_doc`,`nro_doc`,`codigo`);

--
-- Indices de la tabla `curso_programado`
--
ALTER TABLE `curso_programado`
  ADD PRIMARY KEY (`codigo`,`grupo`,`semestre`);

--
-- Indices de la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD PRIMARY KEY (`tipo_doc`,`nro_doc`,`dia`,`hora_desde`,`hora_hasta`);

--
-- Indices de la tabla `microcurriculo`
--
ALTER TABLE `microcurriculo`
  ADD PRIMARY KEY (`semestre`,`cod_curso`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`tipo_doc`,`nro_doc`);

--
-- Indices de la tabla `vinculo_profesor`
--
ALTER TABLE `vinculo_profesor`
  ADD PRIMARY KEY (`tipo_doc`,`nro_doc`,`tipo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion_curso_profesor`
--
ALTER TABLE `asignacion_curso_profesor`
  ADD CONSTRAINT `fk_cursos_prof` FOREIGN KEY (`cod_curso`,`grupo_cur`,`semestre`) REFERENCES `curso_programado` (`codigo`, `grupo`, `semestre`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vinc_profe` FOREIGN KEY (`tipo_doc_profe`,`nro_doc_profe`,`tipo_vinc`) REFERENCES `vinculo_profesor` (`tipo_doc`, `nro_doc`, `tipo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `aula_asignada`
--
ALTER TABLE `aula_asignada`
  ADD CONSTRAINT `aula_asignada_ibfk_1` FOREIGN KEY (`codigo_mat`) REFERENCES `asignacion_curso_profesor` (`cod_curso`),
  ADD CONSTRAINT `fk_aulas` FOREIGN KEY (`nro_aula`) REFERENCES `aula` (`numero`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso_programado`
--
ALTER TABLE `curso_programado`
  ADD CONSTRAINT `codigo_fk` FOREIGN KEY (`codigo`) REFERENCES `curso` (`codigo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `disponibilidad`
--
ALTER TABLE `disponibilidad`
  ADD CONSTRAINT `fk_docid` FOREIGN KEY (`tipo_doc`,`nro_doc`) REFERENCES `profesor` (`tipo_doc`, `nro_doc`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `vinculo_profesor`
--
ALTER TABLE `vinculo_profesor`
  ADD CONSTRAINT `fk_profesor` FOREIGN KEY (`tipo_doc`,`nro_doc`) REFERENCES `profesor` (`tipo_doc`, `nro_doc`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
