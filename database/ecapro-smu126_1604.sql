-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2015 at 01:58 AM
-- Server version: 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ecapro-smu126`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE IF NOT EXISTS `area` (
`id` int(11) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Khu vực' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`id`, `code`, `name`) VALUES
(1, 'B01', 'Khu vực Hà Nội'),
(2, 'B02', 'Khu vực Quảng Ninh'),
(3, 'N01', 'Khu vực TP Hồ Chí Minh');

-- --------------------------------------------------------

--
-- Table structure for table `center`
--

CREATE TABLE IF NOT EXISTS `center` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Trung tâm' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `center`
--

INSERT INTO `center` (`id`, `name`) VALUES
(1, 'Trung tâm HN01'),
(2, 'Trung tâm HN02'),
(3, 'Trung tâm QN01');

-- --------------------------------------------------------

--
-- Table structure for table `dc_equipment`
--

CREATE TABLE IF NOT EXISTS `dc_equipment` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị của tủ DC' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `dc_equipment`
--

INSERT INTO `dc_equipment` (`id`, `name`) VALUES
(1, 'Tủ ắc quy 1'),
(2, 'Tủ ắc quy 2');

-- --------------------------------------------------------

--
-- Table structure for table `dc_equipment_status`
--

CREATE TABLE IF NOT EXISTS `dc_equipment_status` (
`id` int(11) NOT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `amperage` float DEFAULT '0' COMMENT 'cường độ dòng điện',
  `voltage` float DEFAULT '0' COMMENT 'điện áp',
  `temperature` float DEFAULT '0' COMMENT 'nhiệt độ',
  `station_id` int(11) NOT NULL DEFAULT '0',
  `status` int(5) DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng thiết bị của tủ DC' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `dc_equipment_status`
--

INSERT INTO `dc_equipment_status` (`id`, `equipment_id`, `amperage`, `voltage`, `temperature`, `station_id`, `status`) VALUES
(1, 1, 0, 0, NULL, 8, 1),
(2, 2, 0, 0, NULL, 8, 1),
(3, 1, 0, 0, 0, 9, 1),
(4, 2, 0, 0, 0, 9, 1),
(5, 1, 0, 0, 0, 10, 1),
(6, 2, 0, 0, 0, 10, 1),
(7, 1, 0, 0, 0, 11, 1),
(8, 2, 0, 0, 0, 11, 1),
(9, 1, 0, 0, 0, 12, 1),
(10, 2, 0, 0, 0, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `dc_status`
--

CREATE TABLE IF NOT EXISTS `dc_status` (
`id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `voltage` float DEFAULT '0' COMMENT 'điện áp trạm'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng tủ DC' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `dc_status`
--

INSERT INTO `dc_status` (`id`, `station_id`, `voltage`) VALUES
(1, 3, 0),
(2, 4, 0),
(3, 5, 0),
(4, 6, 0),
(5, 7, 0),
(6, 8, 0),
(7, 9, 0),
(8, 10, 0),
(9, 11, 0),
(10, 12, 0);

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `name`, `active`) VALUES
(1, 'Điều hòa 1', 1),
(2, 'Điều hòa 2', 1),
(3, 'Còi báo động', 1),
(4, 'Máy hút ẩm', 1),
(5, 'Thiết bị chiếu sáng', 1),
(6, 'Quạt gió', 1),
(7, 'Điều khiển dự phòng 1', 1),
(8, 'Điều khiển dự phòng 2', 1),
(9, 'Điều khiển dự phòng 3', 1),
(10, 'Điều khiển dự phòng 4', 1);

-- --------------------------------------------------------

--
-- Table structure for table `equipment_status`
--

