-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 13-09-2024 a las 23:27:28
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sisemsyt_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `created_at`, `updated_at`) VALUES
(1, 'CATEGORÍA 1', NULL, NULL),
(3, 'CATEGORIA 2', '2023-05-19 23:49:01', '2023-05-19 23:49:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `ci`, `ci_exp`, `nit`, `fono`, `correo`, `dir`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'PEDRO MARTINEZ', '231231', 'LP', '', '', NULL, '', '2023-04-26', '2023-04-26 20:00:10', '2023-04-26 20:00:10'),
(2, 'MARIA GONZALES CASAS', '1231231', 'CB', '34324111', '666666; 7777777', 'MARIA@GMAIL.COM', 'LOS OLIVOS', '2023-04-26', '2023-04-26 20:05:20', '2023-04-26 20:05:50'),
(3, 'PABLO SANCHEZ', '43434', 'CB', '111111', '', '', '', '2023-04-26', '2023-04-26 20:07:17', '2023-04-26 20:07:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `web` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `ciudad`, `dir`, `fono`, `web`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISTEMA SISEMSYT', 'SISEMSYT', 'SISEMSYT S.A.', '10000000000', 'LA PAZ', 'LA PAZ', '222222', '', 'ACTIVIDAD', '', '1682712649_logo.jpg', NULL, '2024-09-05 13:51:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` double NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `subtotal` decimal(24,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `venta_id`, `producto_id`, `cantidad`, `precio`, `subtotal`, `created_at`, `updated_at`) VALUES
(5, 3, 1, 10, 20.00, 200.00, '2023-04-26 20:47:35', '2023-04-26 20:47:35'),
(6, 5, 1, 1, 20.00, 20.00, '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(8, 6, 1, 3, 20.00, 60.00, '2023-04-27 19:00:50', '2023-04-27 19:00:50'),
(9, 7, 7, 4, 12.00, 48.00, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(10, 7, 2, 1, 35.00, 35.00, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(11, 8, 3, 1, 100.00, 100.00, '2023-04-28 21:11:48', '2023-04-28 21:11:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fecha_stocks`
--

CREATE TABLE `fecha_stocks` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `stock` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `fecha_stocks`
--

INSERT INTO `fecha_stocks` (`id`, `producto_id`, `fecha`, `stock`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-04-27', 93, '2023-04-27 18:59:01', '2023-04-27 19:00:50'),
(2, 7, '2023-04-28', 86, '2023-04-28 15:42:04', '2023-04-28 19:53:34'),
(3, 2, '2023-04-28', 99, '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(4, 3, '2023-04-28', 69, '2023-04-28 21:11:48', '2023-04-28 21:11:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:22<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-17', '11:04:22', '2023-04-17 15:04:22', '2023-04-17 15:04:22'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:22<br/>', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1ASD<br/>updated_at: 2023-04-17 11:04:25<br/>', 'TIPO DE INGRESOS', '2023-04-17', '11:04:25', '2023-04-17 15:04:25', '2023-04-17 15:04:25'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1ASD<br/>updated_at: 2023-04-17 11:04:25<br/>', 'created_at: 2023-04-17 11:04:22<br/>descripcion: <br/>id: 1<br/>nombre: INGRESO TIPO 1<br/>updated_at: 2023-04-17 11:04:30<br/>', 'TIPO DE INGRESOS', '2023-04-17', '11:04:30', '2023-04-17 15:04:30', '2023-04-17 15:04:30'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: VENDEDOR<br/>foto: default.png<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>acceso: 1<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 16:23:30<br/>updated_at: 2023-04-24 16:23:30<br/>', NULL, 'USUARIOS', '2023-04-24', '16:23:31', '2023-04-24 20:23:31', '2023-04-24 20:23:31'),
(5, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:13<br/>', NULL, 'PROVEEDORES', '2023-04-24', '17:09:13', '2023-04-24 21:09:13', '2023-04-24 21:09:13'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:13<br/>', 'id: 1<br/>razon_social: PEPE S.A.S<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:17<br/>', 'PROVEEDORES', '2023-04-24', '17:09:17', '2023-04-24 21:09:17', '2023-04-24 21:09:17'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PROVEEDOR', 'id: 1<br/>razon_social: PEPE S.A.S<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:17<br/>', 'id: 1<br/>razon_social: PEPE S.A.<br/>nit: 3333<br/>dir: <br/>fono: 777777<br/>nombre_contacto: JOSE PAREDES<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:09:13<br/>updated_at: 2023-04-24 17:09:20<br/>', 'PROVEEDORES', '2023-04-24', '17:09:20', '2023-04-24 21:09:20', '2023-04-24 21:09:20'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>nombre: PASTILLAS A<br/>descripcion: <br/>precio: 20<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:36:20<br/>updated_at: 2023-04-24 17:36:20<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:36:20', '2023-04-24 21:36:20', '2023-04-24 21:36:20'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 2<br/>codigo_almacen: A001<br/>codigo_producto: P002<br/>nombre: GEL ANTIBACTERIAL<br/>descripcion: <br/>precio: 35<br/>stock_min: 5<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:44:24<br/>updated_at: 2023-04-24 17:44:24<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:44:24', '2023-04-24 21:44:24', '2023-04-24 21:44:24'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P003<br/>nombre: PRODUCTO 3<br/>descripcion: <br/>precio: 100<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:45:17<br/>updated_at: 2023-04-24 17:45:17<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:45:17', '2023-04-24 21:45:17', '2023-04-24 21:45:17'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 4<br/>codigo_almacen: ASD<br/>codigo_producto: ADS<br/>nombre: ASD<br/>descripcion: <br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372735_4.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:45:35<br/>updated_at: 2023-04-24 17:45:35<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:45:35', '2023-04-24 21:45:35', '2023-04-24 21:45:35'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 5<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASDAS<br/>descripcion: <br/>precio: 12<br/>stock_min: 2<br/>stock_actual: 0<br/>imagen: 1682372808_5.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:46:48<br/>updated_at: 2023-04-24 17:46:48<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:46:48', '2023-04-24 21:46:48', '2023-04-24 21:46:48'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372843_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:23<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:47:23', '2023-04-24 21:47:23', '2023-04-24 21:47:23'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372843_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:23<br/>', 'id: 6<br/>codigo_almacen: AS<br/>codigo_producto: DASD<br/>nombre: ASD<br/>descripcion: AS<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372848_6.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:23<br/>updated_at: 2023-04-24 17:47:28<br/>', 'PRODUCTOS', '2023-04-24', '17:47:28', '2023-04-24 21:47:28', '2023-04-24 21:47:28'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372874_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:54<br/>', NULL, 'PRODUCTOS', '2023-04-24', '17:47:54', '2023-04-24 21:47:54', '2023-04-24 21:47:54'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372874_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:54<br/>', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372879_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:59<br/>', 'PRODUCTOS', '2023-04-24', '17:47:59', '2023-04-24 21:47:59', '2023-04-24 21:47:59'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:37:56<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:37:57', '2023-04-25 14:37:57', '2023-04-25 14:37:57'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:37:56<br/>', 'created_at: 2023-04-25 10:37:56<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:00<br/>', 'TIPO DE INGRESOS', '2023-04-25', '10:38:00', '2023-04-25 14:38:00', '2023-04-25 14:38:00'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:37:56<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:00<br/>', 'created_at: 2023-04-25 10:37:56<br/>descripcion: <br/>id: 2<br/>nombre: TIPO INGRESO 2<br/>updated_at: 2023-04-25 10:38:04<br/>', 'TIPO DE INGRESOS', '2023-04-25', '10:38:04', '2023-04-25 14:38:04', '2023-04-25 14:38:04'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:38:08<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:08<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:38:08', '2023-04-25 14:38:08', '2023-04-25 14:38:08'),
(21, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE INGRESO', 'created_at: 2023-04-25 10:38:08<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:08<br/>', NULL, 'TIPO DE INGRESOS', '2023-04-25', '10:38:10', '2023-04-25 14:38:10', '2023-04-25 14:38:10'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:16<br/>descripcion: <br/>id: 1<br/>nombre: SALIDA 1<br/>updated_at: 2023-04-25 10:38:16<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:16', '2023-04-25 14:38:16', '2023-04-25 14:38:16'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:21<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:21', '2023-04-25 14:38:21', '2023-04-25 14:38:21'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:21<br/>', 'created_at: 2023-04-25 10:38:21<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:23<br/>', 'TIPO DE SALIDAS', '2023-04-25', '10:38:23', '2023-04-25 14:38:23', '2023-04-25 14:38:23'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:27<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:27<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:27', '2023-04-25 14:38:27', '2023-04-25 14:38:27'),
(26, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:27<br/>descripcion: ASD<br/>id: 3<br/>nombre: ASD<br/>updated_at: 2023-04-25 10:38:27<br/>', NULL, 'TIPO DE SALIDAS', '2023-04-25', '10:38:31', '2023-04-25 14:38:31', '2023-04-25 14:38:31'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE SALIDA', 'created_at: 2023-04-25 10:38:21<br/>descripcion: ASD<br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:23<br/>', 'created_at: 2023-04-25 10:38:21<br/>descripcion: <br/>id: 2<br/>nombre: TIPO DE SALIDA 2<br/>updated_at: 2023-04-25 10:38:35<br/>', 'TIPO DE SALIDAS', '2023-04-25', '10:38:35', '2023-04-25 14:38:35', '2023-04-25 14:38:35'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 100<br/>created_at: 2023-04-25 11:23:41<br/>descripcion: <br/>fecha_caducidad: 2025-02-02<br/>fecha_fabricacion: 2023-02-02<br/>fecha_registro: 2023-04-25<br/>id: 1<br/>lote: 1<br/>precio_compra: 20<br/>producto_id: 1<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:23:41<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:23:41', '2023-04-25 15:23:41', '2023-04-25 15:23:41'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 100<br/>created_at: 2023-04-25 11:25:58<br/>descripcion: <br/>fecha_caducidad: 2024-04-25<br/>fecha_fabricacion: 2023-04-25<br/>fecha_registro: 2023-04-25<br/>id: 2<br/>lote: 2<br/>precio_compra: 30<br/>producto_id: 2<br/>proveedor_id: 1<br/>tipo_ingreso_id: 2<br/>updated_at: 2023-04-25 11:25:58<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:25:58', '2023-04-25 15:25:58', '2023-04-25 15:25:58'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 50<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:28:29<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-25', '11:28:30', '2023-04-25 15:28:30', '2023-04-25 15:28:30'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN INGRESO DE PRODUCTO', 'cantidad: 50<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100.00<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:28:29<br/>', 'cantidad: 70<br/>created_at: 2023-04-25 11:28:29<br/>descripcion: <br/>fecha_caducidad: 2026-03-03<br/>fecha_fabricacion: 2023-03-03<br/>fecha_registro: 2023-04-25<br/>id: 3<br/>lote: 3<br/>precio_compra: 100.00<br/>producto_id: 3<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-04-25 11:31:20<br/>', 'INGRESO DE PRODUCTOS', '2023-04-25', '11:31:20', '2023-04-25 15:31:20', '2023-04-25 15:31:20'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:36<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:43:36', '2023-04-25 19:43:36', '2023-04-25 19:43:36'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:36<br/>', 'cantidad: 5<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:51<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:43:51', '2023-04-25 19:43:51', '2023-04-25 19:43:51'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 5<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:43:51<br/>', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:45:43<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:45:43', '2023-04-25 19:45:43', '2023-04-25 19:45:43'),
(35, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:46:09<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 2<br/>producto_id: 1<br/>tipo_salida_id: 2<br/>updated_at: 2023-04-25 15:46:09<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:09', '2023-04-25 19:46:09', '2023-04-25 19:46:09'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:45:43<br/>', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:12<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:12', '2023-04-25 19:46:12', '2023-04-25 19:46:12'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:12<br/>', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:26<br/>', 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:26', '2023-04-25 19:46:26', '2023-04-25 19:46:26'),
(38, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:46:09<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 2<br/>producto_id: 1<br/>tipo_salida_id: 2<br/>updated_at: 2023-04-25 15:46:09<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:46:51', '2023-04-25 19:46:51', '2023-04-25 19:46:51'),
(39, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:47:12<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:47:12', '2023-04-25 19:47:12', '2023-04-25 19:47:12'),
(40, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SALIDA DE PRODUCTO', 'cantidad: 1<br/>created_at: 2023-04-25 15:43:36<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-24<br/>id: 1<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:46:26<br/>', NULL, 'SALIDA DE PRODUCTOS', '2023-04-25', '15:47:17', '2023-04-25 19:47:17', '2023-04-25 19:47:17'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 231231<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-26 16:00:10<br/>dir: <br/>fecha_registro: 2023-04-26<br/>fono: <br/>id: 1<br/>nit: <br/>nombre: PEDRO MARTINEZ<br/>updated_at: 2023-04-26 16:00:10<br/>', NULL, 'CLIENTES', '2023-04-26', '16:00:10', '2023-04-26 20:00:10', '2023-04-26 20:00:10'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777; 22222<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:20<br/>', NULL, 'CLIENTES', '2023-04-26', '16:05:20', '2023-04-26 20:05:20', '2023-04-26 20:05:20'),
(43, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777; 22222<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:20<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:32<br/>', 'CLIENTES', '2023-04-26', '16:05:32', '2023-04-26 20:05:32', '2023-04-26 20:05:32'),
(44, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324242<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:32<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:38<br/>', 'CLIENTES', '2023-04-26', '16:05:38', '2023-04-26 20:05:38', '2023-04-26 20:05:38'),
(45, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES<br/>updated_at: 2023-04-26 16:05:38<br/>', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:42<br/>', 'CLIENTES', '2023-04-26', '16:05:42', '2023-04-26 20:05:42', '2023-04-26 20:05:42'),
(46, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: LP<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:42<br/>', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:45<br/>', 'CLIENTES', '2023-04-26', '16:05:45', '2023-04-26 20:05:45', '2023-04-26 20:05:45'),
(47, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN CLIENTE', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES MAMANI<br/>updated_at: 2023-04-26 16:05:45<br/>', 'ci: 1231231<br/>ci_exp: CB<br/>correo: MARIA@GMAIL.COM<br/>created_at: 2023-04-26 16:05:20<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-26<br/>fono: 666666; 7777777<br/>id: 2<br/>nit: 34324111<br/>nombre: MARIA GONZALES CASAS<br/>updated_at: 2023-04-26 16:05:50<br/>', 'CLIENTES', '2023-04-26', '16:05:50', '2023-04-26 20:05:50', '2023-04-26 20:05:50'),
(48, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', 'ci: 43434<br/>ci_exp: CB<br/>correo: <br/>created_at: 2023-04-26 16:07:17<br/>dir: <br/>fecha_registro: 2023-04-26<br/>fono: <br/>id: 3<br/>nit: 111111<br/>nombre: PABLO SANCHEZ<br/>updated_at: 2023-04-26 16:07:17<br/>', NULL, 'CLIENTES', '2023-04-26', '16:07:17', '2023-04-26 20:07:17', '2023-04-26 20:07:17'),
(49, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', '', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:29:21', '2023-04-26 20:29:21', '2023-04-26 20:29:21'),
(50, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:37:59<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:37:59', '2023-04-26 20:37:59', '2023-04-26 20:37:59'),
(51, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:37:59<br/>user_id: 1<br/>', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 330.00<br/>total_final: 297.00<br/>updated_at: 2023-04-26 16:43:06<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:43:06', '2023-04-26 20:43:06', '2023-04-26 20:43:06'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 330.00<br/>total_final: 297.00<br/>updated_at: 2023-04-26 16:43:06<br/>user_id: 1<br/>', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:43:28<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:43:28', '2023-04-26 20:43:28', '2023-04-26 20:43:28'),
(53, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-26 16:37:59<br/>descuento: 10<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 4<br/>nit: 1231231<br/>total: 310.00<br/>total_final: 279.00<br/>updated_at: 2023-04-26 16:43:28<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-26', '16:45:18', '2023-04-26 20:45:18', '2023-04-26 20:45:18'),
(54, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA SALIDA DE PRODUCTO', 'cantidad: 2<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-25 15:47:12<br/>', 'cantidad: 3<br/>created_at: 2023-04-25 15:47:12<br/>descripcion: <br/>fecha_registro: 2023-04-25<br/>fecha_salida: 2023-04-25<br/>id: 3<br/>producto_id: 1<br/>tipo_salida_id: 1<br/>updated_at: 2023-04-26 16:46:46<br/>', 'SALIDA DE PRODUCTOS', '2023-04-26', '16:46:46', '2023-04-26 20:46:46', '2023-04-26 20:46:46'),
(55, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 80.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:29:21<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 0.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:13<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:47:13', '2023-04-26 20:47:13', '2023-04-26 20:47:13'),
(56, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 0.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:13<br/>user_id: 1<br/>', 'cliente_id: 1<br/>created_at: 2023-04-26 16:29:21<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-26<br/>id: 3<br/>nit: 231231<br/>total: 200.00<br/>total_final: 80.00<br/>updated_at: 2023-04-26 16:47:35<br/>user_id: 1<br/>', 'ORDEN DE VENTA', '2023-04-26', '16:47:35', '2023-04-26 20:47:35', '2023-04-26 20:47:35'),
(57, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 4<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20<br/>cantidad: 10<br/>lote: 10<br/>fecha_fabricacion: 2023-04-27<br/>fecha_caducidad: 2025-04-27<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 14:59:01<br/>updated_at: 2023-04-27 14:59:01<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-27', '14:59:01', '2023-04-27 18:59:01', '2023-04-27 18:59:01'),
(58, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 5<br/>user_id: 1<br/>cliente_id: 1<br/>nit: 231231<br/>total: 20.00<br/>descuento: 0<br/>total_final: 20.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 14:59:27<br/>updated_at: 2023-04-27 14:59:27<br/>', NULL, 'ORDEN DE VENTA', '2023-04-27', '14:59:27', '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(59, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 120.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:19<br/>', NULL, 'ORDEN DE VENTA', '2023-04-27', '15:00:19', '2023-04-27 19:00:19', '2023-04-27 19:00:19'),
(60, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 120.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:19<br/>', 'id: 6<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 60.00<br/>descuento: 0<br/>total_final: 120.00<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-27<br/>created_at: 2023-04-27 15:00:19<br/>updated_at: 2023-04-27 15:00:50<br/>', 'ORDEN DE VENTA', '2023-04-27', '15:00:50', '2023-04-27 19:00:50', '2023-04-27 19:00:50'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PROVEEDOR', 'id: 2<br/>razon_social: PROVEEDOR SRL<br/>nit: 34343<br/>dir: <br/>fono: 2222<br/>nombre_contacto: <br/>descripcion: <br/>fecha_registro: 2023-04-28<br/>created_at: 2023-04-28 11:22:08<br/>updated_at: 2023-04-28 11:22:08<br/>', NULL, 'PROVEEDORES', '2023-04-28', '11:22:08', '2023-04-28 15:22:08', '2023-04-28 15:22:08'),
(62, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: ASD<br/>codigo_producto: ASD<br/>nombre: ASD<br/>descripcion: ASD<br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682372879_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-24 17:47:59<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'PRODUCTOS', '2023-04-28', '11:40:58', '2023-04-28 15:40:58', '2023-04-28 15:40:58'),
(63, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'PRODUCTOS', '2023-04-28', '11:41:05', '2023-04-28 15:41:05', '2023-04-28 15:41:05'),
(64, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: <br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:40:58<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696491_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:31<br/>', 'PRODUCTOS', '2023-04-28', '11:41:31', '2023-04-28 15:41:31', '2023-04-28 15:41:31'),
(65, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696491_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:31<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696493_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:33<br/>', 'PRODUCTOS', '2023-04-28', '11:41:33', '2023-04-28 15:41:33', '2023-04-28 15:41:33'),
(66, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696493_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:33<br/>', 'id: 7<br/>codigo_almacen: A00111<br/>codigo_producto: P004<br/>nombre: PRODUCTO 4<br/>descripcion: <br/>precio: 12.00<br/>stock_min: 12<br/>stock_actual: 0<br/>imagen: 1682696496_7.jpg<br/>fecha_registro: 2023-04-24<br/>created_at: 2023-04-24 17:47:54<br/>updated_at: 2023-04-28 11:41:36<br/>', 'PRODUCTOS', '2023-04-28', '11:41:36', '2023-04-28 15:41:36', '2023-04-28 15:41:36'),
(67, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 5<br/>producto_id: 7<br/>proveedor_id: 2<br/>precio_compra: 11<br/>cantidad: 90<br/>lote: 322323<br/>fecha_fabricacion: 2023-01-01<br/>fecha_caducidad: 2025-01-01<br/>tipo_ingreso_id: 1<br/>descripcion: <br/>fecha_registro: 2023-04-28<br/>created_at: 2023-04-28 11:42:04<br/>updated_at: 2023-04-28 11:42:04<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-04-28', '11:42:04', '2023-04-28 15:42:04', '2023-04-28 15:42:04'),
(68, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-28 15:53:34<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-28<br/>id: 7<br/>nit: 1231231<br/>total: 83.00<br/>total_final: 83.00<br/>updated_at: 2023-04-28 15:53:34<br/>user_id: 1<br/>', NULL, 'ORDEN DE VENTA', '2023-04-28', '15:53:34', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(69, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA NUEVAERA<br/>updated_at: 2023-04-15 14:39:44<br/>web: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:08:46<br/>web: <br/>', 'CONFIGURACIÓN', '2023-04-28', '16:08:46', '2023-04-28 20:08:46', '2023-04-28 20:08:46'),
(70, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1681583846_logo.webp<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:08:46<br/>web: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1682712649_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:10:49<br/>web: <br/>', 'CONFIGURACIÓN', '2023-04-28', '16:10:49', '2023-04-28 20:10:49', '2023-04-28 20:10:49'),
(71, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-24 16:23:30<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: GERENCIA<br/>updated_at: 2023-04-28 17:05:08<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:05:08', '2023-04-28 21:05:08', '2023-04-28 21:05:08'),
(72, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: GERENCIA<br/>updated_at: 2023-04-28 17:05:08<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:06:13<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:06:13', '2023-04-28 21:06:13', '2023-04-28 21:06:13'),
(73, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PROVEEDOR', 'created_at: 2023-04-28 17:07:52<br/>descripcion: <br/>dir: ASD<br/>fecha_registro: 2023-04-28<br/>fono: ASD<br/>id: 3<br/>nit: ASD<br/>nombre_contacto: <br/>razon_social: ASD<br/>updated_at: 2023-04-28 17:07:52<br/>', NULL, 'PROVEEDORES', '2023-04-28', '17:07:52', '2023-04-28 21:07:52', '2023-04-28 21:07:52'),
(74, 2, 'ELIMINACIÓN', 'EL USUARIO JPERES ELIMINÓ UN PROVEEDOR', 'created_at: 2023-04-28 17:07:52<br/>descripcion: <br/>dir: ASD<br/>fecha_registro: 2023-04-28<br/>fono: ASD<br/>id: 3<br/>nit: ASD<br/>nombre_contacto: <br/>razon_social: ASD<br/>updated_at: 2023-04-28 17:07:52<br/>', NULL, 'PROVEEDORES', '2023-04-28', '17:07:54', '2023-04-28 21:07:54', '2023-04-28 21:07:54'),
(75, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:06:13<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-28 17:11:20<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:11:20', '2023-04-28 21:11:20', '2023-04-28 21:11:20'),
(76, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UNA ORDEN DE VENTA', 'cliente_id: 2<br/>created_at: 2023-04-28 17:11:48<br/>descuento: 0<br/>estado: CANCELADO<br/>fecha_registro: 2023-04-28<br/>id: 8<br/>nit: 1231231<br/>total: 100.00<br/>total_final: 100.00<br/>updated_at: 2023-04-28 17:11:48<br/>user_id: 2<br/>', NULL, 'ORDEN DE VENTA', '2023-04-28', '17:11:48', '2023-04-28 21:11:48', '2023-04-28 21:11:48'),
(77, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: VENDEDOR<br/>updated_at: 2023-04-28 17:11:20<br/>usuario: JPERES<br/>', 'acceso: 1<br/>ci: 1234<br/>ci_exp: LP<br/>correo: <br/>created_at: 2023-04-24 16:23:30<br/>dir: LOS OLIVOS<br/>fecha_registro: 2023-04-24<br/>fono: 777777<br/>foto: default.png<br/>id: 2<br/>materno: MAMANI<br/>nombre: JUAN<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>paterno: PERES<br/>tipo: SUPERVISOR<br/>updated_at: 2023-04-28 17:12:44<br/>usuario: JPERES<br/>', 'USUARIOS', '2023-04-28', '17:12:44', '2023-04-28 21:12:44', '2023-04-28 21:12:44'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'codigo_almacen: A002<br/>codigo_producto: P00SIN<br/>created_at: 2023-05-19 19:26:32<br/>descripcion: DEC<br/>fecha_registro: 2023-05-19<br/>id: 8<br/>imagen: <br/>nombre: SIN DEPENDENCIA<br/>precio: 100<br/>stock_actual: 0<br/>stock_min: 50<br/>updated_at: 2023-05-19 19:26:32<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:26:33', '2023-05-19 23:26:33', '2023-05-19 23:26:33'),
(79, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINO UN PRODUCTO', 'codigo_almacen: A002<br/>codigo_producto: P00SIN<br/>created_at: 2023-05-19 19:26:32<br/>descripcion: DEC<br/>fecha_registro: 2023-05-19<br/>id: 8<br/>imagen: <br/>nombre: SIN DEPENDENCIA<br/>precio: 100.00<br/>stock_actual: 0<br/>stock_min: 50<br/>updated_at: 2023-05-19 19:26:32<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:29:41', '2023-05-19 23:29:41', '2023-05-19 23:29:41'),
(80, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'codigo_almacen: ASDA<br/>codigo_producto: ASDASD<br/>created_at: 2023-05-19 19:31:12<br/>descripcion: ASD<br/>fecha_registro: 2023-05-19<br/>id: 9<br/>imagen: <br/>nombre: ASDASD<br/>precio: 100<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:31:12<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:31:12', '2023-05-19 23:31:12', '2023-05-19 23:31:12'),
(81, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'cantidad: 900<br/>created_at: 2023-05-19 19:31:58<br/>descripcion: <br/>fecha_caducidad: 2025-02-22<br/>fecha_fabricacion: 2023-05-19<br/>fecha_registro: 2023-05-19<br/>id: 6<br/>lote: 9090<br/>precio_compra: 100<br/>producto_id: 9<br/>proveedor_id: 1<br/>tipo_ingreso_id: 1<br/>updated_at: 2023-05-19 19:31:58<br/>', NULL, 'INGRESO DE PRODUCTOS', '2023-05-19', '19:31:58', '2023-05-19 23:31:58', '2023-05-19 23:31:58'),
(82, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINO UN PRODUCTO', 'codigo_almacen: ASDA<br/>codigo_producto: ASDASD<br/>created_at: 2023-05-19 19:31:12<br/>descripcion: ASD<br/>fecha_registro: 2023-05-19<br/>id: 9<br/>imagen: <br/>nombre: ASDASD<br/>precio: 100.00<br/>stock_actual: 900<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:31:58<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:32:12', '2023-05-19 23:32:12', '2023-05-19 23:32:12'),
(83, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:47:02<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:47:02', '2023-05-19 23:47:02', '2023-05-19 23:47:02'),
(84, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:47:02<br/>', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2ASDSA<br/>updated_at: 2023-05-19 19:47:11<br/>', 'TIPO DE INGRESOS', '2023-05-19', '19:47:11', '2023-05-19 23:47:11', '2023-05-19 23:47:11'),
(85, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:47:02<br/>id: 2<br/>nombre: CATEGORIA 2ASDSA<br/>updated_at: 2023-05-19 19:47:11<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:47:21', '2023-05-19 23:47:21', '2023-05-19 23:47:21'),
(86, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN TIPO DE INGRESO', 'created_at: 2023-05-19 19:49:01<br/>id: 3<br/>nombre: CATEGORIA 2<br/>updated_at: 2023-05-19 19:49:01<br/>', NULL, 'TIPO DE INGRESOS', '2023-05-19', '19:49:01', '2023-05-19 23:49:01', '2023-05-19 23:49:01'),
(87, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:04<br/>', NULL, 'PRODUCTOS', '2023-05-19', '19:55:04', '2023-05-19 23:55:04', '2023-05-19 23:55:04'),
(88, 2, 'MODIFICACIÓN', 'EL USUARIO JPERES MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99.00<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:04<br/>', 'categoria_id: 3<br/>codigo_almacen: A002222<br/>codigo_producto: P0044<br/>created_at: 2023-05-19 19:55:04<br/>descripcion: DESC<br/>fecha_registro: 2023-05-19<br/>id: 10<br/>imagen: <br/>nombre: PRODUCTO NUEVO P0044<br/>precio: 99.00<br/>stock_actual: 0<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:13<br/>', 'PRODUCTOS', '2023-05-19', '19:55:13', '2023-05-19 23:55:13', '2023-05-19 23:55:13'),
(89, 2, 'MODIFICACIÓN', 'EL USUARIO JPERES MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PASTILLAS A<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2023-04-27 15:00:50<br/>', 'categoria_id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PASTILLAS A<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:53<br/>', 'PRODUCTOS', '2023-05-19', '19:55:53', '2023-05-19 23:55:53', '2023-05-19 23:55:53'),
(90, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISTEMABI<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1682712649_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA DE INVENTARIO Y VENTAS<br/>razon_social: EMPRESA FARMACIA<br/>updated_at: 2023-04-28 16:10:49<br/>web: <br/>', 'actividad: ACTIVIDAD<br/>alias: SISEMSYT<br/>ciudad: LA PAZ<br/>correo: <br/>created_at: <br/>dir: LA PAZ<br/>fono: 222222<br/>id: 1<br/>logo: 1682712649_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA SISEMSYT<br/>razon_social: SISEMSYT S.A.<br/>updated_at: 2024-09-05 09:51:07<br/>web: <br/>', 'CONFIGURACIÓN', '2024-09-05', '09:51:07', '2024-09-05 13:51:07', '2024-09-05 13:51:07'),
(91, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'categoria_id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PASTILLAS A<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2023-05-19 19:55:53<br/>', 'categoria_id: 3<br/>codigo_almacen: A001<br/>codigo_producto: P001<br/>created_at: 2023-04-24 17:36:20<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 1<br/>imagen: <br/>nombre: PRODUCTO #1<br/>precio: 20.00<br/>stock_actual: 93<br/>stock_min: 10<br/>updated_at: 2024-09-05 10:33:52<br/>', 'PRODUCTOS', '2024-09-05', '10:33:52', '2024-09-05 14:33:52', '2024-09-05 14:33:52'),
(92, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P002<br/>created_at: 2023-04-24 17:44:24<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 2<br/>imagen: <br/>nombre: GEL ANTIBACTERIAL<br/>precio: 35.00<br/>stock_actual: 99<br/>stock_min: 5<br/>updated_at: 2023-04-28 15:53:34<br/>', 'categoria_id: 1<br/>codigo_almacen: A001<br/>codigo_producto: P002<br/>created_at: 2023-04-24 17:44:24<br/>descripcion: <br/>fecha_registro: 2023-04-24<br/>id: 2<br/>imagen: <br/>nombre: PRODUCTO #2<br/>precio: 35.00<br/>stock_actual: 99<br/>stock_min: 5<br/>updated_at: 2024-09-05 10:33:58<br/>', 'PRODUCTOS', '2024-09-05', '10:33:58', '2024-09-05 14:33:58', '2024-09-05 14:33:58'),
(93, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068201_11.png<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:21<br/>', NULL, 'PRODUCTOS', '2024-09-11', '11:23:21', '2024-09-11 15:23:21', '2024-09-11 15:23:21'),
(94, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068201_11.png<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:21<br/>', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068210_11.png<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:30<br/>', 'PRODUCTOS', '2024-09-11', '11:23:30', '2024-09-11 15:23:30', '2024-09-11 15:23:30');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(95, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068210_11.png<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:30<br/>', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068215_11.jpg<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:35<br/>', 'PRODUCTOS', '2024-09-11', '11:23:35', '2024-09-11 15:23:35', '2024-09-11 15:23:35'),
(96, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068215_11.jpg<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:35<br/>', 'categoria_id: 1<br/>codigo_producto: COD.6<br/>created_at: 2024-09-11 11:23:21<br/>descripcion: DESC. PROD 6<br/>fecha_registro: 2024-09-11<br/>id: 11<br/>imagen: 1726068221_11.png<br/>nombre: PRODUCTO #6<br/>nro_codigo: 6<br/>precio: 304.00<br/>stock_actual: 0<br/>stock_min: 5<br/>updated_at: 2024-09-11 11:23:41<br/>', 'PRODUCTOS', '2024-09-11', '11:23:41', '2024-09-11 15:23:41', '2024-09-11 15:23:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso_productos`
--

CREATE TABLE `ingreso_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `proveedor_id` bigint UNSIGNED NOT NULL,
  `precio_compra` decimal(8,2) NOT NULL,
  `cantidad` double NOT NULL,
  `lote` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_fabricacion` date NOT NULL,
  `tipo_ingreso_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingreso_productos`
--

INSERT INTO `ingreso_productos` (`id`, `producto_id`, `proveedor_id`, `precio_compra`, `cantidad`, `lote`, `fecha_fabricacion`, `tipo_ingreso_id`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 20.00, 100, '1', '2023-02-02', 1, '', '2023-04-25', '2023-04-25 15:23:41', '2023-04-25 15:23:41'),
(2, 2, 1, 30.00, 100, '2', '2023-04-25', 2, '', '2023-04-25', '2023-04-25 15:25:58', '2023-04-25 15:25:58'),
(3, 3, 1, 100.00, 70, '3', '2023-03-03', 1, '', '2023-04-25', '2023-04-25 15:28:29', '2023-04-25 15:31:20'),
(4, 1, 1, 20.00, 10, '10', '2023-04-27', 1, '', '2023-04-27', '2023-04-27 18:59:01', '2023-04-27 18:59:01'),
(5, 7, 2, 11.00, 90, '322323', '2023-01-01', 1, '', '2023-04-28', '2023-04-28 15:42:04', '2023-04-28 15:42:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex_productos`
--

CREATE TABLE `kardex_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `lugar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_registro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro_id` bigint UNSIGNED DEFAULT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `detalle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `tipo_is` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad_ingreso` double DEFAULT NULL,
  `cantidad_salida` double DEFAULT NULL,
  `cantidad_saldo` double NOT NULL,
  `cu` decimal(24,2) NOT NULL,
  `monto_ingreso` decimal(24,2) DEFAULT NULL,
  `monto_salida` decimal(24,2) DEFAULT NULL,
  `monto_saldo` decimal(24,2) NOT NULL,
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `kardex_productos`
--

INSERT INTO `kardex_productos` (`id`, `lugar`, `tipo_registro`, `registro_id`, `producto_id`, `detalle`, `precio`, `tipo_is`, `cantidad_ingreso`, `cantidad_salida`, `cantidad_saldo`, `cu`, `monto_ingreso`, `monto_salida`, `monto_saldo`, `fecha`, `created_at`, `updated_at`) VALUES
(1, NULL, 'INGRESO', 1, 1, 'VALOR INICIAL', 20.00, 'INGRESO', 100, NULL, 100, 20.00, 2000.00, NULL, 2000.00, '2023-04-25', '2023-04-25 15:23:41', '2023-04-25 19:47:17'),
(2, NULL, 'INGRESO', 2, 2, 'VALOR INICIAL', 35.00, 'INGRESO', 100, NULL, 100, 35.00, 3500.00, NULL, 3500.00, '2023-04-25', '2023-04-25 15:25:58', '2023-04-26 20:45:18'),
(3, NULL, 'INGRESO', 3, 3, 'VALOR INICIAL', 100.00, 'INGRESO', 70, NULL, 70, 100.00, 7000.00, NULL, 7000.00, '2023-04-25', '2023-04-25 15:28:29', '2023-04-26 20:45:18'),
(6, NULL, 'SALIDA', 3, 1, 'SALIDA DE PRODUCTO', 20.00, 'EGRESO', NULL, 3, 97, 20.00, NULL, 60.00, 1940.00, '2023-04-25', '2023-04-25 19:47:12', '2023-04-26 20:47:13'),
(11, NULL, 'VENTA', 5, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 10, 87, 20.00, NULL, 200.00, 1740.00, '2023-04-26', '2023-04-26 20:47:35', '2023-04-26 20:47:35'),
(12, NULL, 'INGRESO', 4, 1, 'INGRESO DE PRODUCTO', 20.00, 'INGRESO', 10, NULL, 97, 20.00, 200.00, NULL, 1940.00, '2023-04-27', '2023-04-27 18:59:01', '2023-04-27 18:59:01'),
(13, NULL, 'VENTA', 6, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 1, 96, 20.00, NULL, 20.00, 1920.00, '2023-04-27', '2023-04-27 18:59:27', '2023-04-27 19:00:50'),
(15, NULL, 'VENTA', 8, 1, 'VENTA DE PRODUCTO', 20.00, 'EGRESO', NULL, 3, 93, 20.00, NULL, 60.00, 1860.00, '2023-04-27', '2023-04-27 19:00:50', '2023-04-27 19:00:50'),
(16, NULL, 'INGRESO', 5, 7, 'VALOR INICIAL', 12.00, 'INGRESO', 90, NULL, 90, 12.00, 1080.00, NULL, 1080.00, '2023-04-28', '2023-04-28 15:42:04', '2023-04-28 15:42:04'),
(17, NULL, 'VENTA', 9, 7, 'VENTA DE PRODUCTO', 12.00, 'EGRESO', NULL, 4, 86, 12.00, NULL, 48.00, 1032.00, '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(18, NULL, 'VENTA', 10, 2, 'VENTA DE PRODUCTO', 35.00, 'EGRESO', NULL, 1, 99, 35.00, NULL, 35.00, 3465.00, '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(19, NULL, 'VENTA', 11, 3, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 69, 100.00, NULL, 100.00, 6900.00, '2023-04-28', '2023-04-28 21:11:48', '2023-04-28 21:11:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_04_27_123517_create_fecha_stocks_table', 1),
(2, '2023_05_19_193721_create_categorias_table', 2),
(3, '2024_09_11_112545_create_notificacions_table', 3),
(4, '2024_09_11_112717_create_notificacion_users_table', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacions`
--

CREATE TABLE `notificacions` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registro_id` bigint UNSIGNED DEFAULT NULL,
  `descripcion` varchar(900) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacions`
--

INSERT INTO `notificacions` (`id`, `tipo`, `registro_id`, `descripcion`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 'STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO PRODUCTO #1 SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-09-13', '11:17:11', '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(2, 'STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO PRODUCTO #2 SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-09-13', '11:17:11', '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(3, 'STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO 3 SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-09-13', '11:17:11', '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(4, 'STOCK MINIMO', 7, 'ALERTA URGENTE EL PRODUCTO PRODUCTO 4 SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-09-13', '11:17:11', '2024-09-13 15:17:11', '2024-09-13 15:17:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion_users`
--

CREATE TABLE `notificacion_users` (
  `id` bigint UNSIGNED NOT NULL,
  `notificacion_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `visto` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificacion_users`
--

INSERT INTO `notificacion_users` (`id`, `notificacion_id`, `user_id`, `visto`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 0, '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(2, 2, 2, 0, '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(3, 3, 2, 0, '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(4, 4, 2, 0, '2024-09-13 15:17:11', '2024-09-13 15:17:11'),
(5, 1, 1, 0, '2024-09-13 15:41:00', '2024-09-13 15:41:00'),
(6, 2, 1, 0, '2024-09-13 15:41:00', '2024-09-13 15:41:00'),
(7, 3, 1, 1, '2024-09-13 15:41:00', '2024-09-13 16:18:47'),
(8, 4, 1, 1, '2024-09-13 15:41:00', '2024-09-13 16:17:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint UNSIGNED NOT NULL,
  `codigo_producto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nro_codigo` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `precio` decimal(24,2) NOT NULL,
  `stock_min` double NOT NULL,
  `stock_actual` double NOT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo_producto`, `nro_codigo`, `nombre`, `descripcion`, `precio`, `stock_min`, `stock_actual`, `imagen`, `categoria_id`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'COD.1', 1, 'PRODUCTO #1', '', 20.00, 10, 93, '', 3, '2023-04-24', '2023-04-24 21:36:20', '2024-09-05 14:33:52'),
(2, 'COD.2', 2, 'PRODUCTO #2', '', 35.00, 5, 99, '', 1, '2023-04-24', '2023-04-24 21:44:24', '2024-09-05 14:33:58'),
(3, 'COD.3', 3, 'PRODUCTO 3', '', 100.00, 10, 69, NULL, 1, '2023-04-24', '2023-04-24 21:45:17', '2023-04-28 21:11:48'),
(7, 'COD.4', 4, 'PRODUCTO 4', '', 12.00, 12, 86, '1682696496_7.jpg', 1, '2023-04-24', '2023-04-24 21:47:54', '2023-04-28 19:53:34'),
(10, 'COD.5', 5, 'PRODUCTO NUEVO P0044', 'DESC', 99.00, 10, 0, '', 3, '2023-05-19', '2023-05-19 23:55:04', '2023-05-19 23:55:13'),
(11, 'COD.6', 6, 'PRODUCTO #6', 'DESC. PROD 6', 304.00, 5, 0, '1726068221_11.png', 1, '2024-09-11', '2024-09-11 15:23:21', '2024-09-11 15:23:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedors`
--

CREATE TABLE `proveedors` (
  `id` bigint UNSIGNED NOT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_contacto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedors`
--

INSERT INTO `proveedors` (`id`, `razon_social`, `nit`, `dir`, `fono`, `nombre_contacto`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'PEPE S.A.', '3333', '', '777777', 'JOSE PAREDES', '', '2023-04-24', '2023-04-24 21:09:13', '2023-04-24 21:09:20'),
(2, 'PROVEEDOR SRL', '34343', '', '2222', '', '', '2023-04-28', '2023-04-28 15:22:08', '2023-04-28 15:22:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida_productos`
--

CREATE TABLE `salida_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` int NOT NULL,
  `fecha_salida` date NOT NULL,
  `tipo_salida_id` bigint UNSIGNED NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `salida_productos`
--

INSERT INTO `salida_productos` (`id`, `producto_id`, `cantidad`, `fecha_salida`, `tipo_salida_id`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(3, 1, 3, '2023-04-25', 1, '', '2023-04-25', '2023-04-25 19:47:12', '2023-04-26 20:46:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ingresos`
--

CREATE TABLE `tipo_ingresos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_ingresos`
--

INSERT INTO `tipo_ingresos` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'INGRESO TIPO 1', '', '2023-04-17 15:04:22', '2023-04-17 15:04:30'),
(2, 'TIPO INGRESO 2', '', '2023-04-25 14:37:56', '2023-04-25 14:38:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_salidas`
--

CREATE TABLE `tipo_salidas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_salidas`
--

INSERT INTO `tipo_salidas` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`) VALUES
(1, 'SALIDA 1', '', '2023-04-25 14:38:16', '2023-04-25 14:38:16'),
(2, 'TIPO DE SALIDA 2', '', '2023-04-25 14:38:21', '2023-04-25 14:38:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo` enum('ADMINISTRADOR','GERENCIA','SUPERVISOR','VENDEDOR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '', '', '', NULL, '', 'ADMINISTRADOR', NULL, '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2023-01-11', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', '', '777777', 'SUPERVISOR', 'default.png', '$2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS', 1, '2023-04-24', '2023-04-24 20:23:30', '2023-04-28 21:12:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nit` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `descuento` double(8,2) NOT NULL,
  `total_final` decimal(24,2) NOT NULL,
  `estado` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `user_id`, `cliente_id`, `nit`, `total`, `descuento`, `total_final`, `estado`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(3, 1, 1, '231231', 200.00, 0.00, 80.00, 'CANCELADO', '2023-04-26', '2023-04-26 20:29:21', '2023-04-26 20:47:35'),
(5, 1, 1, '231231', 20.00, 0.00, 20.00, 'CANCELADO', '2023-04-27', '2023-04-27 18:59:27', '2023-04-27 18:59:27'),
(6, 1, 3, '43434', 60.00, 0.00, 120.00, 'CANCELADO', '2023-04-27', '2023-04-27 19:00:19', '2023-04-27 19:00:50'),
(7, 1, 2, '1231231', 83.00, 0.00, 83.00, 'CANCELADO', '2023-04-28', '2023-04-28 19:53:34', '2023-04-28 19:53:34'),
(8, 2, 2, '1231231', 100.00, 0.00, 100.00, 'CANCELADO', '2023-04-28', '2023-04-28 21:11:48', '2023-04-28 21:11:48');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detalle_ordens_orden_id_foreign` (`venta_id`),
  ADD KEY `detalle_ordens_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fecha_stocks_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingreso_productos_producto_id_foreign` (`producto_id`),
  ADD KEY `ingreso_productos_proveedor_id_foreign` (`proveedor_id`),
  ADD KEY `ingreso_productos_tipo_ingreso_id_foreign` (`tipo_ingreso_id`);

--
-- Indices de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kardex_productos_producto_id_foreign` (`producto_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notificacion_users_notificacion_id_foreign` (`notificacion_id`),
  ADD KEY `notificacion_users_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salida_productos_producto_id_foreign` (`producto_id`),
  ADD KEY `salida_productos_tipo_salida_id_foreign` (`tipo_salida_id`);

--
-- Indices de la tabla `tipo_ingresos`
--
ALTER TABLE `tipo_ingresos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_salidas`
--
ALTER TABLE `tipo_salidas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orden_ventas_cliente_id_foreign` (`cliente_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_ingresos`
--
ALTER TABLE `tipo_ingresos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_salidas`
--
ALTER TABLE `tipo_salidas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  ADD CONSTRAINT `fecha_stocks_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  ADD CONSTRAINT `notificacion_users_notificacion_id_foreign` FOREIGN KEY (`notificacion_id`) REFERENCES `notificacions` (`id`),
  ADD CONSTRAINT `notificacion_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
