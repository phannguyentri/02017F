-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 27, 2017 at 05:26 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foso_02017f`
--

-- --------------------------------------------------------

--
-- Table structure for table `sma_adjustments`
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
-- Table structure for table `sma_calendar`
--

CREATE TABLE `sma_calendar` (
  `date` date NOT NULL,
  `data` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_captcha`
--

CREATE TABLE `sma_captcha` (
  `captcha_id` bigint(13) UNSIGNED NOT NULL,
  `captcha_time` int(10) UNSIGNED NOT NULL,
  `ip_address` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `word` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_captcha`
--

INSERT INTO `sma_captcha` (`captcha_id`, `captcha_time`, `ip_address`, `word`) VALUES
(1, 1497857401, '::1', '5d2MK'),
(2, 1497857404, '::1', 'd7ZC8'),
(3, 1497857405, '::1', '73ZIQ'),
(4, 1497857406, '::1', 'rMzMd');

-- --------------------------------------------------------

--
-- Table structure for table `sma_categories`
--

CREATE TABLE `sma_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_categories`
--

INSERT INTO `sma_categories` (`id`, `code`, `name`, `image`) VALUES
(1, 'C1', 'THUỐC GIẢM ĐAU', '32975a6f16f29f9327be835905e77816.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `sma_combo_items`
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
-- Table structure for table `sma_companies`
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
-- Dumping data for table `sma_companies`
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
-- Table structure for table `sma_costing`
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
-- Dumping data for table `sma_costing`
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
-- Table structure for table `sma_currencies`
--

CREATE TABLE `sma_currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(5) NOT NULL,
  `name` varchar(55) NOT NULL,
  `rate` decimal(12,4) NOT NULL,
  `auto_update` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_currencies`
--

INSERT INTO `sma_currencies` (`id`, `code`, `name`, `rate`, `auto_update`) VALUES
(1, 'USD', 'US Dollar', '1.0000', 0),
(2, 'ERU', 'EURO', '0.7340', 0),
(3, 'VND', 'VNĐ', '1.0000', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_customer_groups`
--

CREATE TABLE `sma_customer_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_customer_groups`
--

INSERT INTO `sma_customer_groups` (`id`, `name`, `percent`) VALUES
(1, 'General', 0),
(2, 'Reseller', -5),
(3, 'Distributor', -15),
(4, 'New Customer (+10)', 10);

-- --------------------------------------------------------

--
-- Table structure for table `sma_date_format`
--

CREATE TABLE `sma_date_format` (
  `id` int(11) NOT NULL,
  `js` varchar(20) NOT NULL,
  `php` varchar(20) NOT NULL,
  `sql` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_date_format`
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
-- Table structure for table `sma_deliveries`
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
-- Table structure for table `sma_expenses`
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
-- Table structure for table `sma_gift_cards`
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
-- Table structure for table `sma_groups`
--

CREATE TABLE `sma_groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_groups`
--

INSERT INTO `sma_groups` (`id`, `name`, `description`) VALUES
(1, 'owner', 'Owner'),
(2, 'admin', 'Administrator'),
(3, 'customer', 'Customer'),
(4, 'supplier', 'Supplier'),
(5, 'sales', 'Sales Staff'),
(6, 'aaa', 'aaaa');

-- --------------------------------------------------------

--
-- Table structure for table `sma_items`
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
-- Dumping data for table `sma_items`
--

INSERT INTO `sma_items` (`id`, `item`, `specification`, `size_long`, `size_wide`, `unit_id`, `unit`, `cost`, `quantity`, `warehouse_id`, `warehouse`, `note`) VALUES
(2, 'Bao trắng', '800*1200', '0', '0', 1, 'Cái', 20000, '20000', 1, NULL, ''),
(3, 'Sơn xanh', '800*1200', '0', '0', 1, 'Cái', 0, NULL, 2, NULL, ''),
(4, 'Thép tấm', '800*1200', '0', '0', 2, 'Bao', 20, '147700', 1, NULL, ''),
(5, 'Nguyen vat lieu 1', 'Nguyen vat lieu 1', '0', '0', 1, 'Cái', 0, '3725', 2, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_labor_norms`
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
-- Dumping data for table `sma_labor_norms`
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
(26, 42, 29, 7, 'Hậu', NULL),
(27, 43, 29, 5, 'Tân', NULL),
(28, 43, 29, 7, 'Hậu', NULL),
(29, 43, 29, 8, 'Tâm', NULL),
(30, 42, 30, 7, 'Hậu', NULL),
(31, 42, 30, 8, 'Tâm', NULL),
(32, 44, 29, 3, 'Chai', NULL),
(33, 44, 29, 5, 'Tân', NULL),
(34, 44, 30, 5, 'Tân', NULL),
(35, 44, 30, 9, 'Tan', NULL),
(36, 45, 30, 7, 'Hậu', NULL),
(37, 45, 29, 5, 'Tân', NULL),
(38, 45, 29, 9, 'Tan', NULL),
(39, 46, 30, 7, 'Hậu', NULL),
(40, 46, 30, 9, 'Tan', NULL),
(41, 46, 29, 3, 'Chai', NULL),
(42, 46, 29, 5, 'Tân', NULL),
(43, 47, 29, 5, 'Tân', NULL),
(44, 47, 29, 8, 'Tâm', NULL),
(45, 47, 30, 5, 'Tân', NULL),
(46, 48, 29, 3, 'Chai', NULL),
(47, 48, 29, 5, 'Tân', NULL),
(48, 48, 30, 3, 'Chai', NULL),
(49, 48, 30, 9, 'Tan', NULL),
(50, 49, 30, 3, 'Chai', NULL),
(51, 49, 30, 7, 'Hậu', NULL),
(52, 50, 29, 5, 'Tân', NULL),
(53, 50, 29, 8, 'Tâm', NULL),
(54, 52, 29, 7, 'Hậu', NULL),
(55, 52, 29, 8, 'Tâm', NULL),
(56, 53, 30, 5, 'Tân', NULL),
(57, 53, 30, 7, 'Hậu', NULL),
(58, 53, 30, 8, 'Tâm', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_login_attempts`
--

CREATE TABLE `sma_login_attempts` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_log_productions`
--

CREATE TABLE `sma_log_productions` (
  `id` int(11) NOT NULL,
  `production_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sma_log_productions`
--

INSERT INTO `sma_log_productions` (`id`, `production_id`, `product_id`) VALUES
(1, 39, 29);

-- --------------------------------------------------------

--
-- Table structure for table `sma_machine`
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
-- Dumping data for table `sma_machine`
--

INSERT INTO `sma_machine` (`id`, `id_machine_categories`, `machine_code`, `machine_name`, `machine_details`, `machine_note`) VALUES
(1, 1, 'MA1', 'May 1', 'cfs', '<p>sdvc</p>'),
(2, 4, 'MA2', 'May 2', 'sdfvd', '<p>dfvdf</p>'),
(3, 1, 'MA3', 'May 3', '', ''),
(4, 4, 'MA4', 'May 4', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_machinery_norms`
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
-- Dumping data for table `sma_machinery_norms`
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
(23, 42, 29, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3'),
(24, 43, 29, 3, 'Xuong 1', 1, 'May 1'),
(25, 43, 29, 3, 'Xuong 1', 3, 'May 3'),
(26, 42, 0, NULL, NULL, 0, NULL),
(27, 42, 30, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3'),
(28, 42, 30, 2, 'MạMechanic& GalvanizedWS', 1, 'May 1'),
(29, 44, 29, 3, 'Xuong 1', 1, 'May 1'),
(30, 44, 29, 3, 'Xuong 1', 2, 'May 2'),
(31, 44, 30, 2, 'MạMechanic& GalvanizedWS', 1, 'May 1'),
(32, 45, 30, 3, 'Xuong 1', 1, 'May 1'),
(33, 45, 29, 4, 'Xuong 2', 2, 'May 2'),
(34, 45, 29, 4, 'Xuong 2', 4, 'May 4'),
(35, 46, 30, 4, 'Xuong 2', 4, 'May 4'),
(36, 46, 30, 4, 'Xuong 2', 2, 'May 2'),
(37, 46, 29, 3, 'Xuong 1', 3, 'May 3'),
(38, 46, 29, 3, 'Xuong 1', 4, 'May 4'),
(39, 47, 29, 3, 'Xuong 1', 3, 'May 3'),
(40, 47, 29, 3, 'Xuong 1', 4, 'May 4'),
(41, 47, 30, 3, 'Xuong 1', 4, 'May 4'),
(42, 48, 29, 2, 'MạMechanic& GalvanizedWS', 3, 'May 3'),
(43, 48, 30, 3, 'Xuong 1', 3, 'May 3'),
(44, 48, 30, 3, 'Xuong 1', 4, 'May 4'),
(45, 49, 30, 3, 'Xuong 1', 3, 'May 3'),
(46, 49, 30, 3, 'Xuong 1', 4, 'May 4'),
(47, 50, 29, 3, 'Xuong 1', 3, 'May 3'),
(48, 52, 29, 4, 'Xuong 2', 4, 'May 4'),
(49, 53, 30, 3, 'Xuong 1', 3, 'May 3'),
(50, 53, 30, 3, 'Xuong 1', 2, 'May 2');

-- --------------------------------------------------------

--
-- Table structure for table `sma_machine_categories`
--

CREATE TABLE `sma_machine_categories` (
  `id` int(11) NOT NULL,
  `categories_name` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Tên',
  `categories_details` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Thông số chi tiết',
  `categories_note` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Ghi chú'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_machine_categories`
--

INSERT INTO `sma_machine_categories` (`id`, `categories_name`, `categories_details`, `categories_note`) VALUES
(1, 'Loai 1', 'Loai 1', '<p>Loai 1</p>'),
(4, 'Loai 2', 'Loai 2', '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_material_norms`
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
-- Dumping data for table `sma_material_norms`
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
(93, 42, 29, 4, 'Thép tấm', 20, '5', '100', NULL),
(94, 43, 29, 5, 'Nguyen vat lieu 1', 100, '10', '1000', NULL),
(95, 43, 29, 4, 'Thép tấm', 100, '5', '500', NULL),
(96, 42, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(97, 42, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(98, 42, 30, 21, NULL, 100, '3', '300', NULL),
(99, 44, 29, 5, 'Nguyen vat lieu 1', 200, '10', '2000', NULL),
(100, 44, 29, 4, 'Thép tấm', 200, '5', '1000', NULL),
(101, 44, 30, 2, 'Bao trắng', 100, '100', '10000', NULL),
(102, 44, 30, 4, 'Thép tấm', 100, '500', '50000', NULL),
(104, 45, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(105, 45, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(107, 45, 29, 5, 'Nguyen vat lieu 1', 50, '10', '500', NULL),
(108, 45, 29, 4, 'Thép tấm', 50, '5', '250', NULL),
(109, 46, 30, 2, 'Bao trắng', 50, '10', '500', NULL),
(110, 46, 30, 4, 'Thép tấm', 50, '5', '250', NULL),
(112, 46, 29, 5, 'Nguyen vat lieu 1', 50, '10', '500', NULL),
(113, 46, 29, 4, 'Thép tấm', 50, '5', '250', NULL),
(114, 47, 29, 5, 'Nguyen vat lieu 1', 50, '10', '500', NULL),
(115, 47, 29, 4, 'Thép tấm', 50, '5', '250', NULL),
(116, 47, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(117, 47, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(118, 47, 30, 21, NULL, 100, '3', '300', NULL),
(119, 48, 29, 5, 'Nguyen vat lieu 1', 50, '10', '500', NULL),
(120, 48, 29, 4, 'Thép tấm', 50, '5', '250', NULL),
(121, 48, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(122, 48, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(123, 48, 30, 21, NULL, 100, '3', '300', NULL),
(124, 49, 30, 2, 'Bao trắng', 100, '10', '10', NULL),
(125, 49, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(126, 49, 30, 5, 'Nguyen vat lieu 1', 100, '3', '100000000', NULL),
(127, 50, 29, 5, 'Nguyen vat lieu 1', 1, '10', '10', NULL),
(128, 50, 29, 4, 'Thép tấm', 1, '5', '5', NULL),
(129, 52, 29, 5, 'Nguyen vat lieu 1', 1, '10', '10', NULL),
(130, 52, 29, 4, 'Thép tấm', 1, '5', '5', NULL),
(131, 53, 30, 2, 'Bao trắng', 100, '10', '1000', NULL),
(132, 53, 30, 4, 'Thép tấm', 100, '5', '500', NULL),
(133, 53, 30, 5, 'Nguyen vat lieu 1', 100, '3', '300', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_migrations`
--

CREATE TABLE `sma_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_migrations`
--

INSERT INTO `sma_migrations` (`version`) VALUES
(306);

-- --------------------------------------------------------

--
-- Table structure for table `sma_notifications`
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
-- Dumping data for table `sma_notifications`
--

INSERT INTO `sma_notifications` (`id`, `comment`, `date`, `from_date`, `till_date`, `scope`) VALUES
(1, '<p>Thank you for purchasing Stock Manager Advance.</p>', '2014-08-15 10:00:57', '2015-01-01 00:00:00', '2017-01-01 00:00:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `sma_order_ref`
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
-- Dumping data for table `sma_order_ref`
--

INSERT INTO `sma_order_ref` (`ref_id`, `date`, `so`, `qu`, `po`, `to`, `pos`, `do`, `pay`, `re`, `ex`, `prod`) VALUES
(1, '2015-03-01', 3, 1, 105, 1, 9, 1, 14, 62, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sma_payments`
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
-- Dumping data for table `sma_payments`
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
-- Table structure for table `sma_paypal`
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
-- Dumping data for table `sma_paypal`
--

INSERT INTO `sma_paypal` (`id`, `active`, `account_email`, `paypal_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'mypaypal@paypal.com', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_permissions`
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
-- Dumping data for table `sma_permissions`
--

INSERT INTO `sma_permissions` (`id`, `group_id`, `products-index`, `products-add`, `products-edit`, `products-delete`, `products-cost`, `products-price`, `quotes-index`, `quotes-add`, `quotes-edit`, `quotes-pdf`, `quotes-email`, `quotes-delete`, `sales-index`, `sales-add`, `sales-edit`, `sales-pdf`, `sales-email`, `sales-delete`, `purchases-index`, `purchases-add`, `purchases-edit`, `purchases-pdf`, `purchases-email`, `purchases-delete`, `transfers-index`, `transfers-add`, `transfers-edit`, `transfers-pdf`, `transfers-email`, `transfers-delete`, `customers-index`, `customers-add`, `customers-edit`, `customers-delete`, `suppliers-index`, `suppliers-add`, `suppliers-edit`, `suppliers-delete`, `sales-deliveries`, `sales-add_delivery`, `sales-edit_delivery`, `sales-delete_delivery`, `sales-email_delivery`, `sales-pdf_delivery`, `sales-gift_cards`, `sales-add_gift_card`, `sales-edit_gift_card`, `sales-delete_gift_card`, `pos-index`, `sales-return_sales`, `reports-index`, `reports-warehouse_stock`, `reports-quantity_alerts`, `reports-expiry_alerts`, `reports-products`, `reports-daily_sales`, `reports-monthly_sales`, `reports-sales`, `reports-payments`, `reports-purchases`, `reports-profit_loss`, `reports-customers`, `reports-suppliers`, `reports-staff`, `reports-register`, `sales-payments`, `purchases-payments`, `purchases-expenses`) VALUES
(1, 5, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_pos_register`
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
-- Dumping data for table `sma_pos_register`
--

INSERT INTO `sma_pos_register` (`id`, `date`, `user_id`, `cash_in_hand`, `status`, `total_cash`, `total_cheques`, `total_cc_slips`, `total_cash_submitted`, `total_cheques_submitted`, `total_cc_slips_submitted`, `note`, `closed_at`, `transfer_opened_bills`, `closed_by`) VALUES
(1, '2017-03-19 05:20:11', 1, '1222.0000', 'open', NULL, NULL, NULL, '0.0000', 0, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_pos_settings`
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
-- Dumping data for table `sma_pos_settings`
--

INSERT INTO `sma_pos_settings` (`pos_id`, `cat_limit`, `pro_limit`, `default_category`, `default_customer`, `default_biller`, `display_time`, `cf_title1`, `cf_title2`, `cf_value1`, `cf_value2`, `receipt_printer`, `cash_drawer_codes`, `focus_add_item`, `add_manual_product`, `customer_selection`, `add_customer`, `toggle_category_slider`, `toggle_subcategory_slider`, `cancel_sale`, `suspend_sale`, `print_items_list`, `finalize_sale`, `today_sale`, `open_hold_bills`, `close_register`, `keyboard`, `pos_printers`, `java_applet`, `product_button_color`, `tooltips`, `paypal_pro`, `stripe`, `rounding`, `char_per_line`, `pin_code`, `purchase_code`, `envato_username`, `version`) VALUES
(1, 22, 20, 1, 1, 3, '1', 'GST Reg', 'VAT Reg', '123456789', '987654321', 'BIXOLON SRP-350II', 'x1C', 'Ctrl+F3', 'Ctrl+Shift+M', 'Ctrl+Shift+C', 'Ctrl+Shift+A', 'Ctrl+F11', 'Ctrl+F12', 'F4', 'F7', 'F9', 'F8', 'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F10', 1, 'BIXOLON SRP-350II, BIXOLON SRP-350II', 0, 'default', 1, 0, 0, 0, 42, NULL, 'purchase_code', 'envato_username', '3.0.1.13');

-- --------------------------------------------------------

--
-- Table structure for table `sma_productions`
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
-- Dumping data for table `sma_productions`
--

INSERT INTO `sma_productions` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`, `working`) VALUES
(41, '2017-07-21', '1234', 1, 'Walk-in Customer', NULL, NULL, 1, '&lt;p&gt;1234&lt;&sol;p&gt;', '', '25000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '25000.0000', 'completed', NULL, NULL, '2017-07-21', 1, NULL, NULL, 30, 0, '0.0000', NULL, '0.0000', NULL, ''),
(42, '2017-07-22', '123', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '70000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '70000.0000', 'completed', NULL, NULL, '2017-07-30', 1, 1, '2017-08-03 08:39:14', NULL, 0, '0.0000', NULL, '0.0000', NULL, ''),
(43, '2017-08-03', 'cdf', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '100000.0000', 'completed', NULL, NULL, '2017-08-03', 1, NULL, NULL, 100, 0, '0.0000', NULL, '0.0000', NULL, 'ffefe'),
(44, '2017-08-03', '3434', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '250000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '250000.0000', 'cancel', NULL, NULL, '2017-08-03', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, ''),
(45, '2017-07-21', '1234', 1, 'Walk-in Customer', NULL, NULL, 1, '&lt;p&gt;1234&lt;&sol;p&gt;', '', '100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '100000.0000', 'cancel', NULL, NULL, '2017-08-03', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, '201'),
(46, '2017-08-03', '435', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '75000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '75000.0000', 'cancel', NULL, NULL, '2017-08-03', 1, NULL, NULL, 100, 0, '0.0000', NULL, '0.0000', NULL, '54454'),
(47, '2017-08-03', 'dsaed', 4, 'tư nhân', NULL, NULL, 1, '', '', '100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '100000.0000', 'cancel', NULL, NULL, '2017-08-03', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, 'erewr'),
(48, '2017-08-03', 'iui', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '100000.0000', 'completed', NULL, NULL, '2017-08-03', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, 'iuiu'),
(49, '2017-08-03', 'sfdf', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '100000.0000', 'pending', NULL, NULL, '2017-08-03', 1, NULL, NULL, 127, 0, '0.0000', NULL, '0.0000', NULL, 'ds'),
(50, '2017-08-15', '10', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '1000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '1000.0000', 'pending', NULL, NULL, '2017-08-15', 1, NULL, NULL, 1, 0, '0.0000', NULL, '0.0000', NULL, 'abc'),
(51, '2017-08-15', '15', 4, 'tư nhân', NULL, NULL, 1, '', '', '500.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '500.0000', 'pending', NULL, NULL, '2017-08-15', 1, NULL, NULL, 1, 0, '0.0000', NULL, '0.0000', NULL, 'BBB'),
(52, '2017-09-03', '145', 4, 'tư nhân', NULL, NULL, 1, '', '', '1000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '1000.0000', 'pending', NULL, NULL, '2017-09-22', 1, NULL, NULL, 1, 0, '0.0000', NULL, '0.0000', NULL, 'HNH'),
(53, '2017-08-20', 'PO001', 1, 'Walk-in Customer', NULL, NULL, 1, '', '', '500000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '500000.0000', 'pending', NULL, NULL, '2017-08-20', 1, 1, '2017-08-20 09:51:32', NULL, 0, '0.0000', NULL, '0.0000', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_production_items`
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
-- Dumping data for table `sma_production_items`
--

INSERT INTO `sma_production_items` (`id`, `sale_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `balance_quantity`, `status`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`) VALUES
(70, 41, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '20.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '20000.0000', '', '1000.0000'),
(71, 41, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '10.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '5000.0000', '', '500.0000'),
(74, 43, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '100000.0000', '', '1000.0000'),
(75, 42, 29, 'N122-30 (ND)', 'Đế trụ', 'null', 0, '1000.0000', '1000.0000', '20.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '20000.0000', '', '1000.0000'),
(76, 42, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(77, 44, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '200.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '200000.0000', '', '1000.0000'),
(78, 44, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(79, 45, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(80, 45, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '50.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '1000.0000'),
(81, 46, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '50.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '1000.0000'),
(82, 46, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '50.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '25000.0000', '', '500.0000'),
(83, 47, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '50.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '1000.0000'),
(84, 47, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(85, 48, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'completed', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(86, 48, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '50.0000', NULL, 'completed', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '1000.0000'),
(87, 49, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '100.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '500.0000'),
(88, 49, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '50.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '50000.0000', '', '1000.0000'),
(89, 50, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '1000.0000', '', '1000.0000'),
(90, 51, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', NULL, '500.0000', '500.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '500.0000', '', '500.0000'),
(91, 52, 29, 'N122-30 (ND)', 'Đế trụ', 'null', NULL, '1000.0000', '1000.0000', '1.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '1000.0000', '', '1000.0000'),
(93, 53, 30, 'XACAP', 'Xà đỡ cáp ngầm', 'null', 0, '500.0000', '500.0000', '1000.0000', NULL, 'pending', 1, '0.0000', 0, '', NULL, '0.0000', '500000.0000', '', '500.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_production_stages`
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
-- Dumping data for table `sma_production_stages`
--

INSERT INTO `sma_production_stages` (`id`, `product_id`, `production_id`, `stage`, `date_start`, `date_end`, `employee_id`, `employee`, `stage_status`, `error_quantity`, `quantity`, `note`) VALUES
(10, 29, 39, 'gd1', '2017-06-26', '2017-06-28', NULL, '3,7', 'completed', '5', '5', NULL),
(11, 29, 39, 'gd2', '2017-06-28', '2017-06-30', NULL, '7', 'completed', '3', '2', NULL),
(12, 30, 39, 'GD1', '2017-06-26', '2017-06-27', NULL, '3,9', 'not_start', '2131', '12', NULL),
(13, 30, 39, 'GD2', '2017-06-27', '2017-06-30', NULL, '8', 'not_start', '0', '0', NULL),
(16, 29, 40, 'gd1', NULL, NULL, NULL, '7', 'not_start', '1', '20', NULL),
(17, 29, 40, 'gd2', NULL, NULL, NULL, '5', 'not_start', '10', '10', NULL),
(18, 29, 41, 'gd1', '2017-07-22', '2017-07-29', NULL, '3', 'completed', '2', '18', NULL),
(19, 29, 41, 'gd2', '2017-07-21', '2017-07-23', NULL, '7', 'completed', '1', '17', NULL),
(22, 29, 42, 'gd1', '2017-07-22', '2017-07-23', NULL, '5', 'completed', '2', '18', NULL),
(23, 29, 42, 'gd2', '2017-07-23', '2017-07-24', NULL, '7', 'completed', '0', '18', NULL),
(24, 29, 43, 'gd1', '2017-08-04', '2017-08-10', NULL, '7', 'completed', '10', '90', NULL),
(25, 29, 43, 'gd2', '2017-08-11', '2017-08-31', NULL, '7,8,5', 'completed', '0', '90', NULL),
(26, 30, 42, 'GD1', '2017-07-22', '2017-07-25', NULL, '7', 'completed', '10', '90', NULL),
(27, 30, 42, 'GD2', '2017-07-28', '2017-07-28', NULL, '8', 'completed', '0', '90', NULL),
(28, 29, 44, 'gd1', '2017-08-03', '2017-08-03', NULL, '3', 'not_start', NULL, NULL, NULL),
(29, 29, 44, 'gd2', '2017-08-03', '2017-08-03', NULL, '3,5', 'not_start', NULL, NULL, NULL),
(30, 30, 44, 'GD1', '2017-08-03', '2017-08-03', NULL, '9', 'not_start', NULL, NULL, NULL),
(31, 30, 44, 'GD2', '2017-08-03', '2017-08-03', NULL, '9,5', 'not_start', NULL, NULL, NULL),
(32, 30, 45, 'GD1', '2017-07-26', '2017-08-02', NULL, '7', 'not_start', NULL, NULL, NULL),
(33, 30, 45, 'GD2', '2017-07-27', '2017-08-02', NULL, '7', 'not_start', NULL, NULL, NULL),
(34, 29, 45, 'gd1', '2017-07-27', '2017-08-03', NULL, '5', 'not_start', NULL, NULL, NULL),
(35, 29, 45, 'gd2', '2017-07-27', '2017-08-03', NULL, '9', 'not_start', NULL, NULL, NULL),
(36, 30, 46, 'GD1', '2017-08-03', '2017-08-03', NULL, '9,7', 'not_start', NULL, NULL, NULL),
(37, 30, 46, 'GD2', '2017-08-03', '2017-08-03', NULL, '7', 'not_start', NULL, NULL, NULL),
(38, 29, 46, 'gd1', '2017-08-03', '2017-08-03', NULL, '3', 'not_start', NULL, NULL, NULL),
(39, 29, 46, 'gd2', '2017-08-03', '2017-08-03', NULL, '5', 'not_start', NULL, NULL, NULL),
(40, 29, 47, 'gd1', '2017-08-03', '2017-08-03', NULL, '8', 'not_start', NULL, NULL, NULL),
(41, 29, 47, 'gd2', '2017-08-03', '2017-08-03', NULL, '5', 'not_start', NULL, NULL, NULL),
(42, 30, 47, 'GD1', '2017-08-03', '2017-08-03', NULL, '5', 'not_start', NULL, NULL, NULL),
(43, 30, 47, 'GD2', '2017-08-03', '2017-08-03', NULL, '5', 'not_start', NULL, NULL, NULL),
(44, 29, 48, 'gd1', '2017-08-03', '2017-08-03', NULL, '5', 'completed', '0', '25', NULL),
(45, 29, 48, 'gd2', '2017-08-03', '2017-08-03', NULL, '3', 'completed', '0', '25', NULL),
(46, 30, 48, 'GD1', '2017-08-03', '2017-08-03', NULL, '3', 'completed', '50', '50', NULL),
(47, 30, 48, 'GD2', '2017-08-03', '2017-08-03', NULL, '9', 'completed', '0', '50', NULL),
(48, 30, 49, 'GD1', '2017-08-03', '2017-08-03', NULL, '3', 'pending', '0', '0', NULL),
(49, 30, 49, 'GD2', '2017-08-03', '2017-08-03', NULL, '7', 'not_start', NULL, NULL, NULL),
(50, 29, 50, 'gd1', '2017-08-15', '2017-08-15', NULL, '5', 'not_start', NULL, NULL, NULL),
(51, 29, 50, 'gd2', '2017-08-15', '2017-08-15', NULL, '5,8', 'not_start', NULL, NULL, NULL),
(52, 29, 52, 'gd1', '2017-09-03', '2017-09-03', NULL, '7', 'not_start', NULL, NULL, NULL),
(53, 29, 52, 'gd2', '2017-09-22', '2017-09-22', NULL, '8,7', 'not_start', NULL, NULL, NULL),
(54, 30, 53, 'GD1', '2017-08-20', '2017-08-22', NULL, '7', 'completed', '-800', '900', NULL),
(55, 30, 53, 'GD2', '2017-08-22', '2017-08-22', NULL, '7,8,5', 'not_start', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_production_stage_details`
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
-- Dumping data for table `sma_production_stage_details`
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
(39, 40, 17, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-07-21 14:04:15', 'Owner Owner'),
(40, 41, 18, 1, '&lt;p&gt;6&plus;52659&lt;&sol;p&gt;', '2017-08-03 14:32:17', 'Owner Owner'),
(41, 41, 18, 1, '&lt;p&gt;54444&lt;&sol;p&gt;', '2017-08-03 14:33:20', 'Owner Owner'),
(42, 41, 18, 1, '&lt;p&gt;5&lt;&sol;p&gt;', '2017-08-03 14:35:04', 'Owner Owner'),
(43, 41, 19, 1, '&lt;p&gt;5615&lt;&sol;p&gt;', '2017-08-03 14:35:21', 'Owner Owner'),
(44, 41, 19, 1, '&lt;p&gt;88&lt;&sol;p&gt;', '2017-08-03 14:36:16', 'Owner Owner'),
(45, 42, 22, 1, '&lt;p&gt;jhjh&lt;&sol;p&gt;', '2017-08-03 14:42:40', 'Owner Owner'),
(46, 42, 22, 1, '&lt;p&gt;ijoio&lt;&sol;p&gt;', '2017-08-03 14:42:58', 'Owner Owner'),
(47, 42, 23, 1, '&lt;p&gt;hhh&lt;&sol;p&gt;', '2017-08-03 14:43:10', 'Owner Owner'),
(48, 42, 23, 1, '&lt;p&gt;hhh&lt;&sol;p&gt;', '2017-08-03 14:43:31', 'Owner Owner'),
(49, 42, 26, 1, '&lt;p&gt;ghghgh&lt;&sol;p&gt;', '2017-08-03 14:44:13', 'Owner Owner'),
(50, 42, 26, 1, '&lt;p&gt;jkkj&lt;&sol;p&gt;', '2017-08-03 14:44:39', 'Owner Owner'),
(51, 42, 27, 1, '&lt;p&gt;kjjk&lt;&sol;p&gt;', '2017-08-03 14:44:46', 'Owner Owner'),
(52, 42, 27, 1, '&lt;p&gt;jhjh&lt;&sol;p&gt;', '2017-08-03 14:44:58', 'Owner Owner'),
(53, 43, 24, 1, '&lt;p&gt;gfgfgf&lt;&sol;p&gt;', '2017-08-03 14:53:12', 'Owner Owner'),
(54, 43, 24, 1, '&lt;p&gt;hghg&lt;&sol;p&gt;', '2017-08-03 14:53:26', 'Owner Owner'),
(55, 43, 25, 1, '&lt;p&gt;hggh&lt;&sol;p&gt;', '2017-08-03 14:53:34', 'Owner Owner'),
(56, 43, 25, 1, '&lt;p&gt;hggh&lt;&sol;p&gt;', '2017-08-03 14:53:47', 'Owner Owner'),
(57, 48, 46, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-08-04 09:41:10', 'Owner Owner'),
(58, 48, 47, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-08-04 09:41:47', 'Owner Owner'),
(59, 48, 47, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-08-04 09:44:47', 'Owner Owner'),
(60, 48, 44, 1, '&lt;p&gt;ererewr&lt;&sol;p&gt;', '2017-08-04 10:02:49', 'Owner Owner'),
(61, 48, 45, 1, '&lt;p&gt;rerewr&lt;&sol;p&gt;', '2017-08-04 10:03:08', 'Owner Owner'),
(62, 48, 44, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-08-04 10:06:11', 'Owner Owner'),
(63, 48, 47, 1, '&lt;p&gt;123&lt;&sol;p&gt;', '2017-08-04 10:10:31', 'Owner Owner'),
(64, 48, 47, 1, '&lt;p&gt;121212&lt;&sol;p&gt;', '2017-08-04 10:12:11', 'Owner Owner'),
(65, 49, 48, 1, '&lt;p&gt;hh&lt;&sol;p&gt;', '2017-08-15 08:47:50', 'Owner Owner'),
(66, 53, 54, 1, '&lt;p&gt;DG TOI GIAI GIROI&lt;&sol;p&gt;', '2017-08-20 15:59:20', 'Owner Owner'),
(67, 53, 54, 1, '&lt;p&gt;TRE&lt;&sol;p&gt;', '2017-08-20 16:19:23', 'Owner Owner');

-- --------------------------------------------------------

--
-- Table structure for table `sma_products`
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
-- Dumping data for table `sma_products`
--

INSERT INTO `sma_products` (`id`, `code`, `name`, `unit`, `cost`, `price`, `alert_quantity`, `image`, `category_id`, `subcategory_id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `quantity`, `tax_rate`, `track_quantity`, `details`, `warehouse`, `barcode_symbology`, `file`, `product_details`, `tax_method`, `type`, `supplier1`, `supplier1price`, `supplier2`, `supplier2price`, `supplier3`, `supplier3price`, `supplier4`, `supplier4price`, `supplier5`, `supplier5price`) VALUES
(29, 'N122-30 (ND)', 'Đế trụ', 'Cai', NULL, '1000.0000', NULL, 'no_image.png', NULL, NULL, 'Quy cach', '1000', '2', '[\"gd1\",\"gd2\"]', '[{\"id\":\"5\",\"item\":\"Nvl1\",\"quantity\":\"10\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"5\"}]', '3', '25.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'XACAP', 'Xà đỡ cáp ngầm', 'Kg', NULL, '500.0000', NULL, 'no_image.png', NULL, NULL, 'Quy cach', '500', '3', '[\"GD1\",\"GD2\"]', '[{\"id\":\"2\",\"item\":\"Bao tr\\u1eafng\",\"quantity\":\"10\"},{\"id\":\"4\",\"item\":\"Th\\u00e9p t\\u1ea5m\",\"quantity\":\"5\"},{\"id\":\"5\",\"item\":\"Nguyen vat lieu 1\",\"quantity\":\"3\"}]', '2', '900.0000', NULL, 0, NULL, 1, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_product_photos`
--

CREATE TABLE `sma_product_photos` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_product_variants`
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
-- Table structure for table `sma_purchases`
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
-- Dumping data for table `sma_purchases`
--

INSERT INTO `sma_purchases` (`id`, `reference_no`, `date`, `supplier_id`, `supplier`, `warehouse_id`, `note`, `total`, `product_discount`, `order_discount_id`, `order_discount`, `total_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `paid`, `status`, `payment_status`, `created_by`, `updated_by`, `updated_at`, `attachment`) VALUES
(154, 'PO/2017/07/0100', '2017-07-20 09:20:00', 2, 'Yanstore', 1, '', '2000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '2000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(155, 'ENQUERY/2017/08/0052', '2017-08-03 08:21:00', NULL, NULL, 1, '&lt;p&gt;Y&ecirc;u cầu nhập h&agrave;ng &sol; 2017-08-03&lt;&sol;p&gt;', '1000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '1000.0000', '0.0000', 'approval', 'pending', 1, 1, '2017-08-03 08:25:13', NULL),
(156, 'tgrett', '2017-08-03 07:25:00', 2, 'Yanstore', 1, '', '1000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '1000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(157, 'jjj', '2017-08-03 07:28:00', 2, 'Yanstore', 1, '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(158, 'ENQUERY/2017/08/0053', '2017-08-03 08:40:55', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(159, 'ENQUERY/2017/08/0054', '2017-08-03 09:06:00', NULL, NULL, 1, '&lt;p&gt;Y&ecirc;u cầu nhập h&agrave;ng &sol; 2017-08-03&lt;&sol;p&gt;', '201017000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', '201017000.0000', '0.0000', 'approval', 'pending', 1, 1, '2017-08-03 09:06:50', NULL),
(160, 'PO/2017/08/0101', '2017-08-03 08:06:00', 2, 'Yanstore', 1, '', '201017000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '201017000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(161, 'ENQUERY/2017/08/0055', '2017-08-03 09:08:09', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(162, 'PO/2017/08/0102', '2017-08-03 08:11:00', 2, 'Yanstore', 1, '', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(163, 'PO/2017/08/0103', '2017-08-03 08:12:00', 2, 'Yanstore', 1, '', '200100000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '200100000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(164, 'PO/2017/08/0104', '2017-08-03 08:25:00', 2, 'Yanstore', 1, '', '917000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '917000.0000', '0.0000', 'received', 'pending', 1, NULL, NULL, NULL),
(165, 'ENQUERY/2017/08/0056', '2017-08-03 11:19:35', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(166, 'ENQUERY/2017/08/0057', '2017-08-03 11:19:52', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(167, 'ENQUERY/2017/08/0058', '2017-08-03 11:20:56', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(168, 'ENQUERY/2017/08/0059', '2017-08-03 11:23:52', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(169, 'ENQUERY/2017/08/0060', '2017-08-03 11:24:06', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-03', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL),
(170, 'ENQUERY/2017/08/0061', '2017-08-20 09:52:45', NULL, NULL, 1, 'Yêu cầu nhập hàng / 2017-08-20', '1607046000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', 0, '0.0000', '0.0000', '0.0000', '1607046000.0000', '0.0000', 'approve', 'pending', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_purchase_items`
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
-- Dumping data for table `sma_purchase_items`
--

INSERT INTO `sma_purchase_items` (`id`, `purchase_id`, `transfer_id`, `product_id`, `item_id`, `product_code`, `product_name`, `option_id`, `net_unit_cost`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `expiry`, `subtotal`, `quantity_balance`, `date`, `status`, `unit_cost`, `real_unit_cost`) VALUES
(348, 154, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '2000.0000', '100.0000', '2017-07-20', 'received', '20.0000', '20.0000'),
(349, 154, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '200.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '200.0000', '2017-07-20', 'received', '0.0000', '0.0000'),
(350, NULL, NULL, NULL, 3, NULL, 'Sơn xanh', NULL, NULL, '0.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(357, 155, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '50.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '1000.0000', '0.0000', '2017-08-03', 'approval', '20.0000', '20.0000'),
(358, 155, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '100.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '50.0000', '2017-08-03', 'approval', '0.0000', '0.0000'),
(359, 156, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '50.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '1000.0000', '50.0000', '2017-08-03', 'received', '20.0000', '20.0000'),
(360, 156, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '50.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '50.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(361, 157, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '50.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '50.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(374, 159, NULL, NULL, 2, NULL, 'Bao trắng', NULL, '20000.0000', '10000.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '200000000.0000', '0.0000', '2017-08-03', 'approval', '20000.0000', '20000.0000'),
(375, 159, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '50850.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '1017000.0000', '45850.0000', '2017-08-03', 'approval', '20.0000', '20.0000'),
(376, 159, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '1650.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '0.0000', '2017-08-03', 'approval', '0.0000', '0.0000'),
(377, 160, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '50.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '50.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(378, 160, NULL, NULL, 2, NULL, 'Bao trắng', NULL, '20000.0000', '10000.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '200000000.0000', '10000.0000', '2017-08-03', 'received', '20000.0000', '20000.0000'),
(379, 160, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '50850.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '1017000.0000', '50850.0000', '2017-08-03', 'received', '20.0000', '20.0000'),
(380, 160, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '1650.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '1650.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(381, 162, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '25.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '25.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(382, 163, NULL, NULL, 2, NULL, 'Bao trắng', NULL, '20000.0000', '10000.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '200000000.0000', '10000.0000', '2017-08-03', 'received', '20000.0000', '20000.0000'),
(383, 163, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '5000.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '100000.0000', '5000.0000', '2017-08-03', 'received', '20.0000', '20.0000'),
(384, 163, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '1650.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '1650.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(385, 164, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '45850.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '917000.0000', '45850.0000', '2017-08-03', 'received', '20.0000', '20.0000'),
(386, 164, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '0.0000', 1, '0.0000', 0, '', '0', '0.0000', NULL, '0.0000', '0.0000', '2017-08-03', 'received', '0.0000', '0.0000'),
(387, 165, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '96275.0000', 2, '0.0000', 0, '0', '0', '0.0000', NULL, '0.0000', '96275.0000', '2017-08-03', 'approve', '0.0000', '0.0000'),
(388, 166, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '99996275.0000', 2, '0.0000', 0, '0', '0', '0.0000', NULL, '0.0000', '99996275.0000', '2017-08-03', 'approve', '0.0000', '0.0000'),
(389, 167, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '99996275.0000', 2, '0.0000', 0, '0', '0', '0.0000', NULL, '0.0000', '99996275.0000', '2017-08-03', 'approve', '0.0000', '0.0000'),
(390, 168, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '99996275.0000', 2, '0.0000', 0, '0', '0', '0.0000', NULL, '0.0000', '99996275.0000', '2017-08-03', 'approve', '0.0000', '0.0000'),
(391, 169, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, '0.0000', '99996275.0000', 2, '0.0000', 0, '0', '0', '0.0000', NULL, '0.0000', '99996275.0000', '2017-08-03', 'approve', '0.0000', '0.0000'),
(395, NULL, NULL, NULL, 21, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(403, 170, NULL, NULL, 4, NULL, 'Thép tấm', NULL, '20.0000', '352300.0000', 1, '0.0000', 0, '0', '0', '0.0000', NULL, '7046000.0000', '352300.0000', '2017-08-20', 'approve', '20.0000', '20.0000'),
(404, 170, NULL, NULL, 2, NULL, 'Bao trắng', NULL, '20000.0000', '80000.0000', 1, '0.0000', 0, '0', '0', '0.0000', NULL, '1600000000.0000', '80000.0000', '2017-08-20', 'approve', '20000.0000', '20000.0000'),
(405, NULL, NULL, NULL, 2, NULL, 'Bao trắng', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(406, NULL, NULL, NULL, 4, NULL, 'Thép tấm', NULL, NULL, '0.0000', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL),
(407, NULL, NULL, NULL, 5, NULL, 'Nguyen vat lieu 1', NULL, NULL, '0.0000', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_quotes`
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
-- Table structure for table `sma_quote_items`
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
-- Table structure for table `sma_return_items`
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
-- Table structure for table `sma_return_sales`
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
-- Table structure for table `sma_sales`
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
-- Dumping data for table `sma_sales`
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
-- Table structure for table `sma_sale_items`
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
-- Dumping data for table `sma_sale_items`
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
-- Table structure for table `sma_sessions`
--

CREATE TABLE `sma_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_sessions`
--

INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('006d6caee31a5732386551d65a9f868c46a79851', '::1', 1502252002, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323235313938393b6964656e746974797c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b757365726e616d657c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b656d61696c7c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b757365725f69647c733a313a2235223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032323531393536223b6c6173745f69707c4e3b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b62696c6c65725f69647c733a313a2233223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a34353a223c703e42e1baa16e20c491c3a320c491c4836e67206e68e1baad70207468c3a06e682063c3b46e672e3c2f703e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('0575ba2ac0d42b54cd9f7390fa8daec682108735', '::1', 1502773637, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737333436343b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0ad53eadf3ceb8ac09f6fc68eddc09285f65d97e', '::1', 1502769726, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736393531323b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0e1ce459bef128b1c1785f7f7af709dc6959ea73', '::1', 1502771269, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737303939343b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0e8cfe4019d1d0a365f35cb6b6d2182ba6fb3151', '::1', 1502763724, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736333730343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22336d39314565675170326973385577446e586b62223b),
('117989a0d5376a6750d0fa4660cff0fe295f6208', '::1', 1502253499, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323235333338343b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032323531373538223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1da5d6350e6786554f3a5e548f0a1329d63abcbc', '::1', 1501819559, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831393432333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2019e6573a04a07356cf7180e94844160e05142e', '::1', 1501811815, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831313539383b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('24b7e0b1e0bea7b13a80fbc346b88475efa2fce8', '::1', 1501818897, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831383734373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('26a83f8b3e707fa928385f1cddb5a8e4a7c68770', '::1', 1501823645, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313832333434313b7265717565737465645f706167657c733a32373a2273797374656d5f73657474696e67732f757365725f67726f757073223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031383039393531223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('26f4d0266741a0331891633de5047b7aba1f8aed', '::1', 1501816472, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831363431373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('28796ad85eb5c0da3f18b09e89764079f4cca062', '::1', 1502762039, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736313935323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2241384778736f3964667643677075505534574f4c223b),
('29bec60a31baf2104c8e16141a03b304477fde80', '::1', 1502253362, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323235333037303b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032323531373538223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a34353a225468c3aa6d206e68c3b36d206e67c6b0e1bb9d692073e1bbad2064e1bba56e67207468c3a06e682063c3b46e67223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('2a0dcb244a598a68de386c1617e148fbfd641dde', '::1', 1502770528, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737303235363b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2a5cf4fb3e0318ca1afa0c1f35397a7a4b2f097e', '::1', 1502763336, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736333333313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22336d39314565675170326973385577446e586b62223b),
('2ca5c81133b2fa9000c305e1fd90328ded7d46bd', '::1', 1503206612, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333230363535313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635373335223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2e8cd7b9b9bc522e29fe96fc77380775df49f716', '::1', 1501814338, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831333936353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('301d2faed7ad0005681cec3ece2f5493dfb80d5b', '::1', 1501819869, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831393739363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('35668598497b7dc33f4f4a770bafcd6011a9e052', '::1', 1501819351, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831393036363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('374cd80e2bc40a18d120d27dbe0071b79fc4dfde', '::1', 1502761901, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736313535353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2272365276415a67616835754b574a58324c784449223b),
('3753442190827e7466fa33566ca32e463ca1b8b9', '::1', 1501815483, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831353333333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('38eeb07bff68542a15df53d12ab4dcbd15dedc3c', '::1', 1502766399, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736363239393b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3981181dbec1b70f3826d8d831cc2c048726880e', '::1', 1501815197, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831343936323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3a6d763e551e80aa04dcd45a26614a5f9c60e5a6', '::1', 1503229295, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333232393239353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353639223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3ac4d246164d7d4cfcde51a915b06aebc641a97e', '::1', 1502771908, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737313930383b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3d88b21a000968134dbc186948dc7e8f078485b8', '::1', 1503219630, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333231393536303b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2276384575476a3453357451316355594243546e79223b),
('4032ba242502f19dc23593f4afe16ef8070c1fd5', '::1', 1502774145, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737343034373b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('415d06edbd444f0f6aa47c9bc87c73089e74112e', '::1', 1501816024, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831353734323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('47edf3dfc1a11fa14a349699b0d7acdef10ab0e3', '::1', 1502771561, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737313332363b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4a430653c468383416e6a4f8fefb1bb9d48393e1', '::1', 1502772518, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737323232303b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4d1c1720fe4a4e197c99e4882e3d882fecb186dc', '::1', 1502331648, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323333313634313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032323533303736223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4f5a61e324771a238fde7dea79c3f7a0fdbb5f3e', '::1', 1501817416, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831373335313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('4f789fbefd4247c1d4741a415fb95dd7efe1ab54', '::1', 1503218719, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333231383438333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5335eece2950144330b6abe49ea301bdc4acb18f', '::1', 1503220833, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333232303537353b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2276384575476a3453357451316355594243546e79223b72656d6f76655f706f6c737c733a313a2231223b),
('5d87c37a43bbcc9096a6f7320f2b1a66ea107116', '::1', 1502772561, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737323533303b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('628e68b3870d4b6ff8aaff967a839f03662d260c', '::1', 1502767619, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736373332313b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('62927030c724c56c35cfa04231377a8721f5de90', '::1', 1502768551, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736383338343b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7080b1d3aa9d6371ff7e6f10c98b293e9988bffa', '::1', 1502766023, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736353931303b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('74fed334a52852504aef3b3baddbcbc01e0755a7', '::1', 1502765735, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736353436393b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a34353a223c703e42e1baa16e20c491c3a320c491c4836e67206e68e1baad70207468c3a06e682063c3b46e672e3c2f703e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226e6577223b7d),
('7cafed22a1426ff54e2fbad81b93656ac537a1e4', '::1', 1502767744, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736373638373b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7f34492c750bcb6355d47bab92e02c7685561ed1', '::1', 1502764164, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736343036353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22336d39314565675170326973385577446e586b62223b),
('7f4ef7a0a3601c1122ec67cad6aaa3483edc8756', '::1', 1502762427, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736323430323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22336d39314565675170326973385577446e586b62223b),
('7ffde214e2c21f6d1ccfa9765698cd3c16cfa361', '::1', 1502779178, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737393136373b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('834a535461769f2335f5417d19b86326d1444100', '::1', 1502767145, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736363933373b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('846cd68517d1b47ae69cd1e3319530249d83349e', '::1', 1502770838, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737303630373b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('883a9ab1104849bf739b111d24a01c7fd280ddf6', '::1', 1502760816, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736303537303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a227753443230423778597a6b6a5a3575504f4e3858223b),
('8c4feed827a004eec019500c266f625464a51e27', '::1', 1501814551, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831343334343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('900f90755d651d5b102931e5f008c39eb263b144', '::1', 1502768301, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736383032393b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('93e760b6c1b0de1f79cc5d0fcf38ace76e8af3ba', '::1', 1502704636, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323730343539373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032333331363436223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('95f8620d6e5d61d3d25051508d3e551a27f9c6cd', '::1', 1502773316, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323737333036333b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a1709f570bfc1c90e2333825b705ce8dd1072a03', '::1', 1502252467, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323235323436363b6964656e746974797c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b757365726e616d657c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b656d61696c7c733a33303a226e677579656e746875616e2e666f736f736f667440676d61696c2e636f6d223b757365725f69647c733a313a2235223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032323531393536223b6c6173745f69707c4e3b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b62696c6c65725f69647c733a313a2233223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ad45386d6c7f586c6c4c13708f45b2ce9fbb3fa5', '::1', 1501812779, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831323439363b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b1d3d908a2179d39236b2ab17085b33ea3f3ee09', '::1', 1502762916, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736323734323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373034363031223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22336d39314565675170326973385577446e586b62223b),
('b7e4ad45f8faf7af4a7c72cb5da1d3a1895fd109', '::1', 1501818650, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831383336303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('beeff37066a63242fd21c55e800c417cc7b96dec', '::1', 1503219207, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333231383930343b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a224470654f7a4b4c63613071646652754232467449223b),
('bfea5753ff9275d42dd1ad2137a204f789263bfa', '::1', 1501812212, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831323136333b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c6964479305ef0a2d4774ba018d32ac6872d8138', '::1', 1501817749, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831373731323b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d11d41b99ef2039856b0471d6c2c3f6b39f81bce', '::1', 1501813876, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831333634373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d1a1965abed7d482506c5980e80c3a58693b7508', '::1', 1501818329, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831383033373b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d4928123d9b926361ef699e756ca16d22e128654', '::1', 1501811206, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831313134313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d8728fc5cf651200b5dddbcf026b5cddcae91b81', '::1', 1501821242, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313832303937393b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('db59f2a89d10dfbabf04892a55b2466cb559d15b', '::1', 1502769345, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736393138363b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ebfb3f207625744de3362a5ab16f0861e9fc3371', '::1', 1501810099, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313830393934353b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f15fcdd1e94197176e8ccf2a73976fb9ea9fdde3', '::1', 1501813128, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831323836303b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b7761726e696e677c733a36343a224b68c3b46e67207468e1bb832063e1baad70206ec3a079207469e1babf6e20c491e1bb99206b6869206368c6b0612063686f2076c3a06f2078e1bbad206cc3bd223b5f5f63695f766172737c613a313a7b733a373a227761726e696e67223b733a333a226f6c64223b7d);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('f3a7c022f674d26236ea12bebb82de2f27c8435c', '::1', 1501814949, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831343636313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f553ac866efa2b72a462f36830ff5bcc28741e05', '::1', 1503216764, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333231363536313b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f72cc7e1d4c4f49ffe79300ab6a387004e9606ba', '::1', 1503219517, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530333231393231333b7265717565737465645f706167657c733a303a22223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353033323136353631223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2276384575476a3453357451316355594243546e79223b),
('fb43d3057c41a4884ea5ddcc13b5ac6d17042bea', '::1', 1501816348, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313831363037313b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('feaab12ddecf6519b2e958b320346700e4fd56ab', '::1', 1501820559, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530313832303530343b7265717565737465645f706167657c733a31313a2270726f64756374696f6e73223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353031373339313939223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ff72ebeb60e30111678cdc97b5180dccea76d050', '::1', 1502766849, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736363633323b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ffc578d0311abe1c8d79bb24203f1ddfe06e1b21', '::1', 1502768961, 0x5f5f63695f6c6173745f726567656e65726174657c693a313530323736383639353b7265717565737465645f706167657c733a31393a227265706f7274732f7265706f72745f79637378223b6964656e746974797c733a31363a226f776e657240676f6f676c652e636f6d223b757365726e616d657c733a353a226f776e6572223b656d61696c7c733a31363a226f776e657240676f6f676c652e636f6d223b757365725f69647c733a313a2231223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231353032373635343733223b6c6173745f69707c733a333a223a3a31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c4e3b62696c6c65725f69647c4e3b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);

-- --------------------------------------------------------

--
-- Table structure for table `sma_settings`
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
-- Dumping data for table `sma_settings`
--

INSERT INTO `sma_settings` (`setting_id`, `logo`, `logo2`, `site_name`, `language`, `default_warehouse`, `accounting_method`, `default_currency`, `default_tax_rate`, `rows_per_page`, `version`, `default_tax_rate2`, `dateformat`, `sales_prefix`, `quote_prefix`, `purchase_prefix`, `transfer_prefix`, `delivery_prefix`, `payment_prefix`, `return_prefix`, `expense_prefix`, `item_addition`, `theme`, `product_serial`, `default_discount`, `product_discount`, `discount_method`, `tax1`, `tax2`, `overselling`, `restrict_user`, `restrict_calendar`, `timezone`, `iwidth`, `iheight`, `twidth`, `theight`, `watermark`, `reg_ver`, `allow_reg`, `reg_notification`, `auto_reg`, `protocol`, `mailpath`, `smtp_host`, `smtp_user`, `smtp_pass`, `smtp_port`, `smtp_crypto`, `corn`, `customer_group`, `default_email`, `mmode`, `bc_fix`, `auto_detect_barcode`, `captcha`, `reference_format`, `racks`, `attributes`, `product_expiry`, `decimals`, `decimals_sep`, `thousands_sep`, `invoice_view`, `default_biller`, `envato_username`, `purchase_code`, `rtl`, `each_spent`, `ca_point`, `each_sale`, `sa_point`, `update`, `sac`) VALUES
(1, 'logo2.png', 'logo4.png', 'PHẦN MỀM SẢN XUẤT FOSO', 'vietnamese', 1, 0, 'VND', 1, 10, '3.0.1.13', 1, 5, 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'ENQUERY', '', 0, 'default', 1, 1, 1, 1, 1, 1, 0, 1, 0, 'Asia/Singapore', 800, 800, 60, 60, 0, 0, 1, 1, NULL, 'smtp', '/usr/sbin/sendmail', 'smtp.gmail.com', 'tvtan06@gmail.com', '4oz0YVuabzm4aTMknlH+KZRfHpP/WFaOad737FKLlE3tOxeng1aKV9HxgdPnG1KLUp+9R9znqJqymYV2AJD4MA==', '587', 'tls', NULL, 1, 'tvtan06@gmail.com', 0, 4, 1, 0, 2, 1, 1, 0, 2, '.', ',', 0, 3, 'StockManager', '3', 0, NULL, NULL, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_skrill`
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
-- Dumping data for table `sma_skrill`
--

INSERT INTO `sma_skrill` (`id`, `active`, `account_email`, `secret_word`, `skrill_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'testaccount2@moneybookers.com', 'mbtest', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_subcategories`
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
-- Table structure for table `sma_suspended_bills`
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
-- Table structure for table `sma_suspended_items`
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
-- Table structure for table `sma_tax_rates`
--

CREATE TABLE `sma_tax_rates` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_tax_rates`
--

INSERT INTO `sma_tax_rates` (`id`, `name`, `code`, `rate`, `type`) VALUES
(1, 'No Tax', 'NT', '0.0000', '2'),
(2, 'VAT @10%', 'VAT10', '10.0000', '1'),
(3, 'GST @6%', 'GST', '6.0000', '1'),
(4, 'VAT @20%', 'VT20', '20.0000', '1');

-- --------------------------------------------------------

--
-- Table structure for table `sma_transfers`
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
-- Table structure for table `sma_transfer_items`
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
-- Table structure for table `sma_units`
--

CREATE TABLE `sma_units` (
  `id` int(10) NOT NULL,
  `unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sma_units`
--

INSERT INTO `sma_units` (`id`, `unit`, `note`) VALUES
(1, 'Cái', ''),
(2, 'Bao', NULL),
(3, 'Hộp', '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_users`
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
-- Dumping data for table `sma_users`
--

INSERT INTO `sma_users` (`id`, `last_ip_address`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `avatar`, `gender`, `group_id`, `warehouse_id`, `biller_id`, `company_id`, `show_cost`, `show_price`, `award_points`) VALUES
(1, 0x3a3a31, 0x0000, 'owner', '2c8ab736b2ccab4f50e72d5fd7d21020cbb77ae7', NULL, 'owner@google.com', NULL, NULL, NULL, '6e5e2f4c47ba10736e92891840965955f42f6f45', 1351661704, 1503229295, 1, 'Owner', 'Owner', 'Stock Manager', '012345678', NULL, 'male', 1, NULL, NULL, NULL, 0, 0, 0),
(2, 0x3a3a31, 0x3a3a31, 'tvtan06@gmail.com', 'cbe0b4851e0807748576e22fa8dc689134c78e07', NULL, 'tvtan06@gmail.com', NULL, NULL, NULL, NULL, 1497862980, 1497921746, 1, 'Tran', 'Tan', 'Foso', '097449157', NULL, 'male', 5, 1, 3, NULL, 0, 0, 0),
(3, NULL, 0x3a3a31, 'trantan', 'b9ce6ed6f53be863a43bf1cc04ae0451b394ed2a', NULL, 'trantan@gmail.com', NULL, NULL, NULL, NULL, 1498007958, 1498007958, 1, 'Tran', 'Tan', 'Walk-in Customer', '0939701693', NULL, 'male', 3, NULL, NULL, 1, 0, 0, 0),
(4, 0x3a3a31, 0x3a3a31, 'hva', '5c3341c973e77a19ee084a2c3496350eb94e03e3', NULL, 'hva@gmail.com', NULL, NULL, NULL, 'a4c9b2616656b62a26ab1f31d851600ceef11fe5', 1498009590, 1498093480, 1, 'fdgdf', 'dfgbf', 'Yanstore', '6786', NULL, 'male', 3, NULL, NULL, 2, 0, 0, 0),
(5, 0x3a3a31, 0x3a3a31, 'nguyenthuan.fososoft@gmail.com', 'd5e31461abd3b392357e77337454c97d5c81a756', NULL, 'nguyenthuan.fososoft@gmail.com', NULL, NULL, NULL, NULL, 1502251956, 1502252002, 1, 'nguyen', 'thuan', 'FOSO soft', '0908855483', NULL, 'male', 1, 0, 3, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_user_logins`
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
-- Dumping data for table `sma_user_logins`
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
(114, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-03 05:46:39'),
(115, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-04 01:25:51'),
(116, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-04 05:10:49'),
(117, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-09 04:09:18'),
(118, 5, NULL, 0x3a3a31, 'nguyenthuan.fososoft@gmail.com', '2017-08-09 04:13:22'),
(119, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-09 04:31:16'),
(120, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-10 02:20:46'),
(121, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-14 09:56:42'),
(122, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-15 01:29:42'),
(123, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-15 02:51:13'),
(124, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-15 02:55:35'),
(125, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-20 05:23:04'),
(126, 1, NULL, 0x3a3a31, 'owner@google.com', '2017-08-20 08:09:29');

-- --------------------------------------------------------

--
-- Table structure for table `sma_variants`
--

CREATE TABLE `sma_variants` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses`
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
-- Dumping data for table `sma_warehouses`
--

INSERT INTO `sma_warehouses` (`id`, `code`, `name`, `address`, `map`, `phone`, `email`) VALUES
(1, 'WHI', 'Kho 1', '<p>Address, City</p>', NULL, '012345678', 'whi@google.com'),
(2, 'WHII', 'Kho 2', '<p>HCM</p>', NULL, '0939701693', 'tvtan06@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses_products`
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
-- Dumping data for table `sma_warehouses_products`
--

INSERT INTO `sma_warehouses_products` (`id`, `product_id`, `item_id`, `warehouse_id`, `quantity`, `rack`) VALUES
(12, NULL, 4, 1, '147700.0000', NULL),
(13, NULL, 5, 1, '3725.0000', NULL),
(14, NULL, 5, 2, '-100.0000', NULL),
(15, NULL, 2, 1, '20000.0000', NULL),
(16, NULL, 3, 2, '0.0000', NULL),
(17, 30, NULL, 1, '900.0000', NULL),
(18, 29, NULL, 1, '25.0000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses_products_variants`
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
-- Table structure for table `sma_working_places`
--

CREATE TABLE `sma_working_places` (
  `id` int(10) NOT NULL,
  `working_place` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sma_working_places`
--

INSERT INTO `sma_working_places` (`id`, `working_place`, `phone`, `address`, `note`) VALUES
(1, 'Xưởng Cơ khí', '1234', '1234', ''),
(2, 'MạMechanic& GalvanizedWS', '1234', '1234', ''),
(3, 'Xuong 1', '456567', '567', ''),
(4, 'Xuong 2', '45645', '34564', ''),
(5, 'Xuong 3', '4354354', '456546', '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_working_place_items`
--

CREATE TABLE `sma_working_place_items` (
  `id` int(11) NOT NULL,
  `working_place_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_working_place_items`
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
-- Indexes for dumped tables
--

--
-- Indexes for table `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_calendar`
--
ALTER TABLE `sma_calendar`
  ADD PRIMARY KEY (`date`);

--
-- Indexes for table `sma_captcha`
--
ALTER TABLE `sma_captcha`
  ADD PRIMARY KEY (`captcha_id`),
  ADD KEY `word` (`word`);

--
-- Indexes for table `sma_categories`
--
ALTER TABLE `sma_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_companies`
--
ALTER TABLE `sma_companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `group_id_2` (`group_id`);

--
-- Indexes for table `sma_costing`
--
ALTER TABLE `sma_costing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_currencies`
--
ALTER TABLE `sma_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_date_format`
--
ALTER TABLE `sma_date_format`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_expenses`
--
ALTER TABLE `sma_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_no` (`card_no`);

--
-- Indexes for table `sma_groups`
--
ALTER TABLE `sma_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_items`
--
ALTER TABLE `sma_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_labor_norms`
--
ALTER TABLE `sma_labor_norms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_log_productions`
--
ALTER TABLE `sma_log_productions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_machine`
--
ALTER TABLE `sma_machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_machinery_norms`
--
ALTER TABLE `sma_machinery_norms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_machine_categories`
--
ALTER TABLE `sma_machine_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_material_norms`
--
ALTER TABLE `sma_material_norms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_notifications`
--
ALTER TABLE `sma_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  ADD PRIMARY KEY (`ref_id`);

--
-- Indexes for table `sma_payments`
--
ALTER TABLE `sma_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_paypal`
--
ALTER TABLE `sma_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_permissions`
--
ALTER TABLE `sma_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_pos_settings`
--
ALTER TABLE `sma_pos_settings`
  ADD PRIMARY KEY (`pos_id`);

--
-- Indexes for table `sma_productions`
--
ALTER TABLE `sma_productions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_production_items`
--
ALTER TABLE `sma_production_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `sma_production_stages`
--
ALTER TABLE `sma_production_stages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_production_stage_details`
--
ALTER TABLE `sma_production_stage_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_products`
--
ALTER TABLE `sma_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`),
  ADD KEY `category_id_2` (`category_id`);

--
-- Indexes for table `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_purchases`
--
ALTER TABLE `sma_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_quotes`
--
ALTER TABLE `sma_quotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quote_id` (`quote_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_return_items`
--
ALTER TABLE `sma_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `sma_return_sales`
--
ALTER TABLE `sma_return_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_sales`
--
ALTER TABLE `sma_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `sma_sessions`
--
ALTER TABLE `sma_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `sma_settings`
--
ALTER TABLE `sma_settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `sma_skrill`
--
ALTER TABLE `sma_skrill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_subcategories`
--
ALTER TABLE `sma_subcategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_transfers`
--
ALTER TABLE `sma_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_units`
--
ALTER TABLE `sma_units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_users`
--
ALTER TABLE `sma_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`,`warehouse_id`,`biller_id`),
  ADD KEY `group_id_2` (`group_id`,`company_id`);

--
-- Indexes for table `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_variants`
--
ALTER TABLE `sma_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sma_working_places`
--
ALTER TABLE `sma_working_places`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_working_place_items`
--
ALTER TABLE `sma_working_place_items`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_captcha`
--
ALTER TABLE `sma_captcha`
  MODIFY `captcha_id` bigint(13) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sma_categories`
--
ALTER TABLE `sma_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_companies`
--
ALTER TABLE `sma_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `sma_costing`
--
ALTER TABLE `sma_costing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `sma_currencies`
--
ALTER TABLE `sma_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sma_date_format`
--
ALTER TABLE `sma_date_format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_expenses`
--
ALTER TABLE `sma_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_groups`
--
ALTER TABLE `sma_groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `sma_items`
--
ALTER TABLE `sma_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sma_labor_norms`
--
ALTER TABLE `sma_labor_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_log_productions`
--
ALTER TABLE `sma_log_productions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sma_machine`
--
ALTER TABLE `sma_machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sma_machinery_norms`
--
ALTER TABLE `sma_machinery_norms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `sma_machine_categories`
--
ALTER TABLE `sma_machine_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sma_material_norms`
--
ALTER TABLE `sma_material_norms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;
--
-- AUTO_INCREMENT for table `sma_notifications`
--
ALTER TABLE `sma_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  MODIFY `ref_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sma_payments`
--
ALTER TABLE `sma_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `sma_permissions`
--
ALTER TABLE `sma_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sma_productions`
--
ALTER TABLE `sma_productions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;
--
-- AUTO_INCREMENT for table `sma_production_items`
--
ALTER TABLE `sma_production_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;
--
-- AUTO_INCREMENT for table `sma_production_stages`
--
ALTER TABLE `sma_production_stages`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;
--
-- AUTO_INCREMENT for table `sma_production_stage_details`
--
ALTER TABLE `sma_production_stage_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `sma_products`
--
ALTER TABLE `sma_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_purchases`
--
ALTER TABLE `sma_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;
--
-- AUTO_INCREMENT for table `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=408;
--
-- AUTO_INCREMENT for table `sma_quotes`
--
ALTER TABLE `sma_quotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_return_items`
--
ALTER TABLE `sma_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_return_sales`
--
ALTER TABLE `sma_return_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_sales`
--
ALTER TABLE `sma_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `sma_subcategories`
--
ALTER TABLE `sma_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `sma_transfers`
--
ALTER TABLE `sma_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_units`
--
ALTER TABLE `sma_units`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `sma_users`
--
ALTER TABLE `sma_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;
--
-- AUTO_INCREMENT for table `sma_variants`
--
ALTER TABLE `sma_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sma_working_places`
--
ALTER TABLE `sma_working_places`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sma_working_place_items`
--
ALTER TABLE `sma_working_place_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
