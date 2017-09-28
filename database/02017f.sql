-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 24, 2017 lúc 09:24 SA
-- Phiên bản máy phục vụ: 10.1.21-MariaDB
-- Phiên bản PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
(1, 'C1', 'THUỐC GIẢM ĐAU', '32975a6f16f29f9327be835905e77816.jpg');

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
(9, NULL, 'biller', NULL, NULL, 'Tan', 'fdbfd', '', 'dfgvdfxvb', '', '', NULL, 'Việt Nam', '5654', 'tvttdsan@gmail.com', 'Tran ', NULL, NULL, NULL, NULL, NULL, '', 0, 'logo-foso-06.gif', 0);

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

INSERT INTO `sma_items` (`id`, `item`, `specification`, `size_long`, `size_wide`, `unit_id`, `unit`, `cost`, `quantity`, `warehouse_id`, `warehouse`, `note`) VALUES
(2, 'Bao trắng', '800*1200', '0', '0', 1, 'Cái', 20000, NULL, 1, NULL, ''),
(3, 'Sơn xanh', '800*1200', '0', '0', 1, 'Cái', 0, NULL, 2, NULL, ''),
(4, 'Thép tấm', '800*1200', '0', '0', 2, 'Bao', 20, '50', 1, NULL, ''),
(5, 'Nguyen vat lieu 1', 'Nguyen vat lieu 1', '0', '0', 1, 'Cái', 0, '100', 2, NULL, '');

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
(9, 39, 29, 3, 'Chai', NULL),
(10, 39, 29, 5, 'Tân', NULL),
(11, 39, 29, 7, 'Hậu', NULL),
(14, 39, 30, 3, 'Chai', NULL),
(15, 39, 30, 7, 'Hậu', NULL),
(16, 39, 30, 9, 'Tan', NULL),
(17, 39, 30, 8, 'Tâm', NULL),
(20, 39, 29, 9, 'Tan', NULL),
(21, 40, 29, 5, 'Tân', NULL),
(22, 40, 29, 7, 'Hậu', NULL),
(23, 41, 29, 3, 'Chai', NULL),
(24, 41, 29, 7, 'Hậu', NULL),
(25, 42, 29, 5, 'Tân', NULL),
(26, 42, 29, 7, 'Hậu', NULL);

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
  `id_machine_categories` int(11) NOT NULL,
  `machine_code` varchar(255) CHARACTER SET utf8 NOT NULL,
  `machine_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `machine_details` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `machine_note` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `sma_machine`
--

INSERT INTO `sma_machine` (`id`, `id_machine_categories`, `machine_code`, `machine_name`, `machine_details`, `machine_note`) VALUES
(1, 1, 'MA1', 'May 1', 'cfs', '<p>sdvc</p>'),
(2, 4, 'MA2', 'May 2', 'sdfvd', '<p>dfvdf</p>'),
(3, 1, 'MA3', 'May 3', '', ''),
(4, 4, 'MA4', 'May 4', '', '');

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
(8, 39, 29, 3, 'Xuong 1', 1, 'May 1'),
(9, 39, 29, 3, 'Xuong 1', 2, 'May 2'),
(10, 39, 29, 3, 'Xuong 1', 3, 'May 3'),
(14, 39, 29, 3, 'Xuong 1', 4, 'May 4'),
(15, 39, 30, 2, 'MạMechanic& GalvanizedWS', 1, 'May 1'),
(16, 39, 30, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3'),
(17, 39, 30, NULL, NULL, 0, NULL),
(18, 40, 29, 1, 'Xưởng Cơ khí', 0, NULL),
(19, 40, 29, 1, 'Xưởng Cơ khí', 3, 'May 3'),
(20, 41, 29, 2, 'MạMechanic& GalvanizedWS', 1, 'May 1'),
(21, 41, 29, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3'),
(22, 42, 29, 2, 'MạMechanic& GalvanizedWS', 1, 'May 1'),
(23, 42, 29, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3');

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
(4, 'Loai 2', 'Loai 2', '');

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
(70, 39, 29, 5, 'Nguyen vat lieu 1', 10, '10', '100', NULL),
(71, 39, 29, 4, 'Thép tấm', 10, '5', '50', NULL),
(72, 39, 30, 3, 'Sơn xanh', 0, '0', '0', NULL),
(74, 39, 29, 2, 'Bao trắng', 20, '0', '0', NULL),
(76, 39, 30, 4, 'Thép tấm', 0, '1', '0', NULL),
(77, 39, 30, 5, 'Nguyen vat lieu 1', 0, '1', '0', NULL),
(80, 39, 30, 2, 'Bao trắng', 0, '1', '0', NULL),
(87, 40, 29, 5, 'Nguyen vat lieu 1', 30, '10', '300', NULL),
(88, 40, 29, 4, 'Thép tấm', 30, '5', '150', NULL),
(89, 40, 29, 2, 'Bao trắng', 30, '10', '300', NULL),
(90, 41, 29, 5, 'Nguyen vat lieu 1', 20, '10', '200', NULL),
(91, 41, 29, 4, 'Thép tấm', 20, '5', '100', NULL),
(92, 42, 29, 5, 'Nguyen vat lieu 1', 20, '10', '200', NULL),
(93, 42, 29, 4, 'Thép tấm', 20, '5', '100', NULL);

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
(1, '2015-03-01', 3, 1, 101, 1, 9, 1, 14, 52, 1, 2);

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
  `working` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_productions`
