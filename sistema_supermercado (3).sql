-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-05-2026 a las 22:20:30
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
-- Base de datos: `sistema_supermercado`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_alerta_stock_bajo` (IN `p_limite` INT)   BEGIN
    SELECT 
        a.sku, 
        a.descripcion, 
        a.stock_disponible, 
        d.nombre_dep,
        d.tel_dep
    FROM articulo a
    INNER JOIN departamento d ON a.id_departamento = d.id_departamento
    WHERE a.stock_disponible <= p_limite
    ORDER BY a.stock_disponible ASC;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `sku` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `tasa_iva` decimal(5,2) NOT NULL,
  `stock_disponible` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `id_departamento` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`sku`, `descripcion`, `costo`, `precio_venta`, `tasa_iva`, `stock_disponible`, `id_departamento`) VALUES
('A1001', 'Arroz 1kg', 11.50, 18.00, 0.00, 340, 1001),
('A1002', 'Huevo Blanco 30 piezas', 65.00, 85.00, 0.00, 49, 1001),
('A1003', 'Leche Entera 1L', 18.50, 26.00, 0.00, 100, 1003),
('A1004', 'Detergente Polvo 5kg', 120.00, 185.00, 0.16, 30, 1005),
('A1005', 'Aceite Vegetal 1L', 35.00, 48.00, 0.00, 80, 1001),
('A1006', 'Pechuga de Pollo 1kg', 95.00, 145.00, 0.00, 45, 1002),
('A1007', 'Pan Blanco Grande', 32.00, 45.00, 0.00, 39, 1006),
('A1008', 'Refresco Cola 2.5L', 24.00, 38.00, 0.16, 119, 1004),
('A1009', 'Jam?n de Pavo 500g', 55.00, 89.00, 0.00, 25, 1011),
('A1010', 'Croquetas Perro 2kg', 110.00, 165.00, 0.16, 13, 1012),
('A1011', 'Salchicha de Pavo 500g', 42.00, 68.00, 0.00, 40, 1011),
('A1012', 'Shampoo 400ml', 45.00, 72.00, 0.16, 54, 1005),
('A1013', 'Paracetamol 500mg', 15.00, 35.00, 0.00, 100, 1013);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) NOT NULL,
  `apellido_materno` varchar(100) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `domicilio` text NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `saldo` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nombre`, `apellido_paterno`, `apellido_materno`, `rfc`, `domicilio`, `telefono`, `email`, `saldo`) VALUES
(2001, 'Luis', 'Hernandez', 'Ruiz', 'LUHR900103AAA', 'Col Sur Calle 3', '5552000083', 'luis@mail.com', 800.00),
(2002, 'Juan', 'Perez', 'Lopez', 'JUAP900101AAA', 'Col Centro Calle 1', '5552000001', 'juan@mail.com', 1000.00),
(2003, 'Maria', 'Gomez', 'Diaz', 'MARG900102AAA', 'Col Norte Calle 2', '5552000002', 'maria@mail.com', 500.00),
(2004, 'Ana', 'Torres', 'Soto', 'ANTS900104AAA', 'Col Este Calle 4', '5552000004', 'ana@mail.com', 1200.00),
(2005, 'Carlos', 'Ramirez', 'Mora', 'CARM900105AAA', 'Col Oeste Calle 5', '5552000805', 'carlos@mail.com', 300.00),
(2006, 'Sofia', 'Flores', 'Rios', 'SOFR900106AAA', 'Col Centro Calle 6', '5552000006', 'sofia@mail.com', 700.00),
(2007, 'Diego', 'Vargas', 'Cruz', 'DIVC900187AAA', 'Col Norte Calle 7', '5552000007', 'diego@mail.com', 650.00),
(2008, 'Laura', 'Castro', 'Reyes', 'LACR900108AAA', 'Col Sur Calle 8', '5552000008', 'laura@mail.com', 900.00),
(2009, 'Jorge', 'Ortega', 'Luna', 'JOOL900189AAA', 'Col Este Calle 9', '5552000009', 'jorge@mail.com', 400.00),
(2010, 'Elena', 'Navarro', 'Silva', 'ELNS900118AAA', 'Col Oeste Calle 10', '5552006018', 'elena@mail.com', 1108.00),
(2011, 'Ricardo', 'Mendoza', 'Ponce', 'RIMP900111AAA', 'Col Sur Calle 11', '5552000011', 'ricardo@mail.com', 150.00),
(2012, 'Patricia', 'Luna', 'Solis', 'PALS900112AAA', 'Col Norte Calle 12', '5552000012', 'patricia@mail.com', 2200.00),
(2013, 'Fernando', 'Reyes', 'Guerra', 'FERG900113AAA', 'Col Este Calle 13', '5552000013', 'fernando@mail.com', 0.00),
(2014, 'Fernando ', 'antonio ', 'mendoza', 'FERG900113zzz', ' Col Este Calle 90', '1234567890', 'fernanditoo@mail.com', 0.00),
(2017, 'Andrea ', 'Legareta', 'Verde', 'ANTS900104zzz', 'Calle 324 bista', '2311345678', 'andreasss@gmail.com', 150.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_departamento` int(10) UNSIGNED NOT NULL,
  `nombre_dep` varchar(100) NOT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `tel_dep` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_departamento`, `nombre_dep`, `ubicacion`, `tel_dep`) VALUES
