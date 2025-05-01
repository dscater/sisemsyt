-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-05-2025 a las 01:02:20
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CATEGORIA UNO', 1, '2024-09-25 19:27:00', '2024-11-04 21:02:00'),
(2, 'CATEGORIA DOS', 1, '2024-11-04 21:01:08', '2024-11-04 21:04:02'),
(18, 'ASDASDASD', 1, '2025-04-01 23:06:19', '2025-04-01 23:06:19');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `ci`, `ci_exp`, `nit`, `fono`, `correo`, `dir`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PEDRO MARTINEZ', '2312314', 'LP', '1234567', '1234567', 'PEDRO@GMAIL.COM', 'LOS OLIVOS NRO. 2', '2023-04-26', 1, '2023-04-26 20:00:10', '2024-11-23 12:55:34'),
(2, 'MARIA GONZALES CASAS', '1231231', 'CB', '34324111', '7777777', 'MARIA@GMAIL.COM', 'LOS OLIVOS', '2023-04-26', 1, '2023-04-26 20:05:20', '2025-04-23 12:43:57'),
(3, 'PABLO SANCHEZ', '43434', 'CB', '111111', '', '', '', '2023-04-26', 1, '2023-04-26 20:07:17', '2023-04-26 20:07:17'),
(4, 'GABRIEL GONZALES', '234234234234', 'LP', '23232323', '', NULL, NULL, '2025-04-23', 1, '2025-04-23 12:50:33', '2025-04-23 12:50:33'),
(5, 'CLIENTE NUEVO S.A.', '23232323', 'LP', '12311123123123', '', NULL, NULL, '2025-04-30', 1, '2025-05-01 00:41:24', '2025-05-01 00:41:24'),
(6, 'EDSON RAMIRES', '34322222', 'OR', '5445454545', '', NULL, NULL, '2025-04-30', 1, '2025-05-01 00:43:39', '2025-05-01 00:43:39'),
(7, 'PABLO MARTINEZ', '12312312313', 'SC', '323232323', '5454454554', 'PABLO@GMAIL.COM', 'LOS PEDREGALES', '2025-04-30', 1, '2025-05-01 00:45:03', '2025-05-01 00:45:03'),
(8, 'JUAN HERRERA', '334343434', 'CB', '34343434', '', '', '', '2025-04-30', 1, '2025-05-01 00:45:22', '2025-05-01 00:45:22');

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
  `conf_email` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `ciudad`, `dir`, `fono`, `web`, `actividad`, `correo`, `logo`, `conf_email`, `created_at`, `updated_at`) VALUES
