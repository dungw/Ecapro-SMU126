/*
Navicat MySQL Data Transfer

Source Server         : JF
Source Server Version : 50539
Source Host           : localhost:3306
Source Database       : ecapro-smu126

Target Server Type    : MYSQL
Target Server Version : 50539
File Encoding         : 65001

Date: 2015-04-20 04:47:07
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
INSERT INTO `area` VALUES ('1', 'B01', 'Hà Nội');
INSERT INTO `area` VALUES ('2', 'B02', 'Quảng Ninh');
INSERT INTO `area` VALUES ('3', 'N01', 'TP Hồ Chí Minh');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị của tủ DC';

-- ----------------------------
-- Records of dc_equipment
-- ----------------------------
INSERT INTO `dc_equipment` VALUES ('1', 'Tủ ắc quy 1');
INSERT INTO `dc_equipment` VALUES ('2', 'Tủ ắc quy 2');

-- ----------------------------
-- Table structure for `dc_equipment_status`
-- ----------------------------
DROP TABLE IF EXISTS `dc_equipment_status`;
CREATE TABLE `dc_equipment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) DEFAULT NULL,
  `amperage` float DEFAULT '0' COMMENT 'cường độ dòng điện',
  `voltage` float DEFAULT '0' COMMENT 'điện áp',
  `temperature` float DEFAULT '0' COMMENT 'nhiệt độ',
  `station_id` int(11) NOT NULL DEFAULT '0',
  `status` int(5) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FkEquipment` (`equipment_id`),
  CONSTRAINT `FkEquipment` FOREIGN KEY (`equipment_id`) REFERENCES `dc_equipment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng thiết bị của tủ DC';

-- ----------------------------
-- Records of dc_equipment_status
-- ----------------------------
INSERT INTO `dc_equipment_status` VALUES ('1', '1', '0', '0', null, '8', '1');
INSERT INTO `dc_equipment_status` VALUES ('2', '2', '0', '0', null, '8', '1');
INSERT INTO `dc_equipment_status` VALUES ('3', '1', '0', '0', '0', '9', '1');
INSERT INTO `dc_equipment_status` VALUES ('4', '2', '0', '0', '0', '9', '1');
INSERT INTO `dc_equipment_status` VALUES ('5', '1', '0', '0', '0', '10', '1');
INSERT INTO `dc_equipment_status` VALUES ('6', '2', '0', '0', '0', '10', '1');
INSERT INTO `dc_equipment_status` VALUES ('7', '1', '0', '0', '0', '11', '1');
INSERT INTO `dc_equipment_status` VALUES ('8', '2', '0', '0', '0', '11', '1');
INSERT INTO `dc_equipment_status` VALUES ('9', '1', '0', '0', '0', '12', '1');
INSERT INTO `dc_equipment_status` VALUES ('10', '2', '0', '0', '0', '12', '1');

-- ----------------------------
-- Table structure for `dc_status`
-- ----------------------------
DROP TABLE IF EXISTS `dc_status`;
CREATE TABLE `dc_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `voltage` float DEFAULT '0' COMMENT 'điện áp trạm',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng tủ DC';

-- ----------------------------
-- Records of dc_status
-- ----------------------------
INSERT INTO `dc_status` VALUES ('1', '3', '0');
INSERT INTO `dc_status` VALUES ('2', '4', '0');
INSERT INTO `dc_status` VALUES ('3', '5', '0');
INSERT INTO `dc_status` VALUES ('4', '6', '0');
INSERT INTO `dc_status` VALUES ('5', '7', '0');
INSERT INTO `dc_status` VALUES ('6', '8', '0');
INSERT INTO `dc_status` VALUES ('7', '9', '0');
INSERT INTO `dc_status` VALUES ('8', '10', '0');
INSERT INTO `dc_status` VALUES ('9', '11', '0');
INSERT INTO `dc_status` VALUES ('10', '12', '0');

-- ----------------------------
-- Table structure for `equipment`
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1',
  `sort` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị';

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES ('1', 'Điều hòa 1', '1', '0');
INSERT INTO `equipment` VALUES ('2', 'Điều hòa 2', '1', '1');
INSERT INTO `equipment` VALUES ('3', 'Còi báo động', '1', '2');
INSERT INTO `equipment` VALUES ('4', 'Máy hút ẩm', '1', '5');
INSERT INTO `equipment` VALUES ('5', 'Thiết bị chiếu sáng', '1', '6');
INSERT INTO `equipment` VALUES ('6', 'Quạt gió', '1', '8');
INSERT INTO `equipment` VALUES ('7', 'Điều khiển dự phòng 1', '0', '7');
INSERT INTO `equipment` VALUES ('8', 'Điều khiển dự phòng 2', '0', '9');
INSERT INTO `equipment` VALUES ('9', 'Điều khiển dự phòng 3', '0', '4');
INSERT INTO `equipment` VALUES ('10', 'Điều khiển dự phòng 4', '0', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment_status
-- ----------------------------
INSERT INTO `equipment_status` VALUES ('34', '3', '1', 'TR02', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('38', '1', '1', 'TR02', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('39', '2', '1', 'TR02', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('40', '4', '1', 'TR02', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('41', '5', '1', 'TR02', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('42', '6', '1', 'TR02', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('44', '1', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('45', '2', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('46', '3', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('47', '4', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('48', '5', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('49', '6', '4', 'TR04', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('54', '1', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('55', '2', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('56', '3', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('57', '4', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('58', '5', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('59', '6', '5', 'TR05', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('64', '1', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('65', '2', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('66', '3', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('67', '4', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('68', '5', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('69', '6', '9', 'TR09', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('74', '1', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('75', '2', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('76', '3', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('77', '4', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('78', '5', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('79', '6', '10', 'TR10', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('84', '1', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('85', '2', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('86', '3', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('87', '4', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('88', '5', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('89', '6', '11', 'TR011', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('94', '1', '12', 'TR012', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('95', '2', '12', 'TR012', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('96', '3', '12', 'TR012', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('97', '4', '12', 'TR012', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('98', '5', '12', 'TR012', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('99', '6', '12', 'TR012', '0', '1', '1', '0');

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
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sort` int(3) DEFAULT '0',
  `message_0` varchar(255) DEFAULT NULL,
  `message_1` varchar(255) DEFAULT NULL,
  `active` int(3) DEFAULT '1' COMMENT '0:unactive | 1:active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Bảng Thông báo';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', 'Tình trạng đột nhập', '0', 'Báo đột nhập', 'Không có đột nhập', '1');
INSERT INTO `message` VALUES ('2', 'Tình trạng cửa', '1', 'Báo mở cửa', 'Cửa đang đóng', '1');
INSERT INTO `message` VALUES ('3', 'Tình trạng khói', '2', 'Báo có khói', 'Không có khói', '1');
INSERT INTO `message` VALUES ('4', 'Tình trạng nhiệt độ', '3', 'Báo nhiệt độ cao', 'Nhiệt độ bình thường', '1');
INSERT INTO `message` VALUES ('5', 'Tình trạng ngập nước', '4', 'Báo ngập nước', 'Không ngập nước', '1');
INSERT INTO `message` VALUES ('6', 'Tình trạng vỡ kính', '5', 'Báo vỡ kính', 'Không vỡ kính', '1');
INSERT INTO `message` VALUES ('7', 'Tình trạng điện máy phát', '6', 'Báo mất điện máy phát', 'Có điện lưới', '1');

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
  `unit_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Bảng Cảm biến';

-- ----------------------------
-- Records of sensor
-- ----------------------------
INSERT INTO `sensor` VALUES ('1', 'Nhiệt độ trong phòng', 'temperature');
INSERT INTO `sensor` VALUES ('3', 'Độ ẩm trong phòng', 'humidity');

-- ----------------------------
-- Table structure for `sensor_status`
-- ----------------------------
DROP TABLE IF EXISTS `sensor_status`;
CREATE TABLE `sensor_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT '0',
  `value` float DEFAULT '0',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1:bình thường',
  PRIMARY KEY (`id`),
  KEY `FkSensor` (`sensor_id`),
  CONSTRAINT `FkSensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng cảm biến';

-- ----------------------------
-- Records of sensor_status
-- ----------------------------
INSERT INTO `sensor_status` VALUES ('1', '1', '12', '0', '1');
INSERT INTO `sensor_status` VALUES ('3', '3', '12', '0', '1');

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
  `staff` varchar(50) DEFAULT NULL COMMENT 'nhân viên trực',
  `addition` tinytext COMMENT 'thông tin thêm',
  `picture_ip` varchar(20) DEFAULT NULL COMMENT 'ip chụp ảnh',
  `video_ip` varchar(20) DEFAULT NULL COMMENT 'ip video',
  `latitude` varchar(20) DEFAULT NULL COMMENT 'vĩ độ',
  `longtitude` varchar(20) DEFAULT NULL COMMENT 'kinh độ',
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT '3' COMMENT 'created by user id',
  `status` int(3) DEFAULT '0' COMMENT '0: not connect | 1:connected',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueCode` (`code`) USING BTREE,
  KEY `FkCenter` (`center_id`),
  KEY `FkArea` (`area_id`),
  KEY `code` (`code`),
  CONSTRAINT `FkArea` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FkCenter` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạm';

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('1', 'TR02', 'Trạm số 02', '2', '2', '1', '', 'JFog', '', '', '', '20.99615', '105.79258', '043.599.933', '', '1', '0');
INSERT INTO `station` VALUES ('3', 'TR03', 'Trạm số 3', '2', '1', '1', '', null, '', '', '', '', '', '', '', '1', '0');
INSERT INTO `station` VALUES ('4', 'TR04', 'Trạm số 4', '1', '1', '1', '', null, '', '', '', '10.823099', '106.629664', '', '', '1', '0');
INSERT INTO `station` VALUES ('5', 'TR05', 'Trạm số 5', '1', '1', '1', '', null, '', '', '', '', '', '', '', '3', '0');
INSERT INTO `station` VALUES ('6', 'TR06', 'Trạm số 6', '1', '1', '1', '', null, '', '', '', '', '', '', '', '5', '0');
INSERT INTO `station` VALUES ('7', 'TR07', 'Trạm số 7', '1', '1', '1', '', null, '', '', '', '', '', '', '', '5', '0');
INSERT INTO `station` VALUES ('8', 'TR08', 'Trạm số 8', '1', '1', '1', '', null, '', '', '', '', '', '', '', '3', '1');
INSERT INTO `station` VALUES ('9', 'TR09', 'Trạm số 9', '1', '1', '1', '', null, '', '', '', '', '', '', '', '3', '0');
INSERT INTO `station` VALUES ('10', 'TR10', 'Trạm số 10', '1', '1', '1', '', null, '', '', '', '', '', '', '', '3', '0');
INSERT INTO `station` VALUES ('11', 'TR011', 'Trạm số 11', '1', '1', '1', '', null, '', '', '', '', '', '', '', '3', '0');
INSERT INTO `station` VALUES ('12', 'TR012', 'Trạm số 12', '1', '1', '1', '', 'JFog', '', '', '', '21.027764', '105.834160', '', '', '5', '1');

-- ----------------------------
-- Table structure for `station_status`
-- ----------------------------
DROP TABLE IF EXISTS `station_status`;
CREATE TABLE `station_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) DEFAULT NULL,
  `input_data` int(11) DEFAULT '0',
  `output_data` int(11) DEFAULT '0',
  `time_update` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạng thái của trạm';

-- ----------------------------
-- Records of station_status
-- ----------------------------
INSERT INTO `station_status` VALUES ('1', '12', '7', '6', '1429308944');

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
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `type` int(3) DEFAULT '1' COMMENT '1: user level 1 | 2: user level 2 | 10: (administrator)',
  `mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT '0' COMMENT 'User id create',
  `fullname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', 'jeBxBMGrgkdyPGDQlflewk0-bOfpIdn3', '$2y$13$BkQWiW7C0jg3OfRaDV4r1uxehk3dazAi8Ygo.4uQP4N6dbqA84UxO', null, 'vvdung88@gmail.com', '1429442709', '1429442709', '10', null, '0', 'Vương Dũng', '10');
INSERT INTO `user` VALUES ('5', 'dungvv', 'rAZcuvhhk7rruQtvnnef4hmjExQbmgCF', '$2y$13$tbviTHAE4Xpei9BJH4ySqOoTXPprTYv3mBci7iMKKB2MkSLalhuIe', null, 'dungvv@smartosc.com', '1429445752', '1429445752', '2', '6843882882', '1', 'Vương Việt Dũng', '10');
INSERT INTO `user` VALUES ('6', 'hungvv', '_a46f8PlMF7u8XnhAiIw8QMbLzoVGb1U', '$2y$13$rN6RnDHPFwh4aZ3qd8AQbeEydqrfyhwwR0z/T81AcDgXvaXDPzOZ2', null, 'hungvv@gmail.com', '1429475103', '1429475103', '1', '0972000444', '5', 'Vương Việt Hùng', '10');

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