(1001, 'Abarrotes', 'Zona A Pasillo 1', '5551000001'),
(1002, 'Carnes', 'Zona A Pasillo 2', '5551000002'),
(1003, 'Lacteos', 'Zona A Pasillo 3', '5551000003'),
(1004, 'Bebidas', 'Zona B Pasillo 1', '5551000004'),
(1005, 'Limpieza', 'Zona B Pasillo 2', '5551000005'),
(1006, 'Panaderia', 'Zona B Pasillo 3', '5551000006'),
(1007, 'Frutas', 'Zona C Pasillo 1', '5551000007'),
(1008, 'Verduras', 'Zona C Pasillo 2', '5551000008'),
(1009, 'Congelados', 'Zona C Pasillo 3', '5551000009'),
(1010, 'Electronica', 'Zona D Pasillo 1', '5551000010'),
(1011, 'Salchichoneria', 'Zona A Pasillo 4', '5551000011'),
(1012, 'Mascotas', 'Zona D Pasillo 2', '5551000012'),
(1013, 'Farmacia', 'Zona E Pasillo 1', '5551000013');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle` int(10) UNSIGNED NOT NULL,
  `id_pedido` int(10) UNSIGNED NOT NULL,
  `sku` varchar(50) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `importe` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id_detalle`, `id_pedido`, `sku`, `cantidad`, `precio_unitario`, `importe`) VALUES
(8001, 7001, 'A1001', 2, 18.00, 36.00),
(8002, 7001, 'A1004', 1, 185.00, 185.00),
(8003, 7001, 'A1007', 1, 45.00, 45.00),
(8004, 7002, 'A1002', 1, 85.00, 85.00),
(8005, 7002, 'A1005', 2, 48.00, 96.00),
(8006, 7002, 'A1008', 3, 38.00, 114.00),
(8007, 7003, 'A1003', 4, 26.00, 104.00),
(8008, 7003, 'A1006', 1, 145.00, 145.00),
(8009, 7003, 'A1009', 2, 89.00, 178.00),
(8010, 7004, 'A1010', 1, 165.00, 165.00),
(8011, 7004, 'A1001', 5, 18.00, 90.00),
(8012, 7004, 'A1002', 1, 85.00, 85.00),
(8013, 7005, 'A1004', 1, 185.00, 185.00),
(8014, 7005, 'A1007', 2, 45.00, 90.00),
(8015, 7005, 'A1003', 3, 26.00, 78.00),
(8016, 7006, 'A1005', 2, 48.00, 96.00),
(8017, 7006, 'A1008', 4, 38.00, 152.00),
(8018, 7006, 'A1006', 1, 145.00, 145.00),
(8019, 7007, 'A1009', 2, 89.00, 178.00),
(8020, 7007, 'A1010', 1, 165.00, 165.00),
(8021, 7007, 'A1001', 3, 18.00, 54.00),
(8022, 7008, 'A1002', 2, 85.00, 170.00),
(8023, 7008, 'A1004', 1, 185.00, 185.00),
(8024, 7008, 'A1007', 2, 45.00, 90.00),
(8025, 7009, 'A1003', 4, 26.00, 104.00),
(8026, 7009, 'A1005', 2, 48.00, 96.00),
(8027, 7009, 'A1008', 5, 38.00, 190.00),
(8028, 7010, 'A1006', 1, 145.00, 145.00),
(8029, 7010, 'A1009', 2, 89.00, 178.00),
(8030, 7010, 'A1010', 1, 165.00, 165.00),
(8031, 7011, 'A1011', 2, 68.00, 136.00),
(8032, 7011, 'A1012', 1, 72.00, 72.00),
(8033, 7011, 'A1013', 1, 35.00, 35.00),
(8034, 7012, 'A1001', 2, 18.00, 36.00),
(8035, 7012, 'A1003', 5, 26.00, 130.00),
(8036, 7012, 'A1006', 1, 145.00, 145.00),
(8037, 7013, 'A1010', 2, 165.00, 330.00),
(8038, 7013, 'A1013', 2, 35.00, 70.00),
(8039, 7013, 'A1012', 1, 10.00, 10.00),
(8040, 1774657091, 'A1001', 1, 18.00, 18.00),
(8041, 1774657091, 'A1004', 1, 185.00, 185.00),
(8042, 1774657468, 'A1001', 1, 18.00, 18.00),
(8043, 1774657468, 'A1007', 1, 45.00, 45.00),
(8044, 1774657606, 'A1005', 1, 48.00, 48.00),
(8045, 7014, 'A1005', 1, 48.00, 48.00),
(8046, 7014, 'A1012', 1, 72.00, 72.00),
(8047, 7015, 'A1001', 1, 18.00, 18.00),
(8048, 7016, 'A1002', 1, 85.00, 85.00),
(8049, 7017, 'A1005', 1, 48.00, 48.00),
(8050, 7018, 'A1010', 2, 165.00, 330.00),
(8051, 7018, 'A1013', 1, 35.00, 35.00),
(8052, 7018, 'A1007', 1, 45.00, 45.00),
(8053, 7018, 'A1011', 2, 68.00, 136.00),
(8054, 7001, 'A1001', 10, 18.00, 180.00),
(8055, 7019, 'A1001', 2, 18.00, 36.00),
(8056, 7019, 'A1010', 2, 165.00, 330.00),
(8057, 7020, 'A1010', 1, 165.00, 165.00),
(8058, 7021, 'A1007', 1, 45.00, 45.00),
(8059, 7022, 'A1002', 1, 85.00, 85.00);