(1, 'SISTEMA SISEMSYT', 'SISEMSYT', 'SISEMSYT S.A.', '10000000000', 'LA PAZ', 'LA PAZ', '2222222', 'SISEMSYT.TEST', 'ACTIVIDAD', 'SISEMSYT@GMAIL.COM', '1743550156_logo.jpg', '{\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}', NULL, '2025-04-01 23:29:16');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_ventas`
--

INSERT INTO `detalle_ventas` (`id`, `venta_id`, `producto_id`, `cantidad`, `precio`, `subtotal`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 100.00, 100.00, 1, '2024-12-06 19:00:07', '2024-12-06 19:00:07'),
(4, 1, 2, 2, 200.00, 400.00, 1, '2025-03-11 14:25:44', '2025-03-11 14:25:44'),
(5, 2, 1, 4, 100.00, 400.00, 1, '2025-03-12 19:35:12', '2025-03-12 19:35:12'),
(6, 3, 3, 30, 999.99, 29999.70, 1, '2025-03-12 19:54:12', '2025-03-12 19:54:12'),
(7, 1, 3, 1, 999.99, 999.99, 1, '2025-03-12 20:15:47', '2025-03-12 20:15:47'),
(8, 4, 4, 4, 230.00, 920.00, 1, '2025-03-31 23:28:42', '2025-03-31 23:28:42'),
(9, 5, 4, 1, 230.00, 230.00, 0, '2025-03-31 23:38:58', '2025-04-01 23:09:46'),
(10, 1, 4, 1, 230.00, 230.00, 1, '2025-04-01 23:11:21', '2025-04-01 23:11:21'),
(11, 6, 1, 1, 100.00, 100.00, 1, '2025-04-01 23:29:31', '2025-04-01 23:29:31'),
(12, 7, 2, 1, 200.00, 200.00, 1, '2025-04-05 15:03:26', '2025-04-05 15:03:26'),
(13, 7, 1, 1, 100.00, 100.00, 1, '2025-04-05 15:03:26', '2025-04-05 15:03:26'),
(14, 8, 1, 1, 100.00, 100.00, 1, '2025-04-05 15:08:01', '2025-04-05 15:08:01'),
(15, 8, 2, 1, 200.00, 200.00, 1, '2025-04-05 15:08:01', '2025-04-05 15:08:01'),
(16, 9, 1, 1, 100.00, 100.00, 1, '2025-05-01 01:00:05', '2025-05-01 01:00:05');

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
(1, 1, '2024-09-25', 9, '2024-09-25 19:27:58', '2024-09-26 00:04:59'),
(2, 1, '2024-11-04', 3, '2024-11-04 20:47:24', '2024-11-04 23:52:29'),
(3, 1, '2024-12-06', 99, '2024-12-06 18:52:06', '2024-12-06 19:00:07'),
(4, 2, '2024-12-06', 119, '2024-12-06 18:54:25', '2024-12-06 19:00:07'),
(5, 3, '2025-03-11', 100, '2025-03-11 14:21:01', '2025-03-11 14:25:44'),
(6, 1, '2025-03-11', 99, '2025-03-11 14:24:44', '2025-03-11 14:25:44'),
(7, 2, '2025-03-11', 121, '2025-03-11 14:24:44', '2025-03-11 14:25:44'),
(8, 1, '2025-03-12', 95, '2025-03-12 19:35:12', '2025-03-12 20:15:47'),
(9, 3, '2025-03-12', 69, '2025-03-12 19:54:12', '2025-03-12 20:15:47'),
(10, 2, '2025-03-12', 121, '2025-03-12 20:15:47', '2025-03-12 20:15:47'),
(11, 4, '2025-03-31', 5, '2025-03-31 23:28:20', '2025-03-31 23:38:58'),
(12, 1, '2025-03-31', 94, '2025-03-31 23:40:28', '2025-03-31 23:40:28'),
(13, 1, '2025-04-01', 93, '2025-04-01 18:31:53', '2025-04-01 23:29:31'),
(15, 4, '2025-04-01', 5, '2025-04-01 23:09:46', '2025-04-01 23:11:21'),
(16, 2, '2025-04-01', 121, '2025-04-01 23:11:21', '2025-04-01 23:11:21'),
(17, 3, '2025-04-01', 69, '2025-04-01 23:11:21', '2025-04-01 23:11:21'),
(18, 2, '2025-04-05', 119, '2025-04-05 15:03:26', '2025-04-05 15:32:13'),
(19, 1, '2025-04-05', 91, '2025-04-05 15:03:26', '2025-04-05 15:32:13'),
(20, 3, '2025-04-05', 69, '2025-04-05 15:29:37', '2025-04-05 15:32:13'),
(21, 4, '2025-04-05', 5, '2025-04-05 15:29:37', '2025-04-05 15:32:13'),
(22, 1, '2025-04-30', 90, '2025-05-01 01:00:05', '2025-05-01 01:00:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
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
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA CATEGORÍA', '{\"id\": 18, \"nombre\": \"ASDASDASD\", \"created_at\": \"2025-04-01T23:06:19.000000Z\", \"updated_at\": \"2025-04-01T23:06:19.000000Z\"}', NULL, 'CATEGORÍAS', '2025-04-01', '19:06:19', '2025-04-01 23:06:19', '2025-04-01 23:06:19'),
(2, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA CATEGORÍA', '{\"id\": 5, \"nit\": \"2312314\", \"total\": \"230.00\", \"estado\": \"CANCELADO\", \"status\": 1, \"user_id\": 1, \"descuento\": 0, \"cliente_id\": 1, \"created_at\": \"2025-03-31T23:38:58.000000Z\", \"updated_at\": \"2025-03-31T23:38:58.000000Z\", \"total_final\": \"230.00\", \"detalle_ventas\": [{\"id\": 9, \"precio\": \"230.00\", \"status\": 0, \"cantidad\": 1, \"subtotal\": \"230.00\", \"venta_id\": 5, \"created_at\": \"2025-03-31T23:38:58.000000Z\", \"updated_at\": \"2025-04-01T23:09:46.000000Z\", \"producto_id\": 4}], \"fecha_registro\": \"2025-03-31\"}', NULL, 'VENTAS', '2025-04-01', '19:09:46', '2025-04-01 23:09:46', '2025-04-01 23:09:46'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA VENTA', '{\"id\": 1, \"nit\": \"111111\", \"total\": \"1499.99\", \"estado\": \"CANCELADO\", \"status\": 1, \"user_id\": 1, \"descuento\": 10, \"cliente_id\": 3, \"created_at\": \"2024-12-06T19:00:07.000000Z\", \"updated_at\": \"2025-03-12T20:15:47.000000Z\", \"total_final\": \"1349.99\", \"detalle_ventas\": [{\"id\": 1, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 1, \"created_at\": \"2024-12-06T19:00:07.000000Z\", \"updated_at\": \"2024-12-06T19:00:07.000000Z\", \"producto_id\": 1}, {\"id\": 4, \"precio\": \"200.00\", \"status\": 1, \"cantidad\": 2, \"subtotal\": \"400.00\", \"venta_id\": 1, \"created_at\": \"2025-03-11T14:25:44.000000Z\", \"updated_at\": \"2025-03-11T14:25:44.000000Z\", \"producto_id\": 2}, {\"id\": 7, \"precio\": \"999.99\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"999.99\", \"venta_id\": 1, \"created_at\": \"2025-03-12T20:15:47.000000Z\", \"updated_at\": \"2025-03-12T20:15:47.000000Z\", \"producto_id\": 3}, {\"id\": 10, \"precio\": \"230.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"230.00\", \"venta_id\": 1, \"created_at\": \"2025-04-01T23:11:21.000000Z\", \"updated_at\": \"2025-04-01T23:11:21.000000Z\", \"producto_id\": 4}], \"fecha_registro\": \"2024-12-06\"}', '{\"id\": 1, \"nit\": \"111111\", \"total\": \"1729.99\", \"estado\": \"CANCELADO\", \"status\": \"1\", \"user_id\": \"1\", \"descuento\": \"10\", \"cliente_id\": \"3\", \"created_at\": \"2024-12-06T19:00:07.000000Z\", \"updated_at\": \"2025-04-01T23:11:21.000000Z\", \"total_final\": \"1556.99\", \"detalle_ventas\": [{\"id\": 1, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 1, \"created_at\": \"2024-12-06T19:00:07.000000Z\", \"updated_at\": \"2024-12-06T19:00:07.000000Z\", \"producto_id\": 1}, {\"id\": 4, \"precio\": \"200.00\", \"status\": 1, \"cantidad\": 2, \"subtotal\": \"400.00\", \"venta_id\": 1, \"created_at\": \"2025-03-11T14:25:44.000000Z\", \"updated_at\": \"2025-03-11T14:25:44.000000Z\", \"producto_id\": 2}, {\"id\": 7, \"precio\": \"999.99\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"999.99\", \"venta_id\": 1, \"created_at\": \"2025-03-12T20:15:47.000000Z\", \"updated_at\": \"2025-03-12T20:15:47.000000Z\", \"producto_id\": 3}, {\"id\": 10, \"precio\": \"230.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"230.00\", \"venta_id\": 1, \"created_at\": \"2025-04-01T23:11:21.000000Z\", \"updated_at\": \"2025-04-01T23:11:21.000000Z\", \"producto_id\": 4}], \"fecha_registro\": \"2024-12-06\"}', 'VENTAS', '2025-04-01', '19:11:21', '2025-04-01 23:11:21', '2025-04-01 23:11:21'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN INGRESO DE PRODUCTO', '{\"id\": 1, \"lote\": \"2024\", \"status\": 1, \"cantidad\": 100, \"producto\": {\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:14:24.000000Z\", \"url_imagen\": \"http://sisemsyt.test/imgs/productos/default.png\", \"descripcion\": \"DESC. PRODUCTO 3\", \"categoria_id\": 1, \"stock_actual\": 94, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}, \"created_at\": \"2024-12-06T18:52:06.000000Z\", \"updated_at\": \"2025-04-01T18:31:53.000000Z\", \"descripcion\": \"DESC INGRESO22\", \"producto_id\": 1, \"proveedor_id\": 1, \"precio_compra\": \"20.00\", \"fecha_registro\": \"2024-12-06\", \"tipo_ingreso_id\": 1, \"fecha_fabricacion\": \"2020-01-01\"}', '{\"id\": 1, \"lote\": \"2023\", \"status\": 1, \"cantidad\": \"100\", \"producto\": {\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:14:24.000000Z\", \"url_imagen\": \"http://sisemsyt.test/imgs/productos/default.png\", \"descripcion\": \"DESC. PRODUCTO 3\", \"categoria_id\": 1, \"stock_actual\": 94, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}, \"created_at\": \"2024-12-06T18:52:06.000000Z\", \"updated_at\": \"2025-04-01T23:14:24.000000Z\", \"descripcion\": \"DESC INGRESO22\", \"producto_id\": \"1\", \"proveedor_id\": \"1\", \"precio_compra\": \"20.00\", \"fecha_registro\": \"2024-12-06\", \"tipo_ingreso_id\": \"1\", \"fecha_fabricacion\": \"2020-01-01\"}', 'INGRESO DE PRODUCTOS', '2025-04-01', '19:14:24', '2025-04-01 23:14:24', '2025-04-01 23:14:24'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SALIDA DE PRODUCTO', '{\"id\": 1, \"status\": 1, \"cantidad\": 1, \"created_at\": \"2025-03-31T23:40:28.000000Z\", \"updated_at\": \"2025-04-01T18:32:02.000000Z\", \"descripcion\": \"DESC22\", \"producto_id\": 1, \"fecha_salida\": \"2025-03-31\", \"fecha_registro\": \"2025-03-31\", \"tipo_salida_id\": 1}', '{\"id\": 1, \"status\": 1, \"cantidad\": \"2\", \"producto\": {\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:16:33.000000Z\", \"url_imagen\": \"http://sisemsyt.test/imgs/productos/default.png\", \"descripcion\": \"DESC. PRODUCTO 3\", \"categoria_id\": 1, \"stock_actual\": 93, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}, \"created_at\": \"2025-03-31T23:40:28.000000Z\", \"updated_at\": \"2025-04-01T23:16:33.000000Z\", \"descripcion\": \"DESC22\", \"producto_id\": \"1\", \"fecha_salida\": \"2025-03-31\", \"fecha_registro\": \"2025-03-31\", \"tipo_salida_id\": \"1\"}', 'SALIDA DE PRODUCTOS', '2025-04-01', '19:16:33', '2025-04-01 23:16:33', '2025-04-01 23:16:33'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA SALIDA DE PRODUCTO', '{\"id\": 1, \"status\": 1, \"cantidad\": 2, \"created_at\": \"2025-03-31T23:40:28.000000Z\", \"updated_at\": \"2025-04-01T23:16:33.000000Z\", \"descripcion\": \"DESC22\", \"producto_id\": 1, \"fecha_salida\": \"2025-03-31\", \"fecha_registro\": \"2025-03-31\", \"tipo_salida_id\": 1}', '{\"id\": 1, \"status\": 1, \"cantidad\": \"1\", \"producto\": {\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:16:55.000000Z\", \"url_imagen\": \"http://sisemsyt.test/imgs/productos/default.png\", \"descripcion\": \"DESC. PRODUCTO 3\", \"categoria_id\": 1, \"stock_actual\": 94, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}, \"created_at\": \"2025-03-31T23:40:28.000000Z\", \"updated_at\": \"2025-04-01T23:16:55.000000Z\", \"descripcion\": \"DESC22\", \"producto_id\": \"1\", \"fecha_salida\": \"2025-03-31\", \"fecha_registro\": \"2025-03-31\", \"tipo_salida_id\": \"1\"}', 'SALIDA DE PRODUCTOS', '2025-04-01', '19:16:55', '2025-04-01 23:16:55', '2025-04-01 23:16:55'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PROVEEDOR', '{\"id\": 1, \"dir\": \"LOS PEDREGALES NRO. 3\", \"nit\": \"3333444\", \"fono\": \"1234567\", \"status\": 1, \"created_at\": \"2023-04-24T21:09:13.000000Z\", \"updated_at\": \"2024-11-05T00:10:52.000000Z\", \"descripcion\": \"DESCRIPCION\", \"razon_social\": \"PEPE S.A.\", \"fecha_registro\": \"2023-04-24\", \"nombre_contacto\": \"JOSE PAREDES\"}', '{\"id\": 1, \"dir\": \"LOS PEDREGALES NRO. 32\", \"nit\": \"3333444\", \"fono\": \"1234567\", \"status\": 1, \"created_at\": \"2023-04-24T21:09:13.000000Z\", \"updated_at\": \"2025-04-01T23:19:50.000000Z\", \"descripcion\": \"DESCRIPCION\", \"razon_social\": \"PEPE S.A.\", \"fecha_registro\": \"2023-04-24\", \"nombre_contacto\": \"JOSE PAREDES\"}', 'PROVEEDORES', '2025-04-01', '19:19:50', '2025-04-01 23:19:50', '2025-04-01 23:19:50'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:16:55.000000Z\", \"descripcion\": \"DESC. PRODUCTO 3\", \"categoria_id\": 1, \"stock_actual\": 94, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}', '{\"id\": 1, \"imagen\": \"\", \"nombre\": \"TECLADO KEYBOARD\", \"precio\": \"100.00\", \"status\": 1, \"stock_min\": \"5\", \"created_at\": \"2024-09-25T19:27:16.000000Z\", \"nro_codigo\": 1, \"updated_at\": \"2025-04-01T23:21:37.000000Z\", \"descripcion\": \"DESC. PRODUCTO 31\", \"categoria_id\": \"1\", \"stock_actual\": 94, \"fecha_registro\": \"2024-09-25\", \"codigo_producto\": \"COD.1\"}', 'PRODUCTOS', '2025-04-01', '19:21:37', '2025-04-01 23:21:37', '2025-04-01 23:21:37'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 1, \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan.as@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 1, \"materno\": \"MAMANI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-01T18:15:16.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"1\", \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"victorgonzalo.as@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 1, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-01T23:23:52.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-01', '19:23:52', '2025-04-01 23:23:52', '2025-04-01 23:23:52'),
(10, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN TIPO DE INGRESO', '{\"id\": 1, \"nombre\": \"INGRESO UNO\", \"status\": 1, \"created_at\": \"2023-04-17T15:04:22.000000Z\", \"updated_at\": \"2024-11-04T21:07:08.000000Z\", \"descripcion\": \"DESC. INGRESO UNO\"}', '{\"id\": 1, \"nombre\": \"INGRESO UNO\", \"status\": 1, \"created_at\": \"2023-04-17T15:04:22.000000Z\", \"updated_at\": \"2025-04-01T23:26:23.000000Z\", \"descripcion\": \"DESCRIPCION INGRESO UNO\"}', 'TIPO DE INGRESOS', '2025-04-01', '19:26:23', '2025-04-01 23:26:23', '2025-04-01 23:26:23'),
(11, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN TIPO DE SALIDA', '{\"id\": 2, \"nombre\": \"TIPO DE SALIDA DOS\", \"status\": 1, \"created_at\": \"2023-04-25T14:38:21.000000Z\", \"updated_at\": \"2024-11-04T21:08:44.000000Z\", \"descripcion\": \"SALIDA DOS\"}', '{\"id\": 2, \"nombre\": \"TIPO DE SALIDA DOS\", \"status\": 1, \"created_at\": \"2023-04-25T14:38:21.000000Z\", \"updated_at\": \"2025-04-01T23:27:56.000000Z\", \"descripcion\": \"DESC SALIDA DOS\"}', 'TIPO DE SALIDAS', '2025-04-01', '19:27:56', '2025-04-01 23:27:56', '2025-04-01 23:27:56'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ LA CONFIGURACIÓN DEL SISTEMA', '{\"id\": 1, \"dir\": \"LA PAZ\", \"nit\": \"10000000000\", \"web\": \"SISEMSYT.TEST\", \"fono\": \"2222222\", \"logo\": \"1742395524_logo.jpg\", \"alias\": \"SISEMSYT\", \"ciudad\": \"LA PAZ\", \"correo\": \"SISEMSYT@GMAIL.COM\", \"actividad\": \"ACTIVIDAD\", \"conf_email\": {\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}, \"created_at\": null, \"updated_at\": \"2025-03-19T14:45:24.000000Z\", \"razon_social\": \"SISEMSYT S.A.\", \"nombre_sistema\": \"SISTEMA SISEMSYT\"}', '{\"id\": 1, \"dir\": \"LA PAZ\", \"nit\": \"10000000000\", \"web\": \"SISEMSYT.TEST\", \"fono\": \"2222222\", \"logo\": \"1743550143_logo.jpg\", \"alias\": \"SISEMSYT\", \"ciudad\": \"LA PAZ\", \"correo\": \"SISEMSYT@GMAIL.COM\", \"actividad\": \"ACTIVIDAD\", \"conf_email\": {\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}, \"created_at\": null, \"updated_at\": \"2025-04-01T23:29:03.000000Z\", \"razon_social\": \"SISEMSYT S.A.\", \"nombre_sistema\": \"SISTEMA SISEMSYTS\"}', 'CONFIGURACIÓN', '2025-04-01', '19:29:03', '2025-04-01 23:29:03', '2025-04-01 23:29:03'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ LA CONFIGURACIÓN DEL SISTEMA', '{\"id\": 1, \"dir\": \"LA PAZ\", \"nit\": \"10000000000\", \"web\": \"SISEMSYT.TEST\", \"fono\": \"2222222\", \"logo\": \"1743550143_logo.jpg\", \"alias\": \"SISEMSYT\", \"ciudad\": \"LA PAZ\", \"correo\": \"SISEMSYT@GMAIL.COM\", \"actividad\": \"ACTIVIDAD\", \"conf_email\": {\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}, \"created_at\": null, \"updated_at\": \"2025-04-01T23:29:03.000000Z\", \"razon_social\": \"SISEMSYT S.A.\", \"nombre_sistema\": \"SISTEMA SISEMSYTS\"}', '{\"id\": 1, \"dir\": \"LA PAZ\", \"nit\": \"10000000000\", \"web\": \"SISEMSYT.TEST\", \"fono\": \"2222222\", \"logo\": \"1743550156_logo.jpg\", \"alias\": \"SISEMSYT\", \"ciudad\": \"LA PAZ\", \"correo\": \"SISEMSYT@GMAIL.COM\", \"actividad\": \"ACTIVIDAD\", \"conf_email\": {\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}, \"created_at\": null, \"updated_at\": \"2025-04-01T23:29:16.000000Z\", \"razon_social\": \"SISEMSYT S.A.\", \"nombre_sistema\": \"SISTEMA SISEMSYT\"}', 'CONFIGURACIÓN', '2025-04-01', '19:29:16', '2025-04-01 23:29:16', '2025-04-01 23:29:16'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA', '{\"id\": 6, \"nit\": \"2312314\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"user_id\": \"1\", \"descuento\": \"0\", \"cliente_id\": \"1\", \"created_at\": \"2025-04-01T23:29:31.000000Z\", \"updated_at\": \"2025-04-01T23:29:31.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 11, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 6, \"created_at\": \"2025-04-01T23:29:31.000000Z\", \"updated_at\": \"2025-04-01T23:29:31.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-01\"}', NULL, 'VENTAS', '2025-04-01', '19:29:31', '2025-04-01 23:29:31', '2025-04-01 23:29:31'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"3232323\", \"id\": 4, \"dir\": \"ZONA LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"1743551222_PCORTEZ.png\", \"tipo\": \"VENDEDOR\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": \"pedro@gmail.com\", \"nombre\": \"PEDRO\", \"materno\": \"RAMIRES\", \"paterno\": \"CORTEZ\", \"usuario\": \"PCORTEZ\", \"created_at\": \"2025-04-01T23:47:02.000000Z\", \"updated_at\": \"2025-04-01T23:47:02.000000Z\", \"fecha_registro\": \"2025-04-01\"}', NULL, 'USUARIOS', '2025-04-01', '19:47:02', '2025-04-01 23:47:02', '2025-04-01 23:47:02'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 1, \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-05T14:20:08.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"0\", \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-05T14:20:20.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-05', '10:20:20', '2025-04-05 14:20:20', '2025-04-05 14:20:20'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 0, \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-05T14:20:20.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"1\", \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-05T14:21:44.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-05', '10:21:44', '2025-04-05 14:21:44', '2025-04-05 14:21:44'),
(18, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TIPO DE SALIDA', '{\"id\": 2, \"nombre\": \"TIPO DE SALIDA DOS\", \"status\": 1, \"created_at\": \"2023-04-25T14:38:21.000000Z\", \"updated_at\": \"2025-04-01T23:27:56.000000Z\", \"descripcion\": \"DESC SALIDA DOS\"}', NULL, 'TIPO DE SALIDAS', '2025-04-05', '10:27:29', '2025-04-05 14:27:29', '2025-04-05 14:27:29'),
(19, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UNA SUGERENCIA DE STOCK MÍNIMO', '{\"id\": 4, \"fecha\": \"2025-04-05\", \"status\": 1, \"stock_min\": 5, \"created_at\": \"2025-04-05T14:46:20.000000Z\", \"updated_at\": \"2025-04-05T14:46:20.000000Z\", \"producto_id\": 4}', NULL, 'STOCK MÍNIMO', '2025-04-05', '10:50:48', '2025-04-05 14:50:48', '2025-04-05 14:50:48'),
(20, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA', '{\"id\": 7, \"nit\": \"2312314\", \"total\": \"300.00\", \"estado\": \"CANCELADO\", \"user_id\": \"1\", \"descuento\": \"2\", \"cliente_id\": \"1\", \"created_at\": \"2025-04-05T15:03:26.000000Z\", \"updated_at\": \"2025-04-05T15:03:26.000000Z\", \"total_final\": \"294.00\", \"detalle_ventas\": [{\"id\": 12, \"precio\": \"200.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"200.00\", \"venta_id\": 7, \"created_at\": \"2025-04-05T15:03:26.000000Z\", \"updated_at\": \"2025-04-05T15:03:26.000000Z\", \"producto_id\": 2}, {\"id\": 13, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 7, \"created_at\": \"2025-04-05T15:03:26.000000Z\", \"updated_at\": \"2025-04-05T15:03:26.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-05\"}', NULL, 'VENTAS', '2025-04-05', '11:03:26', '2025-04-05 15:03:26', '2025-04-05 15:03:26'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA', '{\"id\": 8, \"nit\": \"2312314\", \"total\": \"300.00\", \"estado\": \"CANCELADO\", \"user_id\": \"1\", \"descuento\": \"3\", \"cliente_id\": \"1\", \"created_at\": \"2025-04-05T15:08:01.000000Z\", \"updated_at\": \"2025-04-05T15:08:01.000000Z\", \"total_final\": \"291.00\", \"detalle_ventas\": [{\"id\": 14, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 8, \"created_at\": \"2025-04-05T15:08:01.000000Z\", \"updated_at\": \"2025-04-05T15:08:01.000000Z\", \"producto_id\": 1}, {\"id\": 15, \"precio\": \"200.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"200.00\", \"venta_id\": 8, \"created_at\": \"2025-04-05T15:08:01.000000Z\", \"updated_at\": \"2025-04-05T15:08:01.000000Z\", \"producto_id\": 2}], \"fecha_registro\": \"2025-04-05\"}', NULL, 'VENTAS', '2025-04-05', '11:08:01', '2025-04-05 15:08:01', '2025-04-05 15:08:01'),
(22, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CLIENTE', '{\"ci\": \"1231231\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"nit\": \"34324111\", \"fono\": \"666666; 7777777\", \"ci_exp\": \"CB\", \"correo\": \"MARIA@GMAIL.COM\", \"nombre\": \"MARIA GONZALES CASAS\", \"status\": 1, \"created_at\": \"2023-04-26T20:05:20.000000Z\", \"updated_at\": \"2023-04-26T20:05:50.000000Z\", \"fecha_registro\": \"2023-04-26\"}', '{\"ci\": \"1231231\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"nit\": \"34324111\", \"fono\": \"7777777\", \"ci_exp\": \"CB\", \"correo\": \"MARIA@GMAIL.COM\", \"nombre\": \"MARIA GONZALES CASAS\", \"status\": 1, \"created_at\": \"2023-04-26T20:05:20.000000Z\", \"updated_at\": \"2025-04-23T12:43:57.000000Z\", \"fecha_registro\": \"2023-04-26\"}', 'CLIENTES', '2025-04-23', '08:43:57', '2025-04-23 12:43:57', '2025-04-23 12:43:57'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"234234234234\", \"id\": 4, \"nit\": \"23232323\", \"fono\": \"\", \"ci_exp\": \"LP\", \"nombre\": \"GABRIEL GONZALES\", \"created_at\": \"2025-04-23T12:50:33.000000Z\", \"updated_at\": \"2025-04-23T12:50:33.000000Z\", \"fecha_registro\": \"2025-04-23\"}', NULL, 'CLIENTES', '2025-04-23', '08:50:33', '2025-04-23 12:50:33', '2025-04-23 12:50:33'),
(24, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 2, \"imagen\": \"1732760350_2.png\", \"nombre\": \"COD.DOS\", \"precio\": \"200.00\", \"status\": 1, \"stock_min\": 0, \"created_at\": \"2024-11-28T02:19:10.000000Z\", \"nro_codigo\": 2, \"updated_at\": \"2025-04-05T15:32:13.000000Z\", \"descripcion\": \"PRODUCTO DOS\", \"categoria_id\": 1, \"stock_actual\": 119, \"fecha_registro\": \"2024-11-27\", \"codigo_producto\": \"COD.2\"}', '{\"id\": 2, \"imagen\": \"\", \"nombre\": \"PRD.DOS\", \"precio\": \"200.00\", \"status\": 1, \"stock_min\": \"10\", \"created_at\": \"2024-11-28T02:19:10.000000Z\", \"nro_codigo\": 2, \"updated_at\": \"2025-05-01T00:24:06.000000Z\", \"descripcion\": \"PRODUCTO DOS\", \"categoria_id\": \"1\", \"stock_actual\": 119, \"fecha_registro\": \"2024-11-27\", \"codigo_producto\": \"COD.2\"}', 'PRODUCTOS', '2025-04-30', '20:24:06', '2025-05-01 00:24:06', '2025-05-01 00:24:06'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 1, \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-04-23T12:32:14.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"0\", \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-05-01T00:30:10.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-30', '20:30:10', '2025-05-01 00:30:10', '2025-05-01 00:30:10'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 0, \"b_auth\": 0, \"ci_exp\": \"LP\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-05-01T00:30:10.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"0\", \"b_auth\": 0, \"ci_exp\": \"OR\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-05-01T00:32:46.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-30', '20:32:46', '2025-05-01 00:32:46', '2025-05-01 00:32:46'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": 0, \"b_auth\": 0, \"ci_exp\": \"OR\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-05-01T00:32:46.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', '{\"ci\": \"1234\", \"id\": 2, \"dir\": \"LOS OLIVOS\", \"fono\": \"7777777\", \"foto\": \"default.png\", \"tipo\": \"SUPERVISOR\", \"acceso\": \"0\", \"b_auth\": 0, \"ci_exp\": \"CH\", \"correo\": \"juan@gmail.com\", \"nombre\": \"JUAN\", \"status\": 1, \"auth2fa\": 0, \"materno\": \"CONDORI\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2023-04-24T20:23:30.000000Z\", \"updated_at\": \"2025-05-01T00:33:02.000000Z\", \"fecha_registro\": \"2023-04-24\", \"update_password\": 1, \"google2fa_secret\": \"eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=\"}', 'USUARIOS', '2025-04-30', '20:33:02', '2025-05-01 00:33:02', '2025-05-01 00:33:02'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PROVEEDOR', '{\"id\": 4, \"dir\": \"ZONA LOS PEDREGALES\", \"nit\": \"33334441\", \"fono\": \"43343434\", \"created_at\": \"2025-05-01T00:34:32.000000Z\", \"updated_at\": \"2025-05-01T00:34:32.000000Z\", \"descripcion\": \"DESCRIPCION\", \"razon_social\": \"PROVEEDOR TRES\", \"fecha_registro\": \"2025-04-30\", \"nombre_contacto\": \"JOSE RAMIRES\"}', NULL, 'PROVEEDORES', '2025-04-30', '20:34:32', '2025-05-01 00:34:32', '2025-05-01 00:34:32'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"23232323\", \"id\": 5, \"nit\": \"12311123123123\", \"fono\": \"\", \"ci_exp\": \"LP\", \"nombre\": \"CLIENTE NUEVO S.A.\", \"created_at\": \"2025-05-01T00:41:24.000000Z\", \"updated_at\": \"2025-05-01T00:41:24.000000Z\", \"fecha_registro\": \"2025-04-30\"}', NULL, 'CLIENTES', '2025-04-30', '20:41:24', '2025-05-01 00:41:24', '2025-05-01 00:41:24'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"34322222\", \"id\": 6, \"nit\": \"5445454545\", \"fono\": \"\", \"ci_exp\": \"OR\", \"nombre\": \"EDSON RAMIRES\", \"created_at\": \"2025-05-01T00:43:39.000000Z\", \"updated_at\": \"2025-05-01T00:43:39.000000Z\", \"fecha_registro\": \"2025-04-30\"}', NULL, 'CLIENTES', '2025-04-30', '20:43:39', '2025-05-01 00:43:39', '2025-05-01 00:43:39'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"12312312313\", \"id\": 7, \"dir\": \"LOS PEDREGALES\", \"nit\": \"323232323\", \"fono\": \"5454454554\", \"ci_exp\": \"SC\", \"correo\": \"PABLO@GMAIL.COM\", \"nombre\": \"PABLO MARTINEZ\", \"created_at\": \"2025-05-01T00:45:03.000000Z\", \"updated_at\": \"2025-05-01T00:45:03.000000Z\", \"fecha_registro\": \"2025-04-30\"}', NULL, 'CLIENTES', '2025-04-30', '20:45:03', '2025-05-01 00:45:03', '2025-05-01 00:45:03'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"334343434\", \"id\": 8, \"dir\": \"\", \"nit\": \"34343434\", \"fono\": \"\", \"ci_exp\": \"CB\", \"correo\": \"\", \"nombre\": \"JUAN HERRERA\", \"created_at\": \"2025-05-01T00:45:22.000000Z\", \"updated_at\": \"2025-05-01T00:45:22.000000Z\", \"fecha_registro\": \"2025-04-30\"}', NULL, 'CLIENTES', '2025-04-30', '20:45:22', '2025-05-01 00:45:22', '2025-05-01 00:45:22'),
(33, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA VENTA', '{\"id\": 9, \"nit\": \"334343434\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"nit_fac\": \"111111111\", \"nom_fac\": \"HERRERA\", \"user_id\": \"1\", \"descuento\": \"0\", \"cliente_id\": \"8\", \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 16, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 9, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-30\"}', NULL, 'VENTAS', '2025-04-30', '21:00:05', '2025-05-01 01:00:05', '2025-05-01 01:00:05'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA VENTA', '{\"id\": 9, \"nit\": \"334343434\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"status\": 1, \"nit_fac\": \"111111111\", \"nom_fac\": \"HERRERA\", \"user_id\": 1, \"descuento\": 0, \"cliente_id\": 8, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 16, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 9, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-30\"}', '{\"id\": 9, \"nit\": \"334343434\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"status\": \"1\", \"nit_fac\": \"222222\", \"nom_fac\": \"HERRERAS\", \"user_id\": \"1\", \"descuento\": \"0\", \"cliente_id\": \"8\", \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:19.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 16, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 9, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-30\"}', 'VENTAS', '2025-04-30', '21:00:19', '2025-05-01 01:00:19', '2025-05-01 01:00:19'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UNA VENTA', '{\"id\": 9, \"nit\": \"334343434\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"status\": 1, \"nit_fac\": \"222222\", \"nom_fac\": \"HERRERAS\", \"user_id\": 1, \"descuento\": 0, \"cliente_id\": 8, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:19.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 16, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 9, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-30\"}', '{\"id\": 9, \"nit\": \"334343434\", \"total\": \"100.00\", \"estado\": \"CANCELADO\", \"status\": \"1\", \"nit_fac\": \"222222\", \"nom_fac\": \"HERRERA\", \"user_id\": \"1\", \"descuento\": \"0\", \"cliente_id\": \"8\", \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:30.000000Z\", \"total_final\": \"100.00\", \"detalle_ventas\": [{\"id\": 16, \"precio\": \"100.00\", \"status\": 1, \"cantidad\": 1, \"subtotal\": \"100.00\", \"venta_id\": 9, \"created_at\": \"2025-05-01T01:00:05.000000Z\", \"updated_at\": \"2025-05-01T01:00:05.000000Z\", \"producto_id\": 1}], \"fecha_registro\": \"2025-04-30\"}', 'VENTAS', '2025-04-30', '21:00:30', '2025-05-01 01:00:30', '2025-05-01 01:00:30');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ingreso_productos`
--