--

INSERT INTO `sma_productions` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`, `working`) VALUES
(41, '2017-07-21', '1234', 1, 'Walk-in Customer', NULL, NULL, 1, '&lt;p&gt;1234&lt;&sol;p&gt;', '', '25000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '25000.0000', 'not_start', NULL, NULL, '2017-07-21', 1, NULL, NULL, 30, 0, '0.0000', NULL, '0.0000', NULL, ''),
(42, '2017-07-22', '123', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '20000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '20000.0000', 'not_start', NULL, NULL, '2017-07-30', 1, 1, '2017-07-22 04:06:15', NULL, 0, '0.0000', NULL, '0.0000', NULL, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_items`
--

CREATE TABLE `sma_production_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) UNSIGNED DEFAULT NULL,
  `product_id` int(11) UNSIGNED DEFAULT NULL,
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

INSERT INTO `sma_production_items` (`id`, `sale_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `balance_quantity`, `status`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`) VALUES
(70, 41, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '20.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '20000.0000', '', '1000.0000'),
(71, 41, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '10.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '5000.0000', '', '500.0000'),
(73, 42, 29, 'N122-30 (ND)', 'Đế trụ', 'null', 0, '1000.0000', '1000.0000', '20.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '20000.0000', '', '1000.0000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_stages`
--