--
-- Disparadores `detalle_pedido`
--
DELIMITER $$
CREATE TRIGGER `tg_inventario` BEFORE INSERT ON `detalle_pedido` FOR EACH ROW BEGIN
    DECLARE v_stock_actual INT;

    SELECT stock_disponible INTO v_stock_actual
    FROM articulo
    WHERE sku = NEW.sku;

    IF v_stock_actual >= NEW.cantidad THEN
        UPDATE articulo 
        SET stock_disponible = stock_disponible - NEW.cantidad
        WHERE sku = NEW.sku;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Stock insuficiente para realizar la venta';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(10) UNSIGNED NOT NULL,
  `nombre_emp` varchar(150) NOT NULL,
  `domicilio` text NOT NULL,
  `celular` varchar(20) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `id_departamento` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre_emp`, `domicilio`, `celular`, `salario`, `id_departamento`) VALUES
(4001, 'Luis Martinez', 'Col Centro Calle 10', '5554000001', 8000.00, 1001),
(4002, 'Ana Lopez', 'Col Norte Calle 5', '5554000002', 8200.00, 1002),
(4003, 'Carlos Ramirez', 'Col Sur Calle 8', '5554000003', 8300.00, 1003),
(4004, 'Maria Torres', 'Col Este Calle 3', '5554000004', 8400.00, 1004),
(4005, 'Jorge Hernandez', 'Col Oeste Calle 12', '5554000005', 8500.00, 1005),
(4006, 'Sofia Cruz', 'Col Centro Calle 15', '5554000006', 8600.00, 1006),
(4007, 'Pedro Gomez', 'Col Norte Calle 20', '5554000007', 8700.00, 1007),
(4008, 'Laura Diaz', 'Col Sur Calle 7', '5554000008', 8800.00, 1008),
(4009, 'Miguel Vargas', 'Col Este Calle 9', '5554000009', 8900.00, 1009),
(4010, 'Elena Castro', 'Col Oeste Calle 2', '5554000010', 9000.00, 1010),
(4011, 'Roberto Ruiz', 'Col Sur Calle 25', '5554000011', 8100.00, 1011),
(4012, 'Monica Silva', 'Col Norte Calle 30', '5554000012', 8200.00, 1012),
(4013, 'Gabriel Lima', 'Col Este Calle 40', '5554000013', 9500.00, 1013);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_precios`
--