INSERT INTO `ingreso_productos` (`id`, `producto_id`, `proveedor_id`, `precio_compra`, `cantidad`, `lote`, `fecha_fabricacion`, `tipo_ingreso_id`, `descripcion`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 20.00, 100, '2023', '2020-01-01', 1, 'DESC INGRESO22', '2024-12-06', 1, '2024-12-06 18:52:06', '2025-04-01 23:14:24'),
(2, 2, 2, 37.60, 123, '2024', '2021-01-01', 1, 'DESC', '2024-12-06', 1, '2024-12-06 18:54:25', '2024-12-06 18:54:25'),
(3, 3, 2, 1299.00, 100, '2025', '2024-01-01', 1, 'DESC TRES', '2025-03-11', 1, '2025-03-11 14:21:01', '2025-03-11 14:21:01'),
(4, 4, 2, 22131.00, 10, '2023', '2023-01-01', 1, 'DESC', '2025-03-31', 1, '2025-03-31 23:28:20', '2025-03-31 23:28:20');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `kardex_productos`
--

INSERT INTO `kardex_productos` (`id`, `lugar`, `tipo_registro`, `registro_id`, `producto_id`, `detalle`, `precio`, `tipo_is`, `cantidad_ingreso`, `cantidad_salida`, `cantidad_saldo`, `cu`, `monto_ingreso`, `monto_salida`, `monto_saldo`, `fecha`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'INGRESO', 1, 1, 'VALOR INICIAL', 100.00, 'INGRESO', 100, NULL, 100, 100.00, 10000.00, NULL, 10000.00, '2024-12-06', 1, '2024-12-06 18:52:06', '2025-04-01 23:14:24'),
(2, NULL, 'INGRESO', 2, 2, 'VALOR INICIAL', 200.00, 'INGRESO', 123, NULL, 123, 200.00, 24600.00, NULL, 24600.00, '2024-12-06', 1, '2024-12-06 18:54:25', '2025-03-11 14:24:44'),
(3, NULL, 'VENTA', 1, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 99, 100.00, NULL, 100.00, 9900.00, '2024-12-06', 1, '2024-12-06 19:00:07', '2025-04-05 15:32:13'),
(5, NULL, 'INGRESO', 3, 3, 'VALOR INICIAL', 999.99, 'INGRESO', 100, NULL, 100, 999.99, 99999.00, NULL, 99999.00, '2025-03-11', 1, '2025-03-11 14:21:01', '2025-03-11 14:25:44'),
(7, NULL, 'VENTA', 4, 2, 'VENTA DE PRODUCTO', 200.00, 'EGRESO', NULL, 2, 121, 200.00, NULL, 400.00, 24200.00, '2025-03-11', 1, '2025-03-11 14:25:44', '2025-04-05 15:32:13'),
(8, NULL, 'VENTA', 5, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 4, 95, 100.00, NULL, 400.00, 9500.00, '2025-03-12', 1, '2025-03-12 19:35:12', '2025-04-05 15:32:13'),
(9, NULL, 'VENTA', 6, 3, 'VENTA DE PRODUCTO', 999.99, 'EGRESO', NULL, 30, 70, 999.99, NULL, 29999.70, 69999.30, '2025-03-12', 1, '2025-03-12 19:54:12', '2025-03-12 19:54:12'),
(10, NULL, 'VENTA', 7, 3, 'VENTA DE PRODUCTO', 999.99, 'EGRESO', NULL, 1, 69, 999.99, NULL, 999.99, 68999.31, '2025-03-12', 1, '2025-03-12 20:15:47', '2025-03-12 20:15:47'),
(11, NULL, 'INGRESO', 4, 4, 'VALOR INICIAL', 230.00, 'INGRESO', 10, NULL, 10, 230.00, 2300.00, NULL, 2300.00, '2025-03-31', 1, '2025-03-31 23:28:20', '2025-03-31 23:28:20'),
(12, NULL, 'VENTA', 8, 4, 'VENTA DE PRODUCTO', 230.00, 'EGRESO', NULL, 4, 6, 230.00, NULL, 920.00, 1380.00, '2025-03-31', 1, '2025-03-31 23:28:42', '2025-04-01 23:09:46'),
(13, NULL, 'VENTA', 9, 4, 'VENTA DE PRODUCTO', 230.00, 'EGRESO', NULL, 1, 5, 230.00, NULL, 230.00, 1150.00, '2025-03-31', 0, '2025-03-31 23:38:58', '2025-04-01 23:09:46'),
(14, NULL, 'SALIDA', 1, 1, 'DESC', 100.00, 'EGRESO', NULL, 1, 94, 100.00, NULL, 100.00, 9400.00, '2025-03-31', 1, '2025-03-31 23:40:28', '2025-04-05 15:32:13'),
(15, NULL, 'VENTA', 10, 4, 'VENTA DE PRODUCTO', 230.00, 'EGRESO', NULL, 1, 5, 230.00, NULL, 230.00, 1150.00, '2025-04-01', 1, '2025-04-01 23:11:21', '2025-04-05 15:32:13'),
(16, NULL, 'VENTA', 11, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 93, 100.00, NULL, 100.00, 9300.00, '2025-04-01', 1, '2025-04-01 23:29:31', '2025-04-05 15:32:13'),
(17, NULL, 'VENTA', 12, 2, 'VENTA DE PRODUCTO', 200.00, 'EGRESO', NULL, 1, 120, 200.00, NULL, 200.00, 24000.00, '2025-04-05', 1, '2025-04-05 15:03:26', '2025-04-05 15:32:13'),
(18, NULL, 'VENTA', 13, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 92, 100.00, NULL, 100.00, 9200.00, '2025-04-05', 1, '2025-04-05 15:03:26', '2025-04-05 15:32:13'),
(19, NULL, 'VENTA', 14, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 91, 100.00, NULL, 100.00, 9100.00, '2025-04-05', 1, '2025-04-05 15:08:01', '2025-04-05 15:32:13'),
(20, NULL, 'VENTA', 15, 2, 'VENTA DE PRODUCTO', 200.00, 'EGRESO', NULL, 1, 119, 200.00, NULL, 200.00, 23800.00, '2025-04-05', 1, '2025-04-05 15:08:01', '2025-04-05 15:32:13'),
(21, NULL, 'VENTA', 16, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 90, 100.00, NULL, 100.00, 9000.00, '2025-04-30', 1, '2025-05-01 01:00:05', '2025-05-01 01:00:30');

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
(4, '2024_09_11_112717_create_notificacion_users_table', 4),
(5, '2025_04_05_102817_create_stock_minimos_table', 5);

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
(1, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-12-06', '14:59:41', '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(2, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2024-12-06', '14:59:41', '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(3, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-11', '10:08:17', '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(4, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-11', '10:08:17', '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(5, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-11', '11:35:24', '2025-03-11 15:35:24', '2025-03-11 15:35:24'),
(6, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-12', '08:42:20', '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(7, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-12', '08:42:20', '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(8, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-12', '08:42:20', '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(9, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-19', '09:31:51', '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(10, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-19', '09:31:51', '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(11, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-19', '09:31:51', '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(12, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-31', '19:13:45', '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(13, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-31', '19:13:45', '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(14, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-31', '19:13:45', '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(15, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-03-31', '19:28:42', '2025-03-31 23:28:42', '2025-03-31 23:28:42'),
(16, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-01', '13:48:46', '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(17, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-01', '13:48:46', '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(18, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-01', '13:48:46', '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(19, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-01', '13:48:46', '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(20, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-01', '13:48:46', '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(21, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-05', '10:06:52', '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(22, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-05', '10:06:52', '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(23, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-05', '10:06:52', '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(24, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-05', '10:06:52', '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(25, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-05', '10:06:52', '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(26, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-07', '19:06:42', '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(27, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-07', '19:06:42', '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(28, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-07', '19:06:42', '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(29, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-07', '19:06:42', '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(30, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-07', '19:06:42', '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(31, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-08', '10:47:21', '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(32, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-08', '10:47:21', '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(33, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-08', '10:47:21', '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(34, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-08', '10:47:21', '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(35, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-08', '10:47:21', '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(36, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-23', '08:12:52', '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(37, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-23', '08:12:52', '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(38, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-23', '08:12:52', '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(39, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-23', '08:12:52', '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(40, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-23', '08:12:52', '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(41, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-24', '19:46:22', '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(42, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-24', '19:46:22', '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(43, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-24', '19:46:22', '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(44, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-24', '19:46:22', '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(45, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-24', '19:46:22', '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(46, 'LLEGANDO A STOCK MINIMO', 4, 'EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA CERCA DEL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO', '2025-04-30', '16:41:11', '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(47, 'DEBAJO STOCK MINIMO', 1, 'ALERTA URGENTE EL PRODUCTO TECLADO KEYBOARD SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-30', '16:41:11', '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(48, 'DEBAJO STOCK MINIMO', 2, 'ALERTA URGENTE EL PRODUCTO COD.DOS SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-30', '16:41:11', '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(49, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-30', '16:41:11', '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(50, 'DEBAJO STOCK MINIMO', 4, 'ALERTA URGENTE EL PRODUCTO PRODUCTO CUATRO SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-04-30', '16:41:11', '2025-04-30 20:41:11', '2025-04-30 20:41:11');

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
(1, 1, 1, 1, '2024-12-06 18:59:41', '2025-03-19 14:49:15'),
(2, 1, 2, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(3, 2, 1, 1, '2024-12-06 18:59:41', '2025-03-19 14:49:11'),
(4, 2, 2, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(5, 3, 1, 1, '2025-03-11 14:08:17', '2025-03-19 14:52:47'),
(6, 3, 2, 0, '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(7, 4, 1, 1, '2025-03-11 14:08:17', '2025-03-19 14:52:54'),
(8, 4, 2, 0, '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(9, 5, 1, 1, '2025-03-11 15:35:24', '2025-03-19 14:30:01'),
(10, 5, 2, 0, '2025-03-11 15:35:24', '2025-03-11 15:35:24'),
(11, 6, 1, 1, '2025-03-12 12:42:20', '2025-03-19 14:29:58'),
(12, 6, 2, 0, '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(13, 7, 1, 1, '2025-03-12 12:42:20', '2025-03-19 14:29:57'),
(14, 7, 2, 0, '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(15, 8, 1, 1, '2025-03-12 12:42:20', '2025-03-19 14:28:44'),
(16, 8, 2, 0, '2025-03-12 12:42:20', '2025-03-12 12:42:20'),
(17, 6, 3, 0, '2025-03-12 15:56:29', '2025-03-12 15:56:29'),
(18, 7, 3, 0, '2025-03-12 15:56:29', '2025-03-12 15:56:29'),
(19, 8, 3, 0, '2025-03-12 15:56:29', '2025-03-12 15:56:29'),
(20, 9, 1, 1, '2025-03-19 13:31:51', '2025-03-19 14:28:22'),
(21, 9, 2, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(22, 9, 3, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(23, 10, 1, 1, '2025-03-19 13:31:51', '2025-03-19 14:19:40'),
(24, 10, 2, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(25, 10, 3, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(26, 11, 1, 1, '2025-03-19 13:31:51', '2025-03-19 14:18:52'),
(27, 11, 2, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(28, 11, 3, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51'),
(29, 12, 1, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(30, 12, 2, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(31, 12, 3, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(32, 13, 1, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(33, 13, 2, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(34, 13, 3, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(35, 14, 1, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(36, 14, 2, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(37, 14, 3, 0, '2025-03-31 23:13:45', '2025-03-31 23:13:45'),
(38, 15, 1, 1, '2025-03-31 23:28:42', '2025-03-31 23:28:48'),
(39, 15, 2, 0, '2025-03-31 23:28:42', '2025-03-31 23:28:42'),
(40, 15, 3, 0, '2025-03-31 23:28:42', '2025-03-31 23:28:42'),
(41, 16, 1, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(42, 16, 2, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(43, 16, 3, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(44, 17, 1, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(45, 17, 2, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(46, 17, 3, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(47, 18, 1, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(48, 18, 2, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(49, 18, 3, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(50, 19, 1, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(51, 19, 2, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(52, 19, 3, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(53, 20, 1, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(54, 20, 2, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(55, 20, 3, 0, '2025-04-01 17:48:46', '2025-04-01 17:48:46'),
(56, 16, 4, 0, '2025-04-01 23:47:19', '2025-04-01 23:47:19'),
(57, 17, 4, 0, '2025-04-01 23:47:19', '2025-04-01 23:47:19'),
(58, 18, 4, 0, '2025-04-01 23:47:19', '2025-04-01 23:47:19'),
(59, 19, 4, 0, '2025-04-01 23:47:19', '2025-04-01 23:47:19'),
(60, 20, 4, 0, '2025-04-01 23:47:19', '2025-04-01 23:47:19'),
(61, 21, 1, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(62, 21, 2, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(63, 21, 3, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(64, 21, 4, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(65, 22, 1, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(66, 22, 2, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(67, 22, 3, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(68, 22, 4, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(69, 23, 1, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(70, 23, 2, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(71, 23, 3, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(72, 23, 4, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(73, 24, 1, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(74, 24, 2, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(75, 24, 3, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(76, 24, 4, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(77, 25, 1, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(78, 25, 2, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(79, 25, 3, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(80, 25, 4, 0, '2025-04-05 14:06:52', '2025-04-05 14:06:52'),
(81, 26, 1, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(82, 26, 2, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(83, 26, 3, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(84, 26, 4, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(85, 27, 1, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(86, 27, 2, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(87, 27, 3, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(88, 27, 4, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(89, 28, 1, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(90, 28, 2, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(91, 28, 3, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(92, 28, 4, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(93, 29, 1, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(94, 29, 2, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(95, 29, 3, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(96, 29, 4, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(97, 30, 1, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(98, 30, 2, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(99, 30, 3, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(100, 30, 4, 0, '2025-04-07 23:06:42', '2025-04-07 23:06:42'),
(101, 31, 1, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(102, 31, 2, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(103, 31, 3, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(104, 31, 4, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(105, 32, 1, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(106, 32, 2, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(107, 32, 3, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(108, 32, 4, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(109, 33, 1, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(110, 33, 2, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(111, 33, 3, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(112, 33, 4, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(113, 34, 1, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(114, 34, 2, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(115, 34, 3, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(116, 34, 4, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(117, 35, 1, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(118, 35, 2, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(119, 35, 3, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(120, 35, 4, 0, '2025-04-08 14:47:21', '2025-04-08 14:47:21'),
(121, 36, 1, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(122, 36, 2, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(123, 36, 3, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(124, 36, 4, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(125, 37, 1, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(126, 37, 2, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(127, 37, 3, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(128, 37, 4, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(129, 38, 1, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(130, 38, 2, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(131, 38, 3, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(132, 38, 4, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(133, 39, 1, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(134, 39, 2, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(135, 39, 3, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(136, 39, 4, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(137, 40, 1, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(138, 40, 2, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(139, 40, 3, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(140, 40, 4, 0, '2025-04-23 12:12:52', '2025-04-23 12:12:52'),
(141, 41, 1, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(142, 41, 2, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(143, 41, 3, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(144, 41, 4, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(145, 42, 1, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(146, 42, 2, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(147, 42, 3, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(148, 42, 4, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(149, 43, 1, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(150, 43, 2, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(151, 43, 3, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(152, 43, 4, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(153, 44, 1, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(154, 44, 2, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(155, 44, 3, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(156, 44, 4, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(157, 45, 1, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(158, 45, 2, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(159, 45, 3, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(160, 45, 4, 0, '2025-04-24 23:46:22', '2025-04-24 23:46:22'),
(161, 46, 1, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(162, 46, 2, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(163, 46, 3, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(164, 46, 4, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(165, 47, 1, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(166, 47, 2, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(167, 47, 3, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(168, 47, 4, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(169, 48, 1, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(170, 48, 2, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(171, 48, 3, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(172, 48, 4, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(173, 49, 1, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(174, 49, 2, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(175, 49, 3, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(176, 49, 4, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(177, 50, 1, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(178, 50, 2, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(179, 50, 3, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11'),
(180, 50, 4, 0, '2025-04-30 20:41:11', '2025-04-30 20:41:11');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo_producto`, `nro_codigo`, `nombre`, `descripcion`, `precio`, `stock_min`, `stock_actual`, `imagen`, `categoria_id`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'COD.1', 1, 'TECLADO KEYBOARD', 'DESC. PRODUCTO 31', 100.00, 5, 90, '', 1, '2024-09-25', 1, '2024-09-25 19:27:16', '2025-05-01 01:00:30'),
(2, 'COD.2', 2, 'PRD.DOS', 'PRODUCTO DOS', 200.00, 10, 119, '', 1, '2024-11-27', 1, '2024-11-28 02:19:10', '2025-05-01 00:24:06'),
(3, 'COD.3', 3, 'PRODUCTO TRES', 'DESC PROD TRES', 999.99, 38, 69, '', 2, '2025-03-11', 1, '2025-03-11 14:20:32', '2025-04-05 15:32:13'),
(4, 'COD.4', 4, 'PRODUCTO CUATRO', 'DESC CUATR', 230.00, 4, 5, '', 1, '2025-03-19', 1, '2025-03-19 14:48:53', '2025-04-05 15:32:13');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedors`
--

INSERT INTO `proveedors` (`id`, `razon_social`, `nit`, `dir`, `fono`, `nombre_contacto`, `descripcion`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PEPE S.A.', '3333444', 'LOS PEDREGALES NRO. 32', '1234567', 'JOSE PAREDES', 'DESCRIPCION', '2023-04-24', 1, '2023-04-24 21:09:13', '2025-04-01 23:19:50'),
(2, 'PROVEEDOR SRL', '34343', '', '2222', '', '', '2023-04-28', 1, '2023-04-28 15:22:08', '2024-11-23 13:05:57'),
(4, 'PROVEEDOR TRES', '33334441', 'ZONA LOS PEDREGALES', '43343434', 'JOSE RAMIRES', 'DESCRIPCION', '2025-04-30', 1, '2025-05-01 00:34:32', '2025-05-01 00:34:32');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `salida_productos`
--

INSERT INTO `salida_productos` (`id`, `producto_id`, `cantidad`, `fecha_salida`, `tipo_salida_id`, `descripcion`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-03-31', 1, 'DESC22', '2025-03-31', 1, '2025-03-31 23:40:28', '2025-04-01 23:16:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock_minimos`
--

CREATE TABLE `stock_minimos` (
  `id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `stock_min` double NOT NULL,
  `status` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `stock_minimos`
--

INSERT INTO `stock_minimos` (`id`, `producto_id`, `fecha`, `stock_min`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-04-05', 5, 1, '2025-04-05 14:46:20', '2025-04-05 14:46:20'),
(2, 2, '2025-04-05', 0, 1, '2025-04-05 14:46:20', '2025-04-05 14:46:20'),
(3, 3, '2025-04-05', 38, 1, '2025-04-05 14:46:20', '2025-04-05 14:46:20'),
(4, 4, '2025-04-05', 5, 0, '2025-04-05 14:46:20', '2025-04-05 14:50:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_ingresos`
--

CREATE TABLE `tipo_ingresos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_ingresos`
--

INSERT INTO `tipo_ingresos` (`id`, `nombre`, `descripcion`, `status`, `created_at`, `updated_at`) VALUES
(1, 'INGRESO UNO', 'DESCRIPCION INGRESO UNO', 1, '2023-04-17 15:04:22', '2025-04-01 23:26:23'),
(4, 'INGRESO DOS', 'DESC. INGRESO DOS', 1, '2024-11-04 21:06:56', '2024-11-04 21:07:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_salidas`
--

CREATE TABLE `tipo_salidas` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_salidas`
--

INSERT INTO `tipo_salidas` (`id`, `nombre`, `descripcion`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SALIDA UNO', 'DESC. SALIDA UNO', 1, '2023-04-25 14:38:16', '2024-11-04 21:08:37'),
(2, 'TIPO DE SALIDA DOS', 'DESC SALIDA DOS', 1, '2023-04-25 14:38:21', '2025-04-05 14:27:29');

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
  `status` int NOT NULL DEFAULT '1',
  `b_auth` int NOT NULL DEFAULT '0',
  `update_password` int NOT NULL DEFAULT '0',
  `auth2fa` int NOT NULL DEFAULT '0',
  `google2fa_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `status`, `b_auth`, `update_password`, `auth2fa`, `google2fa_secret`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '', '', '', NULL, '', 'ADMINISTRADOR', NULL, '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2023-01-11', 1, 0, 1, 0, NULL, NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'CONDORI', '1234', 'CH', 'LOS OLIVOS', 'juan@gmail.com', '7777777', 'SUPERVISOR', 'default.png', '$2y$10$TBAsWARQnA/7Q42IkmQoPubombKWw5HXAP7eLNlzlCjZLUgXlbBGG', 0, '2023-04-24', 1, 0, 1, 0, 'eyJpdiI6IkNzdk1EWVBEQTFYSVZLQ1ZKWTZON3c9PSIsInZhbHVlIjoibDlmbEdRc2hNdmZzNmdqalQ3VlVqWTdaenhjSytiSFFLUk1FUnZlUmo5bz0iLCJtYWMiOiJhOGFjNmJhNmM1Yzk5NTljNzYwM2U1ODE0ODY4OWM3ZDEyNDZkMTRlYjlkYmVhZjcwN2U1MGYyMjhmNDljY2FjIiwidGFnIjoiIn0=', '2023-04-24 20:23:30', '2025-05-01 00:33:02'),
(3, 'MMAMANI', 'MARIA', 'MAMANI', 'GONZALES', '1234567', 'LP', 'ZONA LOS OLIVOS', 'maria@gmail.com', '7777777', 'SUPERVISOR', '1741794978_MMAMANI.jpg', '$2y$10$Jbi.AFSOz5KDg6hwjH9yNu3mEQQ31bCsIHrIuCp2g9pXqEEV5NQW6', 1, '2025-03-12', 1, 0, 1, 0, NULL, '2025-03-12 15:56:18', '2025-03-19 13:41:49'),
(4, 'PCORTEZ', 'PEDRO', 'CORTEZ', 'RAMIRES', '3232323', 'LP', 'ZONA LOS OLIVOS', 'pedro@gmail.com', '7777777', 'VENDEDOR', '1743551222_PCORTEZ.png', '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2025-04-01', 1, 0, 0, 0, NULL, '2025-04-01 23:47:02', '2025-04-23 13:52:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nom_fac` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nit_fac` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nit` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `descuento` double(8,2) NOT NULL,
  `total_final` decimal(24,2) NOT NULL,
  `estado` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `user_id`, `cliente_id`, `nom_fac`, `nit_fac`, `nit`, `total`, `descuento`, `total_final`, `estado`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 3, NULL, NULL, '111111', 1729.99, 10.00, 1556.99, 'CANCELADO', '2024-12-06', 1, '2024-12-06 19:00:07', '2025-04-01 23:11:21'),
(2, 1, 1, NULL, NULL, '2312314', 400.00, 0.00, 400.00, 'CANCELADO', '2025-03-12', 1, '2025-03-12 19:35:12', '2025-03-12 19:35:12'),
(3, 1, 3, NULL, NULL, '43434', 29999.70, 0.00, 29999.70, 'CANCELADO', '2025-03-12', 1, '2025-03-12 19:54:12', '2025-03-12 19:54:12'),
(4, 1, 2, NULL, NULL, '1231231', 920.00, 0.00, 920.00, 'CANCELADO', '2025-03-31', 1, '2025-03-31 23:28:42', '2025-03-31 23:28:42'),
(5, 1, 1, NULL, NULL, '2312314', 230.00, 0.00, 230.00, 'CANCELADO', '2025-03-31', 0, '2025-03-31 23:38:58', '2025-04-01 23:09:46'),
(6, 1, 1, NULL, NULL, '2312314', 100.00, 0.00, 100.00, 'CANCELADO', '2025-04-01', 1, '2025-04-01 23:29:31', '2025-04-01 23:29:31'),
(7, 1, 1, NULL, NULL, '2312314', 300.00, 2.00, 294.00, 'CANCELADO', '2025-04-05', 1, '2025-04-05 15:03:26', '2025-04-05 15:03:26'),
(8, 1, 1, 'JUAN PERES', '2342323', '2312314', 300.00, 3.00, 291.00, 'CANCELADO', '2025-04-05', 1, '2025-04-05 15:08:01', '2025-04-05 15:08:01'),
(9, 1, 8, 'HERRERA', '222222', '334343434', 100.00, 0.00, 100.00, 'CANCELADO', '2025-04-30', 1, '2025-05-01 01:00:05', '2025-05-01 01:00:30');

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
-- Indices de la tabla `stock_minimos`
--
ALTER TABLE `stock_minimos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_minimos_producto_id_foreign` (`producto_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `stock_minimos`
--
ALTER TABLE `stock_minimos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_ingresos`
--
ALTER TABLE `tipo_ingresos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_salidas`
--
ALTER TABLE `tipo_salidas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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

--
-- Filtros para la tabla `stock_minimos`
--
ALTER TABLE `stock_minimos`
  ADD CONSTRAINT `stock_minimos_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