CREATE TABLE `sma_production_stages` (
  `id` int(10) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `production_id` int(11) DEFAULT NULL,
  `stage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `employee` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stage_status` varchar(50) COLLATE utf8_unicode_ci DEFAULT 'not_start',
  `error_quantity` decimal(15,0) DEFAULT NULL,
  `quantity` decimal(15,0) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_production_stages`
--

INSERT INTO `sma_production_stages` (`id`, `product_id`, `production_id`, `stage`, `date_start`, `date_end`, `employee_id`, `employee`, `stage_status`, `error_quantity`, `quantity`, `note`) VALUES
(10, 29, 39, 'gd1', '2017-06-26', '2017-06-28', NULL, '3,7', 'completed', '5', '5', NULL),
(11, 29, 39, 'gd2', '2017-06-28', '2017-06-30', NULL, '7', 'completed', '3', '2', NULL),
(12, 30, 39, 'GD1', '2017-06-26', '2017-06-27', NULL, '3,9', 'not_start', '2131', '12', NULL),
(13, 30, 39, 'GD2', '2017-06-27', '2017-06-30', NULL, '8', 'not_start', '0', '0', NULL),
(16, 29, 40, 'gd1', NULL, NULL, NULL, '7', 'not_start', '1', '20', NULL),
(17, 29, 40, 'gd2', NULL, NULL, NULL, '5', 'not_start', '10', '10', NULL),
(18, 29, 41, 'gd1', '2017-07-22', '2017-07-29', NULL, '3', 'not_start', NULL, NULL, NULL),
(19, 29, 41, 'gd2', '2017-07-21', '2017-07-23', NULL, '7', 'not_start', NULL, NULL, NULL),
(22, 29, 42, 'gd1', '2017-07-22', '2017-07-23', NULL, '5', 'not_start', NULL, NULL, NULL),
(23, 29, 42, 'gd2', '2017-07-23', '2017-07-24', NULL, '7', 'not_start', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_production_stage_details`
--

CREATE TABLE `sma_production_stage_details` (
  `id` int(11) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `stage_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sma_production_stage_details`
--

INSERT INTO `sma_production_stage_details` (`id`, `production_id`, `stage_id`, `user_id`, `note`, `date`, `user_name`) VALUES
(3, NULL, 11, 1, '&lt;p&gt;dsfgvdv&lt;&sol;p&gt;', '2017-07-06 15:46:39', 'Owner Owner'),
(4, NULL, 10, 1, '&lt;p&gt;&fjlig;hnggh&lt;&sol;p&gt;', '2017-07-06 16:16:03', 'Owner Owner'),
(7, NULL, 13, 1, '&lt;p&gt;wefgtgfhf&lt;&sol;p&gt;', '2017-07-06 16:29:46', 'Owner Owner'),
(8, NULL, 10, 1, '&lt;p&gt;khjgkjhj&lt;&sol;p&gt;', '2017-07-06 16:32:02', 'Owner Owner'),
(19, 39, 11, 1, '&lt;p&gt;tjtyjj&lt;&sol;p&gt;', '2017-07-07 10:37:35', 'Owner Owner'),
(20, 39, 10, 1, '&lt;p&gt;New comment&lt;&sol;p&gt;', '2017-07-07 10:38:45', 'Owner Owner'),
(21, 39, 10, 1, '&lt;p&gt;123123&lt;&sol;p&gt;', '2017-07-07 12:05:39', 'Owner Owner'),
(22, 39, 10, 1, '&lt;p&gt;21&lt;&sol;p&gt;', '2017-07-07 12:07:34', 'Owner Owner'),
(23, 39, 10, 1, '&lt;p&gt;test comment&lt;&sol;p&gt;', '2017-07-08 10:05:19', 'Owner Owner'),
(24, 39, 10, 1, '&lt;p&gt;regrtgrt&lt;&sol;p&gt;', '2017-07-08 10:49:35', 'Owner Owner'),
(25, 39, 11, 1, '&lt;p&gt;Gdoan 2&lt;&sol;p&gt;', '2017-07-08 10:54:38', 'Owner Owner'),
(26, 39, 12, 1, '&lt;p&gt;adsa&lt;&sol;p&gt;', '2017-07-08 11:58:21', 'Owner Owner'),
(27, 39, 13, 1, '&lt;p&gt;test&lt;&sol;p&gt;', '2017-07-14 16:45:55', 'Owner Owner'),
(28, 39, 13, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-19 15:40:37', 'Owner Owner'),
(29, 39, 13, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-19 16:11:01', 'Owner Owner'),
(30, 39, 13, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-19 16:11:05', 'Owner Owner'),
(31, 39, 11, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-19 16:20:11', 'Owner Owner'),
(32, 39, 13, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 09:11:47', 'Owner Owner'),
(33, 40, 16, 1, '&lt;p&gt;fghfghj&lt;&sol;p&gt;', '2017-07-21 12:01:28', 'Owner Owner'),
(34, 40, 16, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 13:46:07', 'Owner Owner'),
(35, 40, 16, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:03:21', 'Owner Owner'),
(36, 40, 16, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:03:32', 'Owner Owner'),
(37, 40, 16, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:03:46', 'Owner Owner'),
(38, 40, 16, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:04:02', 'Owner Owner'),
(39, 40, 17, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:04:15', 'Owner Owner');

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
  `supplier5price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `sma_products`
--

INSERT INTO `sma_products` (`id`, `code`, `name`, `unit`, `cost`, `price`, `alert_quantity`, `image`, `category_id`, `subcategory_id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `quantity`, `tax_rate`, `track_quantity`, `details`, `warehouse`, `barcode_symbology`, `file`, `product_details`, `tax_method`, `type`, `supplier1`, `supplier1price`, `supplier2`, `supplier2price`, `supplier3`, `supplier3price`, `supplier4`, `supplier4price`, `supplier5`, `supplier5price`) VALUES
(29, 'N122-30 (ND)', 'Đế trụ', 'Cai', NULL, '1000.0000', NULL, 'no_image.png', NULL, NULL, 'Quy cach', '1000', '2', '[\"gd1\",\"gd2\"]', '[{\"id\":\"5\",\"item\":\"Nvl1\",\"quantity\":\"10\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"5\"}]', '3', '10.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'XACAP', 'Xà đỡ cáp ngầm', 'Kg', NULL, '500.0000', NULL, 'no_image.png', NULL, NULL, 'Quy cach', '500', '3', '[\"GD1\",\"GD2\"]', '[{\"id\":\"2\",\"item\":\"Bao tr\\u1eafng\",\"quantity\":\"10\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"5\"},{\"id\":\"21\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"3\"}]', '2', NULL, NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(151, 'ENQUERY/2017/07/0050', '2017-07-20 10:18:00', NULL, NULL, 1, '&lt;p&gt;Y&ecirc;u cầu nhập h&agrave;ng &sol; 2017-07-20&lt;&sol;p&gt;', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'done', 'pending', 1, 1, '2017-07-20 10:18:46', NULL),
(153, 'ENQUERY/2017/07/0051', '2017-07-20 10:20:00', NULL, NULL, 1, '&lt;p&gt;Y&ecirc;u cầu nhập h&agrave;ng &sol; 2017-07-20&lt;&sol;p&gt;', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'done', 'pending', 1, 1, '2017-07-20 10:20:43', NULL),
(154, 'PO/2017/07/0100', '2017-07-20 09:20:00', 2, 'Yanstore', 1, '', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL);

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
(330, NULL, NULL, NULL, 2, NULL, 'Bao trắng', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(340, 151, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '0.0000', '2017-07-20', 'done', '20.0000', '20.0000'),
(341, 151, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '200.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '0.0000', '2017-07-20', 'done', '0.0000', '0.0000'),
(346, 153, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '0.0000', '2017-07-20', 'done', '20.0000', '20.0000'),
(347, 153, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '200.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '0.0000', '2017-07-20', 'done', '0.0000', '0.0000'),
(348, 154, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '100.0000', '2017-07-20', 'received', '20.0000', '20.0000'),
(349, 154, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '200.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '200.0000', '2017-07-20', 'received', '0.0000', '0.0000'),
(350, NULL, NULL, NULL, 3, NULL, 'Sơn xanh', NULL, NULL, '0.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(351, NULL, NULL, NULL, 4, NULL, 'Thép tấm', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(352, NULL, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, NULL, '0.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL);

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
('014178a1412262c91becf1c51633b7be6179fe92', '::1', 1500525734, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532353436393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2256557372455874536146696d6a376f3465415964223b),
('06e99d93c01a7ebd7dde4a562644de01d55973f2', '::1', 1500544552, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534343531333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22424a384b3552743663664d446248314c396c5450223b72656d6f76655f706f6c73737c693a313b),
('099170ba69c5e7045dfe54ae77672e39d3a8e160', '::1', 1500534291, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533343030343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225069337152356237706d434d5a4c59654b426367223b72656d6f76655f706f6c73737c693a313b),
('0a1750e87e270331b34de807510f4a5d14167d6a', '::1', 1500522472, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532323136373b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2235457a473470424f56397341695a6c6375373852223b),
('0d882fab3bdbaf282b1b9e98099bf204a2e2bc7e', '192.168.1.5', 1500524698, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532343337363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353134383237223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22323453315a6b43444b4841794f6c547536497230223b),
('0e227e61c1680214e2244e0241cf07a6da7eb504', '::1', 1500526286, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532363134333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2247335273646550586e7a4568756d6a353144704a223b),
('105309ce7117d7d5319caf3567fabddc86fe6535', '::1', 1500600221, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303539393838363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('11c77c5f26c00a8a53888c2381a3ae8a7eef9045', '::1', 1500601392, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630313130323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('15a885d9d0926d6b7cb0e5c0ab69806558a84b62', '::1', 1500696362, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639363037323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b),
('16452b814e2c9da5c69e8c7d47a77b9ec852cdae', '::1', 1500525118, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532343833303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22637a51546f4944694737794c43706a774b353065223b),
('16d92440d428cc35bce108399d9ac508bc1103a0', '::1', 1500542146, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534313834323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224e5274377046776b573173436167696d50643371223b72656d6f76655f706f6c73737c693a313b),
('19145052382387559e8dea061f1e3780619967a5', '192.168.1.5', 1500879395, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837393337313b7265717565737465645f706167657c733a31353a2270726f64756374732f656469742f32223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383739333832223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1a38517af99ca58554a86c98f84c92c78f2dbc9a', '::1', 1500542446, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534323134373b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224b78394d4a526f77436a65716359345553444f47223b72656d6f76655f706f6c73737c693a313b),
('1b0aa2ff2656ae769c5b053678b0280c206553cf', '::1', 1500623449, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632333137323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1d0cb6bcb6e621bf77657dbab8688f41c8a7af64', '::1', 1500544331, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534333833353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22424a384b3552743663664d446248314c396c5450223b72656d6f76655f706f6c73737c693a313b),
('1e903240824d300e64315f39dde52edde0eac944', '::1', 1500696749, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639363732323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b),
('1ee2ef41ca2ab9c4e4c61ee143ef295ae31d976a', '::1', 1500691955, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639313730333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1f4e81b883637d623cf338c595a0886db8564057', '::1', 1500601510, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630313431393b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1f7d0b55235bb8ef98fadc241e024bb04179c76f', '::1', 1500529686, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532393534383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225731674e764d7a664745534b786c6f7136753534223b72656d6f76655f706f6c73737c693a313b),
('201541e0050ea14ab96410b1125f46af25099fe3', '::1', 1500627867, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632373636323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('21c8d6cd5b6cfab834b2f0130d00afcaaceaa832', '::1', 1500537881, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533373732383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('229b8b9fa9a155fc20e962c967831c4b6dfe6010', '::1', 1500621221, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632303934343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('22cf9b0f56fb0216398490bf2decee70f4d75390', '::1', 1500606777, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630363439353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('238f87602445d74d6abfbf5c24e099c36c1a5837', '::1', 1500523114, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532323835333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224c347453367252375476576a3351456d6347586b223b),
('24eebda41174255ac366feaa3d287309421c9ac6', '::1', 1500696622, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639363337343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b),
('252df1eeac4c9ac93f6b10b6eea5dc9ca36fad4b', '::1', 1500687028, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638363738333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2561536baac7af9dcdc1513b26d052eed6d24007', '::1', 1500622679, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632323332323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2d8d5400f9fbbe3d41fff40c2a36ca50c8eafc12', '::1', 1500698230, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639383032333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b6c6173745f61637469766974797c693a313530303639383231383b),
('2e29cdb2d4024eaf580d0e99d1fb686bcc5d9424', '::1', 1500691316, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639313032303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3716202de3266097b825194676a35cc243b6eaa1', '::1', 1500522549, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532323532343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2241376f4f757a6965324a78686d566c39356b5258223b),
('37c2ed6c36e582faa2489e0b16c11f4818739204', '::1', 1500871008, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837313030343b7265717565737465645f706167657c733a353a2273616c6573223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383730313830223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3867f8bcda7ded9872a8bf00a4041313d821d2a1', '::1', 1500527752, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532373531333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224c514252776f6935377048394d476e7261585679223b72656d6f76655f706f6c73737c693a313b),
('3ae8fa3f6f347ba273cbb67d21e30a0e0f027851', '::1', 1500610085, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630393739343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3c192927b64142b6c606e3eb861e29fea9f7c480', '192.168.1.5', 1500536842, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533363536363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353335333734223b6c6173745f69707c733a31313a223139322e3136382e312e37223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226846317554424f6c47594e6b535a665144625249223b),
('3f41e3429f404df2d1323bf0be11426614e14ba6', '::1', 1500600956, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630303637363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('420c07582dec0a76af8a050b1df8bb43193963e1', '::1', 1500603933, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630333639323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('45d296016aca44b895832f86d6d1935f2be58790', '::1', 1500534648, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533343336383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226a46384d6f45504737426378303277694c366154223b72656d6f76655f706f6c73737c693a313b),
('47fded1234b23e7d0fbe5cded05278286c8a5de1', '::1', 1500524814, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532343532303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22754f6a585153646b617834706269357772745239223b),
('494fe8b5d7c635b05993eb02c864d31d36c68dbc', '::1', 1500539773, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533393432383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('49dbd43e695bf59c8ae2b3bd4f990689839b3b0b', '::1', 1500608393, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630383135363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4a2a2bbb299dbbb9641743ccbf3d246735bb6b55', '::1', 1500529544, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532393233323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22524a686f66677473434b6c394e5770726b654153223b72656d6f76655f706f6c73737c693a313b),
('4ae3efe47ba803f49f0d8d8ed31075dce3dd1705', '192.168.1.5', 1500525030, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532343733333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353134383237223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22734367776b716d47454b48324d6e624150346130223b),
('4afa528607aa1c88f17a0b8f3a7cbc72c85b7710', '::1', 1500532654, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533323631333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2267434b66333161344a464837624e4f4468585645223b72656d6f76655f706f6c73737c693a313b),
('530d0f5b4d46515efd77641a278b042d1ad8aace', '::1', 1500607677, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630373338363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('573aaf7dc6ff4b5e767b2bd40abe3821ab95998a', '::1', 1500525432, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532353135323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227339776a374f464e71724d6f436236327a5a5748223b),
('580d1bb999aa8ebf10ae9f3acda01d4fb42d4dd2', '::1', 1500535283, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533343938363b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226e7a3432444c42636654585947704b7255374362223b72656d6f76655f706f6c73737c693a313b),
('582ab30df8e95b6cbd8f7505c6b74ecf8f839bbf', '::1', 1500870282, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837303137373b7265717565737465645f706167657c733a31303a2271756f7465732f616464223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383639393432223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5cd2f23b31462607aea78b2f75308267713345bd', '::1', 1500699666, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639393636363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b6c6173745f61637469766974797c693a313530303639383231383b),
('5dee56501e96f45063aa6700b72dc619029a3583', '::1', 1500605067, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630343536363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5e2e157fe3d9d4cff8a1d18b78a0cc6dd1b28b3a', '::1', 1500600527, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630303331303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5fc8c7852f57b06e86ff5f6aec9eb31384621911', '::1', 1500605439, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630353135353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('60530eeed4a7db623cc3e1d7790aae1a0604b090', '::1', 1500872110, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837323039323b7265717565737465645f706167657c733a31303a2271756f7465732f616464223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383731303037223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('61a6e610827f4c5dab5955e1f2964c1df16b7110', '::1', 1500689149, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638383930313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('61aad1d36e52fd2a3e7aea22639997ba15f15780', '::1', 1500689880, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638393539313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('63ec7dca39003d638cb3da8c84acac25a62502c2', '::1', 1500523414, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532333137323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22384c577231586977514133677854426a534d6430223b),
('652e843241c12603e3492dd9a433d95e8a0596cf', '::1', 1500599418, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303539393431383b),
('65439e8d6feb6f09f26db8a2b124011ddc2fcdb4', '::1', 1500698511, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639383333353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22784e7230634437735a67456c535141366b496576223b6c6173745f61637469766974797c693a313530303639383231383b),
('6588f1f74b4a1d9b0e7f430263b75d45889e6597', '::1', 1500691618, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639313333323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6735b29b6e563bd10000ab0ac0b8c36859f2d1e6', '::1', 1500625635, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632353436383b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6985f7e6eb0fd4795a5ba8d0314617300b0c3bf9', '::1', 1500541429, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534313133383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('6a2c83fb09d6dd93bac0276d420bc115bb15fcc7', '192.168.1.7', 1500535590, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533353336313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353234333838223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2254483436315a727851627149636f756879355359223b72656d6f76655f706f6c737c733a313a2231223b),
('6cb2b0d29fdb06d3166d0844722b215db376eab2', '::1', 1500631079, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303633303739363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6d4ba7fc6c66c5f8d1cb6f15ed72fe5d7e866e3d', '::1', 1500690149, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638393931363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6d819cc290e6d06e6620ca86179fce6227a6a04e', '::1', 1500687524, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638373233373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6de536f4c4dc01dcbc92a6f11c5b429374aca88e', '::1', 1500534983, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533343638303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226a577a6c68634b55514872645941325847623130223b72656d6f76655f706f6c73737c693a313b),
('6e44893b7659089b37d486f3cb958e42c0ea3f17', '192.168.1.5', 1500535369, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533353336393b),
('6fe5b29cd453c6a0ab75c75e4202ce324abaa303', '::1', 1500610651, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631303530353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('715185663149908a5ac8d94783baa37af6fdc97c', '::1', 1500539782, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533393738313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('72e92809573fec7f2b66d5d39ea977e58d7c0a17', '::1', 1500690397, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639303235333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('774a42a67197a854e8dbf5024fc76abe0d31231c', '::1', 1500872972, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837323934303b7265717565737465645f706167657c733a31303a2271756f7465732f616464223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383732383031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('785d981b64735a9f59bccf556f7375bdfbb20135', '::1', 1500872842, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303837323739393b7265717565737465645f706167657c733a31303a2271756f7465732f616464223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383732303935223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7e2df2411abfa60c2fccaef56b5960c99aa7f1a3', '::1', 1500623767, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632333534323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('827307332b2243f34884f269dcec3a3013f65d2f', '::1', 1500608767, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630383436363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8296aee6630ec840d9cdfd4de35942b9e81483d3', '::1', 1500542650, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534323434383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227061794c4a39356f565365757a71316337577651223b72656d6f76655f706f6c73737c693a313b),
('857b298f04fc32381f16e4120d1190aa96dc6d07', '::1', 1500627536, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632373236303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8688e206087fca2952a38663fb0d9df3c5939a02', '::1', 1500692776, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639323438313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('87ace3deb84bcc474c7c22dad3fdb2d244d84205', '::1', 1500625344, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632353130303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('896ad34b956ce8ebaa4c62f9917e18238b85a28b', '::1', 1500693095, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639323830373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8b2d41640a80007ba865200f2c4174e5a2c1ef8a', '::1', 1500611596, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631313337323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8bdcb9b047c161af5714c7730644c1618ac44925', '::1', 1500603167, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630333039373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8c6782497a7d9edaca06849db0759645041140ec', '::1', 1500533224, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533323931363b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227469644a314975355363564371576f41456c4e5a223b72656d6f76655f706f6c73737c693a313b),
('8d0010afb61dda59f648466b8c724c86ff8ae7c7', '::1', 1500613279, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631323937303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('94ca9b167a8089f9af62edbc162bcc73d414c1f1', '::1', 1500622316, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632313935373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('961792c6c157bea04c9775c16705812f977abfd2', '::1', 1500869946, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303836393933393b7265717565737465645f706167657c733a31303a2271756f7465732f616464223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030363836373836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('96269f6afa5d1d26932428c3f53cc794ba36f99b', '::1', 1500536377, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533353836383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('965c6aabdfef35b109d610059aea0de7b3ddc4de', '::1', 1500539066, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533383636303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('971b8f2f6074da3586ac625f229491e705293158', '::1', 1500624842, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632343632333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9d92043bb3776206223cdfda789787a7b46c8c21', '::1', 1500523878, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532333536333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226539636634416951426f357955623349644a5345223b),
('a1610f264fc98a5a32c2ff151535af971a845a5c', '::1', 1500524511, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532343231363b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c6555526d7a4458305071646b6f4e4135493437223b),
('a451eba3bd74b55958d56dddc466a36171d4b37c', '::1', 1500628145, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632383038323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a60f292be8a26fc689601887ced3a63002c072d4', '::1', 1500690999, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639303639393b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a7965d8187166b11c26ef8fb30b897e7b93c89a8', '::1', 1500611994, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631313639373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('aa6abab7c9058094f1465f527d3227c597cc8870', '::1', 1500602670, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630323536353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('abd89aacee61c96b40c5a862640c79d38e85c394', '192.168.1.5', 1500881043, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303838313031383b7265717565737465645f706167657c733a31353a2270726f64756374732f656469742f32223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383831303234223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d6572726f727c733a32343a224b68c3b46e672063c3b3207468c3a06e68207068e1baa96d223b),
('ae1924d786d02314f345f2896017b26cd1eaca86', '::1', 1500601996, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630313831353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('aea7c434d7eda79b333ec93f584b3e867ebafaf8', '::1', 1500688722, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638383437333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b2046a198420655b1575f273dfc773ab99232631', '::1', 1500527124, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532363831393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22774e6d53503463556848674351544a6662794741223b),
('b287cebc05c4b6eaf82477e43ff8eb77bc94267d', '::1', 1500630034, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632393837373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b3151d17c3b670ea065f66c1058b94199d0b4360', '::1', 1500696072, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639343730383b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b7761726e696e677c733a36343a224b68c3b46e67207468e1bb832063e1baad70206ec3a079207469e1babf6e20c491e1bb99206b6869206368c6b0612063686f2076c3a06f2078e1bbad206cc3bd223b5f5f63695f766172737c613a313a7b733a373a227761726e696e67223b733a333a226e6577223b7d),
('bc395b0fa1aafb3d3cc1c8255426796ef9c62da2', '::1', 1500610415, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631303134333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bd37daeac70d0e6f323f157b260be1b6cf21fc8c', '::1', 1500624269, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632343030313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c5f6ecafa32d1e298dc1eeea007d3afa4e17d2e3', '::1', 1500622708, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632323639353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c6803fd929c16e055a630fb62803ad70c4fba729', '::1', 1500694539, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639343331333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c7e57d7b5d5dd9e24017fd4fd8df6e1c26b2e6d7', '::1', 1500688071, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638373836313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c9091d5ed86a854664fd4f484fbf324027caad7b', '::1', 1500602148, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630323133323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ca2b0f294a182af38962a07334bd0468e06f6e2b', '::1', 1500543673, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534333438393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227061794c4a39356f565365757a71316337577651223b72656d6f76655f706f6c73737c693a313b),
('caf577a8f382472b2217a7bd74a647df3d7891db', '::1', 1500541834, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534313533303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2268415763334a3170774e44723671664935536947223b72656d6f76655f706f6c73737c693a313b),
('cb8effd1f880b86186803b993db01781d2a56792', '::1', 1500524154, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532333838333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225748744a724932477a4c54787045556a4f395364223b),
('ccf70b54b803020e1eb58410defca11da617e010', '::1', 1500543243, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534333131313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227061794c4a39356f565365757a71316337577651223b72656d6f76655f706f6c73737c693a313b),
('cd008e4c86a93ded6c08622d25adad1dd3a85b74', '::1', 1500612875, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631323633333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('cf3088e7ee436cc2ac3ea83325e7341ff7d96eef', '192.168.1.8', 1500881015, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303838313030393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030383739333932223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a34353a223c703e42e1baa16e20c491c3a320c491c4836e67206e68e1baad70207468c3a06e682063c3b46e672e3c2f703e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('d14e418370eb75c5428eae09e9f524064e4be187', '::1', 1500609427, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630393132393b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d1e7a467d8ae17bf2fc3920e93d7b3d113540059', '::1', 1500689500, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638393232303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d230aef519241440adc985ac2bd78adcd4e76533', '::1', 1500541106, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303534303831323b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('d28fe5c1ec3c76c38d4b549f2b1cc386d389bdac', '::1', 1500627241, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632363934363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d4de1a10c33c28a7f88dc07bc5f4846f4ec47bc3', '::1', 1500621480, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632313334323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d5256ea3c39cc9e0e9a01222bf6c28d5a4227ce4', '::1', 1500619564, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631333238373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d6504dbbb2af3af37cc117ee02fdbda24df417a2', '::1', 1500605986, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630353835373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d6cba17a9699b9b9a90ffa0a47ec131c3c537219', '192.168.1.5', 1500537280, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533373030343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353335333734223b6c6173745f69707c733a31313a223139322e3136382e312e37223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a223678674147526d37566a79486661693157645175223b),
('d76aad3794c1353cd78925dbc2df16494e235219', '::1', 1500631441, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303633313134363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d86faba687aecba7b3a152179c63ec57e7eb56bf', '::1', 1500692444, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303639323136313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d9549e8cba162ac6f75ee40a12c32aa3391f89e8', '::1', 1500608035, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630373736343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d98f29199b50857629cd930d0e01cf1c93fadded', '::1', 1500533953, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533333637353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22623676745a724b52344e4c6e3755445838437a45223b72656d6f76655f706f6c73737c693a313b),
('de22c210523702a27ff419060ad036d8d45c83c1', '192.168.1.5', 1500525038, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532353033373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353134383237223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22734367776b716d47454b48324d6e624150346130223b),
('df51d679fbfbfadcb2c69bd5ae56e5a58c55ee01', '::1', 1500535590, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533353330303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226a4148495978586c437747514f3365554639734e223b72656d6f76655f706f6c73737c693a313b),
('e15450fc268206f8f25ced74ba4ffaa0fae043cb', '::1', 1500611231, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631303937313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e3644a6a6d1b427475299bc4b41e1d029891b2d0', '::1', 1500605727, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630353437323b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e53b8b7fe986c12a3023df09b3bb0041d51f36e8', '::1', 1500607156, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630363836363b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('e55f8391d0a73fe885f96f65146724809933a2c7', '::1', 1500526786, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532363438393b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224b506c693745496876434675576e736659716436223b),
('e9213cce4d24caec8f42c4af8dffc88b6ba9930e', '::1', 1500604556, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630343236303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eac9bf3af11fec92a72bdde788ac0309a3cdd98e', '::1', 1500533516, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533333232373b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a223031725a36397348347a457037653532434f4146223b72656d6f76655f706f6c73737c693a313b),
('eada0d8c888d3c635cfcb50d364df2644cab85cc', '::1', 1500620871, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632303630313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eb120286612458fb09dd8cb6e42ddbc059b66667', '::1', 1500626047, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632353738313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('eef1d0290e33fc1e91d980bc48864bd68560aaf7', '::1', 1500612529, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631323331353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ef28c5c910d4cb14c1a6ea0d7dccadd555c7ba89', '::1', 1500609110, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630383830333b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f32ec930f37152dd45a0d2ae3fba354e762eef4b', '::1', 1500624479, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632343330373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f3eaba417e75ec2dfe446d19b3dfe0cb8d33ec83', '::1', 1500619766, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631393536373b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f3ef4643d4567fa49112115a6b65968e62620417', '::1', 1500526096, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532353830333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22754f6b63306e4e49445445725a64683358536651223b),
('f50b01ca61d3e2a7f630f75084d5b32bc09133d0', '::1', 1500539341, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303533393036383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22466f576949364b62317774334f6a707167553978223b72656d6f76655f706f6c73737c693a313b),
('f88e7f054e88d22a6dc4471ce5f2558e2a62d119', '::1', 1500620351, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303632303230383b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fa4711897c69480e729a4044e6f35e62921f61da', '::1', 1500609730, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303630393434313b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fa73f8c59da13fd8488b40083d6b29c5e70292d2', '::1', 1500612281, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303631323031343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fd1c95996fdadfc3b6ca32d2f44ba5d8ff354ea6', '::1', 1500631555, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303633313438343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353336353731223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('fe195da7813a9ac505048f55e8706ad3e77b9f09', '::1', 1500527429, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303532373132383b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030343438383130223b6c6173745f69707c733a31313a223139322e3136382e312e35223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2257494648476243766b343266786c684f6e65384b223b72656d6f76655f706f6c73737c693a313b),
('fe9d501b7fae4d6088620e3d4dd5eb0236802939', '::1', 1500687547, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530303638373534353b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353030353939383836223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);

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
(1, 'logo2.png', 'logo4.png', 'PHẦN MỀM SẢN XUẤT FOSO', 'vietnamese', 1, 0, 'VND', 1, 10, '3.0.1.13', 1, 5, 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'ENQUERY', '', 0, 'default', 1, 1, 1, 1, 1, 1, 0, 1, 0, 'Asia/Singapore', 800, 800, 60, 60, 0, 0, 1, 1, NULL, 'smtp', '/usr/sbin/sendmail', 'smtp.gmail.com', 'tvtan06@gmail.com', '4oz0YVuabzm4aTMknlH+KZRfHpP/WFaOad737FKLlE3tOxeng1aKV9HxgdPnG1KLUp+9R9znqJqymYV2AJD4MA==', '587', 'tls', NULL, 1, 'tvtan06@gmail.com', 0, 4, 1, 0, 2, 1, 1, 0, 2, '.', ',', 0, 3, 'StockManager', '3', 0, NULL, NULL, NULL, NULL, 0, 0);

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
(1, 0x3139322e3136382e312e35, 0x0000, 'owner', '2c8ab736b2ccab4f50e72d5fd7d21020cbb77ae7', NULL, 'owner@google.com', NULL, NULL, NULL, '6e5e2f4c47ba10736e92891840965955f42f6f45', 1351661704, 1500881043, 1, 'Owner', 'Owner', 'Stock Manager', '012345678', NULL, 'male', 1, NULL, NULL, NULL, 0, 0, 0),
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
(113, 1, NULL, 0x3139322e3136382e312e35, 'owner@google.com', '2017-07-24 07:24:03');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sma_variants`
--

CREATE TABLE `sma_variants` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(12, NULL, 4, 1, '50.0000', NULL),
(13, NULL, 5, 1, '200.0000', NULL),
(14, NULL, 5, 2, '-100.0000', NULL),
(15, NULL, 2, 1, '0.0000', NULL),
(16, NULL, 3, 2, '0.0000', NULL),
(17, 30, NULL, 1, '0.0000', NULL),
(18, 29, NULL, 1, '10.0000', NULL);

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
(1, 'Xưởng Cơ khí', '1234', '1234', ''),
(2, 'MạMechanic& GalvanizedWS', '1234', '1234', ''),
(3, 'Xuong 1', '456567', '567', ''),
(4, 'Xuong 2', '45645', '34564', ''),
(5, 'Xuong 3', '4354354', '456546', '');

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
(31, 2, 1),
(32, 2, 3),
(33, 3, 1),
(34, 3, 3),
(35, 3, 2),
(36, 3, 4),
(37, 4, 2),
(38, 4, 4),
(39, 5, 1),
(40, 5, 4),
(41, 1, 3),
(42, 1, 2);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_companies`
--
ALTER TABLE `sma_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `sma_labor_norms`
--
ALTER TABLE `sma_labor_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_machinery_norms`
--
ALTER TABLE `sma_machinery_norms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT cho bảng `sma_machine_categories`
--
ALTER TABLE `sma_machine_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT cho bảng `sma_material_norms`
--
ALTER TABLE `sma_material_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT cho bảng `sma_production_items`
--
ALTER TABLE `sma_production_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT cho bảng `sma_production_stages`
--
ALTER TABLE `sma_production_stages`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT cho bảng `sma_production_stage_details`
--
ALTER TABLE `sma_production_stage_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT cho bảng `sma_products`
--
ALTER TABLE `sma_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT cho bảng `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_purchases`
--
ALTER TABLE `sma_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;
--
-- AUTO_INCREMENT cho bảng `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=353;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;
--
-- AUTO_INCREMENT cho bảng `sma_variants`
--
ALTER TABLE `sma_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT cho bảng `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `sma_working_places`
--
ALTER TABLE `sma_working_places`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `sma_working_place_items`
--
ALTER TABLE `sma_working_place_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