CREATE TABLE `historial_precios` (
  `id_historial` int(10) UNSIGNED NOT NULL,
  `sku` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `costo_anterior` decimal(10,2) DEFAULT NULL,
  `costo_nuevo` decimal(10,2) DEFAULT NULL,
  `stock_anterior` int(11) DEFAULT NULL,
  `stock_nuevo` int(11) DEFAULT NULL,
  `fecha_cambio` datetime DEFAULT NULL,
  `id_proveedor` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_precios`
--

INSERT INTO `historial_precios` (`id_historial`, `sku`, `descripcion`, `costo_anterior`, `costo_nuevo`, `stock_anterior`, `stock_nuevo`, `fecha_cambio`, `id_proveedor`) VALUES
(1, 'A1001', 'Arroz 1kg', 11.00, 11.50, 290, 340, '2026-04-13 09:49:32', 3001),
(2, 'A1005', 'Aceite Vegetal 1L', 35.00, 35.00, 70, 75, '2026-05-12 14:04:51', 3004),
(3, 'A1001', 'Arroz 1kg', 11.50, 11.50, 338, 339, '2026-05-12 14:07:59', 3001);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(10) UNSIGNED NOT NULL,
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `fecha_pedido` datetime NOT NULL DEFAULT current_timestamp(),
  `metodo_pago` varchar(50) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `iva_monto` decimal(12,2) NOT NULL,
  `total_neto` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `id_cliente`, `fecha_pedido`, `metodo_pago`, `subtotal`, `iva_monto`, `total_neto`) VALUES
(7001, 2001, '2026-03-10 10:00:00', 'tarjeta', 256.00, 0.00, 256.00),
(7002, 2002, '2026-03-10 11:00:00', 'efectivo', 295.00, 0.00, 295.00),
(7003, 2003, '2026-03-10 12:00:00', 'tarjeta', 427.00, 0.00, 427.00),
(7004, 2004, '2026-03-11 10:00:00', 'efectivo', 340.00, 0.00, 340.00),
(7005, 2005, '2026-03-11 11:00:00', 'tarjeta', 353.00, 0.00, 353.00),
(7006, 2006, '2026-03-11 12:00:00', 'efectivo', 393.00, 0.00, 393.00),
(7007, 2007, '2026-03-12 10:00:00', 'tarjeta', 397.00, 0.00, 397.00),
(7008, 2008, '2026-03-12 11:00:00', 'efectivo', 445.00, 0.00, 445.00),
(7009, 2009, '2026-03-12 12:00:00', 'tarjeta', 390.00, 0.00, 390.00),
(7010, 2010, '2026-03-13 10:00:00', 'efectivo', 488.00, 0.00, 488.00),
(7011, 2011, '2026-03-13 11:00:00', 'tarjeta', 242.00, 0.00, 242.00),
(7012, 2012, '2026-03-14 10:00:00', 'efectivo', 315.00, 0.00, 315.00),
(7013, 2013, '2026-03-14 11:00:00', 'tarjeta', 410.00, 0.00, 410.00),
(7014, 2007, '2026-03-27 00:00:00', '', 0.00, 0.00, 139.20),
(7015, 2007, '2026-03-27 00:00:00', '', 0.00, 0.00, 20.88),
(7016, 2005, '2026-03-27 00:00:00', '', 0.00, 0.00, 98.60),
(7017, 2010, '2026-03-27 00:00:00', '', 0.00, 0.00, 55.68),
(7018, 2007, '2026-03-27 00:00:00', '', 0.00, 0.00, 633.36),
(7019, 2008, '2026-04-25 00:00:00', '', 0.00, 0.00, 424.56),
(7020, 2007, '2026-04-25 00:00:00', '', 0.00, 0.00, 191.40),
(7021, 2001, '2026-05-11 00:00:00', '', 0.00, 0.00, 52.20),
(7022, 2014, '2026-05-11 00:00:00', '', 0.00, 0.00, 98.60),
(1774657091, 2013, '2026-03-27 00:00:00', '', 0.00, 0.00, 235.48),
(1774657468, 2005, '2026-03-27 00:00:00', '', 0.00, 0.00, 73.08),
(1774657606, 2013, '2026-03-27 00:00:00', '', 0.00, 0.00, 55.68);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(10) UNSIGNED NOT NULL,
  `nombre_prov` varchar(150) NOT NULL,
  `direccion` text NOT NULL,
  `email` varchar(150) NOT NULL,
  `telefono` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre_prov`, `direccion`, `email`, `telefono`) VALUES
