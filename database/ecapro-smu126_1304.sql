/*
Navicat MySQL Data Transfer

Source Server         : JF
Source Server Version : 50539
Source Host           : localhost:3306
Source Database       : ecapro-smu126

Target Server Type    : MYSQL
Target Server Version : 50539
File Encoding         : 65001

Date: 2015-04-13 02:16:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `area`
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Bảng Khu vực';

-- ----------------------------
-- Records of area
-- ----------------------------
INSERT INTO `area` VALUES ('1', 'B01', 'Khu vực Hà Nội');
INSERT INTO `area` VALUES ('2', 'B02', 'Khu vực Quảng Ninh');
INSERT INTO `area` VALUES ('3', 'N01', 'Khu vực TP Hồ Chí Minh');

-- ----------------------------
-- Table structure for `center`
-- ----------------------------
DROP TABLE IF EXISTS `center`;
CREATE TABLE `center` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Bảng Trung tâm';

-- ----------------------------
-- Records of center
-- ----------------------------
INSERT INTO `center` VALUES ('1', 'Trung tâm HN01');
INSERT INTO `center` VALUES ('2', 'Trung tâm HN02');
INSERT INTO `center` VALUES ('3', 'Trung tâm QN01');

-- ----------------------------
-- Table structure for `dc_equipment`
-- ----------------------------
DROP TABLE IF EXISTS `dc_equipment`;
CREATE TABLE `dc_equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị của tủ DC';

-- ----------------------------
-- Records of dc_equipment
-- ----------------------------

-- ----------------------------
-- Table structure for `dc_equipment_status`
-- ----------------------------
DROP TABLE IF EXISTS `dc_equipment_status`;
CREATE TABLE `dc_equipment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) DEFAULT NULL,
  `station_code` varchar(100) DEFAULT NULL,
  `amperage` float DEFAULT '0' COMMENT 'cường độ dòng điện',
  `voltage` float DEFAULT '0' COMMENT 'điện áp',
  `temperature` float DEFAULT NULL COMMENT 'nhiệt độ',
  `status` int(5) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FkEquipment` (`equipment_id`),
  CONSTRAINT `FkEquipment` FOREIGN KEY (`equipment_id`) REFERENCES `dc_equipment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng thiết bị của tủ DC';

-- ----------------------------
-- Records of dc_equipment_status
-- ----------------------------

-- ----------------------------
-- Table structure for `dc_status`
-- ----------------------------
DROP TABLE IF EXISTS `dc_status`;
CREATE TABLE `dc_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_code` varchar(100) NOT NULL,
  `voltage` float DEFAULT '0' COMMENT 'điện áp trạm',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng tủ DC';

-- ----------------------------
-- Records of dc_status
-- ----------------------------

-- ----------------------------
-- Table structure for `equipment`
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị';

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES ('1', 'Điều hòa 1', '1');
INSERT INTO `equipment` VALUES ('2', 'Điều hòa 2', '1');
INSERT INTO `equipment` VALUES ('3', 'Còi báo động', '1');
INSERT INTO `equipment` VALUES ('4', 'Máy hút ẩm', '1');
INSERT INTO `equipment` VALUES ('5', 'Thiết bị chiếu sáng', '1');
INSERT INTO `equipment` VALUES ('6', 'Quạt gió', '1');
INSERT INTO `equipment` VALUES ('7', 'Điều khiển dự phòng 1', '1');
INSERT INTO `equipment` VALUES ('8', 'Điều khiển dự phòng 2', '1');
INSERT INTO `equipment` VALUES ('9', 'Điều khiển dự phòng 3', '1');
INSERT INTO `equipment` VALUES ('10', 'Điều khiển dự phòng 4', '1');

-- ----------------------------
-- Table structure for `equipment_status`
-- ----------------------------
DROP TABLE IF EXISTS `equipment_status`;
CREATE TABLE `equipment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) NOT NULL,
  `station_id` int(11) DEFAULT '0',
  `station_code` varchar(100) NOT NULL COMMENT 'mã trạm',
  `configure` int(2) DEFAULT '0' COMMENT '0:auto | 1:manual',
  `active` int(2) DEFAULT '1' COMMENT '1:active | 0:unactive',
  `status` int(2) DEFAULT '1' COMMENT '0:Tắt | 1:Bật',
  `last_update` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FkStation` (`station_code`),
  CONSTRAINT `FkStation` FOREIGN KEY (`station_code`) REFERENCES `station` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment_status
-- ----------------------------
INSERT INTO `equipment_status` VALUES ('34', '3', '1', 'TR02', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('35', '7', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('36', '8', '1', 'TR02', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('37', '9', '1', 'TR02', '1', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('38', '1', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('39', '2', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('40', '4', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('41', '5', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('42', '6', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('43', '10', '1', 'TR02', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for `generator_configuration`
-- ----------------------------
DROP TABLE IF EXISTS `generator_configuration`;
CREATE TABLE `generator_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `priority_option` int(3) DEFAULT '1' COMMENT 'lựa chọn ưu tiên điều khiển máy phát (1: ưu tiên điện áp DC | 2: ưu tiên thời gian)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Cấu hình máy phát của trạm';

-- ----------------------------
-- Records of generator_configuration
-- ----------------------------

-- ----------------------------
-- Table structure for `generator_status`
-- ----------------------------
DROP TABLE IF EXISTS `generator_status`;
CREATE TABLE `generator_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `warning_status` varchar(10) DEFAULT NULL COMMENT 'nối với nhau bởi dấu '',''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of generator_status
-- ----------------------------

-- ----------------------------
-- Table structure for `generator_warining_type`
-- ----------------------------
DROP TABLE IF EXISTS `generator_warining_type`;
CREATE TABLE `generator_warining_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Loại cảnh báo của máy phát';

-- ----------------------------
-- Records of generator_warining_type
-- ----------------------------

-- ----------------------------
-- Table structure for `migration`
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration
-- ----------------------------
INSERT INTO `migration` VALUES ('m000000_000000_base', '1428253609');
INSERT INTO `migration` VALUES ('m130524_201442_init', '1428253616');

-- ----------------------------
-- Table structure for `power_item`
-- ----------------------------
DROP TABLE IF EXISTS `power_item`;
CREATE TABLE `power_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Các thành phần của nguồn điện';

-- ----------------------------
-- Records of power_item
-- ----------------------------

-- ----------------------------
-- Table structure for `power_status`
-- ----------------------------
DROP TABLE IF EXISTS `power_status`;
CREATE TABLE `power_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `station_code` varchar(100) NOT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FkItem` (`item_id`),
  CONSTRAINT `FkItem` FOREIGN KEY (`item_id`) REFERENCES `power_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng nguồn điện của trạm';

-- ----------------------------
-- Records of power_status
-- ----------------------------

-- ----------------------------
-- Table structure for `sensor`
-- ----------------------------
DROP TABLE IF EXISTS `sensor`;
CREATE TABLE `sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Cảm biến';

-- ----------------------------
-- Records of sensor
-- ----------------------------

-- ----------------------------
-- Table structure for `sensor_status`
-- ----------------------------
DROP TABLE IF EXISTS `sensor_status`;
CREATE TABLE `sensor_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_id` int(11) NOT NULL,
  `station_code` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL COMMENT 'tình trạng cảm biến',
  PRIMARY KEY (`id`),
  KEY `FkSensor` (`sensor_id`),
  CONSTRAINT `FkSensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng cảm biến';

-- ----------------------------
-- Records of sensor_status
-- ----------------------------

-- ----------------------------
-- Table structure for `staff`
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Bảng nhân viên trực của trạm';

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES ('1', 'Vương Dũng', '0906600788', 'vvdung88@gmail.com', '1');

-- ----------------------------
-- Table structure for `station`
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `last_update` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueCode` (`code`) USING BTREE,
  KEY `FkCenter` (`center_id`),
  KEY `FkArea` (`area_id`),
  KEY `code` (`code`),
  CONSTRAINT `FkArea` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FkCenter` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạm';

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('1', 'TR02', 'Trạm số 02', '2', '2', '1', '', '2', '', '', '', '', '', '', '', '0');
INSERT INTO `station` VALUES ('2', 'asd', 'asd', '2', '2', '1', '', null, '', '', '', '', '', '', '', '0');

-- ----------------------------
-- Table structure for `status`
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value_0` varchar(255) DEFAULT NULL,
  `value_1` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Trạng thái đầu ';

-- ----------------------------
-- Records of status
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'jeBxBMGrgkdyPGDQlflewk0-bOfpIdn3', '$2y$13$BkQWiW7C0jg3OfRaDV4r1uxehk3dazAi8Ygo.4uQP4N6dbqA84UxO', null, 'vvdung88@gmail.com', '10', '1423155342', '1423155342');

-- ----------------------------
-- Table structure for `warning`
-- ----------------------------
DROP TABLE IF EXISTS `warning`;
CREATE TABLE `warning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warning_type` int(11) DEFAULT NULL COMMENT 'loại cảnh báo',
  `station_id` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL COMMENT 'ảnh chụp từ camera',
  `warning_time` int(11) DEFAULT NULL COMMENT 'thời điểm cảnh báo',
  PRIMARY KEY (`id`),
  KEY `FkWarningType` (`warning_type`),
  CONSTRAINT `FkWarningType` FOREIGN KEY (`warning_type`) REFERENCES `warning_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Cảnh báo';

-- ----------------------------
-- Records of warning
-- ----------------------------

-- ----------------------------
-- Table structure for `warning_type`
-- ----------------------------
DROP TABLE IF EXISTS `warning_type`;
CREATE TABLE `warning_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng Loại cảnh báo';

-- ----------------------------
-- Records of warning_type
-- ----------------------------