CREATE TABLE IF NOT EXISTS `equipment_status` (
`id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL,
  `station_id` int(11) DEFAULT '0',
  `station_code` varchar(100) NOT NULL COMMENT 'mã trạm',
  `configure` int(2) DEFAULT '0' COMMENT '0:auto | 1:manual',
  `active` int(2) DEFAULT '1' COMMENT '1:active | 0:unactive',
  `status` int(2) DEFAULT '1' COMMENT '0:Tắt | 1:Bật',
  `last_update` int(11) DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=104 ;

--
-- Dumping data for table `equipment_status`
--

INSERT INTO `equipment_status` (`id`, `equipment_id`, `station_id`, `station_code`, `configure`, `active`, `status`, `last_update`) VALUES
(34, 3, 1, 'TR02', 1, 1, 0, 0),
(35, 7, 1, 'TR02', 0, 1, 1, 0),
(36, 8, 1, 'TR02', 0, 1, 0, 0),
(37, 9, 1, 'TR02', 1, 1, 1, 0),
(38, 1, 1, 'TR02', 0, 1, 1, 0),
(39, 2, 1, 'TR02', 0, 1, 1, 0),
(40, 4, 1, 'TR02', 0, 1, 1, 0),
(41, 5, 1, 'TR02', 0, 1, 1, 0),
(42, 6, 1, 'TR02', 0, 1, 1, 0),
(43, 10, 1, 'TR02', 0, 1, 1, 0),
(44, 1, 4, 'TR04', 0, 1, 1, 0),
(45, 2, 4, 'TR04', 0, 1, 1, 0),
(46, 3, 4, 'TR04', 0, 1, 1, 0),
(47, 4, 4, 'TR04', 0, 1, 1, 0),
(48, 5, 4, 'TR04', 0, 1, 1, 0),
(49, 6, 4, 'TR04', 0, 1, 1, 0),
(50, 7, 4, 'TR04', 0, 1, 1, 0),
(51, 8, 4, 'TR04', 0, 1, 1, 0),
(52, 9, 4, 'TR04', 0, 1, 1, 0),
(53, 10, 4, 'TR04', 0, 1, 1, 0),
(54, 1, 5, 'TR05', 0, 1, 1, 0),
(55, 2, 5, 'TR05', 0, 1, 1, 0),
(56, 3, 5, 'TR05', 0, 1, 1, 0),
(57, 4, 5, 'TR05', 0, 1, 1, 0),
(58, 5, 5, 'TR05', 0, 1, 1, 0),
(59, 6, 5, 'TR05', 0, 1, 1, 0),
(60, 7, 5, 'TR05', 0, 1, 1, 0),
(61, 8, 5, 'TR05', 0, 1, 1, 0),
(62, 9, 5, 'TR05', 0, 1, 1, 0),
(63, 10, 5, 'TR05', 0, 1, 1, 0),
(64, 1, 9, 'TR09', 0, 1, 1, 0),
(65, 2, 9, 'TR09', 0, 1, 1, 0),
(66, 3, 9, 'TR09', 0, 1, 1, 0),
(67, 4, 9, 'TR09', 0, 1, 1, 0),
(68, 5, 9, 'TR09', 0, 1, 1, 0),
(69, 6, 9, 'TR09', 0, 1, 1, 0),
(70, 7, 9, 'TR09', 0, 1, 1, 0),
(71, 8, 9, 'TR09', 0, 1, 1, 0),
(72, 9, 9, 'TR09', 0, 1, 1, 0),
(73, 10, 9, 'TR09', 0, 1, 1, 0),
(74, 1, 10, 'TR10', 0, 1, 1, 0),
(75, 2, 10, 'TR10', 0, 1, 1, 0),
(76, 3, 10, 'TR10', 0, 1, 1, 0),
(77, 4, 10, 'TR10', 0, 1, 1, 0),
(78, 5, 10, 'TR10', 0, 1, 1, 0),
(79, 6, 10, 'TR10', 0, 1, 1, 0),
(80, 7, 10, 'TR10', 0, 1, 1, 0),
(81, 8, 10, 'TR10', 0, 1, 1, 0),
(82, 9, 10, 'TR10', 0, 1, 1, 0),
(83, 10, 10, 'TR10', 0, 1, 1, 0),
(84, 1, 11, 'TR011', 0, 1, 1, 0),
(85, 2, 11, 'TR011', 0, 1, 1, 0),
(86, 3, 11, 'TR011', 0, 1, 1, 0),
(87, 4, 11, 'TR011', 0, 1, 1, 0),
(88, 5, 11, 'TR011', 0, 1, 1, 0),
(89, 6, 11, 'TR011', 0, 1, 1, 0),
(90, 7, 11, 'TR011', 0, 1, 1, 0),
(91, 8, 11, 'TR011', 0, 1, 1, 0),
(92, 9, 11, 'TR011', 0, 1, 1, 0),
(93, 10, 11, 'TR011', 0, 1, 1, 0),
(94, 1, 12, 'TR012', 0, 1, 1, 0),
(95, 2, 12, 'TR012', 0, 1, 1, 0),
(96, 3, 12, 'TR012', 0, 1, 1, 0),
(97, 4, 12, 'TR012', 0, 1, 1, 0),
(98, 5, 12, 'TR012', 0, 1, 1, 0),
(99, 6, 12, 'TR012', 0, 1, 1, 0),
(100, 7, 12, 'TR012', 0, 1, 1, 0),
(101, 8, 12, 'TR012', 0, 1, 1, 0),
(102, 9, 12, 'TR012', 0, 1, 1, 0),
(103, 10, 12, 'TR012', 0, 1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `generator_configuration`
--

CREATE TABLE IF NOT EXISTS `generator_configuration` (
`id` int(11) NOT NULL,
  `fuel_min` int(5) DEFAULT NULL COMMENT 'ngưỡng nhiên liệu thấp',
  `station_code` varchar(100) DEFAULT NULL,
  `check_start_time` int(11) DEFAULT '0',
  `check_cycle` int(5) DEFAULT NULL COMMENT 'chu kỳ kiểm tra (ngày)',
  `check_duration` int(5) DEFAULT '0' COMMENT 'thời gian mỗi lần kiểm tra (phút)',
  `ac_start_voltage` float DEFAULT '0' COMMENT 'điện áp AC bắt đầu chạy máy',
  `dc_start_voltage` float DEFAULT '0' COMMENT 'điện áp DC bắt đầu chạy máy',
  `amperage_max` float DEFAULT '0' COMMENT 'giới hạn dòng nạp ngừng chạy máy',
  `pause_duration` int(11) DEFAULT '0' COMMENT 'thời gian máy phát nghỉ (s)',
  `work_duration_max` int(11) DEFAULT '0' COMMENT 'thời gian máy chạy liên tục tối đa (s)',
  `priority_option` int(3) DEFAULT '1' COMMENT 'lựa chọn ưu tiên điều khiển máy phát (1: ưu tiên điện áp DC | 2: ưu tiên thời gian)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Cấu hình máy phát của trạm' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `generator_status`
--

CREATE TABLE IF NOT EXISTS `generator_status` (
`id` int(11) NOT NULL,
  `station_code` varchar(100) DEFAULT NULL,
  `ats_status` varchar(50) DEFAULT NULL,
  `source_type` varchar(50) DEFAULT NULL COMMENT 'nguồn cấp cho tải',
  `status` varchar(50) DEFAULT NULL,
  `vac1` float DEFAULT '0',
  `vac2` float DEFAULT '0',
  `vac3` float DEFAULT '0',
  `vgen1` float DEFAULT '0',
  `vgen2` float DEFAULT '0',
  `vgen3` float DEFAULT '0',
  `line1` float DEFAULT '0',
  `line2` float DEFAULT '0',
  `line3` float DEFAULT '0',
  `accu_voltage` float DEFAULT '0',
  `fuel_level` int(3) DEFAULT '0',
  `warning_status` varchar(10) DEFAULT NULL COMMENT 'nối với nhau bởi dấu '','''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `generator_warining_type`
--

CREATE TABLE IF NOT EXISTS `generator_warining_type` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Loại cảnh báo của máy phát' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1428253609),
('m130524_201442_init', 1428253616);

-- --------------------------------------------------------

--
-- Table structure for table `power_item`
--

CREATE TABLE IF NOT EXISTS `power_item` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Các thành phần của nguồn điện' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `power_status`
--

CREATE TABLE IF NOT EXISTS `power_status` (
`id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `station_code` varchar(100) NOT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng nguồn điện của trạm' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sensor`
--

CREATE TABLE IF NOT EXISTS `sensor` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit_type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Cảm biến' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `sensor`
--

INSERT INTO `sensor` (`id`, `name`, `unit_type`) VALUES
(1, 'Nhiệt độ', 'temperature'),
(2, 'Nhiệt độ ngoài trời', 'temperature'),
(3, 'Độ ẩm', 'humidity'),
(4, 'Cảm biến khói', NULL),
(5, 'Cảm biến cửa', NULL),
(6, 'Cảm biến nhiệt gia tăng', NULL),
(7, 'Cảm biến lụt', NULL),
(8, 'Cảm biến chuyển động', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_status`
--

CREATE TABLE IF NOT EXISTS `sensor_status` (
`id` int(11) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT '0',
  `value` float DEFAULT '0',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1:bình thường'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng cảm biến' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `sensor_status`
--

INSERT INTO `sensor_status` (`id`, `sensor_id`, `station_id`, `value`, `status`) VALUES
(1, 1, 12, 0, 1),
(2, 2, 12, 0, 1),
(3, 3, 12, 0, 1),
(4, 4, 12, 0, 1),
(5, 5, 12, 0, 1),
(6, 6, 12, 0, 1),
(7, 7, 12, 0, 1),
(8, 8, 12, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
`id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng nhân viên trực của trạm' AUTO_INCREMENT=2 ;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `fullname`, `mobile`, `email`, `user_id`) VALUES
(1, 'Vương Dũng', '0906600788', 'vvdung88@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `station`
--

CREATE TABLE IF NOT EXISTS `station` (
`id` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `center_id` int(11) NOT NULL DEFAULT '0',
  `area_id` int(11) NOT NULL DEFAULT '0',
  `type` int(3) NOT NULL DEFAULT '0',
  `firmware` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `addition` tinytext COMMENT 'thông tin thêm',
  `picture_ip` varchar(20) DEFAULT NULL COMMENT 'ip chụp ảnh',
  `video_ip` varchar(20) DEFAULT NULL COMMENT 'ip video',
  `latitude` varchar(20) DEFAULT NULL COMMENT 'vĩ độ',
  `longtitude` varchar(20) DEFAULT NULL COMMENT 'kinh độ',
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `last_update` int(11) DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Bảng Trạm' AUTO_INCREMENT=13 ;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `code`, `name`, `center_id`, `area_id`, `type`, `firmware`, `staff_id`, `addition`, `picture_ip`, `video_ip`, `latitude`, `longtitude`, `phone`, `email`, `last_update`) VALUES
(1, 'TR02', 'Trạm số 02', 2, 2, 1, '', 2, '', '', '', '', '', '', '', 0),
(3, 'TR03', 'Trạm số 3', 2, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(4, 'TR04', 'Trạm số 4', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(5, 'TR05', 'Trạm số 5', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(6, 'TR06', 'Trạm số 6', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(7, 'TR07', 'Trạm số 7', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(8, 'TR08', 'Trạm số 8', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(9, 'TR09', 'Trạm số 9', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(10, 'TR10', 'Trạm số 10', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(11, 'TR011', 'Trạm số 11', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0),
(12, 'TR012', 'Trạm số 12', 1, 1, 1, '', NULL, '', '', '', '', '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE IF NOT EXISTS `status` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value_0` varchar(255) DEFAULT NULL,
  `value_1` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Trạng thái đầu ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'jeBxBMGrgkdyPGDQlflewk0-bOfpIdn3', '$2y$13$BkQWiW7C0jg3OfRaDV4r1uxehk3dazAi8Ygo.4uQP4N6dbqA84UxO', NULL, 'vvdung88@gmail.com', 10, 1423155342, 1423155342);

-- --------------------------------------------------------

--
-- Table structure for table `warning`
--

CREATE TABLE IF NOT EXISTS `warning` (
`id` int(11) NOT NULL,
  `warning_type` int(11) DEFAULT NULL COMMENT 'loại cảnh báo',
  `station_id` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL COMMENT 'ảnh chụp từ camera',
  `warning_time` int(11) DEFAULT NULL COMMENT 'thời điểm cảnh báo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Cảnh báo' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `warning_type`
--

CREATE TABLE IF NOT EXISTS `warning_type` (
`id` int(11) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Loại cảnh báo' AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area`
--
ALTER TABLE `area`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `center`
--
ALTER TABLE `center`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dc_equipment`
--
ALTER TABLE `dc_equipment`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dc_equipment_status`
--
ALTER TABLE `dc_equipment_status`
 ADD PRIMARY KEY (`id`), ADD KEY `FkEquipment` (`equipment_id`);

--
-- Indexes for table `dc_status`
--
ALTER TABLE `dc_status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `equipment_status`
--
ALTER TABLE `equipment_status`
 ADD PRIMARY KEY (`id`), ADD KEY `FkStation` (`station_code`);

--
-- Indexes for table `generator_configuration`
--
ALTER TABLE `generator_configuration`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `generator_status`
--
ALTER TABLE `generator_status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `generator_warining_type`
--
ALTER TABLE `generator_warining_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
 ADD PRIMARY KEY (`version`);

--
-- Indexes for table `power_item`
--
ALTER TABLE `power_item`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `power_status`
--
ALTER TABLE `power_status`
 ADD PRIMARY KEY (`id`), ADD KEY `FkItem` (`item_id`);

--
-- Indexes for table `sensor`
--
ALTER TABLE `sensor`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sensor_status`
--
ALTER TABLE `sensor_status`
 ADD PRIMARY KEY (`id`), ADD KEY `FkSensor` (`sensor_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `station`
--
ALTER TABLE `station`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `UniqueCode` (`code`) USING BTREE, ADD KEY `FkCenter` (`center_id`), ADD KEY `FkArea` (`area_id`), ADD KEY `code` (`code`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warning`
--
ALTER TABLE `warning`
 ADD PRIMARY KEY (`id`), ADD KEY `FkWarningType` (`warning_type`);

--
-- Indexes for table `warning_type`
--
ALTER TABLE `warning_type`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `area`
--
ALTER TABLE `area`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `center`
--
ALTER TABLE `center`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `dc_equipment`
--
ALTER TABLE `dc_equipment`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `dc_equipment_status`
--
ALTER TABLE `dc_equipment_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `dc_status`
--
ALTER TABLE `dc_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `equipment_status`
--
ALTER TABLE `equipment_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=104;
--
-- AUTO_INCREMENT for table `generator_configuration`
--
ALTER TABLE `generator_configuration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `generator_status`
--
ALTER TABLE `generator_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `generator_warining_type`
--
ALTER TABLE `generator_warining_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `power_item`
--
ALTER TABLE `power_item`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `power_status`
--
ALTER TABLE `power_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sensor`
--
ALTER TABLE `sensor`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sensor_status`
--
ALTER TABLE `sensor_status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `station`
--
ALTER TABLE `station`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `warning`
--
ALTER TABLE `warning`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `warning_type`
--
ALTER TABLE `warning_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `dc_equipment_status`
--
ALTER TABLE `dc_equipment_status`
ADD CONSTRAINT `FkEquipment` FOREIGN KEY (`equipment_id`) REFERENCES `dc_equipment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `equipment_status`
--
ALTER TABLE `equipment_status`
ADD CONSTRAINT `FkStation` FOREIGN KEY (`station_code`) REFERENCES `station` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `power_status`
--
ALTER TABLE `power_status`
ADD CONSTRAINT `FkItem` FOREIGN KEY (`item_id`) REFERENCES `power_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sensor_status`
--
ALTER TABLE `sensor_status`
ADD CONSTRAINT `FkSensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `station`
--
ALTER TABLE `station`
ADD CONSTRAINT `FkArea` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `FkCenter` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `warning`
--
ALTER TABLE `warning`
ADD CONSTRAINT `FkWarningType` FOREIGN KEY (`warning_type`) REFERENCES `warning_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