(3001, 'Distribuidora Norte', 'Zona Industrial 1', 'norte@mail.com', '5553000001'),
(3002, 'Carnes Selectas', 'Av Ganaderos 45', 'carnes@mail.com', '5553000002'),
(3003, 'Lacteos del Valle', 'Rancho 12', 'lacteos@mail.com', '5553000003'),
(3004, 'Bebidas Unidas', 'Parque Logistico 3', 'bebidas@mail.com', '5553000004'),
(3005, 'Productos Limpios SA', 'Zona Sur 88', 'limpieza@mail.com', '5553000005'),
(3006, 'Panificadora Central', 'Av Pan 100', 'pan@mail.com', '5553000006'),
(3007, 'Frutas Frescas MX', 'Mercado 21', 'frutas@mail.com', '5553000007'),
(3008, 'Verduras Selectas', 'Central Abasto 5', 'verduras@mail.com', '5553000008'),
(3009, 'Congelados Express', 'Bodega Frio 9', 'congelados@mail.com', '5553000009'),
(3010, 'Electronica Global', 'Plaza Tech 4', 'electronica@mail.com', '5553000010'),
(3011, 'Embutidos Jarpa', 'Calle Fria 5', 'jarpa@mail.com', '5553000011'),
(3012, 'Mascota Feliz', 'Av Mascotas 22', 'feliz@mail.com', '5553000012'),
(3013, 'FarmaUnion', 'Paseo Salud 1', 'farma@mail.com', '5553000013');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `surte_proveedor`
--

