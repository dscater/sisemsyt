-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-03-2025 a las 14:46:53
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
(2, 'CATEGORIA DOS', 1, '2024-11-04 21:01:08', '2024-11-04 21:04:02');

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
(2, 'MARIA GONZALES CASAS', '1231231', 'CB', '34324111', '666666; 7777777', 'MARIA@GMAIL.COM', 'LOS OLIVOS', '2023-04-26', 1, '2023-04-26 20:05:20', '2023-04-26 20:05:50'),
(3, 'PABLO SANCHEZ', '43434', 'CB', '111111', '', '', '', '2023-04-26', 1, '2023-04-26 20:07:17', '2023-04-26 20:07:17');

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
(1, 'SISTEMA SISEMSYT', 'SISEMSYT', 'SISEMSYT S.A.', '10000000000', 'LA PAZ', 'LA PAZ', '2222222', 'SISEMSYT.TEST', 'ACTIVIDAD', 'SISEMSYT@GMAIL.COM', '1742395524_logo.jpg', '{\"host\": \"smtp.hostinger.com\", \"correo\": \"mensaje@emsytsrl.com\", \"driver\": \"smtp\", \"nombre\": \"sisemsyt\", \"puerto\": \"587\", \"password\": \"8Z@d>&kj^y\", \"encriptado\": \"tls\"}', NULL, '2025-03-19 14:45:24');

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
(7, 1, 3, 1, 999.99, 999.99, 1, '2025-03-12 20:15:47', '2025-03-12 20:15:47');

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
(10, 2, '2025-03-12', 121, '2025-03-12 20:15:47', '2025-03-12 20:15:47');

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
(1, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN CLIENTE', 'id: 1<br/>nombre: PEDRO MARTINEZ<br/>ci: 2312314<br/>ci_exp: LP<br/>nit: 1234567<br/>fono: 1234567<br/>correo: PEDRO@GMAIL.COM<br/>dir: LOS OLIVOS NRO. 2<br/>fecha_registro: 2023-04-26<br/>status: 1<br/>created_at: 2023-04-26 16:00:10<br/>updated_at: 2024-11-04 20:03:56<br/>', NULL, 'CLIENTES', '2024-11-23', '08:55:35', '2024-11-23 12:55:35', '2024-11-23 12:55:35'),
(2, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINO UN PRODUCTO', 'id: 1<br/>codigo_producto: COD.1<br/>nro_codigo: 1<br/>nombre: TECLADO KEYBOARD<br/>descripcion: DESC. PRODUCTO<br/>precio: 100.00<br/>stock_min: 3<br/>stock_actual: 0<br/>imagen: <br/>categoria_id: 1<br/>fecha_registro: 2024-09-25<br/>status: 1<br/>created_at: 2024-09-25 15:27:16<br/>updated_at: 2024-11-04 20:18:02<br/>', NULL, 'PRODUCTOS', '2024-11-23', '09:03:32', '2024-11-23 13:03:32', '2024-11-23 13:03:32'),
(3, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN PROVEEDOR', 'id: 2<br/>razon_social: PROVEEDOR SRL<br/>nit: 34343<br/>dir: <br/>fono: 2222<br/>nombre_contacto: <br/>descripcion: <br/>fecha_registro: 2023-04-28<br/>status: 1<br/>created_at: 2023-04-28 11:22:08<br/>updated_at: 2023-04-28 11:22:08<br/>', NULL, 'PROVEEDORES', '2024-11-23', '09:05:57', '2024-11-23 13:05:57', '2024-11-23 13:05:57'),
(4, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: juan@gmail.com<br/>fono: 7777777<br/>tipo: SUPERVISOR<br/>foto: default.png<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>acceso: 1<br/>fecha_registro: 2023-04-24<br/>status: 1<br/>created_at: 2023-04-24 16:23:30<br/>updated_at: 2024-11-04 20:42:32<br/>', NULL, 'USUARIOS', '2024-11-23', '09:09:02', '2024-11-23 13:09:02', '2024-11-23 13:09:02'),
(5, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: juan@gmail.com<br/>fono: 7777777<br/>tipo: SUPERVISOR<br/>foto: default.png<br/>password: $2y$10$ZTabc8GZiG/WlSL4nJbloe3WMay9P10kVUOlfsW/aFjhqzA9mi/jS<br/>acceso: 1<br/>fecha_registro: 2023-04-24<br/>status: 1<br/>created_at: 2023-04-24 16:23:30<br/>updated_at: 2024-11-23 09:09:02<br/>', NULL, 'USUARIOS', '2024-11-23', '09:09:47', '2024-11-23 13:09:47', '2024-11-23 13:09:47'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN PRODUCTO', 'id: 1<br/>codigo_producto: COD.1<br/>nro_codigo: 1<br/>nombre: TECLADO KEYBOARD<br/>descripcion: DESC. PRODUCTO<br/>precio: 100.00<br/>stock_min: 3<br/>stock_actual: 0<br/>imagen: <br/>categoria_id: 1<br/>fecha_registro: 2024-09-25<br/>status: 1<br/>created_at: 2024-09-25 15:27:16<br/>updated_at: 2024-11-23 09:03:32<br/>', 'id: 1<br/>codigo_producto: COD.1<br/>nro_codigo: 1<br/>nombre: TECLADO KEYBOARD<br/>descripcion: DESC. PRODUCTO<br/>precio: 100.00<br/>stock_min: 3<br/>stock_actual: 0<br/>imagen: <br/>categoria_id: 1<br/>fecha_registro: 2024-09-25<br/>status: 1<br/>created_at: 2024-09-25 15:27:16<br/>updated_at: 2024-11-23 09:03:32<br/>', 'PRODUCTOS', '2024-11-27', '22:11:46', '2024-11-28 02:11:46', '2024-11-28 02:11:46'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 2<br/>codigo_producto: COD.2<br/>nro_codigo: 2<br/>nombre: COD.DOS<br/>descripcion: PRODUCTO DOS<br/>precio: 200<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: 1732760350_2.png<br/>categoria_id: 1<br/>fecha_registro: 2024-11-27<br/>status: <br/>created_at: 2024-11-27 22:19:10<br/>updated_at: 2024-11-27 22:19:10<br/>', NULL, 'PRODUCTOS', '2024-11-27', '22:19:10', '2024-11-28 02:19:10', '2024-11-28 02:19:10'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 1<br/>producto_id: 1<br/>proveedor_id: 1<br/>precio_compra: 20<br/>cantidad: 100<br/>lote: 2024<br/>fecha_fabricacion: 2020-01-01<br/>tipo_ingreso_id: 1<br/>descripcion: DESC INGRESO<br/>fecha_registro: 2024-12-06<br/>status: <br/>created_at: 2024-12-06 14:52:06<br/>updated_at: 2024-12-06 14:52:06<br/>', NULL, 'INGRESO DE PRODUCTOS', '2024-12-06', '14:52:06', '2024-12-06 18:52:06', '2024-12-06 18:52:06'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 2<br/>producto_id: 2<br/>proveedor_id: 2<br/>precio_compra: 37.6<br/>cantidad: 123<br/>lote: 2024<br/>fecha_fabricacion: 2021-01-01<br/>tipo_ingreso_id: 1<br/>descripcion: DESC<br/>fecha_registro: 2024-12-06<br/>status: <br/>created_at: 2024-12-06 14:54:25<br/>updated_at: 2024-12-06 14:54:25<br/>', NULL, 'INGRESO DE PRODUCTOS', '2024-12-06', '14:54:25', '2024-12-06 18:54:25', '2024-12-06 18:54:25'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>nit: 2312314<br/>total: 900.00<br/>descuento: 0<br/>total_final: 900.00<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: <br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2024-12-06 15:00:07<br/>', NULL, 'ORDEN DE VENTA', '2024-12-06', '15:00:07', '2024-12-06 19:00:07', '2024-12-06 19:00:07'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', 'id: 3<br/>codigo_producto: COD.3<br/>nro_codigo: 3<br/>nombre: PRODUCTO TRES<br/>descripcion: DESC PROD TRES<br/>precio: 999.99<br/>stock_min: 10<br/>stock_actual: 0<br/>imagen: <br/>categoria_id: 2<br/>fecha_registro: 2025-03-11<br/>status: <br/>created_at: 2025-03-11 10:20:32<br/>updated_at: 2025-03-11 10:20:32<br/>', NULL, 'PRODUCTOS', '2025-03-11', '10:20:32', '2025-03-11 14:20:32', '2025-03-11 14:20:32'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN INGRESO DE PRODUCTO', 'id: 3<br/>producto_id: 3<br/>proveedor_id: 2<br/>precio_compra: 1299<br/>cantidad: 100<br/>lote: 2025<br/>fecha_fabricacion: 2024-01-01<br/>tipo_ingreso_id: 1<br/>descripcion: DESC TRES<br/>fecha_registro: 2025-03-11<br/>status: <br/>created_at: 2025-03-11 10:21:01<br/>updated_at: 2025-03-11 10:21:01<br/>', NULL, 'INGRESO DE PRODUCTOS', '2025-03-11', '10:21:01', '2025-03-11 14:21:01', '2025-03-11 14:21:01'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'id: 1<br/>user_id: 1<br/>cliente_id: 1<br/>nit: 2312314<br/>total: 900.00<br/>descuento: 0<br/>total_final: 900.00<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2024-12-06 15:00:07<br/>', 'id: 1<br/>user_id: 1<br/>cliente_id: 2<br/>nit: 34324111<br/>total: 1099.99<br/>descuento: 0<br/>total_final: 1099.99<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2025-03-11 10:24:44<br/>', 'ORDEN DE VENTA', '2025-03-11', '10:24:44', '2025-03-11 14:24:44', '2025-03-11 14:24:44'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'id: 1<br/>user_id: 1<br/>cliente_id: 2<br/>nit: 34324111<br/>total: 1099.99<br/>descuento: 0<br/>total_final: 1099.99<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2025-03-11 10:24:44<br/>', 'id: 1<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 111111<br/>total: 500.00<br/>descuento: 0<br/>total_final: 500.00<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2025-03-11 10:25:44<br/>', 'ORDEN DE VENTA', '2025-03-11', '10:25:44', '2025-03-11 14:25:44', '2025-03-11 14:25:44'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 3<br/>usuario: MMAMANI<br/>nombre: MARIA<br/>paterno: MAMANI<br/>materno: GONZALES<br/>ci: 1234567<br/>ci_exp: LP<br/>dir: ZONA LOS OLIVOS<br/>correo: maria@gmail.com<br/>fono: 7777777<br/>tipo: SUPERVISOR<br/>foto: 1741794978_MMAMANI.jpg<br/>password: $2y$10$pI4VJXtae9x74kqWwmc2b.9oT6l.IgOFKnrO.1/fL0300Au/D1TXu<br/>acceso: 1<br/>fecha_registro: 2025-03-12<br/>status: <br/>b_auth: <br/>update_password: <br/>auth2fa: <br/>google2fa_secret: <br/>created_at: 2025-03-12 11:56:18<br/>updated_at: 2025-03-12 11:56:18<br/>', NULL, 'USUARIOS', '2025-03-12', '11:56:18', '2025-03-12 15:56:18', '2025-03-12 15:56:18'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 2<br/>user_id: 1<br/>cliente_id: 1<br/>nit: 2312314<br/>total: 400.00<br/>descuento: 0<br/>total_final: 400.00<br/>estado: CANCELADO<br/>fecha_registro: 2025-03-12<br/>status: <br/>created_at: 2025-03-12 15:35:12<br/>updated_at: 2025-03-12 15:35:12<br/>', NULL, 'ORDEN DE VENTA', '2025-03-12', '15:35:12', '2025-03-12 19:35:12', '2025-03-12 19:35:12'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UNA ORDEN DE VENTA', 'id: 3<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 43434<br/>total: 29999.70<br/>descuento: 0<br/>total_final: 29999.70<br/>estado: CANCELADO<br/>fecha_registro: 2025-03-12<br/>status: <br/>created_at: 2025-03-12 15:54:12<br/>updated_at: 2025-03-12 15:54:12<br/>', NULL, 'ORDEN DE VENTA', '2025-03-12', '15:54:12', '2025-03-12 19:54:12', '2025-03-12 19:54:12'),
(18, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UNA ORDEN DE VENTA', 'id: 1<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 111111<br/>total: 500.00<br/>descuento: 0<br/>total_final: 500.00<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2025-03-11 10:25:44<br/>', 'id: 1<br/>user_id: 1<br/>cliente_id: 3<br/>nit: 111111<br/>total: 1499.99<br/>descuento: 10<br/>total_final: 1349.99<br/>estado: CANCELADO<br/>fecha_registro: 2024-12-06<br/>status: 1<br/>created_at: 2024-12-06 15:00:07<br/>updated_at: 2025-03-12 16:15:47<br/>', 'ORDEN DE VENTA', '2025-03-12', '16:15:47', '2025-03-12 20:15:47', '2025-03-12 20:15:47'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISEMSYT<br/>ciudad: LA PAZ<br/>conf_email:{\"host\":\"smtp.hostinger.com\",\"correo\":\"mensaje@emsytsrl.com\",\"driver\":\"smtp\",\"nombre\":\"sisemsyt\",\"puerto\":\"587\",\"password\":\"8Z@d>&kj^y\",\"encriptado\":\"tls\"}<br/>correo: SISEMSYT@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>fono: 2222222<br/>id: 1<br/>logo: 1682712649_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA SISEMSYT<br/>razon_social: SISEMSYT S.A.<br/>updated_at: 2024-11-04 20:34:49<br/>web: SISEMSYT.TEST<br/>', 'actividad: ACTIVIDAD<br/>alias: SISEMSYT<br/>ciudad: LA PAZ<br/>conf_email:{\"host\":\"smtp.hostinger.com\",\"correo\":\"mensaje@emsytsrl.com\",\"driver\":\"smtp\",\"nombre\":\"sisemsyt\",\"puerto\":\"587\",\"password\":\"8Z@d>&kj^y\",\"encriptado\":\"tls\"}<br/>correo: SISEMSYT@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>fono: 2222222<br/>id: 1<br/>logo: 1742395468_logo.jpeg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA SISEMSYT<br/>razon_social: SISEMSYT S.A.<br/>updated_at: 2025-03-19 10:44:28<br/>web: SISEMSYT.TEST<br/>', 'CONFIGURACIÓN', '2025-03-19', '10:44:28', '2025-03-19 14:44:28', '2025-03-19 14:44:28'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ LA CONFIGURACIÓN DEL SISTEMA', 'actividad: ACTIVIDAD<br/>alias: SISEMSYT<br/>ciudad: LA PAZ<br/>conf_email:{\"host\":\"smtp.hostinger.com\",\"correo\":\"mensaje@emsytsrl.com\",\"driver\":\"smtp\",\"nombre\":\"sisemsyt\",\"puerto\":\"587\",\"password\":\"8Z@d>&kj^y\",\"encriptado\":\"tls\"}<br/>correo: SISEMSYT@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>fono: 2222222<br/>id: 1<br/>logo: 1742395468_logo.jpeg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA SISEMSYT<br/>razon_social: SISEMSYT S.A.<br/>updated_at: 2025-03-19 10:44:28<br/>web: SISEMSYT.TEST<br/>', 'actividad: ACTIVIDAD<br/>alias: SISEMSYT<br/>ciudad: LA PAZ<br/>conf_email:{\"host\":\"smtp.hostinger.com\",\"correo\":\"mensaje@emsytsrl.com\",\"driver\":\"smtp\",\"nombre\":\"sisemsyt\",\"puerto\":\"587\",\"password\":\"8Z@d>&kj^y\",\"encriptado\":\"tls\"}<br/>correo: SISEMSYT@GMAIL.COM<br/>created_at: <br/>dir: LA PAZ<br/>fono: 2222222<br/>id: 1<br/>logo: 1742395524_logo.jpg<br/>nit: 10000000000<br/>nombre_sistema: SISTEMA SISEMSYT<br/>razon_social: SISEMSYT S.A.<br/>updated_at: 2025-03-19 10:45:24<br/>web: SISEMSYT.TEST<br/>', 'CONFIGURACIÓN', '2025-03-19', '10:45:24', '2025-03-19 14:45:24', '2025-03-19 14:45:24');

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
(1, 1, 1, 20.00, 100, '2024', '2020-01-01', 1, 'DESC INGRESO', '2024-12-06', 1, '2024-12-06 18:52:06', '2024-12-06 18:52:06'),
(2, 2, 2, 37.60, 123, '2024', '2021-01-01', 1, 'DESC', '2024-12-06', 1, '2024-12-06 18:54:25', '2024-12-06 18:54:25'),
(3, 3, 2, 1299.00, 100, '2025', '2024-01-01', 1, 'DESC TRES', '2025-03-11', 1, '2025-03-11 14:21:01', '2025-03-11 14:21:01');

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
(1, NULL, 'INGRESO', 1, 1, 'VALOR INICIAL', 100.00, 'INGRESO', 100, NULL, 100, 100.00, 10000.00, NULL, 10000.00, '2024-12-06', 1, '2024-12-06 18:52:06', '2024-12-06 18:52:06'),
(2, NULL, 'INGRESO', 2, 2, 'VALOR INICIAL', 200.00, 'INGRESO', 123, NULL, 123, 200.00, 24600.00, NULL, 24600.00, '2024-12-06', 1, '2024-12-06 18:54:25', '2025-03-11 14:24:44'),
(3, NULL, 'VENTA', 1, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 1, 99, 100.00, NULL, 100.00, 9900.00, '2024-12-06', 1, '2024-12-06 19:00:07', '2025-03-12 20:15:47'),
(5, NULL, 'INGRESO', 3, 3, 'VALOR INICIAL', 999.99, 'INGRESO', 100, NULL, 100, 999.99, 99999.00, NULL, 99999.00, '2025-03-11', 1, '2025-03-11 14:21:01', '2025-03-11 14:25:44'),
(7, NULL, 'VENTA', 4, 2, 'VENTA DE PRODUCTO', 200.00, 'EGRESO', NULL, 2, 121, 200.00, NULL, 400.00, 24200.00, '2025-03-11', 1, '2025-03-11 14:25:44', '2025-03-12 20:15:47'),
(8, NULL, 'VENTA', 5, 1, 'VENTA DE PRODUCTO', 100.00, 'EGRESO', NULL, 4, 95, 100.00, NULL, 400.00, 9500.00, '2025-03-12', 1, '2025-03-12 19:35:12', '2025-03-12 20:15:47'),
(9, NULL, 'VENTA', 6, 3, 'VENTA DE PRODUCTO', 999.99, 'EGRESO', NULL, 30, 70, 999.99, NULL, 29999.70, 69999.30, '2025-03-12', 1, '2025-03-12 19:54:12', '2025-03-12 19:54:12'),
(10, NULL, 'VENTA', 7, 3, 'VENTA DE PRODUCTO', 999.99, 'EGRESO', NULL, 1, 69, 999.99, NULL, 999.99, 68999.31, '2025-03-12', 1, '2025-03-12 20:15:47', '2025-03-12 20:15:47');

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
(11, 'DEBAJO STOCK MINIMO', 3, 'ALERTA URGENTE EL PRODUCTO PRODUCTO TRES SE ENCUENTRA MENOR AL STOCK MÍNIMO, LE SUGERIMOS REABASTECER EL PRODUCTO CON URGENCIA', '2025-03-19', '09:31:51', '2025-03-19 13:31:51', '2025-03-19 13:31:51');

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
(1, 1, 1, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(2, 1, 2, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(3, 2, 1, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(4, 2, 2, 0, '2024-12-06 18:59:41', '2024-12-06 18:59:41'),
(5, 3, 1, 0, '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(6, 3, 2, 0, '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
(7, 4, 1, 0, '2025-03-11 14:08:17', '2025-03-11 14:08:17'),
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
(28, 11, 3, 0, '2025-03-19 13:31:51', '2025-03-19 13:31:51');

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
(1, 'COD.1', 1, 'TECLADO KEYBOARD', 'DESC. PRODUCTO', 100.00, 5, 95, '', 1, '2024-09-25', 1, '2024-09-25 19:27:16', '2025-03-12 20:15:47'),
(2, 'COD.2', 2, 'COD.DOS', 'PRODUCTO DOS', 200.00, 0, 121, '1732760350_2.png', 1, '2024-11-27', 1, '2024-11-28 02:19:10', '2025-03-12 20:15:47'),
(3, 'COD.3', 3, 'PRODUCTO TRES', 'DESC PROD TRES', 999.99, 38, 69, '', 2, '2025-03-11', 1, '2025-03-11 14:20:32', '2025-03-12 20:15:47');

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
(1, 'PEPE S.A.', '3333444', 'LOS PEDREGALES NRO. 3', '1234567', 'JOSE PAREDES', 'DESCRIPCION', '2023-04-24', 1, '2023-04-24 21:09:13', '2024-11-05 00:10:52'),
(2, 'PROVEEDOR SRL', '34343', '', '2222', '', '', '2023-04-28', 1, '2023-04-28 15:22:08', '2024-11-23 13:05:57');

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
(1, 'INGRESO UNO', 'DESC. INGRESO UNO', 1, '2023-04-17 15:04:22', '2024-11-04 21:07:08'),
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
(2, 'TIPO DE SALIDA DOS', 'SALIDA DOS', 1, '2023-04-25 14:38:21', '2024-11-04 21:08:44');

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
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', 'victorgonzalo.as@gmail.com', '7777777', 'SUPERVISOR', 'default.png', '$2y$10$tM3Q4FMvwtcW8srzubFgou7QPfzkPfyc5ALC7nLwgaj7yTGSZqJPK', 1, '2023-04-24', 1, 0, 1, 1, 'ATBX5IITF46JOATW', '2023-04-24 20:23:30', '2025-03-12 20:16:58'),
(3, 'MMAMANI', 'MARIA', 'MAMANI', 'GONZALES', '1234567', 'LP', 'ZONA LOS OLIVOS', 'maria@gmail.com', '7777777', 'SUPERVISOR', '1741794978_MMAMANI.jpg', '$2y$10$Jbi.AFSOz5KDg6hwjH9yNu3mEQQ31bCsIHrIuCp2g9pXqEEV5NQW6', 1, '2025-03-12', 1, 0, 1, 0, NULL, '2025-03-12 15:56:18', '2025-03-19 13:41:49');

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
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `user_id`, `cliente_id`, `nit`, `total`, `descuento`, `total_final`, `estado`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '111111', 1499.99, 10.00, 1349.99, 'CANCELADO', '2024-12-06', 1, '2024-12-06 19:00:07', '2025-03-12 20:15:47'),
(2, 1, 1, '2312314', 400.00, 0.00, 400.00, 'CANCELADO', '2025-03-12', 1, '2025-03-12 19:35:12', '2025-03-12 19:35:12'),
(3, 1, 3, '43434', 29999.70, 0.00, 29999.70, 'CANCELADO', '2025-03-12', 1, '2025-03-12 19:54:12', '2025-03-12 19:54:12');

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `fecha_stocks`
--
ALTER TABLE `fecha_stocks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `ingreso_productos`
--
ALTER TABLE `ingreso_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `kardex_productos`
--
ALTER TABLE `kardex_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificacions`
--
ALTER TABLE `notificacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `notificacion_users`
--
ALTER TABLE `notificacion_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedors`
--
ALTER TABLE `proveedors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
