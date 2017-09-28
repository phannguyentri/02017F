-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th9 23, 2017 lúc 07:35 AM
-- Phiên bản máy phục vụ: 10.1.25-MariaDB
-- Phiên bản PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `02017f`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_adjustments`
--

CREATE TABLE `sma_adjustments` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_calendar`
--

CREATE TABLE `sma_calendar` (
  `date` date NOT NULL,
  `data` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_captcha`
--

CREATE TABLE `sma_captcha` (
  `captcha_id` bigint(13) UNSIGNED NOT NULL,
  `captcha_time` int(10) UNSIGNED NOT NULL,
  `ip_address` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `word` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_captcha`
--

INSERT INTO `sma_captcha` (`captcha_id`, `captcha_time`, `ip_address`, `word`) VALUES
(1, 1497857401, '::1', '5d2MK'),
(2, 1497857404, '::1', 'd7ZC8'),
(3, 1497857405, '::1', '73ZIQ'),
(4, 1497857406, '::1', 'rMzMd');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_categories`
--

CREATE TABLE `sma_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_categories`
--

INSERT INTO `sma_categories` (`id`, `code`, `name`, `image`) VALUES
(3, 'KTS', 'KIM THU SÉT L=1,18M', NULL),
(4, 'CVT', 'MẶT BÍCH BÍT ĐẦU CỘT', NULL),
(5, 'DC', 'ĐỐT CỘT 660x660x;L=5500', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_combo_items`
--

CREATE TABLE `sma_combo_items` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_companies`
--

CREATE TABLE `sma_companies` (
  `id` int(11) NOT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `group_name` varchar(20) DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `customer_group_name` varchar(100) DEFAULT NULL,
  `name` varchar(55) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `vat_no` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(55) DEFAULT NULL,
  `state` varchar(55) DEFAULT NULL,
  `postal_code` varchar(8) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `cf1` varchar(100) DEFAULT NULL,
  `cf2` varchar(100) DEFAULT NULL,
  `cf3` varchar(100) DEFAULT NULL,
  `cf4` varchar(100) DEFAULT NULL,
  `cf5` varchar(100) DEFAULT NULL,
  `cf6` varchar(100) DEFAULT NULL,
  `invoice_footer` text,
  `payment_term` int(11) DEFAULT '0',
  `logo` varchar(255) DEFAULT 'logo.png',
  `award_points` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_companies`
--

INSERT INTO `sma_companies` (`id`, `group_id`, `group_name`, `customer_group_id`, `customer_group_name`, `name`, `company`, `vat_no`, `address`, `city`, `state`, `postal_code`, `country`, `phone`, `email`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `invoice_footer`, `payment_term`, `logo`, `award_points`) VALUES
(1, 3, 'customer', 1, 'General', 'Walk-in Customer', 'Walk-in Customer', '', 'Customer Address', 'Petaling Jaya', 'Selangor', '46000', 'Malaysia', '0123456789', 'customer@google.com', '', '', '', '', '', '', NULL, 0, 'logo.png', 0),
(2, 4, 'supplier', NULL, NULL, 'Quần Áo Thời Trang Trực Tuyến', 'Yanstore', '', '12 bàu cát 3, phường 14', 'Hồ Chí Minh', 'Tân Bình', '', 'VietNam', '0123456789', 'supplier@google.com', '-', '-', '-', '-', '-', '-', NULL, 0, 'logo.png', 0),
(3, NULL, 'biller', NULL, NULL, 'Chai', 'Test Biller', '1234', 'HCM', '', '', NULL, 'Việt Nam', '012345678', 'hvchai@gmail.com', 'Hoàng Văn ', NULL, NULL, NULL, NULL, NULL, ' Thank you for shopping with us. Please come again', 0, 'logo1.png', 0),
(4, 3, 'customer', 1, 'General', 'hà', 'tư nhân', '', 'ha noi', 'Hà Nội', '', '', '', '0901122432', 'phamthuha@gmail.com', '', '', '', '0969337365', '', 'phamthuha@gmail.com', NULL, 0, 'logo.png', 0),
(5, NULL, 'biller', NULL, NULL, 'Tân', 'FOSO', '1234', 'HCM', '', '', NULL, 'Việt Nam', '435646', 'trantan@gmai.com', 'Trần', NULL, NULL, NULL, NULL, NULL, '', 0, 'logo-foso-06.gif', 0),
(7, NULL, 'biller', NULL, NULL, 'Hậu', 'FOSO', '12345', 'HCM', '', '', NULL, 'Việt Nam', '0939701693', 'nhhau@gmail.com', 'Nguyễn Hữu ', NULL, NULL, NULL, NULL, NULL, '', 0, 'logo-foso-06.gif', 0),
(8, NULL, 'biller', NULL, NULL, 'Tâm', 'FOSO', '1234', 'HCM', '', '', NULL, 'Việt Nam', '0939701693', 'nctam@gmail.com', 'Nguyễn Chí', NULL, NULL, NULL, NULL, NULL, '', 0, 'logo-foso-06.gif', 0),
(9, NULL, 'biller', NULL, NULL, 'Tan', 'fdbfd', '', 'dfgvdfxvb', '', '', NULL, 'Việt Nam', '5654', 'tvttdsan@gmail.com', 'Tran ', NULL, NULL, NULL, NULL, NULL, '', 0, 'logo-foso-06.gif', 0),
(10, 3, 'customer', 1, 'General', 'THUY', 'THUY', '', '110 cao thắng quận 3', 'hồ chí minh', '', '', '', '866566793', 'nguyenan@fososoft.com', '', '', '', '', '', '', NULL, 0, 'logo.png', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_costing`
--

CREATE TABLE `sma_costing` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sale_item_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `purchase_item_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `purchase_net_unit_cost` decimal(25,4) DEFAULT NULL,
  `purchase_unit_cost` decimal(25,4) DEFAULT NULL,
  `sale_net_unit_price` decimal(25,4) NOT NULL,
  `sale_unit_price` decimal(25,4) NOT NULL,
  `quantity_balance` decimal(15,4) DEFAULT NULL,
  `inventory` tinyint(1) DEFAULT '0',
  `overselling` tinyint(1) DEFAULT '0',
  `option_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_costing`
--

INSERT INTO `sma_costing` (`id`, `date`, `product_id`, `sale_item_id`, `sale_id`, `purchase_item_id`, `quantity`, `purchase_net_unit_cost`, `purchase_unit_cost`, `sale_net_unit_price`, `sale_unit_price`, `quantity_balance`, `inventory`, `overselling`, `option_id`) VALUES
(1, '2017-06-26', 30, 23, 13, NULL, '10.0000', '0.0000', '0.0000', '500.0000', '500.0000', NULL, NULL, 0, NULL),
(2, '2017-06-26', 29, 24, 13, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(3, '2017-06-26', 30, 25, 13, NULL, '1.0000', '0.0000', '0.0000', '500.0000', '500.0000', NULL, NULL, 0, NULL),
(4, '2017-07-01', 30, 32, 40, NULL, '50.0000', '0.0000', '0.0000', '500.0000', '500.0000', NULL, NULL, 0, NULL),
(5, '2017-07-01', 29, 33, 40, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(6, '2017-07-01', 29, 34, 39, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(7, '2017-07-01', 30, 35, 40, NULL, '50.0000', '0.0000', '0.0000', '500.0000', '500.0000', NULL, NULL, 0, NULL),
(8, '2017-07-01', 29, 36, 40, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(9, '2017-07-01', 29, 37, 39, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(10, '2017-07-01', 29, 38, 39, NULL, '10.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', NULL, NULL, 0, NULL),
(11, '2017-07-05', 29, 43, 39, NULL, '0.0000', '0.0000', '0.0000', '1000.0000', '1000.0000', '10.0000', NULL, 0, NULL),
(12, '2017-07-05', 30, 44, 39, NULL, '0.0000', '0.0000', '0.0000', '500.0000', '500.0000', '50.0000', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_currencies`
--

CREATE TABLE `sma_currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(5) NOT NULL,
  `name` varchar(55) NOT NULL,
  `rate` decimal(12,4) NOT NULL,
  `auto_update` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_currencies`
--

INSERT INTO `sma_currencies` (`id`, `code`, `name`, `rate`, `auto_update`) VALUES
(1, 'USD', 'US Dollar', '1.0000', 0),
(2, 'ERU', 'EURO', '0.7340', 0),
(3, 'VND', 'VNĐ', '1.0000', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_customer_groups`
--

CREATE TABLE `sma_customer_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_customer_groups`
--

INSERT INTO `sma_customer_groups` (`id`, `name`, `percent`) VALUES
(1, 'General', 0),
(2, 'Reseller', -5),
(3, 'Distributor', -15),
(4, 'New Customer (+10)', 10);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_date_format`
--

CREATE TABLE `sma_date_format` (
  `id` int(11) NOT NULL,
  `js` varchar(20) NOT NULL,
  `php` varchar(20) NOT NULL,
  `sql` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_date_format`
--

INSERT INTO `sma_date_format` (`id`, `js`, `php`, `sql`) VALUES
(1, 'mm-dd-yyyy', 'm-d-Y', '%m-%d-%Y'),
(2, 'mm/dd/yyyy', 'm/d/Y', '%m/%d/%Y'),
(3, 'mm.dd.yyyy', 'm.d.Y', '%m.%d.%Y'),
(4, 'dd-mm-yyyy', 'd-m-Y', '%d-%m-%Y'),
(5, 'dd/mm/yyyy', 'd/m/Y', '%d/%m/%Y'),
(6, 'dd.mm.yyyy', 'd.m.Y', '%d.%m.%Y');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_deliveries`
--

CREATE TABLE `sma_deliveries` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) NOT NULL,
  `do_reference_no` varchar(50) NOT NULL,
  `sale_reference_no` varchar(50) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_expenses`
--

CREATE TABLE `sma_expenses` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference` varchar(50) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` varchar(55) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_gift_cards`
--

CREATE TABLE `sma_gift_cards` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,4) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `balance` decimal(25,4) NOT NULL,
  `expiry` date DEFAULT NULL,
  `created_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_groups`
--

CREATE TABLE `sma_groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_groups`
--

INSERT INTO `sma_groups` (`id`, `name`, `description`) VALUES
(1, 'owner', 'Owner'),
(2, 'admin', 'Administrator'),
(3, 'customer', 'Customer'),
(4, 'supplier', 'Supplier'),
(5, 'sales', 'Sales Staff');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_items`
--

CREATE TABLE `sma_items` (
  `id` int(11) NOT NULL,
  `item` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `specification` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size_long` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size_wide` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weight` decimal(15,0) DEFAULT NULL,
  `unit_id` int(10) DEFAULT NULL,
  `unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cost` float NOT NULL DEFAULT '0',
  `quantity` decimal(15,0) DEFAULT NULL,
  `warehouse_id` int(10) DEFAULT NULL,
  `warehouse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_items`
--

INSERT INTO `sma_items` (`id`, `item`, `specification`, `size_long`, `size_wide`, `weight`, `unit_id`, `unit`, `cost`, `quantity`, `warehouse_id`, `warehouse`, `note`) VALUES
(2, 'Bao trắng', '800*1200', '0', '0', NULL, 1, 'Cái', 20000, '-100', 1, NULL, ''),
(3, 'Sơn xanh', '800*1200', '0', '0', NULL, 1, 'Cái', 0, '10', 2, NULL, ''),
(4, 'Thép tấm', '800*1200', '0', '0', NULL, 2, 'Bao', 20, '100', 1, NULL, ''),
(5, 'Nguyen vat lieu 1', 'Nguyen vat lieu 1', '0', '0', NULL, 1, 'Cái', 0, '1270', 2, NULL, ''),
(6, 'têst', '12', '', '', '12', 2, 'Bao', 12, '0', NULL, NULL, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_labor_norms`
--

CREATE TABLE `sma_labor_norms` (
  `id` int(10) NOT NULL,
  `production_id` int(10) DEFAULT NULL,
  `product_id` int(10) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `employee` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_labor_norms`
--

INSERT INTO `sma_labor_norms` (`id`, `production_id`, `product_id`, `employee_id`, `employee`, `note`) VALUES
(27, 2, 29, 3, 'Chai', NULL),
(28, 2, 29, 5, 'Tân', NULL),
(29, 4, 29, 3, 'Chai', NULL),
(30, 4, 29, 5, 'Tân', NULL),
(31, 4, 29, 7, 'Hậu', NULL),
(35, 19, 31, 3, 'Chai', NULL),
(36, 19, 31, 5, 'Tân', NULL),
(37, 19, 31, 8, 'Tâm', NULL),
(38, 20, 30, 5, 'Tân', NULL),
(39, 20, 30, 7, 'Hậu', NULL),
(40, 20, 29, 3, 'Chai', NULL),
(41, 20, 29, 8, 'Tâm', NULL),
(42, 20, 29, 9, 'Tan', NULL),
(43, 21, 31, 3, 'Chai', NULL),
(44, 21, 31, 5, 'Tân', NULL),
(45, 21, 31, 7, 'Hậu', NULL),
(46, 22, 34, 5, 'Tân', NULL),
(47, 22, 34, 7, 'Hậu', NULL),
(48, 40, 41, 3, 'Chai', NULL),
(49, 40, 41, 7, 'Hậu', NULL),
(50, 42, 39, 5, 'Tân', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_login_attempts`
--

CREATE TABLE `sma_login_attempts` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_log_productions`
--

CREATE TABLE `sma_log_productions` (
  `id` int(11) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_log_productions`
--

INSERT INTO `sma_log_productions` (`id`, `production_id`, `product_id`) VALUES
(1, 39, 29);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_machine`
--

CREATE TABLE `sma_machine` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) DEFAULT '0',
  `id_machine_categories` int(11) NOT NULL,
  `machine_code` varchar(255) CHARACTER SET utf8 NOT NULL,
  `machine_capacity` decimal(15,0) DEFAULT NULL,
  `machine_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `machine_details` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `machine_note` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sma_machine`
--

INSERT INTO `sma_machine` (`id`, `active`, `id_machine_categories`, `machine_code`, `machine_capacity`, `machine_name`, `machine_details`, `machine_note`) VALUES
(1, 1, 1, 'MA1', '100', 'May 1', 'cfs', '<p>sdvc</p>'),
(2, 1, 4, 'MA2', '200', 'May 2', 'sdfvd', '<p>dfvdf</p>'),
(3, 1, 1, 'MA3', '300', 'May 3', '', ''),
(4, 1, 4, 'MA4', '400', 'May 4', '', ''),
(5, 1, 1, 'MA5', '500', 'May 5', 'N', '<p>Nghjh</p>'),
(6, 1, 6, 'MA6', '600', 'May 6', 'N', '<p>NN</p>'),
(7, 1, 5, 'MA8', '800', 'May 8', 'detail', '<p>Note</p>'),
(8, 1, 6, 'MA9', '900', 'May 9', '', ''),
(9, 1, 4, 'MA7', '700', 'May 7', '', ''),
(10, 1, 5, 'MA10', '1000', 'May 10', '', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_machinery_norms`
--

CREATE TABLE `sma_machinery_norms` (
  `id` int(11) NOT NULL,
  `production_id` int(10) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `working_place_id` int(10) DEFAULT NULL,
  `working_place` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `machine_id` int(10) DEFAULT NULL,
  `machine` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_machinery_norms`
--

INSERT INTO `sma_machinery_norms` (`id`, `production_id`, `product_id`, `working_place_id`, `working_place`, `machine_id`, `machine`) VALUES
(41, 20, 30, 29, 'Xuong 2', 5, 'May 5'),
(42, 20, 29, 31, 'Xuong 4', 3, 'May 3'),
(43, 20, 29, 31, 'Xuong 4', 7, 'May 8'),
(44, 20, 29, 31, 'Xuong 4', 8, 'May 9'),
(45, 21, 31, 29, 'Xuong 2', 5, 'May 5'),
(46, 21, 31, 29, 'Xuong 2', 4, 'May 4'),
(47, 22, 34, 31, 'Xuong 4', 5, 'May 5'),
(48, 22, 34, 31, 'Xuong 4', 4, 'May 4'),
(49, 22, 34, 31, 'Xuong 4', 9, 'May 7'),
(50, 22, 34, 31, 'Xuong 4', 8, 'May 9'),
(51, 22, 34, 31, 'Xuong 4', 7, 'May 8'),
(52, 22, 34, 31, 'Xuong 4', 3, 'May 3'),
(53, 40, 41, 29, 'Xuong 2', 5, 'May 5'),
(54, 42, 39, 30, 'Xuong 3', 10, 'May 10'),
(55, 47, 36, 30, 'Xuong 3', 10, 'May 10'),
(56, 47, 36, 30, 'Xuong 3', 6, 'May 6'),
(57, 48, 31, 29, 'Xuong 2', 4, 'May 4'),
(58, 48, 37, 30, 'Xuong 3', 10, 'May 10'),
(59, 52, 42, 29, 'Xuong 2', 4, 'May 4'),
(60, 52, 41, 30, 'Xuong 3', 10, 'May 10'),
(61, 52, 43, 30, 'Xuong 3', 6, 'May 6'),
(62, 52, 43, 30, 'Xuong 3', 10, 'May 10'),
(63, 53, 43, 29, 'Xuong 2', 5, 'May 5'),
(64, 53, 42, 29, 'Xuong 2', 5, 'May 5'),
(65, 54, 70, 27, 'Xuong 1', 1, 'May 1'),
(66, 54, 72, 29, 'Xuong 2', 4, 'May 4'),
(67, 54, 77, 29, 'Xuong 2', 5, 'May 5'),
(68, 54, 74, 30, 'Xuong 3', 10, 'May 10'),
(69, 54, 75, 30, 'Xuong 3', 10, 'May 10'),
(70, 54, 76, 30, 'Xuong 3', 2, 'May 2'),
(71, 54, 78, 29, 'Xuong 2', 4, 'May 4'),
(72, 54, 79, 29, 'Xuong 2', 4, 'May 4'),
(73, 55, 70, 29, 'Xuong 2', 5, 'May 5'),
(74, 55, 71, 29, 'Xuong 2', 5, 'May 5'),
(75, 60, 72, 29, 'Xuong 2', 5, 'May 5'),
(76, 61, 70, 29, 'Xuong 2', 5, 'May 5'),
(77, 61, 71, 29, 'Xuong 2', 5, 'May 5'),
(78, 61, 72, 27, 'Xuong 1', 1, 'May 1'),
(79, 62, 70, 29, 'Xuong 2', 5, 'May 5'),
(80, 62, 70, 29, 'Xuong 2', 4, 'May 4'),
(81, 62, 71, 29, 'Xuong 2', 5, 'May 5'),
(82, 62, 74, 29, 'Xuong 2', 5, 'May 5'),
(83, 62, 74, 29, 'Xuong 2', 4, 'May 4'),
(90, 87, 73, 29, 'Xuong 2', 5, 'May 5');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_machine_categories`
--

CREATE TABLE `sma_machine_categories` (
  `id` int(11) NOT NULL,
  `categories_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Tên',
  `categories_details` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Thông số chi tiết',
  `categories_note` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Ghi chú'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sma_machine_categories`
--

INSERT INTO `sma_machine_categories` (`id`, `categories_name`, `categories_details`, `categories_note`) VALUES
(1, 'Loai 1', 'Loai 1', '<p>Loai 1</p>'),
(4, 'Loai 2', 'Loai 2', '<p>Loai 2</p>'),
(5, 'Loai 3', 'Loai 3', '<p>Loai 3</p>'),
(6, 'Loai 4', 'Loai 4', '<p>Loai 4</p>');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_material_norms`
--

CREATE TABLE `sma_material_norms` (
  `id` int(10) NOT NULL,
  `production_id` int(10) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL,
  `item` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ord_quantity` int(11) DEFAULT '0',
  `quantity` decimal(15,0) DEFAULT NULL,
  `total_quantity` decimal(15,0) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_material_norms`
--

INSERT INTO `sma_material_norms` (`id`, `production_id`, `product_id`, `item_id`, `item`, `ord_quantity`, `quantity`, `total_quantity`, `note`) VALUES
(94, 2, 29, 5, 'Nguyen vat lieu 1', 100, '10', '1000', NULL),
(95, 2, 29, 4, 'Thép tấm', 100, '5', '500', NULL),
(96, 4, 29, 5, 'Nguyen vat lieu 1', 100, '10', '1000', NULL),
(97, 4, 29, 4, 'Thép tấm', 100, '5', '500', NULL),
(98, 19, 31, 2, 'Bao trắng', 100, '10', '1000', NULL),
(99, 19, 31, 4, 'Thép tấm', 100, '15', '1500', NULL),
(100, 19, 31, 5, 'Nguyen vat lieu 1', 100, '20', '2000', NULL),
(101, 20, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(102, 20, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(103, 20, 30, 21, NULL, 100, '3', '300', NULL),
(104, 20, 29, 5, 'Nguyen vat lieu 1', 100, '10', '1000', NULL),
(105, 20, 29, 4, 'Thép tấm', 100, '5', '500', NULL),
(106, 21, 31, 2, 'Bao trắng', 100, '10', '1000', NULL),
(107, 21, 31, 4, 'Thép tấm', 100, '15', '1500', NULL),
(108, 21, 31, 5, 'Nguyen vat lieu 1', 100, '20', '2000', NULL),
(109, 22, 34, 3, 'Sơn xanh', 10, '1', '10', NULL),
(110, 22, 34, 5, 'Nguyen vat lieu 1', 10, '2', '20', NULL),
(111, 40, 41, 2, 'Bao trắng', 1, '1', '1', NULL),
(112, 42, 39, 2, 'Bao trắng', 1, '1', '1', NULL),
(113, 48, 31, 2, 'Bao trắng', 1, '10', '10', NULL),
(114, 48, 31, 4, 'Thép tấm', 1, '15', '15', NULL),
(115, 48, 31, 5, 'Nguyen vat lieu 1', 1, '20', '20', NULL),
(116, 48, 37, 3, 'Sơn xanh', 1, '1', '1', NULL),
(117, 48, 37, 2, 'Bao trắng', 1, '1', '1', NULL),
(121, 52, 43, 2, 'Bao trắng', 100, '1', '100', NULL),
(122, 52, 43, 6, 'têst', 100, '1', '100', NULL),
(123, 52, 42, 2, 'Bao trắng', 100, '1', '100', NULL),
(124, 52, 42, 4, 'Thép tấm', 100, '1', '100', NULL),
(125, 53, 43, 2, 'Bao trắng', 120, '1', '120', NULL),
(126, 53, 43, 6, 'têst', 120, '1', '120', NULL),
(127, 53, 42, 2, 'Bao trắng', 150, '1', '150', NULL),
(128, 53, 42, 4, 'Thép tấm', 150, '1', '150', NULL),
(129, 54, 70, 4, 'Thép tấm', 100, '1', '100', NULL),
(130, 54, 72, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(131, 54, 77, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(132, 54, 74, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(133, 54, 75, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(134, 54, 76, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(135, 54, 78, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(136, 54, 79, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(140, 60, 72, 5, 'Nguyen vat lieu 1', 1, '1', '1', NULL),
(141, 61, 70, 4, 'Thép tấm', 100, '1', '100', NULL),
(144, 61, 72, 5, 'Nguyen vat lieu 1', 100, '1', '100', NULL),
(150, 62, 72, 5, 'Nguyen vat lieu 1', 60, '1', '60', NULL),
(151, 62, 74, 5, 'Nguyen vat lieu 1', 70, '1', '70', NULL),
(152, 66, 78, 5, 'Nguyen vat lieu 1', 1, '1', '1', NULL),
(153, 66, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(154, 66, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(155, 78, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(156, 78, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(157, 78, 78, 5, 'Nguyen vat lieu 1', 1, '1', '1', NULL),
(158, 79, 78, 5, 'Nguyen vat lieu 1', 1, '1', '1', NULL),
(159, 79, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(160, 79, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(161, 80, 78, 5, 'Nguyen vat lieu 1', 20, '1', '20', NULL),
(162, 80, 73, 2, 'Bao trắng', 10, '1', '10', NULL),
(163, 80, 73, 4, 'Thép tấm', 10, '1', '10', NULL),
(164, 82, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(165, 82, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(166, 83, 70, 4, 'Thép tấm', 1, '1', '1', NULL),
(167, 84, 78, 5, 'Nguyen vat lieu 1', 1, '1', '1', NULL),
(168, 86, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(169, 86, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(170, 87, 73, 2, 'Bao trắng', 1, '1', '1', NULL),
(171, 87, 73, 4, 'Thép tấm', 1, '1', '1', NULL),
(172, 89, 78, 5, 'Nguyen vat lieu 1', 200, '1', '200', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_migrations`
--

CREATE TABLE `sma_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_migrations`
--

INSERT INTO `sma_migrations` (`version`) VALUES
(306);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_notifications`
--

CREATE TABLE `sma_notifications` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_date` datetime DEFAULT NULL,
  `till_date` datetime DEFAULT NULL,
  `scope` tinyint(1) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_notifications`
--

INSERT INTO `sma_notifications` (`id`, `comment`, `date`, `from_date`, `till_date`, `scope`) VALUES
(1, '<p>Thank you for purchasing Stock Manager Advance.</p>', '2014-08-15 10:00:57', '2015-01-01 00:00:00', '2017-01-01 00:00:00', 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_order_ref`
--

CREATE TABLE `sma_order_ref` (
  `ref_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `so` int(11) NOT NULL DEFAULT '1',
  `qu` int(11) NOT NULL DEFAULT '1',
  `po` int(11) NOT NULL DEFAULT '1',
  `to` int(11) NOT NULL DEFAULT '1',
  `pos` int(11) NOT NULL DEFAULT '1',
  `do` int(11) NOT NULL DEFAULT '1',
  `pay` int(11) NOT NULL DEFAULT '1',
  `re` int(11) NOT NULL DEFAULT '1',
  `ex` int(11) NOT NULL DEFAULT '1',
  `prod` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_order_ref`
--

INSERT INTO `sma_order_ref` (`ref_id`, `date`, `so`, `qu`, `po`, `to`, `pos`, `do`, `pay`, `re`, `ex`, `prod`) VALUES
(1, '2015-03-01', 3, 1, 101, 1, 9, 1, 14, 56, 1, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_payments`
--

CREATE TABLE `sma_payments` (
  `id` int(11) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) DEFAULT NULL,
  `return_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `reference_no` varchar(50) NOT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `paid_by` varchar(20) NOT NULL,
  `cheque_no` varchar(20) DEFAULT NULL,
  `cc_no` varchar(20) DEFAULT NULL,
  `cc_holder` varchar(25) DEFAULT NULL,
  `cc_month` varchar(2) DEFAULT NULL,
  `cc_year` varchar(4) DEFAULT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `pos_paid` decimal(25,4) DEFAULT '0.0000',
  `pos_balance` decimal(25,4) DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_payments`
--

INSERT INTO `sma_payments` (`id`, `date`, `sale_id`, `return_id`, `purchase_id`, `reference_no`, `transaction_id`, `paid_by`, `cheque_no`, `cc_no`, `cc_holder`, `cc_month`, `cc_year`, `cc_type`, `amount`, `currency`, `created_by`, `attachment`, `type`, `note`, `pos_paid`, `pos_balance`) VALUES
(1, '2017-03-21 19:04:22', 1, NULL, NULL, 'IPAY/2017/03/0001', NULL, 'cash', '', '', '', '', '', '', '52000.0000', NULL, 1, NULL, 'received', '', '52000.0000', '0.0000'),
(2, '2017-03-23 21:23:28', 2, NULL, NULL, 'IPAY/2017/03/0003', NULL, 'cash', '', '', '', '', '', '', '109000.0000', NULL, 1, NULL, 'received', '', '218000.0000', '109000.0000'),
(3, '2017-03-23 20:38:00', 4, NULL, NULL, 'IPAY/2017/03/0005', NULL, 'cash', '', '', '', '', '', 'Visa', '515000.0000', NULL, 1, NULL, 'received', '', '0.0000', '0.0000'),
(4, '2017-04-09 20:55:13', 5, NULL, NULL, 'IPAY/2017/04/0006', NULL, 'cash', '', '', '', '', '', '', '270000.0000', NULL, 1, NULL, 'received', '', '817650.0000', '547650.0000'),
(5, '2017-04-09 21:01:18', 6, NULL, NULL, 'IPAY/2017/04/0008', NULL, 'cash', '', '', '', '', '', '', '240000.0000', NULL, 1, NULL, 'received', '', '5000000.0000', '4760000.0000'),
(6, '2017-04-09 21:08:16', 9, NULL, NULL, 'IPAY/2017/04/0010', NULL, 'cash', '', '', '', '', '', '', '60000.0000', NULL, 1, NULL, 'received', '', '65000.0000', '5000.0000'),
(7, '2017-04-09 21:10:32', 10, NULL, NULL, 'IPAY/2017/04/0012', NULL, 'cash', '', '', '', '', '', '', '33000.0000', NULL, 1, NULL, 'received', '', '65000.0000', '32000.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_paypal`
--

CREATE TABLE `sma_paypal` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL,
  `paypal_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '2.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '3.9000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '4.4000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_paypal`
--

INSERT INTO `sma_paypal` (`id`, `active`, `account_email`, `paypal_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'mypaypal@paypal.com', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_permissions`
--

CREATE TABLE `sma_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `products-index` tinyint(1) DEFAULT '0',
  `products-add` tinyint(1) DEFAULT '0',
  `products-edit` tinyint(1) DEFAULT '0',
  `products-delete` tinyint(1) DEFAULT '0',
  `products-cost` tinyint(1) DEFAULT '0',
  `products-price` tinyint(1) DEFAULT '0',
  `quotes-index` tinyint(1) DEFAULT '0',
  `quotes-add` tinyint(1) DEFAULT '0',
  `quotes-edit` tinyint(1) DEFAULT '0',
  `quotes-pdf` tinyint(1) DEFAULT '0',
  `quotes-email` tinyint(1) DEFAULT '0',
  `quotes-delete` tinyint(1) DEFAULT '0',
  `sales-index` tinyint(1) DEFAULT '0',
  `sales-add` tinyint(1) DEFAULT '0',
  `sales-edit` tinyint(1) DEFAULT '0',
  `sales-pdf` tinyint(1) DEFAULT '0',
  `sales-email` tinyint(1) DEFAULT '0',
  `sales-delete` tinyint(1) DEFAULT '0',
  `purchases-index` tinyint(1) DEFAULT '0',
  `purchases-add` tinyint(1) DEFAULT '0',
  `purchases-edit` tinyint(1) DEFAULT '0',
  `purchases-pdf` tinyint(1) DEFAULT '0',
  `purchases-email` tinyint(1) DEFAULT '0',
  `purchases-delete` tinyint(1) DEFAULT '0',
  `transfers-index` tinyint(1) DEFAULT '0',
  `transfers-add` tinyint(1) DEFAULT '0',
  `transfers-edit` tinyint(1) DEFAULT '0',
  `transfers-pdf` tinyint(1) DEFAULT '0',
  `transfers-email` tinyint(1) DEFAULT '0',
  `transfers-delete` tinyint(1) DEFAULT '0',
  `customers-index` tinyint(1) DEFAULT '0',
  `customers-add` tinyint(1) DEFAULT '0',
  `customers-edit` tinyint(1) DEFAULT '0',
  `customers-delete` tinyint(1) DEFAULT '0',
  `suppliers-index` tinyint(1) DEFAULT '0',
  `suppliers-add` tinyint(1) DEFAULT '0',
  `suppliers-edit` tinyint(1) DEFAULT '0',
  `suppliers-delete` tinyint(1) DEFAULT '0',
  `sales-deliveries` tinyint(1) DEFAULT '0',
  `sales-add_delivery` tinyint(1) DEFAULT '0',
  `sales-edit_delivery` tinyint(1) DEFAULT '0',
  `sales-delete_delivery` tinyint(1) DEFAULT '0',
  `sales-email_delivery` tinyint(1) DEFAULT '0',
  `sales-pdf_delivery` tinyint(1) DEFAULT '0',
  `sales-gift_cards` tinyint(1) DEFAULT '0',
  `sales-add_gift_card` tinyint(1) DEFAULT '0',
  `sales-edit_gift_card` tinyint(1) DEFAULT '0',
  `sales-delete_gift_card` tinyint(1) DEFAULT '0',
  `pos-index` tinyint(1) DEFAULT '0',
  `sales-return_sales` tinyint(1) DEFAULT '0',
  `reports-index` tinyint(1) DEFAULT '0',
  `reports-warehouse_stock` tinyint(1) DEFAULT '0',
  `reports-quantity_alerts` tinyint(1) DEFAULT '0',
  `reports-expiry_alerts` tinyint(1) DEFAULT '0',
  `reports-products` tinyint(1) DEFAULT '0',
  `reports-daily_sales` tinyint(1) DEFAULT '0',
  `reports-monthly_sales` tinyint(1) DEFAULT '0',
  `reports-sales` tinyint(1) DEFAULT '0',
  `reports-payments` tinyint(1) DEFAULT '0',
  `reports-purchases` tinyint(1) DEFAULT '0',
  `reports-profit_loss` tinyint(1) DEFAULT '0',
  `reports-customers` tinyint(1) DEFAULT '0',
  `reports-suppliers` tinyint(1) DEFAULT '0',
  `reports-staff` tinyint(1) DEFAULT '0',
  `reports-register` tinyint(1) DEFAULT '0',
  `sales-payments` tinyint(1) DEFAULT '0',
  `purchases-payments` tinyint(1) DEFAULT '0',
  `purchases-expenses` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_permissions`
--

INSERT INTO `sma_permissions` (`id`, `group_id`, `products-index`, `products-add`, `products-edit`, `products-delete`, `products-cost`, `products-price`, `quotes-index`, `quotes-add`, `quotes-edit`, `quotes-pdf`, `quotes-email`, `quotes-delete`, `sales-index`, `sales-add`, `sales-edit`, `sales-pdf`, `sales-email`, `sales-delete`, `purchases-index`, `purchases-add`, `purchases-edit`, `purchases-pdf`, `purchases-email`, `purchases-delete`, `transfers-index`, `transfers-add`, `transfers-edit`, `transfers-pdf`, `transfers-email`, `transfers-delete`, `customers-index`, `customers-add`, `customers-edit`, `customers-delete`, `suppliers-index`, `suppliers-add`, `suppliers-edit`, `suppliers-delete`, `sales-deliveries`, `sales-add_delivery`, `sales-edit_delivery`, `sales-delete_delivery`, `sales-email_delivery`, `sales-pdf_delivery`, `sales-gift_cards`, `sales-add_gift_card`, `sales-edit_gift_card`, `sales-delete_gift_card`, `pos-index`, `sales-return_sales`, `reports-index`, `reports-warehouse_stock`, `reports-quantity_alerts`, `reports-expiry_alerts`, `reports-products`, `reports-daily_sales`, `reports-monthly_sales`, `reports-sales`, `reports-payments`, `reports-purchases`, `reports-profit_loss`, `reports-customers`, `reports-suppliers`, `reports-staff`, `reports-register`, `sales-payments`, `purchases-payments`, `purchases-expenses`) VALUES
(1, 5, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_pos_register`
--

CREATE TABLE `sma_pos_register` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `cash_in_hand` decimal(25,4) NOT NULL,
  `status` varchar(10) NOT NULL,
  `total_cash` decimal(25,4) DEFAULT NULL,
  `total_cheques` int(11) DEFAULT NULL,
  `total_cc_slips` int(11) DEFAULT NULL,
  `total_cash_submitted` decimal(25,4) NOT NULL,
  `total_cheques_submitted` int(11) NOT NULL,
  `total_cc_slips_submitted` int(11) NOT NULL,
  `note` text,
  `closed_at` timestamp NULL DEFAULT NULL,
  `transfer_opened_bills` varchar(50) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_pos_register`
--

INSERT INTO `sma_pos_register` (`id`, `date`, `user_id`, `cash_in_hand`, `status`, `total_cash`, `total_cheques`, `total_cc_slips`, `total_cash_submitted`, `total_cheques_submitted`, `total_cc_slips_submitted`, `note`, `closed_at`, `transfer_opened_bills`, `closed_by`) VALUES
(1, '2017-03-19 05:20:11', 1, '1222.0000', 'open', NULL, NULL, NULL, '0.0000', 0, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_pos_settings`
--

CREATE TABLE `sma_pos_settings` (
  `pos_id` int(1) NOT NULL,
  `cat_limit` int(11) NOT NULL,
  `pro_limit` int(11) NOT NULL,
  `default_category` int(11) NOT NULL,
  `default_customer` int(11) NOT NULL,
  `default_biller` int(11) NOT NULL,
  `display_time` varchar(3) NOT NULL DEFAULT 'yes',
  `cf_title1` varchar(255) DEFAULT NULL,
  `cf_title2` varchar(255) DEFAULT NULL,
  `cf_value1` varchar(255) DEFAULT NULL,
  `cf_value2` varchar(255) DEFAULT NULL,
  `receipt_printer` varchar(55) DEFAULT NULL,
  `cash_drawer_codes` varchar(55) DEFAULT NULL,
  `focus_add_item` varchar(55) DEFAULT NULL,
  `add_manual_product` varchar(55) DEFAULT NULL,
  `customer_selection` varchar(55) DEFAULT NULL,
  `add_customer` varchar(55) DEFAULT NULL,
  `toggle_category_slider` varchar(55) DEFAULT NULL,
  `toggle_subcategory_slider` varchar(55) DEFAULT NULL,
  `cancel_sale` varchar(55) DEFAULT NULL,
  `suspend_sale` varchar(55) DEFAULT NULL,
  `print_items_list` varchar(55) DEFAULT NULL,
  `finalize_sale` varchar(55) DEFAULT NULL,
  `today_sale` varchar(55) DEFAULT NULL,
  `open_hold_bills` varchar(55) DEFAULT NULL,
  `close_register` varchar(55) DEFAULT NULL,
  `keyboard` tinyint(1) NOT NULL,
  `pos_printers` varchar(255) DEFAULT NULL,
  `java_applet` tinyint(1) NOT NULL,
  `product_button_color` varchar(20) NOT NULL DEFAULT 'default',
  `tooltips` tinyint(1) DEFAULT '1',
  `paypal_pro` tinyint(1) DEFAULT '0',
  `stripe` tinyint(1) DEFAULT '0',
  `rounding` tinyint(1) DEFAULT '0',
  `char_per_line` tinyint(4) DEFAULT '42',
  `pin_code` varchar(20) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT 'purchase_code',
  `envato_username` varchar(50) DEFAULT 'envato_username',
  `version` varchar(10) DEFAULT '3.0.1.13'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_pos_settings`
--

INSERT INTO `sma_pos_settings` (`pos_id`, `cat_limit`, `pro_limit`, `default_category`, `default_customer`, `default_biller`, `display_time`, `cf_title1`, `cf_title2`, `cf_value1`, `cf_value2`, `receipt_printer`, `cash_drawer_codes`, `focus_add_item`, `add_manual_product`, `customer_selection`, `add_customer`, `toggle_category_slider`, `toggle_subcategory_slider`, `cancel_sale`, `suspend_sale`, `print_items_list`, `finalize_sale`, `today_sale`, `open_hold_bills`, `close_register`, `keyboard`, `pos_printers`, `java_applet`, `product_button_color`, `tooltips`, `paypal_pro`, `stripe`, `rounding`, `char_per_line`, `pin_code`, `purchase_code`, `envato_username`, `version`) VALUES
(1, 22, 20, 1, 1, 3, '1', 'GST Reg', 'VAT Reg', '123456789', '987654321', 'BIXOLON SRP-350II', 'x1C', 'Ctrl+F3', 'Ctrl+Shift+M', 'Ctrl+Shift+C', 'Ctrl+Shift+A', 'Ctrl+F11', 'Ctrl+F12', 'F4', 'F7', 'F9', 'F8', 'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F10', 1, 'BIXOLON SRP-350II, BIXOLON SRP-350II', 0, 'default', 1, 0, 0, 0, 42, NULL, 'purchase_code', 'envato_username', '3.0.1.13');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_productions`
--

CREATE TABLE `sma_productions` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `reference_no` varchar(55) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(55) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `biller` varchar(55) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `staff_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) DEFAULT NULL,
  `sale_status` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_items` tinyint(4) DEFAULT NULL,
  `pos` tinyint(1) DEFAULT '0',
  `paid` decimal(25,4) DEFAULT '0.0000',
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `working` varchar(255) DEFAULT NULL,
  `delivery_mode` tinyint(4) DEFAULT '1',
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_productions`
--

INSERT INTO `sma_productions` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`, `working`, `delivery_mode`, `created_at`) VALUES
(57, '2017-09-21', 'PO/01', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'pending', NULL, NULL, '2017-09-28', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, '', 1, '2017-09-21'),
(59, '2017-09-21', '2123', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'cancel', NULL, NULL, '2017-09-28', 1, NULL, NULL, 3, 0, '0.0000', NULL, '0.0000', NULL, '', 1, '2017-09-21'),
(60, '2017-09-21', 'tt', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'pending', NULL, NULL, '2017-09-28', 1, NULL, NULL, 3, 0, '0.0000', NULL, '0.0000', NULL, '', 1, '2017-09-21'),
(61, '2017-09-21', 'BO1', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'completed', NULL, NULL, '2017-09-28', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, 'BO1', 1, '2017-09-21'),
(62, '2017-09-22', 'BO/02', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'pending', NULL, NULL, '2017-09-29', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, 'Xưởng cơ khí', 1, '2017-09-22'),
(87, '2017-09-23', 'POA', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'pending', NULL, NULL, '2017-09-30', 1, 1, '2017-09-23 03:56:57', NULL, 0, '0.0000', NULL, '0.0000', NULL, 'Xưởng cơ khí', 1, '2017-09-23'),
(89, '2017-09-23', 'POAAAA', 1, 'Walk-in Customer', NULL, NULL, NULL, '', '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', 'not_start', NULL, NULL, '2017-09-30', 1, 1, '2017-09-23 05:47:46', NULL, 0, '0.0000', NULL, '0.0000', NULL, 'Xưởng cơ khí', 1, '2017-09-23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_deliveries`
--

CREATE TABLE `sma_production_deliveries` (
  `id` int(11) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `delivery_date_start` date DEFAULT NULL,
  `delivery_date_end` date DEFAULT NULL,
  `delivery_percent` decimal(25,0) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sma_production_deliveries`
--

INSERT INTO `sma_production_deliveries` (`id`, `production_id`, `delivery_date_start`, `delivery_date_end`, `delivery_percent`, `note`) VALUES
(82, 39, '2017-09-14', '2017-09-21', '100', NULL),
(83, 40, '2017-09-14', '2017-09-21', '100', NULL),
(85, 41, '0000-00-00', '0000-00-00', '2', NULL),
(86, 41, '0000-00-00', '0000-00-00', '2', NULL),
(87, 42, '2017-09-14', '2017-09-21', '100', NULL),
(88, 43, '2017-09-15', '2017-09-22', '100', NULL),
(89, 44, '2017-09-15', '2017-09-22', '100', NULL),
(90, 45, '2017-09-15', '2017-09-22', '100', NULL),
(91, 46, '2017-09-15', '2017-09-22', '100', NULL),
(92, 47, '2017-09-15', '2017-09-22', '100', NULL),
(93, 48, '2017-09-16', '2017-09-23', '100', NULL),
(94, 49, '2017-09-18', '2017-09-25', '20', NULL),
(95, 49, '2017-09-20', '2017-09-24', '80', NULL),
(96, 50, '2017-09-18', '2017-09-25', '100', NULL),
(97, 51, '2017-09-18', '2017-09-25', '100', NULL),
(98, 52, '2017-09-19', '2017-09-26', '100', NULL),
(99, 53, '2017-09-20', '2017-09-27', '100', NULL),
(103, 54, '0000-00-00', '0000-00-00', '2', NULL),
(104, 1, '0000-00-00', '0000-00-00', '2', NULL),
(105, 55, '2017-09-21', '2017-09-28', '100', NULL),
(106, 56, '2017-09-21', '2017-09-28', '100', NULL),
(107, 57, '2017-09-21', '2017-09-28', '100', NULL),
(108, 58, '2017-09-21', '2017-09-28', '100', NULL),
(109, 59, '2017-09-21', '2017-09-28', '100', NULL),
(110, 60, '2017-09-21', '2017-09-28', '100', NULL),
(111, 61, '2017-09-21', '2017-09-28', '100', NULL),
(112, 62, '2017-09-22', '2017-09-29', '100', NULL),
(113, 63, '2017-09-22', '2017-09-29', '100', NULL),
(114, 64, '2017-09-22', '2017-09-29', '100', NULL),
(115, 65, '2017-09-22', '2017-09-29', '100', NULL),
(137, 87, '2017-09-23', '2017-09-30', '100', NULL),
(139, 89, '2017-09-23', '2017-09-30', '100', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_items`
--

CREATE TABLE `sma_production_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) UNSIGNED DEFAULT NULL,
  `product_id` int(11) UNSIGNED DEFAULT NULL,
  `employees` varchar(255) DEFAULT NULL,
  `product_code` varchar(55) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) DEFAULT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `balance_quantity` decimal(15,4) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'pending',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_production_items`
--

INSERT INTO `sma_production_items` (`id`, `sale_id`, `product_id`, `employees`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `balance_quantity`, `status`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`) VALUES
(132, 20, 29, '', 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '100.0000', NULL, 'completed', 1, '0.0000', 0, '', NULL, '0.0000', '100000.0000', '', '1000.0000'),
(133, 20, 30, '', 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'completed', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(134, 21, 31, '', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '1000000.0000', '', '10000.0000'),
(137, 23, 35, '', '321123', 'Ghế', 'null', 0, '1000.0000', '1000.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '1000.0000', '', '1000.0000'),
(138, 24, 41, '', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(139, 25, 42, '', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(140, 26, 30, '', 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '500.0000', '', '500.0000'),
(142, 27, 37, '', '99999', 'Bàn Cao Cấp', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(145, 22, 34, '', '123', '123', 'null', 0, '12.0000', '12.0000', '10.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '120.0000', '', '12.0000'),
(156, 28, 30, '', 'XACAP', 'Xà đỡ cáp ngầm', 'null', 0, '500.0000', '500.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '500.0000', '', '500.0000'),
(157, 28, 32, '', 'I25*3*5', 'Lưới Grating I25*3*5', 'null', 0, '5000000.0000', '5000000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '5000000.0000', '', '5000000.0000'),
(158, 28, 35, '', '321123', 'Ghế', 'null', 0, '1000.0000', '1000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '1000.0000', '', '1000.0000'),
(159, 28, 36, '', '5231', 'Bàn', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(160, 28, 37, '', '99999', 'Bàn Cao Cấp', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(161, 28, 38, '', '11111', 'SP1', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(162, 28, 39, '', 'C222', 'SP2', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(163, 28, 40, '', 'C233', 'SP3', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(164, 28, 41, '', 'C3-01222', 'Bàn 2', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(165, 28, 42, '', 'C223231', 'Bàn Gỗ 3', 'null', 0, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(166, 29, 30, '', 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '500.0000', '', '500.0000'),
(167, 29, 32, '', 'I25*3*5', 'Lưới Grating I25*3*5', 'null', NULL, '5000000.0000', '5000000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '5000000.0000', '', '5000000.0000'),
(168, 29, 35, '', '321123', 'Ghế', 'null', NULL, '1000.0000', '1000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '1000.0000', '', '1000.0000'),
(169, 29, 36, '', '5231', 'Bàn', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(170, 29, 37, '', '99999', 'Bàn Cao Cấp', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(171, 29, 38, '', '11111', 'SP1', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(172, 29, 39, '', 'C222', 'SP2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(173, 29, 40, '', 'C233', 'SP3', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(174, 29, 41, '', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(175, 29, 42, '', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(176, 30, 42, '', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(177, 31, 43, '', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(178, 32, 42, '', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(179, 33, 31, '', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(180, 37, 43, '', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(181, 38, 36, '', '5231', 'Bàn', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(182, 39, 31, '', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(183, 40, 41, '', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(186, 41, 43, '', 'C3-021112', 'Bàn Gỗ 5', 'null', 0, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(187, 42, 31, '', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(188, 42, 39, '', 'C222', 'SP2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(189, 43, 37, '', '99999', 'Bàn Cao Cấp', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(190, 43, 43, '', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(191, 44, 31, '5,8', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(192, 44, 41, '3,5', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(193, 45, 37, '5,8', '99999', 'Bàn Cao Cấp', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(194, 45, 41, '3,5', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(195, 46, 31, '5,8', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(196, 46, 37, '3,7', '99999', 'Bàn Cao Cấp', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(197, 47, 36, '7,9', '5231', 'Bàn', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(198, 47, 41, '3,7', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(199, 48, 31, '5,7', 'PLASMA', 'Gia công bệ máy Plasma', 'null', NULL, '10000.0000', '10000.0000', '3.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(200, 48, 37, '3,8', '99999', 'Bàn Cao Cấp', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(201, 49, 42, '5,7', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '11000.0000', '', '11000.0000'),
(202, 49, 43, '3,8', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '10000.0000'),
(203, 52, 42, '7', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '100.0000', NULL, 'completed', NULL, '0.0000', 0, '', NULL, '0.0000', '1100000.0000', '', '11000.0000'),
(204, 52, 41, '5', 'C3-01222', 'Bàn 2', 'null', NULL, '10000.0000', '10000.0000', '150.0000', NULL, 'completed', NULL, '0.0000', 0, '', NULL, '0.0000', '1000000.0000', '', '10000.0000'),
(205, 52, 43, '3', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '1000000.0000', '', '10000.0000'),
(206, 53, 43, '5,7', 'C3-021112', 'Bàn Gỗ 5', 'null', NULL, '10000.0000', '10000.0000', '120.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '1200000.0000', '', '10000.0000'),
(207, 53, 42, '3,7', 'C223231', 'Bàn Gỗ 3', 'null', NULL, '11000.0000', '11000.0000', '150.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '1650000.0000', '', '11000.0000'),
(227, 54, 71, '', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(228, 54, 72, '', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(229, 54, 77, '', 'V26-T3', 'ĐỐT CỘT 660x660x;L=5500 V26-T3', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(230, 54, 78, '', 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(231, 54, 73, '', 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(232, 54, 74, '', 'V26-T1', 'ĐỐT CỘT 660x660x;L=5500 V26-T1', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(233, 54, 75, '', 'V26-T2', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(234, 54, 76, '', 'V26-T2.1', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(235, 54, 70, '', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(236, 54, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(256, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(257, 55, 70, '', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', 0, '0.0000', '0.0000', '50.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(258, 55, 71, '', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', 0, '0.0000', '0.0000', '45.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(259, 55, 72, '', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', 0, '0.0000', '0.0000', '60.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(260, 55, 73, '', 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', 0, '0.0000', '0.0000', '70.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(261, 55, 74, '', 'V26-T1', 'ĐỐT CỘT 660x660x;L=5500 V26-T1', 'null', 0, '0.0000', '0.0000', '25.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(262, 55, 75, '', 'V26-T2', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(263, 55, 76, '', 'V26-T2.1', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(264, 55, 77, '', 'V26-T3', 'ĐỐT CỘT 660x660x;L=5500 V26-T3', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(265, 55, 78, '', 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(266, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(267, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(268, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(269, 55, 70, '', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', 0, '0.0000', '0.0000', '50.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(270, 55, 71, '', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', 0, '0.0000', '0.0000', '45.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(271, 55, 72, '', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', 0, '0.0000', '0.0000', '60.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(272, 55, 73, '', 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', 0, '0.0000', '0.0000', '70.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(273, 55, 74, '', 'V26-T1', 'ĐỐT CỘT 660x660x;L=5500 V26-T1', 'null', 0, '0.0000', '0.0000', '25.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(274, 55, 75, '', 'V26-T2', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(275, 55, 76, '', 'V26-T2.1', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(276, 55, 77, '', 'V26-T3', 'ĐỐT CỘT 660x660x;L=5500 V26-T3', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(277, 55, 78, '', 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(278, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(279, 55, 79, '', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(280, 56, 70, '7', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', NULL, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(281, 56, 71, '5', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', NULL, '0.0000', '0.0000', '20.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(282, 56, 72, '3', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', NULL, '0.0000', '0.0000', '10.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(283, 59, 70, '7', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', NULL, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(284, 59, 71, '7', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', NULL, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(285, 59, 72, '5', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', NULL, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(286, 60, 72, '3', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', NULL, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(287, 61, 70, '5', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', NULL, '0.0000', '0.0000', '100.0000', NULL, 'completed', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(288, 61, 71, '3,5', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', NULL, '0.0000', '0.0000', '100.0000', NULL, 'completed', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(289, 61, 72, '3', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', NULL, '0.0000', '0.0000', '100.0000', NULL, 'completed', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(290, 62, 70, '5', 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', NULL, '0.0000', '0.0000', '20.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(291, 62, 71, '5', 'KTST8', 'KIM THU SÉT L=1,18M T8', 'null', NULL, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(292, 62, 72, '5', 'KTSF25', 'KIM THU SÉT L=1,18M F25', 'null', NULL, '0.0000', '0.0000', '60.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(293, 62, 74, '7', 'V26-T1', 'ĐỐT CỘT 660x660x;L=5500 V26-T1', 'null', NULL, '0.0000', '0.0000', '70.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(294, 62, 75, '7', 'V26-T2', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', NULL, '0.0000', '0.0000', '220.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(295, 62, 76, '5', 'V26-T2.1', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'null', NULL, '0.0000', '0.0000', '40.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(296, 62, 77, '3', 'V26-T3', 'ĐỐT CỘT 660x660x;L=5500 V26-T3', 'null', NULL, '0.0000', '0.0000', '50.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(297, 62, 78, '3', 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', NULL, '0.0000', '0.0000', '200.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(298, 62, 79, '3,7', 'V26-B2', 'ĐỐT CỘT 660x660x;L=5500 V26-B2', 'null', NULL, '0.0000', '0.0000', '100.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(299, 62, 73, '5,7', 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', NULL, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(338, 87, 73, NULL, 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(339, 87, 78, NULL, 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', 0, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(340, 87, 70, NULL, 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'null', NULL, '0.0000', '0.0000', '1.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(355, 89, 73, '8', 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', 'null', 0, '0.0000', '0.0000', '30.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000'),
(356, 89, 78, '3,5,8', 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'null', 0, '0.0000', '0.0000', '2000.0000', NULL, 'pending', NULL, '0.0000', 0, '', NULL, '0.0000', '0.0000', '', '0.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_stages`
--

CREATE TABLE `sma_production_stages` (
  `id` int(10) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `production_id` int(11) DEFAULT NULL,
  `stage_id` int(10) NOT NULL,
  `delivery_time` int(4) DEFAULT NULL,
  `stage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `employee` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stage_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'not_start',
  `error_quantity` decimal(15,0) DEFAULT NULL,
  `quantity` decimal(15,0) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `stage_percent` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_production_stages`
--

INSERT INTO `sma_production_stages` (`id`, `product_id`, `production_id`, `stage_id`, `delivery_time`, `stage`, `date_start`, `date_end`, `employee_id`, `employee`, `stage_status`, `error_quantity`, `quantity`, `note`, `stage_percent`) VALUES
(44, 30, 20, 2, 50, 'GD1', '2017-08-15', '2017-08-29', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(45, 30, 20, 1, 50, 'GD2', '2017-08-30', '2017-08-22', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(46, 29, 20, 0, 50, 'gd1', '2017-08-30', '2017-09-03', NULL, '3,9', 'not_start', NULL, NULL, NULL, 0),
(47, 29, 20, 0, 50, 'gd2', '2017-09-03', '2017-09-06', NULL, '8,9', 'not_start', NULL, NULL, NULL, 0),
(48, 31, 21, 0, 51, 'Ra phôi', '2017-08-31', '2017-09-01', NULL, '3', 'pending', '0', '5', NULL, 0),
(49, 31, 21, 0, 51, 'Cắt góc', '2017-09-01', '2017-09-02', NULL, '5', 'not_start', NULL, NULL, NULL, 0),
(50, 31, 21, 0, 51, 'Uốn nhấn', '2017-09-03', '2017-09-04', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(51, 31, 21, 0, 51, 'Tạo lỗ', '2017-09-04', '2017-09-05', NULL, '3', 'not_start', NULL, NULL, NULL, 0),
(52, 31, 21, 0, 51, 'Gá hàn', '2017-09-05', '2017-09-06', NULL, '5', 'not_start', NULL, NULL, NULL, 0),
(53, 31, 21, 0, 51, 'VS -giao mạ', '2017-09-06', '2017-09-07', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(54, 31, 21, 0, 51, 'Mạ kẽm', '2017-09-07', '2017-09-08', NULL, '3', 'not_start', NULL, NULL, NULL, 0),
(55, 31, 21, 0, 51, 'ĐK & Giao hàng', '2017-09-08', '2017-09-09', NULL, '5', 'not_start', NULL, NULL, NULL, 0),
(56, 31, 21, 0, 52, 'Ra phôi', '2017-09-07', '2017-09-08', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(57, 31, 21, 0, 52, 'Cắt góc', '2017-09-08', '2017-09-09', NULL, '3', 'not_start', NULL, NULL, NULL, 0),
(58, 31, 21, 0, 52, 'Uốn nhấn', '2017-09-09', '2017-09-10', NULL, '5', 'not_start', NULL, NULL, NULL, 0),
(59, 31, 21, 0, 52, 'Tạo lỗ', '2017-09-10', '2017-09-11', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(60, 31, 21, 0, 52, 'Gá hàn', '2017-09-11', '2017-09-12', NULL, '3', 'not_start', NULL, NULL, NULL, 0),
(61, 31, 21, 0, 52, 'VS -giao mạ', '2017-09-13', '2017-09-14', NULL, '5', 'not_start', NULL, NULL, NULL, 0),
(62, 31, 21, 0, 52, 'Mạ kẽm', '2017-09-14', '2017-09-15', NULL, '7', 'not_start', NULL, NULL, NULL, 0),
(63, 31, 21, 0, 52, 'ĐK & Giao hàng', '2017-09-15', '2017-09-16', NULL, '3', 'not_start', NULL, NULL, NULL, 0),
(64, 34, 22, 0, 53, 'Cắt', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(65, 34, 22, 0, 53, 'May', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(66, 41, 40, 0, 83, 'gd1', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(67, 41, 40, 0, 83, 'g2', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(68, 41, 40, 0, 83, 'GĐ3', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(69, 41, 40, 0, 83, 'GĐ4', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 0),
(70, 39, 42, 1, 87, 'gd1', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 25),
(71, 39, 42, 2, 87, 'g2', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 25),
(72, 39, 42, 3, 87, 'GĐ3', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 20),
(73, 39, 42, 4, 87, 'GĐ4', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 30),
(74, 31, 48, 1, 93, 'gd1', NULL, NULL, NULL, '5,7,3', 'not_start', NULL, NULL, NULL, 25),
(75, 31, 48, 2, 93, 'g2', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 25),
(76, 31, 48, 3, 93, 'GĐ3', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 20),
(77, 31, 48, 4, 93, 'GĐ4', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 30),
(78, 37, 48, 1, 93, 'gd1', NULL, NULL, NULL, '3,8', 'not_start', NULL, NULL, NULL, 25),
(79, 37, 48, 2, 93, 'g2', NULL, NULL, NULL, '3,8', 'not_start', NULL, NULL, NULL, 25),
(80, 37, 48, 3, 93, 'GĐ3', NULL, NULL, NULL, '3,8,7', 'not_start', NULL, NULL, NULL, 20),
(81, 37, 48, 4, 93, 'GĐ4', NULL, NULL, NULL, '3,8,7', 'not_start', NULL, NULL, NULL, 30),
(82, 42, 52, 1, 98, 'gd1', '2017-09-06', '2017-09-28', NULL, '7,3', 'completed', '0', '250', NULL, 25),
(83, 42, 52, 2, 98, 'g2', '2017-09-15', '2017-09-30', NULL, '7,8', 'completed', '0', '70', NULL, 25),
(84, 42, 52, 3, 98, 'GĐ3', '2017-09-15', '2017-09-21', NULL, '7,3,5,9', 'completed', '0', '90', NULL, 20),
(85, 42, 52, 4, 98, 'GĐ4', '2017-09-07', '2017-09-22', NULL, '8,7', 'completed', '0', '20', NULL, 30),
(86, 41, 52, 1, 98, 'gd1', '2017-09-28', '2017-09-22', NULL, '5', 'completed', '0', '50', NULL, 25),
(87, 41, 52, 2, 98, 'g2', '2017-09-06', '2017-09-21', NULL, '5', 'completed', '0', '40', NULL, 25),
(88, 41, 52, 3, 98, 'GĐ3', '2017-08-31', '2017-09-15', NULL, '5,7', 'completed', '0', '110', NULL, 20),
(89, 41, 52, 4, 98, 'GĐ4', '2017-08-31', '2017-09-28', NULL, '5,8', 'completed', '0', '30', NULL, 30),
(90, 43, 52, 1, 98, 'gd1', '2017-09-05', '2017-09-21', NULL, '3', 'pending', '0', '110', NULL, 25),
(91, 43, 52, 2, 98, 'g2', '2017-09-08', '2017-09-21', NULL, '3', 'not_start', NULL, '0', NULL, 25),
(92, 43, 52, 3, 98, 'GĐ3', '2017-09-08', '2017-09-20', NULL, '3', 'not_start', NULL, '0', NULL, 20),
(93, 43, 52, 4, 98, 'GĐ4', '2017-09-08', '2017-09-21', NULL, '3', 'not_start', NULL, '0', NULL, 30),
(94, 43, 53, 1, 99, 'gd1', '2017-09-19', '2017-09-22', NULL, '5,7,3', 'pending', '0', '0', NULL, 25),
(95, 43, 53, 2, 99, 'g2', '2017-09-19', '2017-09-22', NULL, '5,7', 'not_start', NULL, NULL, NULL, 25),
(96, 43, 53, 3, 99, 'GĐ3', '2017-09-19', '2017-09-28', NULL, '5,7', 'not_start', NULL, NULL, NULL, 20),
(97, 43, 53, 4, 99, 'GĐ4', '2017-09-26', '2017-09-29', NULL, '5,7', 'not_start', NULL, NULL, NULL, 30),
(98, 42, 53, 1, 99, 'gd1', '2017-09-19', '2017-09-21', NULL, '3,7', 'not_start', NULL, NULL, NULL, 25),
(99, 42, 53, 2, 99, 'g2', '2017-09-19', '2017-09-21', NULL, '3,7', 'not_start', NULL, NULL, NULL, 25),
(100, 42, 53, 3, 99, 'GĐ3', '2017-09-19', '2017-09-23', NULL, '3,7,8', 'not_start', NULL, NULL, NULL, 20),
(101, 42, 53, 4, 99, 'GĐ4', '2017-09-19', '2017-09-27', NULL, '3,7', 'not_start', NULL, NULL, NULL, 30),
(102, 70, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(103, 70, 54, 2, 100, 'Uốn nhấn', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(104, 70, 54, 3, 100, 'Tạo lỗ', '2017-09-21', '2017-09-30', NULL, '5', 'not_start', NULL, NULL, NULL, 15),
(105, 70, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(106, 70, 54, 5, 100, 'Gá hàn', '2017-09-22', '2017-10-01', NULL, '5', 'not_start', NULL, NULL, NULL, 30),
(107, 70, 54, 6, 100, 'VS-Giao mạ', '2017-10-01', '2017-10-14', NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(108, 70, 54, 7, 100, 'Mạ kẽm', '2017-10-14', '2017-10-14', NULL, '5', 'not_start', NULL, NULL, NULL, 20),
(109, 70, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-15', '2017-10-15', NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(110, 72, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '8', 'not_start', NULL, NULL, NULL, 10),
(111, 72, 54, 2, 100, 'Uốn nhấn', '2017-09-21', '2017-09-30', NULL, '8', 'not_start', NULL, NULL, NULL, 10),
(112, 72, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '8', 'not_start', NULL, NULL, NULL, 15),
(113, 72, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(114, 72, 54, 5, 100, 'Gá hàn', '2017-09-21', '2017-09-30', NULL, '8', 'not_start', NULL, NULL, NULL, 30),
(115, 72, 54, 6, 100, 'VS-Giao mạ', '2017-10-01', '2017-10-14', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(116, 72, 54, 7, 100, 'Mạ kẽm', '2017-10-14', '2017-10-14', NULL, '8', 'not_start', NULL, NULL, NULL, 20),
(117, 72, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-15', '2017-10-15', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(118, 77, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(119, 77, 54, 2, 100, 'Uốn nhấn', '2017-09-21', '2017-09-30', NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(120, 77, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 15),
(121, 77, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(122, 77, 54, 5, 100, 'Gá hàn', '2017-10-01', '2017-10-14', NULL, '5', 'not_start', NULL, NULL, NULL, 30),
(123, 77, 54, 6, 100, 'VS-Giao mạ', '2017-10-14', '2017-10-14', NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(124, 77, 54, 7, 100, 'Mạ kẽm', '2017-10-14', '2017-10-14', NULL, '5', 'not_start', NULL, NULL, NULL, 20),
(125, 77, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-15', '2017-10-15', NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(126, 74, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(127, 74, 54, 2, 100, 'Uốn nhấn', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(128, 74, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 15),
(129, 74, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(130, 74, 54, 5, 100, 'Gá hàn', '2017-09-21', '2017-10-12', NULL, '7', 'not_start', NULL, NULL, NULL, 30),
(131, 74, 54, 6, 100, 'VS-Giao mạ', '2017-09-25', '2017-10-13', NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(132, 74, 54, 7, 100, 'Mạ kẽm', '2017-09-26', '2017-10-14', NULL, '7', 'not_start', NULL, NULL, NULL, 20),
(133, 74, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-10', '2017-10-15', NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(134, 75, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(135, 75, 54, 2, 100, 'Uốn nhấn', '2017-09-21', '2017-09-28', NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(136, 75, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 15),
(137, 75, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(138, 75, 54, 5, 100, 'Gá hàn', '2017-09-21', '2017-10-12', NULL, '7', 'not_start', NULL, NULL, NULL, 30),
(139, 75, 54, 6, 100, 'VS-Giao mạ', '2017-09-25', '2017-10-13', NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(140, 75, 54, 7, 100, 'Mạ kẽm', '2017-09-28', '2017-10-13', NULL, '7', 'not_start', NULL, NULL, NULL, 20),
(141, 75, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-10', '2017-09-15', NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(142, 76, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '5,8', 'not_start', NULL, NULL, NULL, 10),
(143, 76, 54, 2, 100, 'Uốn nhấn', '2017-09-21', '2017-09-28', NULL, '5,8', 'not_start', NULL, NULL, NULL, 10),
(144, 76, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '5,8', 'not_start', NULL, NULL, NULL, 15),
(145, 76, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '5,8', 'not_start', NULL, NULL, NULL, 5),
(146, 76, 54, 5, 100, 'Gá hàn', '2017-09-21', '2017-10-13', NULL, '5,8', 'not_start', NULL, NULL, NULL, 30),
(147, 76, 54, 6, 100, 'VS-Giao mạ', '2017-09-22', '2017-10-13', NULL, '5,8', 'not_start', NULL, NULL, NULL, 5),
(148, 76, 54, 7, 100, 'Mạ kẽm', '2017-10-13', '2017-10-14', NULL, '5,8', 'not_start', NULL, NULL, NULL, 20),
(149, 76, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-10', '2017-10-15', NULL, '5,8', 'not_start', NULL, NULL, NULL, 5),
(150, 78, 54, 1, 100, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '8', 'not_start', NULL, NULL, NULL, 10),
(151, 78, 54, 2, 100, 'Uốn nhấn', NULL, NULL, NULL, '8', 'not_start', NULL, NULL, NULL, 10),
(152, 78, 54, 3, 100, 'Tạo lỗ', NULL, NULL, NULL, '8', 'not_start', NULL, NULL, NULL, 15),
(153, 78, 54, 4, 100, 'Cắt góc', NULL, NULL, NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(154, 78, 54, 5, 100, 'Gá hàn', '2017-09-21', '2017-10-13', NULL, '8', 'not_start', NULL, NULL, NULL, 30),
(155, 78, 54, 6, 100, 'VS-Giao mạ', '2017-09-22', '2017-10-13', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(156, 78, 54, 7, 100, 'Mạ kẽm', '2017-09-25', '2017-10-14', NULL, '8', 'not_start', NULL, NULL, NULL, 20),
(157, 78, 54, 8, 100, 'ĐK & Giao hàng', '2017-10-10', '2017-10-15', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(158, 79, 54, 1, 101, 'Ra phôi', '2017-09-20', '2017-09-30', NULL, '', 'not_start', NULL, NULL, NULL, 10),
(159, 79, 54, 2, 101, 'Uốn nhấn', '2017-09-21', '2017-09-30', NULL, '', 'not_start', NULL, NULL, NULL, 10),
(160, 79, 54, 3, 101, 'Tạo lỗ', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 15),
(161, 79, 54, 4, 101, 'Cắt góc', NULL, NULL, NULL, '', 'not_start', NULL, NULL, NULL, 5),
(162, 79, 54, 5, 101, 'Gá hàn', '2017-09-21', '2017-09-28', NULL, '', 'not_start', NULL, NULL, NULL, 30),
(163, 79, 54, 6, 101, 'VS-Giao mạ', '2017-09-26', '2017-10-13', NULL, '', 'not_start', NULL, NULL, NULL, 5),
(164, 79, 54, 7, 101, 'Mạ kẽm', '2017-09-21', '2017-10-15', NULL, '', 'not_start', NULL, NULL, NULL, 20),
(165, 79, 54, 8, 101, 'ĐK & Giao hàng', '2017-10-10', '2017-10-15', NULL, '', 'not_start', NULL, NULL, NULL, 5),
(166, 70, 55, 1, 105, 'Ra phôi', '2017-09-22', '2017-09-29', NULL, '3,5,7', 'completed', '0', '50', NULL, 10),
(167, 70, 55, 2, 105, 'Uốn nhấn', NULL, NULL, NULL, '3,7', 'completed', '0', '20', NULL, 10),
(168, 70, 55, 3, 105, 'Tạo lỗ', '2017-09-25', '2017-09-28', NULL, '3,7', 'completed', '0', '30', NULL, 15),
(169, 70, 55, 4, 105, 'Cắt góc', '2017-09-20', '2017-09-28', NULL, '3', 'completed', '0', '50', NULL, 5),
(170, 70, 55, 5, 105, 'Gá hàn', '2017-09-22', '2017-09-27', NULL, '3', 'completed', '0', '0', NULL, 30),
(171, 70, 55, 6, 105, 'VS-Giao mạ', '2017-09-22', '2017-09-28', NULL, '3,9', 'completed', '0', '0', NULL, 5),
(172, 70, 55, 7, 105, 'Mạ kẽm', '2017-09-24', '2017-09-27', NULL, '3,8', 'completed', '0', '0', NULL, 20),
(173, 70, 55, 8, 105, 'ĐK & Giao hàng', '2017-09-24', '2017-09-28', NULL, '3,8', 'completed', '0', '0', NULL, 5),
(174, 71, 55, 1, 105, 'Ra phôi', '2017-09-22', '2017-09-27', NULL, '8', 'pending', '0', '25', NULL, 10),
(175, 71, 55, 2, 105, 'Uốn nhấn', '2017-09-27', '2017-09-29', NULL, '8', 'not_start', NULL, NULL, NULL, 10),
(176, 71, 55, 3, 105, 'Tạo lỗ', '2017-09-22', '2017-09-27', NULL, '8', 'not_start', NULL, NULL, NULL, 15),
(177, 71, 55, 4, 105, 'Cắt góc', '2017-09-22', '2017-09-27', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(178, 71, 55, 5, 105, 'Gá hàn', '2017-09-23', '2017-09-26', NULL, '8,3', 'not_start', NULL, NULL, NULL, 30),
(179, 71, 55, 6, 105, 'VS-Giao mạ', '2017-09-22', '2017-09-29', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(180, 71, 55, 7, 105, 'Mạ kẽm', '2017-09-25', '2017-09-28', NULL, '8', 'not_start', NULL, NULL, NULL, 20),
(181, 71, 55, 8, 105, 'ĐK & Giao hàng', '2017-09-22', '2017-09-27', NULL, '8', 'not_start', NULL, NULL, NULL, 5),
(182, 72, 60, 1, 110, 'Ra phôi', '2017-09-20', '2017-09-23', NULL, '3', 'not_start', NULL, NULL, NULL, 10),
(183, 72, 60, 2, 110, 'Uốn nhấn', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 10),
(184, 72, 60, 3, 110, 'Tạo lỗ', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 15),
(185, 72, 60, 4, 110, 'Cắt góc', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(186, 72, 60, 5, 110, 'Gá hàn', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 30),
(187, 72, 60, 6, 110, 'VS-Giao mạ', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(188, 72, 60, 7, 110, 'Mạ kẽm', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 20),
(189, 72, 60, 8, 110, 'ĐK & Giao hàng', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(190, 70, 61, 1, 111, 'Ra phôi', '2017-09-13', '2017-09-22', NULL, '5', 'completed', '0', '5', NULL, 10),
(191, 70, 61, 2, 111, 'Uốn nhấn', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(192, 70, 61, 3, 111, 'Tạo lỗ', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 15),
(193, 70, 61, 4, 111, 'Cắt góc', '2017-09-06', '2017-09-20', NULL, '5', 'completed', '0', '30', NULL, 5),
(194, 70, 61, 5, 111, 'Gá hàn', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 30),
(195, 70, 61, 6, 111, 'VS-Giao mạ', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(196, 70, 61, 7, 111, 'Mạ kẽm', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 20),
(197, 70, 61, 8, 111, 'ĐK & Giao hàng', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(198, 71, 61, 1, 111, 'Ra phôi', '2017-09-23', '2017-09-25', NULL, '3,5,9', 'completed', '0', '0', NULL, 10),
(199, 71, 61, 2, 111, 'Uốn nhấn', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 10),
(200, 71, 61, 3, 111, 'Tạo lỗ', NULL, NULL, NULL, '3,5,8', 'not_start', NULL, NULL, NULL, 15),
(201, 71, 61, 4, 111, 'Cắt góc', '2017-09-21', '2017-09-23', NULL, '3,5', 'completed', '0', '50', NULL, 5),
(202, 71, 61, 5, 111, 'Gá hàn', '2017-09-23', '2017-09-25', NULL, '3,5,7', 'completed', '0', '0', NULL, 30),
(203, 71, 61, 6, 111, 'VS-Giao mạ', '2017-09-23', '2017-09-26', NULL, '3,5,7', 'completed', '0', '0', NULL, 5),
(204, 71, 61, 7, 111, 'Mạ kẽm', '2017-09-19', '2017-09-23', NULL, '3,5', 'completed', '0', '0', NULL, 20),
(205, 71, 61, 8, 111, 'ĐK & Giao hàng', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 5),
(206, 72, 61, 1, 111, 'Ra phôi', '2017-09-23', '2017-09-25', NULL, '3', 'completed', '0', '100', NULL, 10),
(207, 72, 61, 2, 111, 'Uốn nhấn', '2017-09-22', '2017-09-23', NULL, '3', 'completed', '0', '90', NULL, 10),
(208, 72, 61, 3, 111, 'Tạo lỗ', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 15),
(209, 72, 61, 4, 111, 'Cắt góc', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(210, 72, 61, 5, 111, 'Gá hàn', '2017-09-23', '2017-09-25', NULL, '3', 'completed', '0', '0', NULL, 30),
(211, 72, 61, 6, 111, 'VS-Giao mạ', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(212, 72, 61, 7, 111, 'Mạ kẽm', '2017-09-23', '2017-09-27', NULL, '3', 'completed', '0', '0', NULL, 20),
(213, 72, 61, 8, 111, 'ĐK & Giao hàng', NULL, NULL, NULL, '3', 'not_start', NULL, NULL, NULL, 5),
(214, 70, 62, 1, 112, 'Ra phôi', '2017-09-22', '2017-09-27', NULL, '5,3', 'pending', '0', '10', NULL, 10),
(215, 70, 62, 2, 112, 'Uốn nhấn', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(216, 70, 62, 3, 112, 'Tạo lỗ', '2017-09-23', '2017-09-26', NULL, '5,7', 'pending', '0', '20', NULL, 15),
(217, 70, 62, 4, 112, 'Cắt góc', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(218, 70, 62, 5, 112, 'Gá hàn', '2017-09-23', '2017-09-27', NULL, '5,7', 'not_start', NULL, NULL, NULL, 30),
(219, 70, 62, 6, 112, 'VS-Giao mạ', '2017-09-23', '2017-09-27', NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(220, 70, 62, 7, 112, 'Mạ kẽm', NULL, NULL, NULL, '5,8', 'not_start', NULL, NULL, NULL, 20),
(221, 70, 62, 8, 112, 'ĐK & Giao hàng', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(222, 72, 62, 1, 112, 'Ra phôi', '2017-09-23', '2017-09-26', NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(223, 72, 62, 2, 112, 'Uốn nhấn', '2017-09-23', '2017-09-26', NULL, '5', 'not_start', NULL, NULL, NULL, 10),
(224, 72, 62, 3, 112, 'Tạo lỗ', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 15),
(225, 72, 62, 4, 112, 'Cắt góc', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(226, 72, 62, 5, 112, 'Gá hàn', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 30),
(227, 72, 62, 6, 112, 'VS-Giao mạ', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(228, 72, 62, 7, 112, 'Mạ kẽm', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 20),
(229, 72, 62, 8, 112, 'ĐK & Giao hàng', NULL, NULL, NULL, '5', 'not_start', NULL, NULL, NULL, 5),
(230, 74, 62, 1, 112, 'Ra phôi', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(231, 74, 62, 2, 112, 'Uốn nhấn', '2017-09-23', '2017-09-28', NULL, '7', 'not_start', NULL, NULL, NULL, 10),
(232, 74, 62, 3, 112, 'Tạo lỗ', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 15),
(233, 74, 62, 4, 112, 'Cắt góc', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(234, 74, 62, 5, 112, 'Gá hàn', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 30),
(235, 74, 62, 6, 112, 'VS-Giao mạ', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(236, 74, 62, 7, 112, 'Mạ kẽm', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 20),
(237, 74, 62, 8, 112, 'ĐK & Giao hàng', NULL, NULL, NULL, '7', 'not_start', NULL, NULL, NULL, 5),
(416, 73, 87, 1, 137, 'Ra phôi', '2017-09-28', '2017-09-30', NULL, '5,7', 'pending', '0', '1', NULL, 10),
(417, 73, 87, 2, 137, 'Uốn nhấn', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 10),
(418, 73, 87, 3, 137, 'Tạo lỗ', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 15),
(419, 73, 87, 4, 137, 'Cắt góc', '2017-09-27', '2017-09-29', NULL, '5,7', 'not_start', NULL, NULL, NULL, 5),
(420, 73, 87, 5, 137, 'Gá hàn', NULL, NULL, NULL, '5,7', 'not_start', NULL, NULL, NULL, 30),
(421, 73, 87, 6, 137, 'VS-Giao mạ', '2017-09-27', '2017-09-30', NULL, '5,7,3', 'not_start', NULL, NULL, NULL, 5),
(422, 73, 87, 7, 137, 'Mạ kẽm', '2017-09-29', '2017-10-04', NULL, '5,7', 'not_start', NULL, NULL, NULL, 20),
(423, 73, 87, 8, 137, 'ĐK & Giao hàng', '2017-09-27', '2017-10-07', NULL, '5,7', 'not_start', NULL, NULL, NULL, 5),
(424, 78, 89, 1, 139, 'Ra phôi', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 10),
(425, 78, 89, 2, 139, 'Uốn nhấn', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 10),
(426, 78, 89, 3, 139, 'Tạo lỗ', NULL, NULL, NULL, '3,5,7', 'not_start', NULL, NULL, NULL, 15),
(427, 78, 89, 4, 139, 'Cắt góc', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 5),
(428, 78, 89, 5, 139, 'Gá hàn', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 30),
(429, 78, 89, 6, 139, 'VS-Giao mạ', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 5),
(430, 78, 89, 7, 139, 'Mạ kẽm', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 20),
(431, 78, 89, 8, 139, 'ĐK & Giao hàng', NULL, NULL, NULL, '3,5', 'not_start', NULL, NULL, NULL, 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_stage_details`
--

CREATE TABLE `sma_production_stage_details` (
  `id` int(11) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `stage_id` int(11) DEFAULT NULL,
  `complete_quantity` decimal(25,0) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_production_stage_details`
--

INSERT INTO `sma_production_stage_details` (`id`, `production_id`, `product_id`, `stage_id`, `complete_quantity`, `user_id`, `note`, `date`, `user_name`) VALUES
(86, 21, 31, 48, '5', 1, '&lt;p&gt;5&lt;&sol;p&gt;', '2017-08-31 17:08:00', 'Owner Owner'),
(87, 21, 31, 48, '3', 1, '&lt;p&gt;3&lt;&sol;p&gt;', '2017-08-31 17:09:00', 'Owner Owner'),
(88, 52, 43, 90, '10', 1, '&lt;p&gt;zzzzzzz&lt;&sol;p&gt;', '2017-09-19 11:26:00', 'Owner Owner'),
(89, 52, 43, 90, '20', 1, '&lt;p&gt;zzzzzzzz&lt;&sol;p&gt;', '2017-09-19 11:27:00', 'Owner Owner'),
(90, 52, 43, 90, '50', 1, '&lt;p&gt;zzzzzzzzzz&lt;&sol;p&gt;', '2017-09-19 11:28:00', 'Owner Owner'),
(91, 52, 42, 82, '20', 1, '&lt;p&gt;vvv&lt;&sol;p&gt;', '2017-09-19 11:35:00', 'Owner Owner'),
(92, 52, 42, 82, '50', 1, '&lt;p&gt;8g4f5gh&lt;&sol;p&gt;', '2017-09-19 11:36:00', 'Owner Owner'),
(93, 52, 42, 82, '0', 1, '&lt;p&gt;599&lt;&sol;p&gt;', '2017-09-20 11:35:00', 'Owner Owner'),
(94, 52, 42, 82, '20', 1, '&lt;p&gt;vvvvvv&lt;&sol;p&gt;', '2017-09-19 15:50:00', 'Owner Owner'),
(95, 52, 42, 82, '10', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-19 15:52:00', 'Owner Owner'),
(96, 52, 42, 83, '48', 1, '&lt;p&gt;nnn&lt;&sol;p&gt;', '2017-09-19 15:53:00', 'Owner Owner'),
(97, 52, 42, 84, '47', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-19 15:54:00', 'Owner Owner'),
(98, 52, 42, 84, '5', 1, '&lt;p&gt;ccaa&lt;&sol;p&gt;', '2017-09-19 15:56:00', 'Owner Owner'),
(99, 52, 42, 83, '2', 1, '&lt;p&gt;vvvvvvv&lt;&sol;p&gt;', '2017-09-19 15:57:00', 'Owner Owner'),
(100, 52, 42, 83, '8', 1, '&lt;p&gt;aaaaaaaaa&lt;&sol;p&gt;', '2017-09-19 15:57:00', 'Owner Owner'),
(101, 52, 42, 82, '50', 1, '&lt;p&gt;aaaaaaa&lt;&sol;p&gt;', '2017-09-19 15:58:00', 'Owner Owner'),
(102, 52, 42, 82, '10', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-19 16:56:00', 'Owner Owner'),
(103, 52, 42, 82, '40', 1, '&lt;p&gt;zzxc&lt;&sol;p&gt;', '2017-09-19 16:57:00', 'Owner Owner'),
(104, 52, 41, 87, '10', 1, '&lt;p&gt;zxc&lt;&sol;p&gt;', '2017-09-19 16:59:00', 'Owner Owner'),
(105, 52, 42, 83, '10', 1, '&lt;p&gt;cccccc&lt;&sol;p&gt;', '2017-09-19 17:05:00', 'Owner Owner'),
(106, 52, 42, 83, '2', 1, '&lt;p&gt;xxx&lt;&sol;p&gt;', '2017-09-19 17:06:00', 'Owner Owner'),
(107, 52, 42, 84, '20', 1, '&lt;p&gt;zxxxx&lt;&sol;p&gt;', '2017-09-19 17:08:00', 'Owner Owner'),
(108, 52, 42, 84, '8', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-19 17:08:00', 'Owner Owner'),
(109, 52, 42, 85, '6', 1, '&lt;p&gt;xxx&lt;&sol;p&gt;', '2017-09-19 17:10:00', 'Owner Owner'),
(110, 52, 42, 85, '4', 1, '&lt;p&gt;zzzz&lt;&sol;p&gt;', '2017-09-19 17:11:00', 'Owner Owner'),
(111, 52, 42, 82, '50', 1, '&lt;p&gt;21&lt;&sol;p&gt;', '2017-09-19 17:16:00', 'Owner Owner'),
(112, 52, 42, 82, '0', 1, '&lt;p&gt;qswd&lt;&sol;p&gt;', '2017-09-20 08:04:00', 'Owner Owner'),
(113, 52, 42, 83, '0', 1, '&lt;p&gt;aaaaa&lt;&sol;p&gt;', '2017-09-20 08:04:00', 'Owner Owner'),
(114, 52, 42, 83, '0', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(115, 52, 42, 83, '0', 1, '&lt;p&gt;zxcxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(116, 52, 42, 84, '10', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(117, 52, 42, 85, '10', 1, '&lt;p&gt;cccccc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(118, 52, 42, 84, '0', 1, '&lt;p&gt;12&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(119, 52, 42, 85, '0', 1, '&lt;p&gt;11&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(120, 52, 41, 86, '30', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(121, 52, 41, 87, '10', 1, '&lt;p&gt;xxxxxx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(122, 52, 41, 88, '30', 1, '&lt;p&gt;zxcxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(123, 52, 41, 89, '30', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(124, 52, 41, 86, '10', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(125, 52, 41, 87, '20', 1, '&lt;p&gt;zczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(126, 52, 41, 89, '0', 1, '&lt;p&gt;aaaa&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(127, 52, 41, 87, '0', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(128, 52, 41, 86, '10', 1, '&lt;p&gt;xxxxa&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(129, 52, 41, 86, '0', 1, '&lt;p&gt;123321&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(130, 52, 41, 88, '10', 1, '&lt;p&gt;czxczx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(131, 52, 41, 88, '10', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(132, 52, 41, 88, '10', 1, '&lt;p&gt;zxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(133, 52, 41, 88, '10', 1, '&lt;p&gt;zxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(134, 52, 41, 88, '10', 1, '&lt;p&gt;zxc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(135, 52, 41, 88, '10', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(136, 52, 41, 88, '20', 1, '&lt;p&gt;zxczx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(137, 52, 41, 88, '0', 1, '&lt;p&gt;s1df&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(138, 53, 43, 94, '30', 1, '&lt;p&gt;zzzzz&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(139, 53, 43, 94, '10', 1, '&lt;p&gt;xxxxxx&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(140, 52, 43, 90, '10', 1, '&lt;p&gt;cccc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(141, 52, 43, 90, '10', 1, '&lt;p&gt;cccccc&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(142, 52, 43, 90, '10', 1, '&lt;p&gt;ffff&lt;&sol;p&gt;', '2017-09-20 00:00:00', 'Owner Owner'),
(143, 55, 70, 166, '20', 1, '&lt;p&gt;0&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(144, 55, 71, 174, '10', 1, '&lt;p&gt;zzzz&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(145, 55, 70, 166, '30', 1, '&lt;p&gt;xxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(146, 55, 70, 167, '20', 1, '&lt;p&gt;xxxxxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(147, 55, 70, 167, '0', 1, '&lt;p&gt;Ho&agrave;n th&agrave;nh&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(148, 55, 70, 166, '0', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(149, 55, 70, 168, '30', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(150, 55, 70, 168, '0', 1, '&lt;p&gt;qqq&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(151, 55, 70, 169, '50', 1, '&lt;p&gt;ccc&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(152, 55, 70, 169, '0', 1, '&lt;p&gt;ffff&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(153, 55, 70, 170, '0', 1, '&lt;p&gt;vvvv&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(154, 55, 70, 171, '0', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(155, 55, 70, 172, '0', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(156, 55, 70, 173, '0', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(157, 55, 71, 174, '15', 1, '&lt;p&gt;aaaaaa&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(158, 61, 70, 190, '5', 1, '&lt;p&gt;FGF&lt;&sol;p&gt;', '2017-09-21 00:00:00', 'Owner Owner'),
(159, 61, 70, 193, '30', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(160, 61, 71, 201, '50', 1, '&lt;p&gt;xccc&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(161, 61, 72, 207, '90', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(162, 61, 72, 206, '100', 1, '&lt;p&gt;llll&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(163, 61, 70, 190, '0', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(164, 61, 70, 193, '0', 1, '&lt;p&gt;zxczx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(165, 61, 71, 198, '0', 1, '&lt;p&gt;zxczc&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(166, 61, 71, 201, '0', 1, '&lt;p&gt;zxczxcz&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(167, 61, 71, 202, '0', 1, '&lt;p&gt;zxcc&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(168, 61, 71, 204, '0', 1, '&lt;p&gt;zxczxc&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(169, 61, 71, 203, '0', 1, '&lt;p&gt;zxczxczx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(170, 61, 72, 206, '0', 1, '&lt;p&gt;1111&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(171, 61, 72, 207, '0', 1, '&lt;p&gt;1111&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(172, 61, 72, 210, '0', 1, '&lt;p&gt;1111&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(173, 61, 72, 212, '0', 1, '&lt;p&gt;2222&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(174, 62, 70, 214, '10', 1, '&lt;p&gt;xxxxxx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(175, 62, 70, 216, '20', 1, '&lt;p&gt;xxxxx&lt;&sol;p&gt;', '2017-09-22 00:00:00', 'Owner Owner'),
(176, 87, 73, 416, '1', 1, '&lt;p&gt;xxxx&lt;&sol;p&gt;', '2017-09-23 00:00:00', 'Owner Owner');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_products`
--

CREATE TABLE `sma_products` (
  `id` int(11) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` char(255) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `alert_quantity` decimal(15,4) DEFAULT '20.0000',
  `image` varchar(255) DEFAULT 'no_image.png',
  `category_id` int(11) DEFAULT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `cf1` varchar(255) DEFAULT NULL,
  `cf2` varchar(255) DEFAULT NULL,
  `cf3` varchar(255) DEFAULT NULL,
  `cf4` text,
  `cf5` text,
  `cf6` varchar(255) DEFAULT NULL,
  `cf7` text NOT NULL,
  `cf8` text NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `tax_rate` int(11) DEFAULT NULL,
  `track_quantity` tinyint(1) DEFAULT '1',
  `details` varchar(1000) DEFAULT NULL,
  `warehouse` int(11) DEFAULT '1',
  `barcode_symbology` varchar(55) DEFAULT 'code128',
  `file` varchar(100) DEFAULT NULL,
  `product_details` text,
  `tax_method` tinyint(1) DEFAULT '0',
  `type` varchar(55) DEFAULT 'standard',
  `supplier1` int(11) DEFAULT NULL,
  `supplier1price` decimal(25,4) DEFAULT NULL,
  `supplier2` int(11) DEFAULT NULL,
  `supplier2price` decimal(25,4) DEFAULT NULL,
  `supplier3` int(11) DEFAULT NULL,
  `supplier3price` decimal(25,4) DEFAULT NULL,
  `supplier4` int(11) DEFAULT NULL,
  `supplier4price` decimal(25,4) DEFAULT NULL,
  `supplier5` int(11) DEFAULT NULL,
  `supplier5price` decimal(25,4) DEFAULT NULL,
  `quantity_config` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_products`
--

INSERT INTO `sma_products` (`id`, `code`, `name`, `unit`, `cost`, `price`, `alert_quantity`, `image`, `category_id`, `subcategory_id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `cf7`, `cf8`, `quantity`, `tax_rate`, `track_quantity`, `details`, `warehouse`, `barcode_symbology`, `file`, `product_details`, `tax_method`, `type`, `supplier1`, `supplier1price`, `supplier2`, `supplier2price`, `supplier3`, `supplier3price`, `supplier4`, `supplier4price`, `supplier5`, `supplier5price`, `quantity_config`) VALUES
(70, 'KTMT16', 'KIM THU SÉT L =1,8M T16', 'Tấm', NULL, '0.0000', NULL, 'no_image.png', 3, NULL, '200X200', '5.02', '2', NULL, '[{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(71, 'KTST8', 'KIM THU SÉT L=1,18M T8', 'Tấm', NULL, '0.0000', NULL, 'no_image.png', 3, NULL, '120x75', '1.7', '2', NULL, '[{\"id\":\"2\",\"item\":\"Bao tr\\u1eafng\",\"quantity\":\"1\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(72, 'KTSF25', 'KIM THU SÉT L=1,18M F25', '', NULL, '0.0000', NULL, 'no_image.png', 3, NULL, '1800', '6.93', '1', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '1', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(73, 'MBBDCT5', 'MẶT BÍCH BÍT ĐẦU CỘT T5', '', NULL, '0.0000', NULL, 'no_image.png', 4, NULL, '200x200', '1.57', '2', NULL, '[{\"id\":\"2\",\"item\":\"Bao tr\\u1eafng\",\"quantity\":\"1\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(74, 'V26-T1', 'ĐỐT CỘT 660x660x;L=5500 V26-T1', 'Thanh', NULL, '0.0000', NULL, 'no_image.png', 5, NULL, '5484', '131.08', '10', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '5', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(75, 'V26-T2', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'Thanh', NULL, '0.0000', NULL, 'no_image.png', 5, NULL, '6425', '47.61', '4', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(76, 'V26-T2.1', 'ĐỐT CỘT 660x660x;L=5500 V26-T2', 'Thanh', NULL, '0.0000', NULL, 'no_image.png', 5, NULL, '7200', '53.35', '4', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(77, 'V26-T3', 'ĐỐT CỘT 660x660x;L=5500 V26-T3', 'Thanh', NULL, '0.0000', NULL, 'no_image.png', 5, NULL, '365', '8.11', '4', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '4', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9),
(78, 'V26-B1', 'ĐỐT CỘT 660x660x;L=5500 V26-B1', 'Tấm', NULL, '0.0000', NULL, 'no_image.png', 5, NULL, '200x200', '30.14', '2', NULL, '[{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"1\"}]', '2', '', '', '0.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_product_photos`
--

CREATE TABLE `sma_product_photos` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_product_variants`
--

CREATE TABLE `sma_product_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_product_variants`
--

INSERT INTO `sma_product_variants` (`id`, `product_id`, `name`, `cost`, `price`, `quantity`) VALUES
(1, 45, 'Red', NULL, NULL, NULL),
(2, 45, 'Blue', NULL, NULL, NULL),
(3, 45, 'Black', NULL, NULL, NULL),
(4, 45, 'White', NULL, NULL, NULL),
(5, 46, 'Red', NULL, NULL, NULL),
(6, 46, 'Blue', NULL, NULL, NULL),
(7, 46, 'Black', NULL, NULL, NULL),
(8, 46, 'White', NULL, NULL, NULL),
(9, 47, 'Red', NULL, NULL, NULL),
(10, 47, 'Blue', NULL, NULL, NULL),
(11, 47, 'Black', NULL, NULL, NULL),
(12, 47, 'White', NULL, NULL, NULL),
(13, 48, 'Red', NULL, NULL, NULL),
(14, 48, 'Blue', NULL, NULL, NULL),
(15, 48, 'Black', NULL, NULL, NULL),
(16, 48, 'White', NULL, NULL, NULL),
(17, 49, 'Red', NULL, NULL, NULL),
(18, 49, 'Blue', NULL, NULL, NULL),
(19, 49, 'Black', NULL, NULL, NULL),
(20, 49, 'White', NULL, NULL, NULL),
(21, 50, 'Red', NULL, NULL, NULL),
(22, 50, 'Blue', NULL, NULL, NULL),
(23, 50, 'Black', NULL, NULL, NULL),
(24, 50, 'White', NULL, NULL, NULL),
(25, 51, 'Red', NULL, NULL, NULL),
(26, 51, 'Blue', NULL, NULL, NULL),
(27, 51, 'Black', NULL, NULL, NULL),
(28, 51, 'White', NULL, NULL, NULL),
(29, 52, 'Red', NULL, NULL, NULL),
(30, 52, 'Blue', NULL, NULL, NULL),
(31, 52, 'Black', NULL, NULL, NULL),
(32, 52, 'White', NULL, NULL, NULL),
(33, 53, 'Red', NULL, NULL, NULL),
(34, 53, 'Blue', NULL, NULL, NULL),
(35, 53, 'Black', NULL, NULL, NULL),
(36, 53, 'White', NULL, NULL, NULL),
(37, 54, 'Red', NULL, NULL, NULL),
(38, 54, 'Blue', NULL, NULL, NULL),
(39, 54, 'Black', NULL, NULL, NULL),
(40, 54, 'White', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_purchases`
--

CREATE TABLE `sma_purchases` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(11) DEFAULT NULL,
  `supplier` varchar(55) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `product_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_discount` decimal(25,4) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT NULL,
  `product_tax` decimal(25,4) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `paid` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(55) DEFAULT '',
  `payment_status` varchar(20) DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_purchases`
--

INSERT INTO `sma_purchases` (`id`, `reference_no`, `date`, `supplier_id`, `supplier`, `warehouse_id`, `note`, `total`, `product_discount`, `order_discount_id`, `order_discount`, `total_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `paid`, `status`, `payment_status`, `created_by`, `updated_by`, `updated_at`, `attachment`) VALUES
(154, 'PO/2017/07/0100', '2017-07-20 09:20:00', 2, 'Yanstore', 1, '', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(158, 'ENQUERY/2017/09/0055', '2017-09-11 05:45:00', NULL, NULL, 1, '&lt;p&gt;Y&ecirc;u cầu nhập h&agrave;ng &sol; 2017-09-11&lt;&sol;p&gt;', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approval', 'paid', 1, 1, '2017-09-11 05:46:33', NULL),
(159, '12', '2017-09-11 04:47:00', 2, 'Yanstore', 1, '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(160, 'uuuu', '2017-09-11 04:48:00', 2, 'Yanstore', 1, '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(161, 'DMH', '2017-09-20 09:29:00', NULL, NULL, 1, '', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'done', 'pending', 1, 1, '2017-09-20 10:30:30', NULL),
(162, 'NH001', '2017-09-20 09:30:00', 2, 'Yanstore', 1, '', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_purchase_items`
--

CREATE TABLE `sma_purchase_items` (
  `id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(20) DEFAULT NULL,
  `discount` varchar(20) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `quantity_balance` decimal(15,4) DEFAULT '0.0000',
  `date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_purchase_items`
--

INSERT INTO `sma_purchase_items` (`id`, `purchase_id`, `transfer_id`, `product_id`, `item_id`, `product_code`, `product_name`, `option_id`, `net_unit_cost`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `expiry`, `subtotal`, `quantity_balance`, `date`, `status`, `unit_cost`, `real_unit_cost`) VALUES
(348, 154, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '100.0000', '2017-07-20', 'received', '20.0000', '20.0000'),
(349, 154, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '200.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '200.0000', '2017-07-20', 'received', '0.0000', '0.0000'),
(357, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL, '-300.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '-300.0000', NULL, NULL, NULL, NULL),
(378, 158, NULL, NULL, 3, NULL, 'Sơn xanh', NULL, '0.0000', '10.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '0.0000', '2017-09-11', 'approval', '0.0000', '0.0000'),
(379, 158, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '820.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '320.0000', '2017-09-11', 'approval', '0.0000', '0.0000'),
(380, 159, NULL, NULL, 3, NULL, 'Sơn xanh', NULL, '0.0000', '10.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '10.0000', '2017-09-11', 'received', '0.0000', '0.0000'),
(381, 159, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '500.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '500.0000', '2017-09-11', 'received', '0.0000', '0.0000'),
(382, 160, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '320.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '320.0000', '2017-09-11', 'received', '0.0000', '0.0000'),
(383, NULL, NULL, NULL, 3, NULL, 'Sơn xanh', NULL, NULL, '0.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(392, NULL, NULL, NULL, 6, NULL, 'têst', NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(394, 161, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '0.0000', '2017-09-20', 'done', '20.0000', '20.0000'),
(395, 162, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '100.0000', '2017-09-20', 'received', '20.0000', '20.0000'),
(412, NULL, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, NULL, '-70.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '-70.0000', NULL, NULL, NULL, NULL),
(413, NULL, NULL, NULL, 2, NULL, 'Bao trắng', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(414, NULL, NULL, NULL, 4, NULL, 'Thép tấm', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_quotes`
--

CREATE TABLE `sma_quotes` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `internal_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_quote_items`
--

CREATE TABLE `sma_quote_items` (
  `id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_return_items`
--

CREATE TABLE `sma_return_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) UNSIGNED NOT NULL,
  `return_id` int(11) UNSIGNED NOT NULL,
  `sale_item_id` int(11) DEFAULT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_return_sales`
--

CREATE TABLE `sma_return_sales` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `surcharge` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_sales`
--

CREATE TABLE `sma_sales` (
  `id` int(11) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(55) DEFAULT NULL,
  `implementation_unit` varchar(255) DEFAULT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `biller` varchar(55) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `staff_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) DEFAULT NULL,
  `sale_status` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_items` tinyint(4) DEFAULT NULL,
  `pos` tinyint(1) DEFAULT '0',
  `paid` decimal(25,4) DEFAULT '0.0000',
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_sales`
--

INSERT INTO `sma_sales` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `implementation_unit`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`) VALUES
(1, '2017-03-21 19:04:22', 'SALE/POS/2017/03/0001', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '52000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '52000.0000', 'pending', 'paid', 0, NULL, 1, NULL, NULL, 3, 1, '52000.0000', NULL, '0.0000', NULL),
(2, '2017-03-23 21:23:28', 'SALE/POS/2017/03/0002', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '109000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '109000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 7, 1, '109000.0000', NULL, '0.0000', NULL),
(3, '2017-03-23 20:25:00', 'SALE/2017/03/0001', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '445000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '445000.0000', 'completed', 'pending', 0, NULL, 1, NULL, NULL, 1, 0, '0.0000', NULL, '0.0000', NULL),
(4, '2017-03-23 20:38:00', 'SALE/2017/03/0002', 4, 'tư nhân', NULL, 3, 'Test Biller', 1, '', '', '515000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '515000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, 0, '515000.0000', NULL, '0.0000', NULL),
(5, '2017-04-09 20:55:13', 'SALE/POS/2017/04/0003', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '270000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '270000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 9, 1, '270000.0000', NULL, '0.0000', NULL),
(6, '2017-04-09 21:01:18', 'SALE/POS/2017/04/0004', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '300000.0000', '0.0000', '20%', '60000.0000', '60000.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '240000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 10, 1, '240000.0000', NULL, '0.0000', NULL),
(7, '2017-04-09 21:05:08', 'SALE/POS/2017/04/0005', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '60000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'due', 0, NULL, 1, NULL, NULL, 2, 1, '0.0000', NULL, '0.0000', NULL),
(8, '2017-04-09 21:06:39', 'SALE/POS/2017/04/0006', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '60000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'due', 0, NULL, 1, NULL, NULL, 2, 1, '0.0000', NULL, '0.0000', NULL),
(9, '2017-04-09 21:08:16', 'SALE/POS/2017/04/0007', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '60000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 2, 1, '60000.0000', NULL, '0.0000', NULL),
(10, '2017-04-09 21:10:32', 'SALE/POS/2017/04/0008', 1, 'Walk-in Customer', NULL, 3, 'Test Biller', 1, '', '', '30000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 2, '3000.0000', '3000.0000', '0.0000', '33000.0000', 'completed', 'paid', 0, NULL, 1, NULL, NULL, 1, 1, '33000.0000', NULL, '0.0000', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_sale_items`
--

CREATE TABLE `sma_sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_sale_items`
--

INSERT INTO `sma_sale_items` (`id`, `sale_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`) VALUES
(1, 1, 3, 'BC', 'Bông Cải', 'standard', 0, '12000.0000', '12000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '12000.0000', '', '12000.0000'),
(2, 1, 2, 'CC', 'Cà chua', 'standard', 0, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '20000.0000', '', '20000.0000'),
(3, 1, 2, 'CC', 'Cà chua', 'standard', 0, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '20000.0000', '', '20000.0000'),
(4, 2, 2, 'CC', 'Cà chua', 'standard', 0, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '20000.0000', '', '20000.0000'),
(5, 2, 2, 'CC', 'Cà chua', 'standard', 0, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '20000.0000', '', '20000.0000'),
(6, 2, 4, 'KT', 'Khoai Tây', 'standard', 0, '15000.0000', '15000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '15000.0000', '', '15000.0000'),
(7, 2, 3, 'BC', 'Bông Cải', 'standard', 0, '12000.0000', '12000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '12000.0000', '', '12000.0000'),
(8, 2, 5, 'ODL', 'Ớt Đà Lạt', 'standard', 0, '25000.0000', '25000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '25000.0000', '', '25000.0000'),
(9, 2, 3, 'BC', 'Bông Cải', 'standard', 0, '12000.0000', '12000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '12000.0000', '', '12000.0000'),
(10, 2, 1, 'CT', 'Cải Thìa', 'standard', 0, '5000.0000', '5000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '5000.0000', '', '5000.0000'),
(11, 3, 4294967295, 'ts', 'tinh sen', 'manual', 0, '445000.0000', '445000.0000', '1.0000', 1, '0.0000', 0, '', '0', '0.0000', '445000.0000', '', '445000.0000'),
(12, 4, 7, 'Tinh s', 'tinh sen', 'standard', NULL, '445000.0000', '445000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '445000.0000', '', '445000.0000'),
(13, 4, 8, 'tra s', 'trà sen', 'standard', NULL, '70000.0000', '70000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '70000.0000', '', '70000.0000'),
(14, 5, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '9.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '270000.0000', '', '30000.0000'),
(15, 6, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '10.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '300000.0000', '', '30000.0000'),
(16, 7, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(17, 7, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(18, 8, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(19, 8, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(20, 9, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(21, 9, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(22, 10, 9, 'led', 'Den led', 'service', NULL, '30000.0000', '30000.0000', '1.0000', 1, '0.0000', 1, '0.0000', '0', '0.0000', '30000.0000', '', '30000.0000'),
(26, 14, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '5.0000', 1, '0.0000', 0, '', NULL, '0.0000', '2500.0000', '', '500.0000'),
(27, 14, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '10.0000', 1, '0.0000', 0, '', NULL, '0.0000', '5000.0000', '', '500.0000'),
(35, 40, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', 0, '500.0000', '500.0000', '50.0000', 1, '0.0000', 0, '', NULL, '0.0000', '25000.0000', '', '500.0000'),
(36, 40, 29, 'N122-30 (ND)', 'Đế trụ', 'null', 0, '1000.0000', '1000.0000', '10.0000', 1, '0.0000', 0, '', NULL, '0.0000', '10000.0000', '', '1000.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_sessions`
--

CREATE TABLE `sma_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_sessions`
--

INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('01f8205e6bc98b9c206a596671288e4281bdf8bc', '::1', 1506129713, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363132393434333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0269537d4dea569c08810ab5c0192423f900da41', '::1', 1506129395, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363132393132303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('02d039a9714cd0e6ce90d0542dab2a0876cab193', '::1', 1505977278, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937363937373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0387e535bfef2b6d7ebf5a996da5431519533718', '::1', 1505978590, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937383332373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('03f2e0d0b9bf8f60eb52ccc798420163a33a723d', '::1', 1505901646, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930313432313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('0407249c894db9e9533c06de2ca124e182a8a0c9', '::1', 1505900893, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930303633353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('043f6ec91aad761ae291099d2708075e7ac1a3c0', '::1', 1506043841, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034333639313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('05743967ad43c9e1697fb022367b7515b54555e6', '::1', 1506074104, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037333930393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('05b2cdc803056fcea608af759ff53ea0de1668d2', '::1', 1505894479, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839343437383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('067c9599bdd8ef3dff2ec29270a9aaf83669e581', '::1', 1505983175, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938333037363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('06c65aa8d78cc1ce72e6b0a80cb3a92fd701a588', '::1', 1505983525, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938333433343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('09fe6e318c137e36c3ee8b3709b034fee2fa1107', '::1', 1506068340, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036383035383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('0b251c028a6705ddd2349b61cbed4bb85ed0423b', '::1', 1505985078, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938343739333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0dbdc74ebed7fc06c143a0907eda02f478b855bd', '::1', 1505891085, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839303739323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0f92c0891b7a4dd6d637ef2f75b22e3f7cce4005', '::1', 1506052564, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035323337353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('0fb371bd12f45350506511695089c4eb031e03a9', '::1', 1505983068, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938323737323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('10839390222874f0802cb01dcec2e1bb006e9a98', '::1', 1505981587, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938313238393b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('109a84d94f500dd449567a3d3dff6574934a28d0', '::1', 1505975731, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937353436333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('11eb3904df19813fee3a47f803e6f1b0e3bfd2b0', '::1', 1505902738, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930323035363b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('13ca7386d083a5ea4c7f3f8e216d0d6ed7031c29', '::1', 1505979282, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937393034333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('145ce1f1a5f519f0e4b76f81bebf0602fb8fb608', '::1', 1506043349, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034323836313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('14d2ce9f1429aa9ec6894385ce67da2a1d71153b', '::1', 1505988100, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938373830353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('17938790bcae67b267049dee6b871a2c1fc02ae5', '::1', 1506137669, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133373339353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1903d6bb24294d9e0be7f36c481f1de33d108cbe', '::1', 1506141434, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363134313033303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('1bab1219e4d9145f7b1c22cf03ccbbf4fae2d617', '::1', 1505898526, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839383139393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('216c8fb0fc94edddf2d5e558846e4c477644909c', '::1', 1505980357, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938303138363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('23fd226e630a7d37efdf78e5725205341637f371', '::1', 1506046753, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034363637353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('24af349861b2b3051c41046ac6c3622bb9c1380e', '::1', 1506046074, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034353835373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('24d4a744521802887fdd65e6484e0e8ba1886405', '::1', 1505978243, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937373933373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('25a9c5e60aa7f9335cdcaa2602dd180fe4641d2f', '::1', 1505894042, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839333735353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2676688daa4464e22e34964721bf062e383b557c', '::1', 1506057036, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035373031333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('26ca79fac1745bd6aef9c3c81b0fc069aba5ce1b', '::1', 1506140679, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363134303538393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('28f32ae62e88aec9c1825a94e3f6251d8b13d5a6', '::1', 1505988420, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938383239323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2963afbc311cc6bfb903cb1dd87689419c9ff151', '::1', 1506070438, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037303238323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('2a48e16f5bcd850517aa0820dedefe960ba20dab', '::1', 1506054078, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035333838323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('2bec80a8e3c287954e818d89767e53b427cc2816', '::1', 1505899254, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839383935353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2c2d44c9f23be9f2851b1c9fad7facf53ed33ef3', '::1', 1506076386, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037363338363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('2c55c00f3775980e05dc4d17276b44871f71f2bf', '::1', 1506138774, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133383439383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226f425039373632515768774a4b667a334930546a223b),
('2d0fe7372986d04114881837e29004ca0f3fc3fa', '::1', 1505903154, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930333131313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('2d4435d8fc17da133a432b97c026b53e7a806c08', '::1', 1505893750, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839333435313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2fe915f641e41202fe3e610a6ca05dc57f98bb15', '::1', 1506074770, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037343632343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('32bced5af626b659d69ff5ebe409ac8ef2cae958', '::1', 1506069235, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036393035323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('35b8e6a0ba8d598f3c302683459db794b4bdb38e', '::1', 1506063406, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036333233353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('3972dfbb2da0013febbcb8bbecf0ec3bcf154656', '::1', 1506066180, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036363039313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('3b82cd3cb9a64585fe1942019cfc29c7e608afdb', '::1', 1505986982, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938363734363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3bbd9164f547f1852f083d4ba81a1cb4aadc0c67', '::1', 1505898907, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839383537343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3d0ea13e174c20804697bd14c76928be988ea686', '::1', 1506133710, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133333435333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3e66da17f6b748725271a296a6a55069eb91a858', '::1', 1505901280, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930303936383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('3e93f8eae4076ba5a43d941d01d0c3f46b84c0d2', '::1', 1506074384, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037343233363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('3edfd69e92764e6cc2630549eba16f7f118b0808', '::1', 1506136118, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133363131373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('41143b97ff70f5a61df348138f4d3417db934de6', '::1', 1506134203, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133333933393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('41f0b7c836c243e7b9e6c7afd58b69b7cb98bddb', '::1', 1506055106, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035353039323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('42c4d0c35290df13f67d584d93b2ab3d7b7b7fa6', '::1', 1506073144, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037323837343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('44b5c66e0bf3470d0b4a6a75ca70f5d7e1cb023a', '::1', 1505985963, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938353834313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('44e85a8b284385f8746123fcee34110e240c5f15', '::1', 1506141785, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363134313530333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('458dfb5f65f44ad1b1ae3ba2c2b6ee19c1b798d7', '::1', 1505989304, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938383936343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('48bdb0b434e2c7652b7490bf3ee5f1241ef56a19', '::1', 1506062405, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036323430343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('498384f99f8072965319d667b664157a9673780f', '::1', 1506073206, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037333230353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('4e78ec090442aff19a47989a5b005ac2c1ca8c04', '::1', 1505981875, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938313539363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4fac227ad4e5e51e36bfacdc0589010301fa08b9', '::1', 1506133035, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133323833363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('52152a3d501b2f185e0ac586cd788aa23bdfdce4', '::1', 1506075931, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037353733313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('540bd708bbadcfc5df6feead33f8db8322bad90f', '::1', 1506048106, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034373832333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('559009156cfbb948f24a930b8d0acf2e4b85c566', '::1', 1506140138, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133393933323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('55d7e9a13a3c7a925858d3af0e14f5651c3ef24c', '::1', 1505893441, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839333135303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('56c4c3bc62f3f89681a5d8d9b09dfd5c35b4f45e', '::1', 1505892317, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839323031303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('5852764b44fc4387d6adc6c17a072bdc6024e2d6', '::1', 1505976625, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937363332363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5996a0ecfb874f20cf4cdfe332fb835118000f37', '::1', 1506067228, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036373035313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('5b06125149b78b68a08746a7c17494e5da2bfa88', '::1', 1506053878, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035333431303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('5b4e850469d604cea139a6f37a52359f6ba6e915', '::1', 1505890787, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839303436373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5d2cd57237e84e7455dd75318e904d2092a3676f', '::1', 1506130378, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133303038323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5dfe10b1b774734ee9c568b87b6dc20a3563bada', '::1', 1505901847, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930313734373b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('61a06444d93233c937dfce62578b7fb9ceb7ff78', '::1', 1506050089, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034393933303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('624a7b982b0bcdb76ed9e023e19dde4291c8899a', '::1', 1506136816, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133363535323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6479ca72fa4841197edaf03d8b5eec3f2611b09d', '::1', 1505889661, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838393432393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('65e7ddae4c8767c7fa1f183c46d9748e99f02e2c', '::1', 1505890272, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839303036343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('66da648141ffba028dea65fb4641c61a631bdac2', '::1', 1505900631, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930303332393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('670c65228a1d87e3f33285455adef80198e22543', '::1', 1506132494, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133323139353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6964908795cb8c834a74b1faae0ab4d48032e214', '::1', 1506134726, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133343332333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6993dcc298e6ea4f366e7a3ed58278e63fb84ab5', '::1', 1506131596, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133313338373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6a41caf1524a864ef83b6a4958c5ad0595a09306', '::1', 1505989845, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938393635333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6c39606a51360a2beff54ca39e26ed9053e5fd16', '::1', 1506072419, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037323231343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('6cc63bfd14a0b01f8f741761f9239f11b1c17ba9', '::1', 1506045095, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034343833383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6fcf84c4a8b1e28bb0ce5761123b4b5399a315cb', '::1', 1505976933, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937363634373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('70078d5850c74a598fd4f957f13923ab207a5de0', '::1', 1505891856, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839313537363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('711caa601861d5bf2d952b36be1652e3245c2ae0', '::1', 1506055835, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035353535353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('731781d021ae63c8c3ce74c2ccb0d6e23f426441', '::1', 1506135080, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133353033393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('74b46b09f444aa3034f0aee8966b4257d29eca4d', '::1', 1506056615, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035363331383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('74bc17c4e796292a53a86a9d3be17ce89e95de2a', '::1', 1506066084, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036343535353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('75e5328c41bb84f188215b53057d28ef34aba1ae', '::1', 1506137179, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133373035383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7669d6f321e329d2495da2350b0e6135f2d051ab', '::1', 1505985197, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938353139343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('79d34e117518a0c4d8d776b511dd31bf911be8fc', '::1', 1505891230, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839313133323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7a8172dae502b131b851a7fe642ca6a8cb55bd23', '::1', 1506064550, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036343232393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('7ce005519e4b1cb3a345394bd6f07247cee39cc5', '::1', 1506138133, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133373738363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7d6803b1570319c56b26df2fc77148b5c89f5b5f', '::1', 1505897380, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839373130373b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7e5ba0fd0fa91dee1a74507df93d54da30d31f26', '::1', 1506068984, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036383730343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('7e8554b1f901cb1d1001cad2781af8e621ce9966', '::1', 1506047508, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034373434323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7f5be542b0a3ce55d347551bed2663f97b59f88f', '::1', 1506068507, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036383335393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('81c3816b426efaec8456a6744f69d581f847f7fd', '::1', 1505884291, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838343130313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('843ba74d684d34dfdd0f1773bacfae815df6bef7', '::1', 1506135542, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133353338373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('973866e99f5c04f5dffcb0b23edea8fa398eeea8', '::1', 1506132823, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133323530383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9793ba819a5ff6b0f56f3002a21ef8fd9cf2ce46', '::1', 1506043688, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034333339303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('994b5468a62cb7c4811fa76611ea07ef1eb59c93', '::1', 1505902992, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930323736323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('9d56dcc0c1b44ec29f87c0ae16077adb10da22cf', '::1', 1506071159, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037303934353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('9f7fc695ae111336f170bc020eadf9dd6126d060', '::1', 1506134904, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133343733363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a33383a2243e1baad70206e68e1baad74206769616920c4916fe1baa16e207468c3a06e682063c3b46e67223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('9fe55a7ad1aefe65773cfbe01d862bdb5e431086', '::1', 1506072673, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037323537313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('a0f19e012132c92a016e66b4b8ea5e28aea4db57', '::1', 1506057000, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035363633353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('a13fe9cb6670b829ea94ce5c2c13686f37eb77b1', '::1', 1506139410, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133393133363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('a1ec22f6b345bf7044e03a1d51e335c83f94c1c9', '::1', 1505890056, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838393734383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a438b934e3cc6b84469dfd4d1cd08bc4d35a60c5', '::1', 1506063833, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036333534363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('a5a81a8ed04cfd027381e41a0f085515c1f887c6', '::1', 1505899961, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839393636323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('a5ce76ca2e8b14766f96b3129c41a105116425cc', '::1', 1506054509, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035343232343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('a656db84d80a70d77de42947854d1c022f2338fa', '::1', 1505980606, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938303439383b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a75b4f962939ef1f7e8f90e5a38531304843684c', '::1', 1506042409, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034323335393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a77e142318147ebc69fb1ce653b777ba911d3919', '::1', 1505977932, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937373633333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a7f53c1251665d084dc568ab215a18341d99f10d', '::1', 1505980081, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937393735393b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a838e7873b73d5e1ddff8ee40a471dba6218f298', '::1', 1506048274, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034383132373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ab5c517b711e09e3856a8fd3cc901407a177143b', '::1', 1505894246, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839343037363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('abb25c585df7a6305dbc09a7db570576c052a6f6', '::1', 1505986724, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938363434323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ac67a30625b4fd47961e7ab3c9abc7f5fd17e8ee', '::1', 1506047375, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034373039393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('acc39c36d26268a224a9a77028d2de7e7308f766', '::1', 1506131079, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133303935343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ae7ef74f08ff6356cddb72f1acdc9821e9684a4d', '::1', 1505898104, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839373833343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('afa8888b994ad32d3cc41e97a6a2de6b89686a01', '::1', 1505982611, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938323431313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a33383a2243e1baad70206e68e1baad74206769616920c4916fe1baa16e207468c3a06e682063c3b46e67223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('b21953c0784731eff183ee6924ffa45abfd12426', '::1', 1505892902, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839323637373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b3f2297e2f6356582acd0780b3019a9184d38345', '::1', 1506128705, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363132383635333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b4c66bb5f31961c47ee3045cf285d20e11859350', '::1', 1506138319, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133383134363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226f425039373632515768774a4b667a334930546a223b),
('b772e59a35fe3b43338269552e7927d331ef8171', '::1', 1505897723, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839373436343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b9d225585899a8888e9ad394de24146ab3c7277e', '::1', 1506133423, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133333134323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b9e45ae86f63a780a2b0b7ea1b6c8adbbed901bd', '::1', 1505981211, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938303937303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('baf5c84f624177780c918ef8b89c95d550161d57', '::1', 1506049007, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363034383734373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bb7b61273c2933d7ab335da17c0ce8723dc38407', '::1', 1505987315, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938373036313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('bbba82a4784b916a971c6e9d60a9f2c50d4bad40', '::1', 1506139607, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133393437313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('bc214a5176ca22b15530462fd7d2e664896d8510', '::1', 1506051277, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035303938313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bd88e5923b3238271c201fe7c71c39dbee0e81fa', '::1', 1505984151, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938333937363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('be7e6124c9b6a920c38502968c26f873f8e3be95', '::1', 1506075263, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037343936303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('bf8ba7b77701404cb630d2e7235eef8acc589375', '::1', 1505892624, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839323334333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c283d7cab107d291c59dec43f7f88a6123b03561', '::1', 1506062853, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036323738303b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('c307f860a6a447bb9fd939a7d88c70ce1699fec0', '::1', 1505975316, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937353034323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c564672bdd5317e110c246964c759e2fcdb6ce22', '::1', 1506054895, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035343633343b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('c5e0053a7df798a175efe07c3b739ddd96d57d67', '::1', 1505979656, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937393431353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c718f8ed6094cea80dd30783a1877c49a8103774', '::1', 1506051892, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035313238323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c8d8393e0c124f78d8df8a9898f2fed15db0c357', '::1', 1506070832, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037303630353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('cada44c9a9b588de35225755131629ae700635b3', '::1', 1505895569, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839353533333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('cbbb5f50df76cf7f70620d53cdaf27b512fc9fe0', '::1', 1506052008, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035313933353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('cc3f3d6e630d5ddf7ca0b63b936316146652b52f', '::1', 1506050634, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035303237353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ccdc9d11d8a1ce243b3f3ec1c572cb8352fe4136', '::1', 1506139070, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133383831363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226f425039373632515768774a4b667a334930546a223b),
('ce96c817787ea061e7f39f66ca68831e1c4fb769', '::1', 1505982252, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938323038303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d2e53b4bae91fd24c402c1b080e076c8811286cd', '::1', 1505984719, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938343436383b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d3d65151e2169abd84a4ccc93ec8e19a6c4793f1', '::1', 1505899589, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353839393236333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d4e66230d93267b905c16a32b64d5463bf25a708', '::1', 1506142069, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363134323032323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('d5d5494e7091fb6a5a1e8c22c55f0031df91bc5a', '::1', 1506069677, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036393436323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('d693120c0e4a7a5d05da7dde624964496fbeeab0', '::1', 1506064222, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036333932313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('df0dcbc50ae25acac0d2aa978db616ab0de132ef', '::1', 1505889424, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838393030333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e079944596dfb3d9fc199ea1f4a3df2356d037c3', '::1', 1505988928, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938383633393b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e29845b559a51337f169c0c3bf0e0a9fa385b458', '::1', 1506066719, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363036363438363b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('e369f29186b7f272a2efbcc3f0767801fbd60d10', '::1', 1506132042, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133313739323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e393f8231bb8d8c0ec9acb96ad343b4579d25ee4', '::1', 1505987789, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353938373434393b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e468f6dcf2c75411ea1e19e23a0354518e054169', '::1', 1505900283, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353930303031323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035383639323136223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22764f7356344948396c55703844454d6950625435223b72656d6f76655f706f6c73737c693a313b),
('e828a429750b7688e2c873dceed111bd6026e6ff', '::1', 1506076851, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037363731333b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('e9791d7a8faba75f08368e38f730c05f57751661', '::1', 1506130945, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133303633393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eae17ea40646354aaa9bda162591b55bc590e72d', '::1', 1506073886, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037333538373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('ee842334275c04f7d241dd0553b89c3b5e51d49a', '::1', 1505977438, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937373331303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f3be6c53fccae8b7fe6d162055a74143ca5ad5a3', '::1', 1506052974, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035323834323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('f4bdd4ab507b85249d1c74316976ca8702c4f109', '::1', 1506072123, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363037313839373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('f608675f86fe986f8530cc18854048bc78d034dc', '::1', 1506129770, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363132393736353b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fa53b6f9d43950221976207a04a12648ae3dcbfc', '::1', 1506144879, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363134343837323b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2255467a773079616b473641726275536569485066223b),
('fb92acfcc9b02a0d45fe8b67d080e85d1f2547b7', '::1', 1505884481, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838343435313b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fcc8cf8bdd3b4524c4d8a065946d535f6c65ff64', '::1', 1505979025, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353937383634363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fefd3e77c3286ed3f4f483b843a19b9add3d1431', '::1', 1506055993, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363035353835393b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035393735303636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313530363035323533303b),
('ff68d3303e2ec6f84943443e7492c706122c138f', '::1', 1505883797, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530353838333738373b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353035373833343137223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ffc4eed41bb045024660f8971c1f64b143051b22', '::1', 1506136090, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530363133353830383b7265717565737465645f706167657c733a383a2270726f6475637473223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353036303432333636223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_settings`
--

CREATE TABLE `sma_settings` (
  `setting_id` int(1) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `logo2` varchar(255) NOT NULL,
  `site_name` varchar(55) NOT NULL,
  `language` varchar(20) NOT NULL,
  `default_warehouse` int(2) NOT NULL,
  `accounting_method` tinyint(4) NOT NULL DEFAULT '0',
  `default_currency` varchar(3) NOT NULL,
  `default_tax_rate` int(2) NOT NULL,
  `rows_per_page` int(2) NOT NULL,
  `version` varchar(10) NOT NULL DEFAULT '1.0',
  `default_tax_rate2` int(11) NOT NULL DEFAULT '0',
  `dateformat` int(11) NOT NULL,
  `sales_prefix` varchar(20) DEFAULT NULL,
  `quote_prefix` varchar(20) DEFAULT NULL,
  `purchase_prefix` varchar(20) DEFAULT NULL,
  `transfer_prefix` varchar(20) DEFAULT NULL,
  `delivery_prefix` varchar(20) DEFAULT NULL,
  `payment_prefix` varchar(20) DEFAULT NULL,
  `return_prefix` varchar(20) DEFAULT NULL,
  `expense_prefix` varchar(20) DEFAULT NULL,
  `item_addition` tinyint(1) NOT NULL DEFAULT '0',
  `theme` varchar(20) NOT NULL,
  `product_serial` tinyint(4) NOT NULL,
  `default_discount` int(11) NOT NULL,
  `product_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_method` tinyint(4) NOT NULL,
  `tax1` tinyint(4) NOT NULL,
  `tax2` tinyint(4) NOT NULL,
  `overselling` tinyint(1) NOT NULL DEFAULT '0',
  `restrict_user` tinyint(4) NOT NULL DEFAULT '0',
  `restrict_calendar` tinyint(4) NOT NULL DEFAULT '0',
  `timezone` varchar(100) DEFAULT NULL,
  `iwidth` int(11) NOT NULL DEFAULT '0',
  `iheight` int(11) NOT NULL,
  `twidth` int(11) NOT NULL,
  `theight` int(11) NOT NULL,
  `watermark` tinyint(1) DEFAULT NULL,
  `reg_ver` tinyint(1) DEFAULT NULL,
  `allow_reg` tinyint(1) DEFAULT NULL,
  `reg_notification` tinyint(1) DEFAULT NULL,
  `auto_reg` tinyint(1) DEFAULT NULL,
  `protocol` varchar(20) NOT NULL DEFAULT 'mail',
  `mailpath` varchar(55) DEFAULT '/usr/sbin/sendmail',
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_user` varchar(100) DEFAULT NULL,
  `smtp_pass` varchar(255) DEFAULT NULL,
  `smtp_port` varchar(10) DEFAULT '25',
  `smtp_crypto` varchar(10) DEFAULT NULL,
  `corn` datetime DEFAULT NULL,
  `customer_group` int(11) NOT NULL,
  `default_email` varchar(100) NOT NULL,
  `mmode` tinyint(1) NOT NULL,
  `bc_fix` tinyint(4) NOT NULL DEFAULT '0',
  `auto_detect_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `captcha` tinyint(1) NOT NULL DEFAULT '1',
  `reference_format` tinyint(1) NOT NULL DEFAULT '1',
  `racks` tinyint(1) DEFAULT '0',
  `attributes` tinyint(1) NOT NULL DEFAULT '0',
  `product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `decimals` tinyint(2) NOT NULL DEFAULT '2',
  `decimals_sep` varchar(2) NOT NULL DEFAULT '.',
  `thousands_sep` varchar(2) NOT NULL DEFAULT ',',
  `invoice_view` tinyint(1) DEFAULT '0',
  `default_biller` int(11) DEFAULT NULL,
  `envato_username` varchar(50) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT NULL,
  `rtl` tinyint(1) DEFAULT '0',
  `each_spent` decimal(15,4) DEFAULT NULL,
  `ca_point` tinyint(4) DEFAULT NULL,
  `each_sale` decimal(15,4) DEFAULT NULL,
  `sa_point` tinyint(4) DEFAULT NULL,
  `update` tinyint(1) DEFAULT '0',
  `sac` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_settings`
--

INSERT INTO `sma_settings` (`setting_id`, `logo`, `logo2`, `site_name`, `language`, `default_warehouse`, `accounting_method`, `default_currency`, `default_tax_rate`, `rows_per_page`, `version`, `default_tax_rate2`, `dateformat`, `sales_prefix`, `quote_prefix`, `purchase_prefix`, `transfer_prefix`, `delivery_prefix`, `payment_prefix`, `return_prefix`, `expense_prefix`, `item_addition`, `theme`, `product_serial`, `default_discount`, `product_discount`, `discount_method`, `tax1`, `tax2`, `overselling`, `restrict_user`, `restrict_calendar`, `timezone`, `iwidth`, `iheight`, `twidth`, `theight`, `watermark`, `reg_ver`, `allow_reg`, `reg_notification`, `auto_reg`, `protocol`, `mailpath`, `smtp_host`, `smtp_user`, `smtp_pass`, `smtp_port`, `smtp_crypto`, `corn`, `customer_group`, `default_email`, `mmode`, `bc_fix`, `auto_detect_barcode`, `captcha`, `reference_format`, `racks`, `attributes`, `product_expiry`, `decimals`, `decimals_sep`, `thousands_sep`, `invoice_view`, `default_biller`, `envato_username`, `purchase_code`, `rtl`, `each_spent`, `ca_point`, `each_sale`, `sa_point`, `update`, `sac`) VALUES
(1, 'logo2.png', 'logo4.png', 'PHẦN MỀM SẢN XUẤT FOSO', 'vietnamese', 1, 0, 'VND', 1, 10, '3.0.1.13', 1, 5, 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'ENQUERY', '', 0, 'default', 1, 1, 1, 1, 1, 1, 0, 1, 0, 'Asia/Singapore', 800, 800, 60, 60, 0, 0, 1, 1, NULL, 'smtp', '/usr/sbin/sendmail', 'smtp.gmail.com', 'tvtan06@gmail.com', 'YsP4gkjL9Zz1vc9l7VMgQJf3Gdk50l2/OeQaIfwlxgEiQb8FCkN6YpH1zlo75jioQw0xedhtKTErXNjf1Fv4Tg==', '587', 'tls', NULL, 1, 'tvtan06@gmail.com', 0, 4, 1, 0, 2, 1, 1, 0, 3, '.', ',', 0, 3, 'StockManager', '3', 0, NULL, NULL, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_skrill`
--

CREATE TABLE `sma_skrill` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL DEFAULT 'testaccount2@moneybookers.com',
  `secret_word` varchar(20) NOT NULL DEFAULT 'mbtest',
  `skrill_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_skrill`
--

INSERT INTO `sma_skrill` (`id`, `active`, `account_email`, `secret_word`, `skrill_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'testaccount2@moneybookers.com', 'mbtest', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_subcategories`
--

CREATE TABLE `sma_subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_suspended_bills`
--

CREATE TABLE `sma_suspended_bills` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `suspend_note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_suspended_items`
--

CREATE TABLE `sma_suspended_items` (
  `id` int(11) NOT NULL,
  `suspend_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_tax_rates`
--

CREATE TABLE `sma_tax_rates` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_tax_rates`
--

INSERT INTO `sma_tax_rates` (`id`, `name`, `code`, `rate`, `type`) VALUES
(1, 'No Tax', 'NT', '0.0000', '2'),
(2, 'VAT @10%', 'VAT10', '10.0000', '1'),
(3, 'GST @6%', 'GST', '6.0000', '1'),
(4, 'VAT @20%', 'VT20', '20.0000', '1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_transfers`
--

CREATE TABLE `sma_transfers` (
  `id` int(11) NOT NULL,
  `transfer_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_warehouse_id` int(11) NOT NULL,
  `from_warehouse_code` varchar(55) NOT NULL,
  `from_warehouse_name` varchar(55) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `to_warehouse_code` varchar(55) NOT NULL,
  `to_warehouse_name` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `grand_total` decimal(25,4) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `status` varchar(55) NOT NULL DEFAULT 'pending',
  `shipping` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_transfer_items`
--

CREATE TABLE `sma_transfer_items` (
  `id` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `quantity_balance` decimal(15,4) NOT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_units`
--

CREATE TABLE `sma_units` (
  `id` int(10) NOT NULL,
  `unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_units`
--

INSERT INTO `sma_units` (`id`, `unit`, `note`) VALUES
(1, 'Cái', ''),
(2, 'Bao', NULL),
(3, 'Hộp', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_users`
--

CREATE TABLE `sma_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `last_ip_address` varbinary(45) DEFAULT NULL,
  `ip_address` varbinary(45) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(55) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `warehouse_id` int(10) UNSIGNED DEFAULT NULL,
  `biller_id` int(10) UNSIGNED DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `show_cost` tinyint(1) DEFAULT '0',
  `show_price` tinyint(1) DEFAULT '0',
  `award_points` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_users`
--

INSERT INTO `sma_users` (`id`, `last_ip_address`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `avatar`, `gender`, `group_id`, `warehouse_id`, `biller_id`, `company_id`, `show_cost`, `show_price`, `award_points`) VALUES
(1, 0x3a3a31, 0x0000, 'owner', '2c8ab736b2ccab4f50e72d5fd7d21020cbb77ae7', NULL, 'owner@google.com', NULL, NULL, NULL, '6e5e2f4c47ba10736e92891840965955f42f6f45', 1351661704, 1506128656, 1, 'Owner', 'Owner', 'Stock Manager', '012345678', NULL, 'male', 1, NULL, NULL, NULL, 0, 0, 0),
(2, 0x3a3a31, 0x3a3a31, 'tvtan06@gmail.com', 'cbe0b4851e0807748576e22fa8dc689134c78e07', NULL, 'tvtan06@gmail.com', NULL, NULL, NULL, NULL, 1497862980, 1497921746, 1, 'Tran', 'Tan', 'Foso', '097449157', NULL, 'male', 5, 1, 3, NULL, 0, 0, 0),
(3, NULL, 0x3a3a31, 'trantan', 'b9ce6ed6f53be863a43bf1cc04ae0451b394ed2a', NULL, 'trantan@gmail.com', NULL, NULL, NULL, NULL, 1498007958, 1498007958, 1, 'Tran', 'Tan', 'Walk-in Customer', '0939701693', NULL, 'male', 3, NULL, NULL, 1, 0, 0, 0),
(4, 0x3a3a31, 0x3a3a31, 'hva', '5c3341c973e77a19ee084a2c3496350eb94e03e3', NULL, 'hva@gmail.com', NULL, NULL, NULL, 'a4c9b2616656b62a26ab1f31d851600ceef11fe5', 1498009590, 1498093480, 1, 'fdgdf', 'dfgbf', 'Yanstore', '6786', NULL, 'male', 3, NULL, NULL, 2, 0, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_user_logins`
--

CREATE TABLE `sma_user_logins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_user_logins`
--

INSERT INTO `sma_user_logins` (`id`, `user_id`, `company_id`, `ip_address`, `login`, `time`) VALUES
(1, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-10-26 08:48:42'),
(2, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-11-01 12:37:11'),
(3, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-11-01 12:40:30'),
(4, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-11-02 20:04:13'),
(5, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-11-02 20:12:23'),
(6, 1, NULL, 0x3132372e302e302e31, 'owner@google.com', '2016-11-02 20:15:46'),
(7, 1, NULL, 0x312e32332e342e36, 'owner@google.com', '2017-03-15 14:12:00'),
(8, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-19 04:59:10'),
(9, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-19 05:01:41'),
(10, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-19 05:56:19'),
(11, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-19 05:59:56'),
(12, 1, NULL, 0x3131332e3136312e37342e313939, 'owner@google.com', '2017-03-19 06:17:11'),
(13, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-21 02:31:35'),
(14, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-21 02:36:06'),
(15, 1, NULL, 0x3131372e362e35382e323338, 'owner@google.com', '2017-03-21 06:40:24'),
(16, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-21 06:41:20'),
(17, 1, NULL, 0x32372e37342e3234312e3533, 'owner@google.com', '2017-03-22 04:45:49'),
(18, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-03-22 04:58:48'),
(19, 1, NULL, 0x312e35322e3138302e313738, 'owner@google.com', '2017-03-23 09:16:04'),
(20, 1, NULL, 0x3131372e362e35382e323338, 'owner@google.com', '2017-03-23 09:16:25'),
(21, 1, NULL, 0x32372e36372e34312e313835, 'owner@google.com', '2017-03-24 02:53:45'),
(22, 1, NULL, 0x3138332e38312e34352e313436, 'owner@google.com', '2017-03-24 15:41:09'),
(23, 1, NULL, 0x3138332e38312e34352e313436, 'owner@google.com', '2017-03-26 03:42:54'),
(24, 1, NULL, 0x35382e3138362e32332e3234, 'owner@google.com', '2017-03-29 13:24:10'),
(25, 1, NULL, 0x3131332e3139302e3130342e323334, 'owner@google.com', '2017-03-29 13:24:54'),
(26, 1, NULL, 0x35382e3138362e32332e3234, 'owner@google.com', '2017-03-29 13:34:59'),
(27, 1, NULL, 0x35382e3138372e3233322e313936, 'owner@google.com', '2017-03-29 14:19:49'),
(28, 1, NULL, 0x35382e3138372e3233322e313936, 'owner@google.com', '2017-03-29 14:19:49'),
(29, 1, NULL, 0x3131332e3139302e3130342e323334, 'owner@google.com', '2017-03-29 18:02:36'),
(30, 1, NULL, 0x3131332e3139302e3130342e323334, 'owner@google.com', '2017-03-29 18:56:27'),
(31, 1, NULL, 0x32372e37372e3132352e323236, 'owner@google.com', '2017-03-30 12:27:43'),
(32, 1, NULL, 0x31342e3136352e3231392e3238, 'owner@google.com', '2017-03-31 07:11:48'),
(33, 1, NULL, 0x34322e3131392e3134382e323037, 'owner@google.com', '2017-03-31 09:24:06'),
(34, 1, NULL, 0x34322e3131392e3134382e323037, 'owner@google.com', '2017-04-01 07:26:41'),
(35, 1, NULL, 0x3137312e3233342e3231382e3835, 'owner@google.com', '2017-04-02 03:22:52'),
(36, 1, NULL, 0x3137312e3233342e3231382e3835, 'owner@google.com', '2017-04-02 03:23:20'),
(37, 1, NULL, 0x3137312e3233342e3231382e3835, 'owner@google.com', '2017-04-02 03:25:09'),
(38, 1, NULL, 0x312e35352e3234322e313635, 'owner@google.com', '2017-04-03 02:25:05'),
(39, 1, NULL, 0x3131372e362e3136322e38, 'owner@google.com', '2017-04-03 06:47:52'),
(40, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-04-04 03:50:28'),
(41, 1, NULL, 0x3132302e37322e3130362e313134, 'owner@google.com', '2017-04-05 02:45:37'),
(42, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-04-05 03:01:13'),
(43, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-04-07 07:05:02'),
(44, 1, NULL, 0x3131332e3136332e3234352e313037, 'owner@google.com', '2017-04-09 08:20:54'),
(45, 1, NULL, 0x3131332e3136332e3234352e313037, 'owner@google.com', '2017-04-09 09:01:45'),
(46, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-04-10 05:49:36'),
(47, 1, NULL, 0x3131352e37372e3138342e313338, 'owner@google.com', '2017-04-10 05:52:47'),
(48, 1, NULL, 0x3132332e32312e3232382e3230, 'owner@google.com', '2017-04-10 09:17:22'),
(49, 1, NULL, 0x3132332e32312e3232382e3230, 'owner@google.com', '2017-04-11 01:57:09'),
(50, 1, NULL, 0x3137312e3233342e3233362e3834, 'owner@google.com', '2017-04-11 02:10:56'),
(51, 1, NULL, 0x3132332e32312e3232382e3230, 'owner@google.com', '2017-04-11 06:20:26'),
(52, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-19 06:08:02'),
(53, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-19 07:30:32'),
(54, 2, NULL, 0x3a3a31, 'tvtan06@gmail.com', '2017-06-20 01:22:27'),
(55, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-20 01:22:51'),
(56, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-21 01:05:55'),
(57, 4, NULL, 0x3a3a31, 'hva@gmail.com', '2017-06-22 01:04:40'),
(58, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-22 01:04:53'),
(59, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-23 01:30:08'),
(60, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-23 03:18:06'),
(61, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-23 07:07:28'),
(62, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-24 01:09:27'),
(63, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-26 01:30:04'),
(64, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-27 04:11:08'),
(65, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-28 01:17:36'),
(66, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-06-29 09:44:01'),
(67, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-01 02:59:49'),
(68, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-02 01:56:19'),
(69, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-02 08:33:46'),
(70, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-02 10:06:59'),
(71, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-03 01:10:50'),
(72, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-03 02:42:55'),
(73, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-04 02:50:26'),
(74, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-05 04:05:56'),
(75, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-05 07:17:01'),
(76, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-05 08:40:00'),
(77, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-06 01:07:58'),
(78, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-07 01:22:13'),
(79, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-07 07:40:38'),
(80, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-07 08:50:20'),
(81, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-08 01:05:09'),
(82, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-08 01:07:12'),
(83, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-13 07:09:56'),
(84, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-14 01:22:00'),
(85, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-15 01:18:41'),
(86, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-15 05:31:47'),
(87, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-17 01:23:06'),
(88, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-17 02:57:19'),
(89, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-17 03:00:06'),
(90, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-18 01:31:43'),
(91, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-18 04:15:29'),
(92, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-18 04:18:41'),
(93, 1, NULL, 0x3139322e3136382e312e34, 'owner@google.com', '2017-07-18 09:43:20'),
(94, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-19 01:29:24'),
(95, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-19 07:20:10'),
(96, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-20 01:40:27'),
(97, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-20 04:19:48'),
(98, 1, NULL, 0x3139322e3136382e312e37, 'owner@google.com', '2017-07-20 07:22:54'),
(99, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-20 07:42:51'),
(100, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-21 01:18:06'),
(101, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-22 01:26:26'),
(102, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 04:19:02'),
(103, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 04:23:00'),
(104, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 04:36:47'),
(105, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 04:54:55'),
(106, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 05:06:41'),
(107, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-07-24 05:09:31'),
(108, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 06:56:16'),
(109, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 06:56:22'),
(110, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 06:56:32'),
(111, 1, NULL, 0x3139322e3136382e312e38, 'owner@google.com', '2017-07-24 07:23:34'),
(112, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 07:23:44'),
(113, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 07:24:03'),
(114, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-27 03:28:34'),
(115, 1, NULL, 0x3139322e3136382e312e33, 'owner@google.com', '2017-08-27 03:53:54'),
(116, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-28 01:17:46'),
(117, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-29 01:19:28'),
(118, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-30 01:14:46'),
(119, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-31 01:22:32'),
(120, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-11 01:18:14'),
(121, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-12 01:12:26'),
(122, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-13 01:10:20'),
(123, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-14 01:29:30'),
(124, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-15 01:05:16'),
(125, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-16 00:57:49'),
(126, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-18 01:00:43'),
(127, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-19 01:10:17'),
(128, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-20 01:00:16'),
(129, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-20 08:18:59'),
(130, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-21 06:24:26'),
(131, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-21 06:24:27'),
(132, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-22 01:06:06'),
(133, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-09-23 01:04:16');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_variants`
--

CREATE TABLE `sma_variants` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `percent` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_variants`
--

INSERT INTO `sma_variants` (`id`, `name`, `percent`) VALUES
(1, 'Ra phôi', 10),
(2, 'Uốn nhấn', 10),
(3, 'Tạo lỗ', 15),
(4, 'Cắt góc', 5),
(5, 'Gá hàn', 30),
(6, 'VS-Giao mạ', 5),
(7, 'Mạ kẽm', 20),
(8, 'ĐK & Giao hàng', 5);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_warehouses`
--

CREATE TABLE `sma_warehouses` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `map` varchar(255) DEFAULT NULL,
  `phone` varchar(55) DEFAULT NULL,
  `email` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_warehouses`
--

INSERT INTO `sma_warehouses` (`id`, `code`, `name`, `address`, `map`, `phone`, `email`) VALUES
(1, 'WHI', 'Kho 1', '<p>Address, City</p>', NULL, '012345678', 'whi@google.com'),
(2, 'WHII', 'Kho 2', '<p>HCM</p>', NULL, '0939701693', 'tvtan06@gmail.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_warehouses_products`
--

CREATE TABLE `sma_warehouses_products` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_warehouses_products`
--

INSERT INTO `sma_warehouses_products` (`id`, `product_id`, `item_id`, `warehouse_id`, `quantity`, `rack`) VALUES
(12, NULL, 4, 1, '100.0000', NULL),
(13, NULL, 5, 1, '1340.0000', NULL),
(14, NULL, 5, 2, '-70.0000', NULL),
(15, NULL, 2, 1, '-100.0000', NULL),
(16, NULL, 3, 2, '0.0000', NULL),
(19, 3, NULL, 1, '0.0000', NULL),
(20, 2, NULL, 1, '0.0000', NULL),
(21, 4, NULL, 1, '0.0000', NULL),
(22, 5, NULL, 1, '0.0000', NULL),
(23, 1, NULL, 1, '0.0000', NULL),
(24, 2147483647, NULL, 1, '0.0000', NULL),
(25, 2147483647, NULL, 1, '0.0000', NULL),
(26, 7, NULL, 1, '0.0000', NULL),
(27, 8, NULL, 1, '0.0000', NULL),
(28, 9, NULL, 1, '0.0000', NULL),
(29, NULL, 3, 1, '10.0000', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_warehouses_products_variants`
--

CREATE TABLE `sma_warehouses_products_variants` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_working_places`
--

CREATE TABLE `sma_working_places` (
  `id` int(10) NOT NULL,
  `working_place` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_working_places`
--

INSERT INTO `sma_working_places` (`id`, `working_place`, `phone`, `address`, `note`) VALUES
(27, 'Xuong 1', '1234567890', 'HCM', ''),
(29, 'Xuong 2', '', '', ''),
(30, 'Xuong 3', '', '', ''),
(31, 'Xuong 4', '', '', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_working_place_items`
--

CREATE TABLE `sma_working_place_items` (
  `id` int(11) NOT NULL,
  `working_place_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sma_working_place_items`
--

INSERT INTO `sma_working_place_items` (`id`, `working_place_id`, `machine_id`) VALUES
(124, 29, 5),
(125, 29, 4),
(126, 30, 2),
(127, 30, 10),
(128, 30, 6),
(129, 27, 1),
(130, 31, 3),
(131, 31, 9),
(132, 31, 7),
(133, 31, 8);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_calendar`
--
ALTER TABLE `sma_calendar`
  ADD PRIMARY KEY (`date`);

--
-- Chỉ mục cho bảng `sma_captcha`
--
ALTER TABLE `sma_captcha`
  ADD PRIMARY KEY (`captcha_id`),
  ADD KEY `word` (`word`);

--
-- Chỉ mục cho bảng `sma_categories`
--
ALTER TABLE `sma_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_companies`
--
ALTER TABLE `sma_companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `group_id_2` (`group_id`);

--
-- Chỉ mục cho bảng `sma_costing`
--
ALTER TABLE `sma_costing`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_currencies`
--
ALTER TABLE `sma_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_date_format`
--
ALTER TABLE `sma_date_format`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_expenses`
--
ALTER TABLE `sma_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_no` (`card_no`);

--
-- Chỉ mục cho bảng `sma_groups`
--
ALTER TABLE `sma_groups`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_items`
--
ALTER TABLE `sma_items`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_labor_norms`
--
ALTER TABLE `sma_labor_norms`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_log_productions`
--
ALTER TABLE `sma_log_productions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_machine`
--
ALTER TABLE `sma_machine`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_machinery_norms`
--
ALTER TABLE `sma_machinery_norms`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_machine_categories`
--
ALTER TABLE `sma_machine_categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_material_norms`
--
ALTER TABLE `sma_material_norms`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_notifications`
--
ALTER TABLE `sma_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  ADD PRIMARY KEY (`ref_id`);

--
-- Chỉ mục cho bảng `sma_payments`
--
ALTER TABLE `sma_payments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_paypal`
--
ALTER TABLE `sma_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_permissions`
--
ALTER TABLE `sma_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_pos_settings`
--
ALTER TABLE `sma_pos_settings`
  ADD PRIMARY KEY (`pos_id`);

--
-- Chỉ mục cho bảng `sma_productions`
--
ALTER TABLE `sma_productions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_production_deliveries`
--
ALTER TABLE `sma_production_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_production_items`
--
ALTER TABLE `sma_production_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Chỉ mục cho bảng `sma_production_stages`
--
ALTER TABLE `sma_production_stages`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_production_stage_details`
--
ALTER TABLE `sma_production_stage_details`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_products`
--
ALTER TABLE `sma_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`),
  ADD KEY `category_id_2` (`category_id`);

--
-- Chỉ mục cho bảng `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_purchases`
--
ALTER TABLE `sma_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `sma_quotes`
--
ALTER TABLE `sma_quotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quote_id` (`quote_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `sma_return_items`
--
ALTER TABLE `sma_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Chỉ mục cho bảng `sma_return_sales`
--
ALTER TABLE `sma_return_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_sales`
--
ALTER TABLE `sma_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Chỉ mục cho bảng `sma_sessions`
--
ALTER TABLE `sma_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Chỉ mục cho bảng `sma_settings`
--
ALTER TABLE `sma_settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Chỉ mục cho bảng `sma_skrill`
--
ALTER TABLE `sma_skrill`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_subcategories`
--
ALTER TABLE `sma_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_transfers`
--
ALTER TABLE `sma_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `sma_units`
--
ALTER TABLE `sma_units`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_users`
--
ALTER TABLE `sma_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`,`warehouse_id`,`biller_id`),
  ADD KEY `group_id_2` (`group_id`,`company_id`);

--
-- Chỉ mục cho bảng `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_variants`
--
ALTER TABLE `sma_variants`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Chỉ mục cho bảng `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Chỉ mục cho bảng `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Chỉ mục cho bảng `sma_working_places`
--
ALTER TABLE `sma_working_places`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `sma_working_place_items`
--
ALTER TABLE `sma_working_place_items`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_captcha`
--
ALTER TABLE `sma_captcha`
  MODIFY `captcha_id` bigint(13) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_categories`
--
ALTER TABLE `sma_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_companies`
--
ALTER TABLE `sma_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT cho bảng `sma_costing`
--
ALTER TABLE `sma_costing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT cho bảng `sma_currencies`
--
ALTER TABLE `sma_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT cho bảng `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_date_format`
--
ALTER TABLE `sma_date_format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT cho bảng `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_expenses`
--
ALTER TABLE `sma_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_groups`
--
ALTER TABLE `sma_groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `sma_items`
--
ALTER TABLE `sma_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT cho bảng `sma_labor_norms`
--
ALTER TABLE `sma_labor_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT cho bảng `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_log_productions`
--
ALTER TABLE `sma_log_productions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_machine`
--
ALTER TABLE `sma_machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT cho bảng `sma_machinery_norms`
--
ALTER TABLE `sma_machinery_norms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT cho bảng `sma_machine_categories`
--
ALTER TABLE `sma_machine_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT cho bảng `sma_material_norms`
--
ALTER TABLE `sma_material_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;
--
-- AUTO_INCREMENT cho bảng `sma_notifications`
--
ALTER TABLE `sma_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  MODIFY `ref_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_payments`
--
ALTER TABLE `sma_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT cho bảng `sma_permissions`
--
ALTER TABLE `sma_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_productions`
--
ALTER TABLE `sma_productions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;
--
-- AUTO_INCREMENT cho bảng `sma_production_deliveries`
--
ALTER TABLE `sma_production_deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;
--
-- AUTO_INCREMENT cho bảng `sma_production_items`
--
ALTER TABLE `sma_production_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=357;
--
-- AUTO_INCREMENT cho bảng `sma_production_stages`
--
ALTER TABLE `sma_production_stages`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=432;
--
-- AUTO_INCREMENT cho bảng `sma_production_stage_details`
--
ALTER TABLE `sma_production_stage_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;
--
-- AUTO_INCREMENT cho bảng `sma_products`
--
ALTER TABLE `sma_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT cho bảng `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT cho bảng `sma_purchases`
--
ALTER TABLE `sma_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;
--
-- AUTO_INCREMENT cho bảng `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=415;
--
-- AUTO_INCREMENT cho bảng `sma_quotes`
--
ALTER TABLE `sma_quotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_return_items`
--
ALTER TABLE `sma_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_return_sales`
--
ALTER TABLE `sma_return_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_sales`
--
ALTER TABLE `sma_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT cho bảng `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT cho bảng `sma_subcategories`
--
ALTER TABLE `sma_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_transfers`
--
ALTER TABLE `sma_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_units`
--
ALTER TABLE `sma_units`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT cho bảng `sma_users`
--
ALTER TABLE `sma_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;
--
-- AUTO_INCREMENT cho bảng `sma_variants`
--
ALTER TABLE `sma_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_working_places`
--
ALTER TABLE `sma_working_places`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT cho bảng `sma_working_place_items`
--
ALTER TABLE `sma_working_place_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