CREATE TABLE `surte_proveedor` (
  `id_surte` int(10) UNSIGNED NOT NULL,
  `id_proveedor` int(10) UNSIGNED NOT NULL,
  `sku` varchar(50) NOT NULL,
  `fecha_entrega` date NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `costo_compra` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `surte_proveedor`
--

INSERT INTO `surte_proveedor` (`id_surte`, `id_proveedor`, `sku`, `fecha_entrega`, `precio_unitario`, `cantidad`, `costo_compra`) VALUES
(6001, 3001, 'A1001', '2026-03-01', 11.00, 200, 2200.00),
(6002, 3002, 'A1003', '2026-03-02', 18.50, 100, 1850.00),
(6003, 3003, 'A1004', '2026-03-03', 120.00, 300, 36000.00),
(6004, 3004, 'A1005', '2026-03-04', 35.00, 250, 8750.00),
(6005, 3005, 'A1006', '2026-03-05', 95.00, 150, 14250.00),
(6006, 3006, 'A1007', '2026-03-06', 32.00, 180, 5760.00),
(6007, 3007, 'A1008', '2026-03-07', 24.00, 220, 5280.00),
(6008, 3008, 'A1009', '2026-03-08', 55.00, 210, 11550.00),
(6009, 3009, 'A1010', '2026-03-09', 110.00, 140, 15400.00),
(6010, 3010, 'A1001', '2026-03-10', 10.50, 90, 945.00),
(6011, 3011, 'A1011', '2026-03-11', 40.00, 100, 4000.00),
(6012, 3012, 'A1012', '2026-03-12', 43.00, 80, 3440.00),
(6013, 3013, 'A1013', '2026-03-13', 14.00, 150, 2100.00),
(6014, 3001, 'A1001', '2026-04-13', 11.50, 50, 525.00),
(6015, 3004, 'A1005', '2026-05-12', 35.00, 5, 175.00),
(6016, 3001, 'A1001', '2026-05-12', 11.50, 1, 11.50);

--
-- Disparadores `surte_proveedor`
--
DELIMITER $$
CREATE TRIGGER `tg_actualizar_inventario_y_historial` AFTER INSERT ON `surte_proveedor` FOR EACH ROW BEGIN
    DECLARE v_costo_viejo DECIMAL(10,2);
    DECLARE v_stock_viejo INT;
    DECLARE v_desc TEXT;

    SELECT costo, stock_disponible, descripcion 
    INTO v_costo_viejo, v_stock_viejo, v_desc
    FROM articulo 
    WHERE sku = NEW.sku;

    INSERT INTO historial_precios (
        sku, 
        descripcion, 
        costo_anterior, 
        costo_nuevo, 
        stock_anterior, 
        stock_nuevo, 
        fecha_cambio, 
        id_proveedor
    ) VALUES (
        NEW.sku, 
        v_desc, 
        v_costo_viejo, 
        NEW.precio_unitario, 
        v_stock_viejo, 
        (v_stock_viejo + NEW.cantidad), 
        NOW(), 
        NEW.id_proveedor
    );

    UPDATE articulo 
    SET stock_disponible = stock_disponible + NEW.cantidad,
        costo = NEW.precio_unitario
    WHERE sku = NEW.sku;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjeta_cliente`
--

CREATE TABLE `tarjeta_cliente` (
  `id_tarjeta` int(10) UNSIGNED NOT NULL,
  `id_cliente` int(10) UNSIGNED NOT NULL,
  `num_tarjeta` varchar(16) NOT NULL,
  `mes_venc` int(10) UNSIGNED NOT NULL,
  `anio_venc` int(10) UNSIGNED NOT NULL,
  `cvv` int(10) UNSIGNED NOT NULL,
  `banco_emisor` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarjeta_cliente`
--

INSERT INTO `tarjeta_cliente` (`id_tarjeta`, `id_cliente`, `num_tarjeta`, `mes_venc`, `anio_venc`, `cvv`, `banco_emisor`) VALUES
(5001, 2001, '1234567812345671', 12, 2027, 123, 'BBVA'),
(5002, 2002, '1234567812345672', 11, 2026, 234, 'BBVA'),
(5003, 2003, '1234567812345673', 10, 2028, 345, 'Banamex'),
(5004, 2004, '1234567812345674', 9, 2027, 456, 'Santander'),
(5005, 2005, '1234567812345675', 8, 2028, 567, 'HSBC'),
(5006, 2006, '1234567812345676', 7, 2027, 678, 'Banorte'),
(5007, 2007, '1234567812345677', 6, 2026, 789, 'Santander'),
(5008, 2008, '1234567812345678', 5, 2028, 321, 'HSBC'),
(5009, 2009, '1234567812345679', 4, 2027, 654, 'BBVA'),
(5010, 2010, '1234567812345680', 3, 2026, 987, 'Banamex'),
(5011, 2011, '1234567812345681', 2, 2027, 111, 'Banorte'),
(5012, 2012, '1234567812345682', 1, 2028, 222, 'BBVA'),
(5013, 2013, '1234567812345683', 12, 2026, 333, 'HSBC');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`sku`),
  ADD KEY `fk_art_dep` (`id_departamento`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `rfc` (`rfc`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_det_ped` (`id_pedido`),
  ADD KEY `fk_det_art` (`sku`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`),
  ADD KEY `fk_emp_dep` (`id_departamento`);

--
-- Indices de la tabla `historial_precios`
--
ALTER TABLE `historial_precios`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `fk_hist_art` (`sku`),
  ADD KEY `fk_hist_prov` (`id_proveedor`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `fk_ped_cli` (`id_cliente`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `surte_proveedor`
--
ALTER TABLE `surte_proveedor`
  ADD PRIMARY KEY (`id_surte`),
  ADD KEY `fk_surte_prov` (`id_proveedor`),
  ADD KEY `fk_surte_art` (`sku`);

--
-- Indices de la tabla `tarjeta_cliente`
--
ALTER TABLE `tarjeta_cliente`
  ADD PRIMARY KEY (`id_tarjeta`),
  ADD KEY `fk_tarjeta_cli` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2018;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id_departamento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1014;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8063;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4014;

--
-- AUTO_INCREMENT de la tabla `historial_precios`
--
ALTER TABLE `historial_precios`
  MODIFY `id_historial` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1774657607;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3014;

--
-- AUTO_INCREMENT de la tabla `surte_proveedor`
--
ALTER TABLE `surte_proveedor`
  MODIFY `id_surte` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6017;

--
-- AUTO_INCREMENT de la tabla `tarjeta_cliente`
--
ALTER TABLE `tarjeta_cliente`
  MODIFY `id_tarjeta` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5014;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_art_dep` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`);

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_det_art` FOREIGN KEY (`sku`) REFERENCES `articulo` (`sku`),
  ADD CONSTRAINT `fk_det_ped` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `fk_emp_dep` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`);

--
-- Filtros para la tabla `historial_precios`
--
ALTER TABLE `historial_precios`
  ADD CONSTRAINT `fk_hist_art` FOREIGN KEY (`sku`) REFERENCES `articulo` (`sku`),
  ADD CONSTRAINT `fk_hist_prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_ped_cli` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `surte_proveedor`
--
ALTER TABLE `surte_proveedor`
  ADD CONSTRAINT `fk_surte_art` FOREIGN KEY (`sku`) REFERENCES `articulo` (`sku`),
  ADD CONSTRAINT `fk_surte_prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);

--
-- Filtros para la tabla `tarjeta_cliente`
--
ALTER TABLE `tarjeta_cliente`
  ADD CONSTRAINT `fk_tarjeta_cli` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
