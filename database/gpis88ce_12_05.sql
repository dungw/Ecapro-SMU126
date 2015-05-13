/*
Navicat MySQL Data Transfer

Source Server         : JF
Source Server Version : 50539
Source Host           : localhost:3306
Source Database       : gpis88ce

Target Server Type    : MYSQL
Target Server Version : 50539
File Encoding         : 65001

Date: 2015-05-12 01:57:27
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng thiết bị của tủ DC';

-- ----------------------------
-- Records of dc_equipment_status
-- ----------------------------
INSERT INTO `dc_equipment_status` VALUES ('13', '1', '0', '0', '0', '13', '1');
INSERT INTO `dc_equipment_status` VALUES ('14', '2', '0', '0', '0', '13', '1');
INSERT INTO `dc_equipment_status` VALUES ('15', '1', '0', '0', '0', '14', '1');
INSERT INTO `dc_equipment_status` VALUES ('16', '2', '0', '0', '0', '14', '1');
INSERT INTO `dc_equipment_status` VALUES ('17', '1', '0', '0', '0', '15', '1');
INSERT INTO `dc_equipment_status` VALUES ('18', '2', '0', '0', '0', '15', '1');

-- ----------------------------
-- Table structure for `dc_status`
-- ----------------------------
DROP TABLE IF EXISTS `dc_status`;
CREATE TABLE `dc_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `voltage` float DEFAULT '0' COMMENT 'điện áp trạm',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng tủ DC';

-- ----------------------------
-- Records of dc_status
-- ----------------------------
INSERT INTO `dc_status` VALUES ('12', '13', '0');
INSERT INTO `dc_status` VALUES ('13', '14', '0');
INSERT INTO `dc_status` VALUES ('14', '15', '0');

-- ----------------------------
-- Table structure for `equipment`
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` int(3) DEFAULT '1',
  `binary_pos` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Bảng Thiết bị';

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES ('1', 'Điều hòa 1', '1', '0');
INSERT INTO `equipment` VALUES ('2', 'Điều hòa 2', '1', '1');
INSERT INTO `equipment` VALUES ('3', 'Còi báo động', '1', '2');
INSERT INTO `equipment` VALUES ('4', 'Máy hút ẩm', '1', '3');
INSERT INTO `equipment` VALUES ('5', 'Thiết bị chiếu sáng', '1', '4');
INSERT INTO `equipment` VALUES ('6', 'Quạt gió', '1', '5');
INSERT INTO `equipment` VALUES ('7', 'Điều khiển dự phòng 1', '1', '6');
INSERT INTO `equipment` VALUES ('8', 'Điều khiển dự phòng 2', '1', '7');
INSERT INTO `equipment` VALUES ('9', 'Điều khiển máy phát', '1', '8');
INSERT INTO `equipment` VALUES ('10', 'Điều khiển dự phòng 4', '0', '9');

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
  KEY `FkStation` (`station_code`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment_status
-- ----------------------------
INSERT INTO `equipment_status` VALUES ('101', '1', '13', 'TR01', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('102', '2', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('103', '3', '13', 'TR01', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('104', '4', '13', 'TR01', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('105', '5', '13', 'TR01', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('106', '6', '13', 'TR01', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('107', '7', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('108', '1', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('109', '2', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('110', '3', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('111', '4', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('112', '5', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('113', '6', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('114', '7', '14', '533db3', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('115', '1', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('116', '2', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('117', '3', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('118', '4', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('119', '5', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('120', '6', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('121', '7', '15', '533db4', '0', '1', '1', '0');
INSERT INTO `equipment_status` VALUES ('122', '8', '13', '533db2', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('123', '9', '13', '533db2', '0', '1', '0', '0');

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
  `message_0` varchar(255) DEFAULT NULL,
  `message_1` varchar(255) DEFAULT NULL,
  `active` int(3) DEFAULT '1' COMMENT '0:unactive | 1:active',
  `sensor_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Bảng Thông báo';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', 'Tình trạng đột nhập', 'Không có đột nhập', 'Báo đột nhập', '1', '5');
INSERT INTO `message` VALUES ('2', 'Tình trạng cửa', 'Cửa đang đóng', 'Báo mở cửa', '1', '6');
INSERT INTO `message` VALUES ('3', 'Tình trạng khói', 'Không có khói', 'Báo có khói', '1', '7');
INSERT INTO `message` VALUES ('4', 'Tình trạng nhiệt độ', 'Nhiệt độ bình thường', 'Báo nhiệt độ cao', '1', '8');
INSERT INTO `message` VALUES ('5', 'Tình trạng ngập nước', 'Không ngập nước', 'Báo ngập nước', '1', '9');
INSERT INTO `message` VALUES ('6', 'Tình trạng vỡ kính', 'Không vỡ kính', 'Báo vỡ kính', '1', '10');
INSERT INTO `message` VALUES ('7', 'Tình trạng điện máy phát', 'Có điện lưới', 'Báo mất điện máy phát', '1', '11');
INSERT INTO `message` VALUES ('11', 'Tình trạng điện lưới', 'Có điện lưới', 'Mất điện lưới', '1', '12');

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
-- Table structure for `power_equipment`
-- ----------------------------
DROP TABLE IF EXISTS `power_equipment`;
CREATE TABLE `power_equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unit_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Bảng Các thành phần của nguồn điện';

-- ----------------------------
-- Records of power_equipment
-- ----------------------------
INSERT INTO `power_equipment` VALUES ('1', 'Điện áp', 'voltage');
INSERT INTO `power_equipment` VALUES ('2', 'Công suất', 'capacity');
INSERT INTO `power_equipment` VALUES ('3', 'Điện năng tiêu thụ', 'consume');
INSERT INTO `power_equipment` VALUES ('4', 'Tần số', 'frequency');

-- ----------------------------
-- Table structure for `power_status`
-- ----------------------------
DROP TABLE IF EXISTS `power_status`;
CREATE TABLE `power_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT '0',
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FkItem` (`item_id`),
  CONSTRAINT `FkItem` FOREIGN KEY (`item_id`) REFERENCES `power_equipment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng nguồn điện của trạm';

-- ----------------------------
-- Records of power_status
-- ----------------------------
INSERT INTO `power_status` VALUES ('5', '1', '13', '0');
INSERT INTO `power_status` VALUES ('6', '2', '13', '0');
INSERT INTO `power_status` VALUES ('7', '3', '13', '0');
INSERT INTO `power_status` VALUES ('8', '4', '13', '0');
INSERT INTO `power_status` VALUES ('9', '1', '14', null);
INSERT INTO `power_status` VALUES ('10', '2', '14', null);
INSERT INTO `power_status` VALUES ('11', '3', '14', null);
INSERT INTO `power_status` VALUES ('12', '4', '14', null);
INSERT INTO `power_status` VALUES ('13', '1', '15', null);
INSERT INTO `power_status` VALUES ('14', '2', '15', null);
INSERT INTO `power_status` VALUES ('15', '3', '15', null);
INSERT INTO `power_status` VALUES ('16', '4', '15', null);

-- ----------------------------
-- Table structure for `sensor`
-- ----------------------------
DROP TABLE IF EXISTS `sensor`;
CREATE TABLE `sensor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unit_type` varchar(20) DEFAULT NULL,
  `type` int(3) DEFAULT '1' COMMENT '1:không có giá trị | 2:có giá trị',
  `binary_pos` int(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Bảng Cảm biến';

-- ----------------------------
-- Records of sensor
-- ----------------------------
INSERT INTO `sensor` VALUES ('1', 'Chế độ báo động', '', '2', '0');
INSERT INTO `sensor` VALUES ('3', 'Nhiệt độ trong phòng', 'temperature', '2', '0');
INSERT INTO `sensor` VALUES ('4', 'Độ ẩm trong phòng', 'humidity', '2', '0');
INSERT INTO `sensor` VALUES ('5', 'Cảm biến đột nhập', null, '1', '0');
INSERT INTO `sensor` VALUES ('6', 'Cảm biến cửa', null, '1', '1');
INSERT INTO `sensor` VALUES ('7', 'Cảm biến khói', null, '1', '2');
INSERT INTO `sensor` VALUES ('8', 'Cảm biến nhiệt độ', null, '1', '3');
INSERT INTO `sensor` VALUES ('9', 'Cảm biến lụt', null, '1', '4');
INSERT INTO `sensor` VALUES ('10', 'Cảm biến kính', null, '1', '5');
INSERT INTO `sensor` VALUES ('11', 'Điện máy phát', null, '1', '6');
INSERT INTO `sensor` VALUES ('12', 'Điện lưới', null, '1', '7');

-- ----------------------------
-- Table structure for `sensor_status`
-- ----------------------------
DROP TABLE IF EXISTS `sensor_status`;
CREATE TABLE `sensor_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sensor_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(100) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1:bình thường',
  PRIMARY KEY (`id`),
  KEY `FkSensor` (`sensor_id`),
  CONSTRAINT `FkSensor` FOREIGN KEY (`sensor_id`) REFERENCES `sensor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='Bảng Tình trạng cảm biến';

-- ----------------------------
-- Records of sensor_status
-- ----------------------------
INSERT INTO `sensor_status` VALUES ('7', '1', '13', '1', '1');
INSERT INTO `sensor_status` VALUES ('8', '3', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('9', '4', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('10', '5', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('11', '6', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('12', '7', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('13', '8', '13', '1', '1');
INSERT INTO `sensor_status` VALUES ('14', '9', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('15', '10', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('16', '11', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('17', '12', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('18', '1', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('19', '3', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('20', '4', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('21', '5', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('22', '6', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('23', '7', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('24', '8', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('25', '9', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('26', '10', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('27', '11', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('28', '12', '14', null, '1');
INSERT INTO `sensor_status` VALUES ('29', '1', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('30', '3', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('31', '4', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('32', '5', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('33', '6', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('34', '7', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('35', '8', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('36', '9', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('37', '10', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('38', '11', '15', null, '1');
INSERT INTO `sensor_status` VALUES ('39', '12', '15', null, '1');

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
  `picture_url` varchar(255) DEFAULT NULL COMMENT 'url chụp ảnh',
  `video_url` varchar(255) DEFAULT NULL COMMENT 'url video',
  `latitude` varchar(20) DEFAULT NULL COMMENT 'vĩ độ',
  `longtitude` varchar(20) DEFAULT NULL COMMENT 'kinh độ',
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT '3' COMMENT 'created by user id',
  `status` int(3) DEFAULT '0' COMMENT '0: not connect | 1:connected',
  `picture_warning_numb` int(11) DEFAULT '1' COMMENT 'số ảnh chụp khi có cảnh báo',
  `ip` varchar(50) DEFAULT '',
  `port` varchar(20) DEFAULT '',
  `change_equipment_status` int(3) DEFAULT '0' COMMENT '0: no change | 1: changed',
  `updated_at` int(11) DEFAULT '0',
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UniqueCode` (`code`) USING BTREE,
  KEY `FkCenter` (`center_id`),
  KEY `FkArea` (`area_id`),
  KEY `code` (`code`),
  CONSTRAINT `FkArea` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FkCenter` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạm';

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('13', '533db2', 'ECAPRO', '1', '1', '1', 'GPIs8.8CE15', 'Vương Việt Dũng', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '21.027764', '105.834160', '0437555555', 'tram01@gmail.com', '1', '1', '5', '14.177.215.227', '8880', '0', '1431153419', 'Ngõ 1 Trung Văn, Từ Liêm, HN');
INSERT INTO `station` VALUES ('14', '533db3', 'Trạm số 2', '2', '1', '2', '', '', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '20.992695', '105.777354', '', '', '1', '1', '5', '', '', '0', '0', null);
INSERT INTO `station` VALUES ('15', '533db4', 'Trạm số 3', '3', '2', '2', '', '', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '20.976988', '105.841641', '', '', '1', '1', '2', '', '', '0', '0', null);

-- ----------------------------
-- Table structure for `station_status`
-- ----------------------------
DROP TABLE IF EXISTS `station_status`;
CREATE TABLE `station_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) DEFAULT NULL,
  `request_string` tinytext,
  `received` int(3) DEFAULT '1' COMMENT '2: gửi đi | 1: nhận được',
  `time_update` int(11) DEFAULT '0',
  `status` int(3) DEFAULT '1' COMMENT '0: thất bại | 1: thành công',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3530 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạng thái của trạm';

-- ----------------------------
-- Records of station_status
-- ----------------------------
INSERT INTO `station_status` VALUES ('545', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953706', '1');
INSERT INTO `station_status` VALUES ('546', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953754', '1');
INSERT INTO `station_status` VALUES ('547', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953804', '1');
INSERT INTO `station_status` VALUES ('548', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953896', '1');
INSERT INTO `station_status` VALUES ('549', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953947', '1');
INSERT INTO `station_status` VALUES ('550', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430953997', '1');
INSERT INTO `station_status` VALUES ('551', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954047', '1');
INSERT INTO `station_status` VALUES ('552', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954139', '1');
INSERT INTO `station_status` VALUES ('553', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954190', '1');
INSERT INTO `station_status` VALUES ('554', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954241', '1');
INSERT INTO `station_status` VALUES ('555', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954291', '1');
INSERT INTO `station_status` VALUES ('556', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954384', '1');
INSERT INTO `station_status` VALUES ('557', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954678', '1');
INSERT INTO `station_status` VALUES ('558', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954687', '1');
INSERT INTO `station_status` VALUES ('559', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954697', '1');
INSERT INTO `station_status` VALUES ('560', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954708', '1');
INSERT INTO `station_status` VALUES ('561', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954718', '1');
INSERT INTO `station_status` VALUES ('562', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954727', '1');
INSERT INTO `station_status` VALUES ('563', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954737', '1');
INSERT INTO `station_status` VALUES ('564', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954747', '1');
INSERT INTO `station_status` VALUES ('565', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954758', '1');
INSERT INTO `station_status` VALUES ('566', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954767', '1');
INSERT INTO `station_status` VALUES ('567', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954777', '1');
INSERT INTO `station_status` VALUES ('568', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954788', '1');
INSERT INTO `station_status` VALUES ('569', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954798', '1');
INSERT INTO `station_status` VALUES ('570', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954807', '1');
INSERT INTO `station_status` VALUES ('571', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954817', '1');
INSERT INTO `station_status` VALUES ('572', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954829', '1');
INSERT INTO `station_status` VALUES ('573', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954837', '1');
INSERT INTO `station_status` VALUES ('574', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954847', '1');
INSERT INTO `station_status` VALUES ('575', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954858', '1');
INSERT INTO `station_status` VALUES ('576', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954868', '1');
INSERT INTO `station_status` VALUES ('577', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954877', '1');
INSERT INTO `station_status` VALUES ('578', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954887', '1');
INSERT INTO `station_status` VALUES ('579', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954898', '1');
INSERT INTO `station_status` VALUES ('580', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954908', '1');
INSERT INTO `station_status` VALUES ('581', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954918', '1');
INSERT INTO `station_status` VALUES ('582', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954928', '1');
INSERT INTO `station_status` VALUES ('583', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954938', '1');
INSERT INTO `station_status` VALUES ('584', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954948', '1');
INSERT INTO `station_status` VALUES ('585', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954958', '1');
INSERT INTO `station_status` VALUES ('586', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954968', '1');
INSERT INTO `station_status` VALUES ('587', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954978', '1');
INSERT INTO `station_status` VALUES ('588', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954988', '1');
INSERT INTO `station_status` VALUES ('589', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430954998', '1');
INSERT INTO `station_status` VALUES ('590', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955008', '1');
INSERT INTO `station_status` VALUES ('591', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955018', '1');
INSERT INTO `station_status` VALUES ('592', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955029', '1');
INSERT INTO `station_status` VALUES ('593', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955038', '1');
INSERT INTO `station_status` VALUES ('594', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955048', '1');
INSERT INTO `station_status` VALUES ('595', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955058', '1');
INSERT INTO `station_status` VALUES ('596', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955068', '1');
INSERT INTO `station_status` VALUES ('597', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955078', '1');
INSERT INTO `station_status` VALUES ('598', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955088', '1');
INSERT INTO `station_status` VALUES ('599', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955098', '1');
INSERT INTO `station_status` VALUES ('600', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955108', '1');
INSERT INTO `station_status` VALUES ('601', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955118', '1');
INSERT INTO `station_status` VALUES ('602', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955128', '1');
INSERT INTO `station_status` VALUES ('603', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955138', '1');
INSERT INTO `station_status` VALUES ('604', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955148', '1');
INSERT INTO `station_status` VALUES ('605', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955158', '1');
INSERT INTO `station_status` VALUES ('606', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955168', '1');
INSERT INTO `station_status` VALUES ('607', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955178', '1');
INSERT INTO `station_status` VALUES ('608', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955188', '1');
INSERT INTO `station_status` VALUES ('609', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955199', '1');
INSERT INTO `station_status` VALUES ('610', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955208', '1');
INSERT INTO `station_status` VALUES ('611', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955218', '1');
INSERT INTO `station_status` VALUES ('612', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955228', '1');
INSERT INTO `station_status` VALUES ('613', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955238', '1');
INSERT INTO `station_status` VALUES ('614', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955248', '1');
INSERT INTO `station_status` VALUES ('615', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955258', '1');
INSERT INTO `station_status` VALUES ('616', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955268', '1');
INSERT INTO `station_status` VALUES ('617', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955278', '1');
INSERT INTO `station_status` VALUES ('618', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955288', '1');
INSERT INTO `station_status` VALUES ('619', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955298', '1');
INSERT INTO `station_status` VALUES ('620', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955308', '1');
INSERT INTO `station_status` VALUES ('621', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955318', '1');
INSERT INTO `station_status` VALUES ('622', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955328', '1');
INSERT INTO `station_status` VALUES ('623', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955338', '1');
INSERT INTO `station_status` VALUES ('624', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955349', '1');
INSERT INTO `station_status` VALUES ('625', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955359', '1');
INSERT INTO `station_status` VALUES ('626', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955368', '1');
INSERT INTO `station_status` VALUES ('627', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955378', '1');
INSERT INTO `station_status` VALUES ('628', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955389', '1');
INSERT INTO `station_status` VALUES ('629', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955399', '1');
INSERT INTO `station_status` VALUES ('630', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955408', '1');
INSERT INTO `station_status` VALUES ('631', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955418', '1');
INSERT INTO `station_status` VALUES ('632', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955429', '1');
INSERT INTO `station_status` VALUES ('633', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955439', '1');
INSERT INTO `station_status` VALUES ('634', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955448', '1');
INSERT INTO `station_status` VALUES ('635', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955459', '1');
INSERT INTO `station_status` VALUES ('636', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955469', '1');
INSERT INTO `station_status` VALUES ('637', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955480', '1');
INSERT INTO `station_status` VALUES ('638', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955489', '1');
INSERT INTO `station_status` VALUES ('639', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955498', '1');
INSERT INTO `station_status` VALUES ('640', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955509', '1');
INSERT INTO `station_status` VALUES ('641', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955519', '1');
INSERT INTO `station_status` VALUES ('642', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955528', '1');
INSERT INTO `station_status` VALUES ('643', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955538', '1');
INSERT INTO `station_status` VALUES ('644', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955549', '1');
INSERT INTO `station_status` VALUES ('645', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955559', '1');
INSERT INTO `station_status` VALUES ('646', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955568', '1');
INSERT INTO `station_status` VALUES ('647', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955578', '1');
INSERT INTO `station_status` VALUES ('648', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955589', '1');
INSERT INTO `station_status` VALUES ('649', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955599', '1');
INSERT INTO `station_status` VALUES ('650', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955608', '1');
INSERT INTO `station_status` VALUES ('651', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955619', '1');
INSERT INTO `station_status` VALUES ('652', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955629', '1');
INSERT INTO `station_status` VALUES ('653', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955639', '1');
INSERT INTO `station_status` VALUES ('654', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955649', '1');
INSERT INTO `station_status` VALUES ('655', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955659', '1');
INSERT INTO `station_status` VALUES ('656', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955669', '1');
INSERT INTO `station_status` VALUES ('657', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955679', '1');
INSERT INTO `station_status` VALUES ('658', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955688', '1');
INSERT INTO `station_status` VALUES ('659', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955699', '1');
INSERT INTO `station_status` VALUES ('660', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955709', '1');
INSERT INTO `station_status` VALUES ('661', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955719', '1');
INSERT INTO `station_status` VALUES ('662', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955729', '1');
INSERT INTO `station_status` VALUES ('663', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955739', '1');
INSERT INTO `station_status` VALUES ('664', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955749', '1');
INSERT INTO `station_status` VALUES ('665', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955759', '1');
INSERT INTO `station_status` VALUES ('666', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955769', '1');
INSERT INTO `station_status` VALUES ('667', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955779', '1');
INSERT INTO `station_status` VALUES ('668', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955789', '1');
INSERT INTO `station_status` VALUES ('669', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955799', '1');
INSERT INTO `station_status` VALUES ('670', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955809', '1');
INSERT INTO `station_status` VALUES ('671', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955819', '1');
INSERT INTO `station_status` VALUES ('672', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955829', '1');
INSERT INTO `station_status` VALUES ('673', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955839', '1');
INSERT INTO `station_status` VALUES ('674', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955849', '1');
INSERT INTO `station_status` VALUES ('675', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955859', '1');
INSERT INTO `station_status` VALUES ('676', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955869', '1');
INSERT INTO `station_status` VALUES ('677', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955879', '1');
INSERT INTO `station_status` VALUES ('678', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955889', '1');
INSERT INTO `station_status` VALUES ('679', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955900', '1');
INSERT INTO `station_status` VALUES ('680', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955909', '1');
INSERT INTO `station_status` VALUES ('681', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955919', '1');
INSERT INTO `station_status` VALUES ('682', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955929', '1');
INSERT INTO `station_status` VALUES ('683', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955939', '1');
INSERT INTO `station_status` VALUES ('684', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955950', '1');
INSERT INTO `station_status` VALUES ('685', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955959', '1');
INSERT INTO `station_status` VALUES ('686', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955969', '1');
INSERT INTO `station_status` VALUES ('687', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955979', '1');
INSERT INTO `station_status` VALUES ('688', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430955990', '1');
INSERT INTO `station_status` VALUES ('689', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956000', '1');
INSERT INTO `station_status` VALUES ('690', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956009', '1');
INSERT INTO `station_status` VALUES ('691', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956019', '1');
INSERT INTO `station_status` VALUES ('692', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956030', '1');
INSERT INTO `station_status` VALUES ('693', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956040', '1');
INSERT INTO `station_status` VALUES ('694', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956049', '1');
INSERT INTO `station_status` VALUES ('695', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956059', '1');
INSERT INTO `station_status` VALUES ('696', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956070', '1');
INSERT INTO `station_status` VALUES ('697', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956080', '1');
INSERT INTO `station_status` VALUES ('698', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956089', '1');
INSERT INTO `station_status` VALUES ('699', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956099', '1');
INSERT INTO `station_status` VALUES ('700', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956109', '1');
INSERT INTO `station_status` VALUES ('701', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956119', '1');
INSERT INTO `station_status` VALUES ('702', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956130', '1');
INSERT INTO `station_status` VALUES ('703', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956140', '1');
INSERT INTO `station_status` VALUES ('704', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956149', '1');
INSERT INTO `station_status` VALUES ('705', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956159', '1');
INSERT INTO `station_status` VALUES ('706', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956170', '1');
INSERT INTO `station_status` VALUES ('707', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956180', '1');
INSERT INTO `station_status` VALUES ('708', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956190', '1');
INSERT INTO `station_status` VALUES ('709', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956200', '1');
INSERT INTO `station_status` VALUES ('710', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956210', '1');
INSERT INTO `station_status` VALUES ('711', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956220', '1');
INSERT INTO `station_status` VALUES ('712', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956230', '1');
INSERT INTO `station_status` VALUES ('713', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956240', '1');
INSERT INTO `station_status` VALUES ('714', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956250', '1');
INSERT INTO `station_status` VALUES ('715', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956260', '1');
INSERT INTO `station_status` VALUES ('716', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956270', '1');
INSERT INTO `station_status` VALUES ('717', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956280', '1');
INSERT INTO `station_status` VALUES ('718', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956289', '1');
INSERT INTO `station_status` VALUES ('719', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956300', '1');
INSERT INTO `station_status` VALUES ('720', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956310', '1');
INSERT INTO `station_status` VALUES ('721', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956320', '1');
INSERT INTO `station_status` VALUES ('722', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956330', '1');
INSERT INTO `station_status` VALUES ('723', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956340', '1');
INSERT INTO `station_status` VALUES ('724', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956350', '1');
INSERT INTO `station_status` VALUES ('725', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956362', '1');
INSERT INTO `station_status` VALUES ('726', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956370', '1');
INSERT INTO `station_status` VALUES ('727', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956380', '1');
INSERT INTO `station_status` VALUES ('728', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956390', '1');
INSERT INTO `station_status` VALUES ('729', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956400', '1');
INSERT INTO `station_status` VALUES ('730', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956413', '1');
INSERT INTO `station_status` VALUES ('731', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956421', '1');
INSERT INTO `station_status` VALUES ('732', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956430', '1');
INSERT INTO `station_status` VALUES ('733', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956441', '1');
INSERT INTO `station_status` VALUES ('734', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956451', '1');
INSERT INTO `station_status` VALUES ('735', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956461', '1');
INSERT INTO `station_status` VALUES ('736', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956470', '1');
INSERT INTO `station_status` VALUES ('737', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956480', '1');
INSERT INTO `station_status` VALUES ('738', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956490', '1');
INSERT INTO `station_status` VALUES ('739', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956500', '1');
INSERT INTO `station_status` VALUES ('740', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956510', '1');
INSERT INTO `station_status` VALUES ('741', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956520', '1');
INSERT INTO `station_status` VALUES ('742', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956530', '1');
INSERT INTO `station_status` VALUES ('743', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956541', '1');
INSERT INTO `station_status` VALUES ('744', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956550', '1');
INSERT INTO `station_status` VALUES ('745', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956561', '1');
INSERT INTO `station_status` VALUES ('746', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956570', '1');
INSERT INTO `station_status` VALUES ('747', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956580', '1');
INSERT INTO `station_status` VALUES ('748', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956590', '1');
INSERT INTO `station_status` VALUES ('749', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956600', '1');
INSERT INTO `station_status` VALUES ('750', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956611', '1');
INSERT INTO `station_status` VALUES ('751', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956621', '1');
INSERT INTO `station_status` VALUES ('752', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956630', '1');
INSERT INTO `station_status` VALUES ('753', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956640', '1');
INSERT INTO `station_status` VALUES ('754', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956650', '1');
INSERT INTO `station_status` VALUES ('755', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956660', '1');
INSERT INTO `station_status` VALUES ('756', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956671', '1');
INSERT INTO `station_status` VALUES ('757', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956680', '1');
INSERT INTO `station_status` VALUES ('758', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956691', '1');
INSERT INTO `station_status` VALUES ('759', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956702', '1');
INSERT INTO `station_status` VALUES ('760', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956710', '1');
INSERT INTO `station_status` VALUES ('761', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956720', '1');
INSERT INTO `station_status` VALUES ('762', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956731', '1');
INSERT INTO `station_status` VALUES ('763', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956741', '1');
INSERT INTO `station_status` VALUES ('764', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956751', '1');
INSERT INTO `station_status` VALUES ('765', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956760', '1');
INSERT INTO `station_status` VALUES ('766', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956770', '1');
INSERT INTO `station_status` VALUES ('767', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956781', '1');
INSERT INTO `station_status` VALUES ('768', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956791', '1');
INSERT INTO `station_status` VALUES ('769', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956801', '1');
INSERT INTO `station_status` VALUES ('770', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956811', '1');
INSERT INTO `station_status` VALUES ('771', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956821', '1');
INSERT INTO `station_status` VALUES ('772', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956831', '1');
INSERT INTO `station_status` VALUES ('773', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956842', '1');
INSERT INTO `station_status` VALUES ('774', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956851', '1');
INSERT INTO `station_status` VALUES ('775', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956861', '1');
INSERT INTO `station_status` VALUES ('776', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956871', '1');
INSERT INTO `station_status` VALUES ('777', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956881', '1');
INSERT INTO `station_status` VALUES ('778', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956890', '1');
INSERT INTO `station_status` VALUES ('779', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956901', '1');
INSERT INTO `station_status` VALUES ('780', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956911', '1');
INSERT INTO `station_status` VALUES ('781', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956921', '1');
INSERT INTO `station_status` VALUES ('782', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956932', '1');
INSERT INTO `station_status` VALUES ('783', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956941', '1');
INSERT INTO `station_status` VALUES ('784', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956951', '1');
INSERT INTO `station_status` VALUES ('785', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956961', '1');
INSERT INTO `station_status` VALUES ('786', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956971', '1');
INSERT INTO `station_status` VALUES ('787', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956981', '1');
INSERT INTO `station_status` VALUES ('788', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430956991', '1');
INSERT INTO `station_status` VALUES ('789', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957001', '1');
INSERT INTO `station_status` VALUES ('790', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957011', '1');
INSERT INTO `station_status` VALUES ('791', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957021', '1');
INSERT INTO `station_status` VALUES ('792', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957031', '1');
INSERT INTO `station_status` VALUES ('793', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957041', '1');
INSERT INTO `station_status` VALUES ('794', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957051', '1');
INSERT INTO `station_status` VALUES ('795', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957061', '1');
INSERT INTO `station_status` VALUES ('796', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957071', '1');
INSERT INTO `station_status` VALUES ('797', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957081', '1');
INSERT INTO `station_status` VALUES ('798', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957091', '1');
INSERT INTO `station_status` VALUES ('799', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957101', '1');
INSERT INTO `station_status` VALUES ('800', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957111', '1');
INSERT INTO `station_status` VALUES ('801', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957121', '1');
INSERT INTO `station_status` VALUES ('802', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957131', '1');
INSERT INTO `station_status` VALUES ('803', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957141', '1');
INSERT INTO `station_status` VALUES ('804', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957151', '1');
INSERT INTO `station_status` VALUES ('805', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957161', '1');
INSERT INTO `station_status` VALUES ('806', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957171', '1');
INSERT INTO `station_status` VALUES ('807', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957181', '1');
INSERT INTO `station_status` VALUES ('808', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957191', '1');
INSERT INTO `station_status` VALUES ('809', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957201', '1');
INSERT INTO `station_status` VALUES ('810', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957211', '1');
INSERT INTO `station_status` VALUES ('811', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957222', '1');
INSERT INTO `station_status` VALUES ('812', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957232', '1');
INSERT INTO `station_status` VALUES ('813', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957241', '1');
INSERT INTO `station_status` VALUES ('814', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957251', '1');
INSERT INTO `station_status` VALUES ('815', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957261', '1');
INSERT INTO `station_status` VALUES ('816', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957272', '1');
INSERT INTO `station_status` VALUES ('817', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957281', '1');
INSERT INTO `station_status` VALUES ('818', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957291', '1');
INSERT INTO `station_status` VALUES ('819', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957301', '1');
INSERT INTO `station_status` VALUES ('820', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957311', '1');
INSERT INTO `station_status` VALUES ('821', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957321', '1');
INSERT INTO `station_status` VALUES ('822', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957331', '1');
INSERT INTO `station_status` VALUES ('823', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957342', '1');
INSERT INTO `station_status` VALUES ('824', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957352', '1');
INSERT INTO `station_status` VALUES ('825', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957361', '1');
INSERT INTO `station_status` VALUES ('826', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957371', '1');
INSERT INTO `station_status` VALUES ('827', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957382', '1');
INSERT INTO `station_status` VALUES ('828', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957392', '1');
INSERT INTO `station_status` VALUES ('829', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957401', '1');
INSERT INTO `station_status` VALUES ('830', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957411', '1');
INSERT INTO `station_status` VALUES ('831', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957422', '1');
INSERT INTO `station_status` VALUES ('832', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957432', '1');
INSERT INTO `station_status` VALUES ('833', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957441', '1');
INSERT INTO `station_status` VALUES ('834', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957451', '1');
INSERT INTO `station_status` VALUES ('835', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957462', '1');
INSERT INTO `station_status` VALUES ('836', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957472', '1');
INSERT INTO `station_status` VALUES ('837', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957482', '1');
INSERT INTO `station_status` VALUES ('838', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957491', '1');
INSERT INTO `station_status` VALUES ('839', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957501', '1');
INSERT INTO `station_status` VALUES ('840', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957512', '1');
INSERT INTO `station_status` VALUES ('841', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957522', '1');
INSERT INTO `station_status` VALUES ('842', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957531', '1');
INSERT INTO `station_status` VALUES ('843', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957541', '1');
INSERT INTO `station_status` VALUES ('844', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957553', '1');
INSERT INTO `station_status` VALUES ('845', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957562', '1');
INSERT INTO `station_status` VALUES ('846', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957571', '1');
INSERT INTO `station_status` VALUES ('847', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957582', '1');
INSERT INTO `station_status` VALUES ('848', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957592', '1');
INSERT INTO `station_status` VALUES ('849', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957601', '1');
INSERT INTO `station_status` VALUES ('850', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957612', '1');
INSERT INTO `station_status` VALUES ('851', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957622', '1');
INSERT INTO `station_status` VALUES ('852', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957632', '1');
INSERT INTO `station_status` VALUES ('853', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957642', '1');
INSERT INTO `station_status` VALUES ('854', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957651', '1');
INSERT INTO `station_status` VALUES ('855', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957663', '1');
INSERT INTO `station_status` VALUES ('856', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957672', '1');
INSERT INTO `station_status` VALUES ('857', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957681', '1');
INSERT INTO `station_status` VALUES ('858', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957693', '1');
INSERT INTO `station_status` VALUES ('859', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957702', '1');
INSERT INTO `station_status` VALUES ('860', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957712', '1');
INSERT INTO `station_status` VALUES ('861', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957722', '1');
INSERT INTO `station_status` VALUES ('862', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957732', '1');
INSERT INTO `station_status` VALUES ('863', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957742', '1');
INSERT INTO `station_status` VALUES ('864', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957752', '1');
INSERT INTO `station_status` VALUES ('865', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957762', '1');
INSERT INTO `station_status` VALUES ('866', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957772', '1');
INSERT INTO `station_status` VALUES ('867', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957782', '1');
INSERT INTO `station_status` VALUES ('868', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957792', '1');
INSERT INTO `station_status` VALUES ('869', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957802', '1');
INSERT INTO `station_status` VALUES ('870', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957813', '1');
INSERT INTO `station_status` VALUES ('871', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957822', '1');
INSERT INTO `station_status` VALUES ('872', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957832', '1');
INSERT INTO `station_status` VALUES ('873', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957842', '1');
INSERT INTO `station_status` VALUES ('874', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957852', '1');
INSERT INTO `station_status` VALUES ('875', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957864', '1');
INSERT INTO `station_status` VALUES ('876', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957872', '1');
INSERT INTO `station_status` VALUES ('877', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957882', '1');
INSERT INTO `station_status` VALUES ('878', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957944', '1');
INSERT INTO `station_status` VALUES ('879', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957952', '1');
INSERT INTO `station_status` VALUES ('880', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957963', '1');
INSERT INTO `station_status` VALUES ('881', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957973', '1');
INSERT INTO `station_status` VALUES ('882', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957983', '1');
INSERT INTO `station_status` VALUES ('883', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430957993', '1');
INSERT INTO `station_status` VALUES ('884', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958003', '1');
INSERT INTO `station_status` VALUES ('885', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958013', '1');
INSERT INTO `station_status` VALUES ('886', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958023', '1');
INSERT INTO `station_status` VALUES ('887', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958034', '1');
INSERT INTO `station_status` VALUES ('888', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958043', '1');
INSERT INTO `station_status` VALUES ('889', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958053', '1');
INSERT INTO `station_status` VALUES ('890', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958063', '1');
INSERT INTO `station_status` VALUES ('891', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958073', '1');
INSERT INTO `station_status` VALUES ('892', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958083', '1');
INSERT INTO `station_status` VALUES ('893', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958093', '1');
INSERT INTO `station_status` VALUES ('894', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958103', '1');
INSERT INTO `station_status` VALUES ('895', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958113', '1');
INSERT INTO `station_status` VALUES ('896', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958166', '1');
INSERT INTO `station_status` VALUES ('897', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958176', '1');
INSERT INTO `station_status` VALUES ('898', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958185', '1');
INSERT INTO `station_status` VALUES ('899', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958196', '1');
INSERT INTO `station_status` VALUES ('900', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958206', '1');
INSERT INTO `station_status` VALUES ('901', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958215', '1');
INSERT INTO `station_status` VALUES ('902', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958267', '1');
INSERT INTO `station_status` VALUES ('903', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958276', '1');
INSERT INTO `station_status` VALUES ('904', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958286', '1');
INSERT INTO `station_status` VALUES ('905', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958297', '1');
INSERT INTO `station_status` VALUES ('906', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958306', '1');
INSERT INTO `station_status` VALUES ('907', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958316', '1');
INSERT INTO `station_status` VALUES ('908', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958327', '1');
INSERT INTO `station_status` VALUES ('909', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958337', '1');
INSERT INTO `station_status` VALUES ('910', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958346', '1');
INSERT INTO `station_status` VALUES ('911', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958356', '1');
INSERT INTO `station_status` VALUES ('912', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958366', '1');
INSERT INTO `station_status` VALUES ('913', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958377', '1');
INSERT INTO `station_status` VALUES ('914', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958387', '1');
INSERT INTO `station_status` VALUES ('915', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958396', '1');
INSERT INTO `station_status` VALUES ('916', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958406', '1');
INSERT INTO `station_status` VALUES ('917', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958458', '1');
INSERT INTO `station_status` VALUES ('918', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958467', '1');
INSERT INTO `station_status` VALUES ('919', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958559', '1');
INSERT INTO `station_status` VALUES ('920', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958568', '1');
INSERT INTO `station_status` VALUES ('921', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958578', '1');
INSERT INTO `station_status` VALUES ('922', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958588', '1');
INSERT INTO `station_status` VALUES ('923', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958599', '1');
INSERT INTO `station_status` VALUES ('924', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958608', '1');
INSERT INTO `station_status` VALUES ('925', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958618', '1');
INSERT INTO `station_status` VALUES ('926', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958629', '1');
INSERT INTO `station_status` VALUES ('927', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958638', '1');
INSERT INTO `station_status` VALUES ('928', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958648', '1');
INSERT INTO `station_status` VALUES ('929', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958659', '1');
INSERT INTO `station_status` VALUES ('930', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958669', '1');
INSERT INTO `station_status` VALUES ('931', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958678', '1');
INSERT INTO `station_status` VALUES ('932', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958688', '1');
INSERT INTO `station_status` VALUES ('933', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958699', '1');
INSERT INTO `station_status` VALUES ('934', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958709', '1');
INSERT INTO `station_status` VALUES ('935', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958718', '1');
INSERT INTO `station_status` VALUES ('936', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958728', '1');
INSERT INTO `station_status` VALUES ('937', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958739', '1');
INSERT INTO `station_status` VALUES ('938', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958749', '1');
INSERT INTO `station_status` VALUES ('939', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958758', '1');
INSERT INTO `station_status` VALUES ('940', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958768', '1');
INSERT INTO `station_status` VALUES ('941', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958779', '1');
INSERT INTO `station_status` VALUES ('942', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958789', '1');
INSERT INTO `station_status` VALUES ('943', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958798', '1');
INSERT INTO `station_status` VALUES ('944', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958808', '1');
INSERT INTO `station_status` VALUES ('945', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958819', '1');
INSERT INTO `station_status` VALUES ('946', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958829', '1');
INSERT INTO `station_status` VALUES ('947', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958838', '1');
INSERT INTO `station_status` VALUES ('948', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958848', '1');
INSERT INTO `station_status` VALUES ('949', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958859', '1');
INSERT INTO `station_status` VALUES ('950', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958869', '1');
INSERT INTO `station_status` VALUES ('951', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958878', '1');
INSERT INTO `station_status` VALUES ('952', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958888', '1');
INSERT INTO `station_status` VALUES ('953', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958899', '1');
INSERT INTO `station_status` VALUES ('954', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958909', '1');
INSERT INTO `station_status` VALUES ('955', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958918', '1');
INSERT INTO `station_status` VALUES ('956', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958928', '1');
INSERT INTO `station_status` VALUES ('957', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958939', '1');
INSERT INTO `station_status` VALUES ('958', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958949', '1');
INSERT INTO `station_status` VALUES ('959', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958959', '1');
INSERT INTO `station_status` VALUES ('960', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958969', '1');
INSERT INTO `station_status` VALUES ('961', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958979', '1');
INSERT INTO `station_status` VALUES ('962', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958989', '1');
INSERT INTO `station_status` VALUES ('963', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430958999', '1');
INSERT INTO `station_status` VALUES ('964', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959009', '1');
INSERT INTO `station_status` VALUES ('965', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959019', '1');
INSERT INTO `station_status` VALUES ('966', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959029', '1');
INSERT INTO `station_status` VALUES ('967', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959039', '1');
INSERT INTO `station_status` VALUES ('968', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959049', '1');
INSERT INTO `station_status` VALUES ('969', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959059', '1');
INSERT INTO `station_status` VALUES ('970', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959069', '1');
INSERT INTO `station_status` VALUES ('971', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959079', '1');
INSERT INTO `station_status` VALUES ('972', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959089', '1');
INSERT INTO `station_status` VALUES ('973', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959099', '1');
INSERT INTO `station_status` VALUES ('974', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959109', '1');
INSERT INTO `station_status` VALUES ('975', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959119', '1');
INSERT INTO `station_status` VALUES ('976', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959129', '1');
INSERT INTO `station_status` VALUES ('977', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959139', '1');
INSERT INTO `station_status` VALUES ('978', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959150', '1');
INSERT INTO `station_status` VALUES ('979', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959159', '1');
INSERT INTO `station_status` VALUES ('980', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959169', '1');
INSERT INTO `station_status` VALUES ('981', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959180', '1');
INSERT INTO `station_status` VALUES ('982', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959189', '1');
INSERT INTO `station_status` VALUES ('983', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959199', '1');
INSERT INTO `station_status` VALUES ('984', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959209', '1');
INSERT INTO `station_status` VALUES ('985', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959219', '1');
INSERT INTO `station_status` VALUES ('986', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959229', '1');
INSERT INTO `station_status` VALUES ('987', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959239', '1');
INSERT INTO `station_status` VALUES ('988', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959249', '1');
INSERT INTO `station_status` VALUES ('989', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959259', '1');
INSERT INTO `station_status` VALUES ('990', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959269', '1');
INSERT INTO `station_status` VALUES ('991', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959279', '1');
INSERT INTO `station_status` VALUES ('992', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959289', '1');
INSERT INTO `station_status` VALUES ('993', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959299', '1');
INSERT INTO `station_status` VALUES ('994', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959310', '1');
INSERT INTO `station_status` VALUES ('995', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959319', '1');
INSERT INTO `station_status` VALUES ('996', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959329', '1');
INSERT INTO `station_status` VALUES ('997', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959340', '1');
INSERT INTO `station_status` VALUES ('998', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959350', '1');
INSERT INTO `station_status` VALUES ('999', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959359', '1');
INSERT INTO `station_status` VALUES ('1000', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959369', '1');
INSERT INTO `station_status` VALUES ('1001', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959380', '1');
INSERT INTO `station_status` VALUES ('1002', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959390', '1');
INSERT INTO `station_status` VALUES ('1003', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959400', '1');
INSERT INTO `station_status` VALUES ('1004', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959409', '1');
INSERT INTO `station_status` VALUES ('1005', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959419', '1');
INSERT INTO `station_status` VALUES ('1006', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959430', '1');
INSERT INTO `station_status` VALUES ('1007', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959440', '1');
INSERT INTO `station_status` VALUES ('1008', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959449', '1');
INSERT INTO `station_status` VALUES ('1009', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959459', '1');
INSERT INTO `station_status` VALUES ('1010', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959470', '1');
INSERT INTO `station_status` VALUES ('1011', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959480', '1');
INSERT INTO `station_status` VALUES ('1012', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959489', '1');
INSERT INTO `station_status` VALUES ('1013', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959499', '1');
INSERT INTO `station_status` VALUES ('1014', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959510', '1');
INSERT INTO `station_status` VALUES ('1015', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959520', '1');
INSERT INTO `station_status` VALUES ('1016', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959529', '1');
INSERT INTO `station_status` VALUES ('1017', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959539', '1');
INSERT INTO `station_status` VALUES ('1018', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959550', '1');
INSERT INTO `station_status` VALUES ('1019', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959560', '1');
INSERT INTO `station_status` VALUES ('1020', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959569', '1');
INSERT INTO `station_status` VALUES ('1021', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959579', '1');
INSERT INTO `station_status` VALUES ('1022', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959590', '1');
INSERT INTO `station_status` VALUES ('1023', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959600', '1');
INSERT INTO `station_status` VALUES ('1024', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959609', '1');
INSERT INTO `station_status` VALUES ('1025', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959620', '1');
INSERT INTO `station_status` VALUES ('1026', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959630', '1');
INSERT INTO `station_status` VALUES ('1027', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959640', '1');
INSERT INTO `station_status` VALUES ('1028', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959650', '1');
INSERT INTO `station_status` VALUES ('1029', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959659', '1');
INSERT INTO `station_status` VALUES ('1030', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959670', '1');
INSERT INTO `station_status` VALUES ('1031', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959680', '1');
INSERT INTO `station_status` VALUES ('1032', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959690', '1');
INSERT INTO `station_status` VALUES ('1033', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959700', '1');
INSERT INTO `station_status` VALUES ('1034', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959710', '1');
INSERT INTO `station_status` VALUES ('1035', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959720', '1');
INSERT INTO `station_status` VALUES ('1036', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959730', '1');
INSERT INTO `station_status` VALUES ('1037', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959740', '1');
INSERT INTO `station_status` VALUES ('1038', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959747', '1');
INSERT INTO `station_status` VALUES ('1039', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959750', '1');
INSERT INTO `station_status` VALUES ('1040', '13', '533db2&ECAPRO&status&ERROR&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959757', '1');
INSERT INTO `station_status` VALUES ('1041', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959760', '1');
INSERT INTO `station_status` VALUES ('1042', '13', '533db2&ECAPRO&status&ERROR&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959767', '1');
INSERT INTO `station_status` VALUES ('1043', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959770', '1');
INSERT INTO `station_status` VALUES ('1044', '13', '533db2&ECAPRO&status&ERROR&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959777', '1');
INSERT INTO `station_status` VALUES ('1045', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959780', '1');
INSERT INTO `station_status` VALUES ('1046', '13', '533db2&ECAPRO&status&ERROR&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959787', '1');
INSERT INTO `station_status` VALUES ('1047', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959790', '1');
INSERT INTO `station_status` VALUES ('1048', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959800', '1');
INSERT INTO `station_status` VALUES ('1049', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959811', '1');
INSERT INTO `station_status` VALUES ('1050', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959820', '1');
INSERT INTO `station_status` VALUES ('1051', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959830', '1');
INSERT INTO `station_status` VALUES ('1052', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959840', '1');
INSERT INTO `station_status` VALUES ('1053', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959850', '1');
INSERT INTO `station_status` VALUES ('1054', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959860', '1');
INSERT INTO `station_status` VALUES ('1055', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959870', '1');
INSERT INTO `station_status` VALUES ('1056', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959880', '1');
INSERT INTO `station_status` VALUES ('1057', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959890', '1');
INSERT INTO `station_status` VALUES ('1058', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959900', '1');
INSERT INTO `station_status` VALUES ('1059', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959911', '1');
INSERT INTO `station_status` VALUES ('1060', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959920', '1');
INSERT INTO `station_status` VALUES ('1061', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959930', '1');
INSERT INTO `station_status` VALUES ('1062', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959940', '1');
INSERT INTO `station_status` VALUES ('1063', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959950', '1');
INSERT INTO `station_status` VALUES ('1064', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959960', '1');
INSERT INTO `station_status` VALUES ('1065', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959970', '1');
INSERT INTO `station_status` VALUES ('1066', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959980', '1');
INSERT INTO `station_status` VALUES ('1067', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430959991', '1');
INSERT INTO `station_status` VALUES ('1068', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960001', '1');
INSERT INTO `station_status` VALUES ('1069', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960011', '1');
INSERT INTO `station_status` VALUES ('1070', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960020', '1');
INSERT INTO `station_status` VALUES ('1071', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960031', '1');
INSERT INTO `station_status` VALUES ('1072', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960041', '1');
INSERT INTO `station_status` VALUES ('1073', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960050', '1');
INSERT INTO `station_status` VALUES ('1074', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960060', '1');
INSERT INTO `station_status` VALUES ('1075', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960070', '1');
INSERT INTO `station_status` VALUES ('1076', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960081', '1');
INSERT INTO `station_status` VALUES ('1077', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960091', '1');
INSERT INTO `station_status` VALUES ('1078', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960100', '1');
INSERT INTO `station_status` VALUES ('1079', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960110', '1');
INSERT INTO `station_status` VALUES ('1080', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960121', '1');
INSERT INTO `station_status` VALUES ('1081', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960131', '1');
INSERT INTO `station_status` VALUES ('1082', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960140', '1');
INSERT INTO `station_status` VALUES ('1083', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960150', '1');
INSERT INTO `station_status` VALUES ('1084', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960160', '1');
INSERT INTO `station_status` VALUES ('1085', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960171', '1');
INSERT INTO `station_status` VALUES ('1086', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960181', '1');
INSERT INTO `station_status` VALUES ('1087', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960186', '1');
INSERT INTO `station_status` VALUES ('1088', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960191', '1');
INSERT INTO `station_status` VALUES ('1089', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960196', '1');
INSERT INTO `station_status` VALUES ('1090', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960200', '1');
INSERT INTO `station_status` VALUES ('1091', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960207', '1');
INSERT INTO `station_status` VALUES ('1092', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960211', '1');
INSERT INTO `station_status` VALUES ('1093', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960217', '1');
INSERT INTO `station_status` VALUES ('1094', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960221', '1');
INSERT INTO `station_status` VALUES ('1095', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960226', '1');
INSERT INTO `station_status` VALUES ('1096', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960230', '1');
INSERT INTO `station_status` VALUES ('1097', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960237', '1');
INSERT INTO `station_status` VALUES ('1098', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960241', '1');
INSERT INTO `station_status` VALUES ('1099', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960246', '1');
INSERT INTO `station_status` VALUES ('1100', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960251', '1');
INSERT INTO `station_status` VALUES ('1101', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960256', '1');
INSERT INTO `station_status` VALUES ('1102', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960261', '1');
INSERT INTO `station_status` VALUES ('1103', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960266', '1');
INSERT INTO `station_status` VALUES ('1104', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960271', '1');
INSERT INTO `station_status` VALUES ('1105', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960277', '1');
INSERT INTO `station_status` VALUES ('1106', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960281', '1');
INSERT INTO `station_status` VALUES ('1107', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960287', '1');
INSERT INTO `station_status` VALUES ('1108', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960291', '1');
INSERT INTO `station_status` VALUES ('1109', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960297', '1');
INSERT INTO `station_status` VALUES ('1110', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960301', '1');
INSERT INTO `station_status` VALUES ('1111', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960306', '1');
INSERT INTO `station_status` VALUES ('1112', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960311', '1');
INSERT INTO `station_status` VALUES ('1113', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960316', '1');
INSERT INTO `station_status` VALUES ('1114', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960322', '1');
INSERT INTO `station_status` VALUES ('1115', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960327', '1');
INSERT INTO `station_status` VALUES ('1116', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960332', '1');
INSERT INTO `station_status` VALUES ('1117', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960336', '1');
INSERT INTO `station_status` VALUES ('1118', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960341', '1');
INSERT INTO `station_status` VALUES ('1119', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960346', '1');
INSERT INTO `station_status` VALUES ('1120', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960351', '1');
INSERT INTO `station_status` VALUES ('1121', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960357', '1');
INSERT INTO `station_status` VALUES ('1122', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960361', '1');
INSERT INTO `station_status` VALUES ('1123', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960367', '1');
INSERT INTO `station_status` VALUES ('1124', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960371', '1');
INSERT INTO `station_status` VALUES ('1125', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960376', '1');
INSERT INTO `station_status` VALUES ('1126', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960381', '1');
INSERT INTO `station_status` VALUES ('1127', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960386', '1');
INSERT INTO `station_status` VALUES ('1128', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960391', '1');
INSERT INTO `station_status` VALUES ('1129', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960401', '1');
INSERT INTO `station_status` VALUES ('1130', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960411', '1');
INSERT INTO `station_status` VALUES ('1131', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960421', '1');
INSERT INTO `station_status` VALUES ('1132', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960431', '1');
INSERT INTO `station_status` VALUES ('1133', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960441', '1');
INSERT INTO `station_status` VALUES ('1134', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960451', '1');
INSERT INTO `station_status` VALUES ('1135', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960461', '1');
INSERT INTO `station_status` VALUES ('1136', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960472', '1');
INSERT INTO `station_status` VALUES ('1137', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960482', '1');
INSERT INTO `station_status` VALUES ('1138', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960491', '1');
INSERT INTO `station_status` VALUES ('1139', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960501', '1');
INSERT INTO `station_status` VALUES ('1140', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960511', '1');
INSERT INTO `station_status` VALUES ('1141', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960521', '1');
INSERT INTO `station_status` VALUES ('1142', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960531', '1');
INSERT INTO `station_status` VALUES ('1143', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960541', '1');
INSERT INTO `station_status` VALUES ('1144', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960551', '1');
INSERT INTO `station_status` VALUES ('1145', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960555', '1');
INSERT INTO `station_status` VALUES ('1146', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960562', '1');
INSERT INTO `station_status` VALUES ('1147', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960565', '1');
INSERT INTO `station_status` VALUES ('1148', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960571', '1');
INSERT INTO `station_status` VALUES ('1149', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960575', '1');
INSERT INTO `station_status` VALUES ('1150', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960581', '1');
INSERT INTO `station_status` VALUES ('1151', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960586', '1');
INSERT INTO `station_status` VALUES ('1152', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960591', '1');
INSERT INTO `station_status` VALUES ('1153', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960596', '1');
INSERT INTO `station_status` VALUES ('1154', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960601', '1');
INSERT INTO `station_status` VALUES ('1155', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960605', '1');
INSERT INTO `station_status` VALUES ('1156', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960611', '1');
INSERT INTO `station_status` VALUES ('1157', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960615', '1');
INSERT INTO `station_status` VALUES ('1158', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960622', '1');
INSERT INTO `station_status` VALUES ('1159', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960625', '1');
INSERT INTO `station_status` VALUES ('1160', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960632', '1');
INSERT INTO `station_status` VALUES ('1161', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960641', '1');
INSERT INTO `station_status` VALUES ('1162', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960643', '1');
INSERT INTO `station_status` VALUES ('1163', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960651', '1');
INSERT INTO `station_status` VALUES ('1164', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960662', '1');
INSERT INTO `station_status` VALUES ('1165', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960672', '1');
INSERT INTO `station_status` VALUES ('1166', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960681', '1');
INSERT INTO `station_status` VALUES ('1167', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960691', '1');
INSERT INTO `station_status` VALUES ('1168', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960701', '1');
INSERT INTO `station_status` VALUES ('1169', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960711', '1');
INSERT INTO `station_status` VALUES ('1170', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960722', '1');
INSERT INTO `station_status` VALUES ('1171', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960732', '1');
INSERT INTO `station_status` VALUES ('1172', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960734', '1');
INSERT INTO `station_status` VALUES ('1173', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960741', '1');
INSERT INTO `station_status` VALUES ('1174', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960751', '1');
INSERT INTO `station_status` VALUES ('1175', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960761', '1');
INSERT INTO `station_status` VALUES ('1176', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960772', '1');
INSERT INTO `station_status` VALUES ('1177', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960782', '1');
INSERT INTO `station_status` VALUES ('1178', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960791', '1');
INSERT INTO `station_status` VALUES ('1179', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960794', '1');
INSERT INTO `station_status` VALUES ('1180', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960801', '1');
INSERT INTO `station_status` VALUES ('1181', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960811', '1');
INSERT INTO `station_status` VALUES ('1182', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960822', '1');
INSERT INTO `station_status` VALUES ('1183', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960832', '1');
INSERT INTO `station_status` VALUES ('1184', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960841', '1');
INSERT INTO `station_status` VALUES ('1185', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960844', '1');
INSERT INTO `station_status` VALUES ('1186', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960851', '1');
INSERT INTO `station_status` VALUES ('1187', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960862', '1');
INSERT INTO `station_status` VALUES ('1188', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960872', '1');
INSERT INTO `station_status` VALUES ('1189', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960882', '1');
INSERT INTO `station_status` VALUES ('1190', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960892', '1');
INSERT INTO `station_status` VALUES ('1191', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960895', '1');
INSERT INTO `station_status` VALUES ('1192', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960902', '1');
INSERT INTO `station_status` VALUES ('1193', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960911', '1');
INSERT INTO `station_status` VALUES ('1194', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960922', '1');
INSERT INTO `station_status` VALUES ('1195', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960932', '1');
INSERT INTO `station_status` VALUES ('1196', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960943', '1');
INSERT INTO `station_status` VALUES ('1197', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960946', '1');
INSERT INTO `station_status` VALUES ('1198', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960951', '1');
INSERT INTO `station_status` VALUES ('1199', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960961', '1');
INSERT INTO `station_status` VALUES ('1200', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960972', '1');
INSERT INTO `station_status` VALUES ('1201', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960982', '1');
INSERT INTO `station_status` VALUES ('1202', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430960991', '1');
INSERT INTO `station_status` VALUES ('1203', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961002', '1');
INSERT INTO `station_status` VALUES ('1204', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961012', '1');
INSERT INTO `station_status` VALUES ('1205', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961022', '1');
INSERT INTO `station_status` VALUES ('1206', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961032', '1');
INSERT INTO `station_status` VALUES ('1207', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961038', '1');
INSERT INTO `station_status` VALUES ('1208', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961042', '1');
INSERT INTO `station_status` VALUES ('1209', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961052', '1');
INSERT INTO `station_status` VALUES ('1210', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961062', '1');
INSERT INTO `station_status` VALUES ('1211', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961072', '1');
INSERT INTO `station_status` VALUES ('1212', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961083', '1');
INSERT INTO `station_status` VALUES ('1213', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961088', '1');
INSERT INTO `station_status` VALUES ('1214', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961092', '1');
INSERT INTO `station_status` VALUES ('1215', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961102', '1');
INSERT INTO `station_status` VALUES ('1216', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961112', '1');
INSERT INTO `station_status` VALUES ('1217', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961122', '1');
INSERT INTO `station_status` VALUES ('1218', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961132', '1');
INSERT INTO `station_status` VALUES ('1219', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961139', '1');
INSERT INTO `station_status` VALUES ('1220', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961142', '1');
INSERT INTO `station_status` VALUES ('1221', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961152', '1');
INSERT INTO `station_status` VALUES ('1222', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961162', '1');
INSERT INTO `station_status` VALUES ('1223', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961172', '1');
INSERT INTO `station_status` VALUES ('1224', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961183', '1');
INSERT INTO `station_status` VALUES ('1225', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961190', '1');
INSERT INTO `station_status` VALUES ('1226', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961192', '1');
INSERT INTO `station_status` VALUES ('1227', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961202', '1');
INSERT INTO `station_status` VALUES ('1228', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961213', '1');
INSERT INTO `station_status` VALUES ('1229', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961222', '1');
INSERT INTO `station_status` VALUES ('1230', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961232', '1');
INSERT INTO `station_status` VALUES ('1231', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961242', '1');
INSERT INTO `station_status` VALUES ('1232', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961252', '1');
INSERT INTO `station_status` VALUES ('1233', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961262', '1');
INSERT INTO `station_status` VALUES ('1234', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961273', '1');
INSERT INTO `station_status` VALUES ('1235', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961281', '1');
INSERT INTO `station_status` VALUES ('1236', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961283', '1');
INSERT INTO `station_status` VALUES ('1237', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961292', '1');
INSERT INTO `station_status` VALUES ('1238', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961302', '1');
INSERT INTO `station_status` VALUES ('1239', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961313', '1');
INSERT INTO `station_status` VALUES ('1240', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961322', '1');
INSERT INTO `station_status` VALUES ('1241', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961333', '1');
INSERT INTO `station_status` VALUES ('1242', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961334', '1');
INSERT INTO `station_status` VALUES ('1243', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961342', '1');
INSERT INTO `station_status` VALUES ('1244', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961352', '1');
INSERT INTO `station_status` VALUES ('1245', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961362', '1');
INSERT INTO `station_status` VALUES ('1246', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961372', '1');
INSERT INTO `station_status` VALUES ('1247', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961383', '1');
INSERT INTO `station_status` VALUES ('1248', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961385', '1');
INSERT INTO `station_status` VALUES ('1249', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961393', '1');
INSERT INTO `station_status` VALUES ('1250', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961402', '1');
INSERT INTO `station_status` VALUES ('1251', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961412', '1');
INSERT INTO `station_status` VALUES ('1252', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961423', '1');
INSERT INTO `station_status` VALUES ('1253', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961433', '1');
INSERT INTO `station_status` VALUES ('1254', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961436', '1');
INSERT INTO `station_status` VALUES ('1255', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961442', '1');
INSERT INTO `station_status` VALUES ('1256', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961452', '1');
INSERT INTO `station_status` VALUES ('1257', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961463', '1');
INSERT INTO `station_status` VALUES ('1258', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961473', '1');
INSERT INTO `station_status` VALUES ('1259', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961483', '1');
INSERT INTO `station_status` VALUES ('1260', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961486', '1');
INSERT INTO `station_status` VALUES ('1261', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961492', '1');
INSERT INTO `station_status` VALUES ('1262', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961502', '1');
INSERT INTO `station_status` VALUES ('1263', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961513', '1');
INSERT INTO `station_status` VALUES ('1264', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961523', '1');
INSERT INTO `station_status` VALUES ('1265', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961532', '1');
INSERT INTO `station_status` VALUES ('1266', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961542', '1');
INSERT INTO `station_status` VALUES ('1267', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961553', '1');
INSERT INTO `station_status` VALUES ('1268', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961563', '1');
INSERT INTO `station_status` VALUES ('1269', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961572', '1');
INSERT INTO `station_status` VALUES ('1270', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961578', '1');
INSERT INTO `station_status` VALUES ('1271', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961583', '1');
INSERT INTO `station_status` VALUES ('1272', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961593', '1');
INSERT INTO `station_status` VALUES ('1273', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961602', '1');
INSERT INTO `station_status` VALUES ('1274', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961613', '1');
INSERT INTO `station_status` VALUES ('1275', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961623', '1');
INSERT INTO `station_status` VALUES ('1276', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961628', '1');
INSERT INTO `station_status` VALUES ('1277', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961632', '1');
INSERT INTO `station_status` VALUES ('1278', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961642', '1');
INSERT INTO `station_status` VALUES ('1279', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961653', '1');
INSERT INTO `station_status` VALUES ('1280', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961663', '1');
INSERT INTO `station_status` VALUES ('1281', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961672', '1');
INSERT INTO `station_status` VALUES ('1282', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961679', '1');
INSERT INTO `station_status` VALUES ('1283', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961683', '1');
INSERT INTO `station_status` VALUES ('1284', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961693', '1');
INSERT INTO `station_status` VALUES ('1285', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961703', '1');
INSERT INTO `station_status` VALUES ('1286', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961713', '1');
INSERT INTO `station_status` VALUES ('1287', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961723', '1');
INSERT INTO `station_status` VALUES ('1288', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961730', '1');
INSERT INTO `station_status` VALUES ('1289', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961733', '1');
INSERT INTO `station_status` VALUES ('1290', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961743', '1');
INSERT INTO `station_status` VALUES ('1291', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961753', '1');
INSERT INTO `station_status` VALUES ('1292', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961763', '1');
INSERT INTO `station_status` VALUES ('1293', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961773', '1');
INSERT INTO `station_status` VALUES ('1294', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961783', '1');
INSERT INTO `station_status` VALUES ('1295', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961784', '1');
INSERT INTO `station_status` VALUES ('1296', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961793', '1');
INSERT INTO `station_status` VALUES ('1297', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961803', '1');
INSERT INTO `station_status` VALUES ('1298', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961813', '1');
INSERT INTO `station_status` VALUES ('1299', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961823', '1');
INSERT INTO `station_status` VALUES ('1300', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961833', '1');
INSERT INTO `station_status` VALUES ('1301', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961843', '1');
INSERT INTO `station_status` VALUES ('1302', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961853', '1');
INSERT INTO `station_status` VALUES ('1303', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961863', '1');
INSERT INTO `station_status` VALUES ('1304', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961874', '1');
INSERT INTO `station_status` VALUES ('1305', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961876', '1');
INSERT INTO `station_status` VALUES ('1306', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961883', '1');
INSERT INTO `station_status` VALUES ('1307', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961893', '1');
INSERT INTO `station_status` VALUES ('1308', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961903', '1');
INSERT INTO `station_status` VALUES ('1309', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961913', '1');
INSERT INTO `station_status` VALUES ('1310', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961924', '1');
INSERT INTO `station_status` VALUES ('1311', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961927', '1');
INSERT INTO `station_status` VALUES ('1312', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961933', '1');
INSERT INTO `station_status` VALUES ('1313', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961943', '1');
INSERT INTO `station_status` VALUES ('1314', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961953', '1');
INSERT INTO `station_status` VALUES ('1315', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961963', '1');
INSERT INTO `station_status` VALUES ('1316', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961974', '1');
INSERT INTO `station_status` VALUES ('1317', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961977', '1');
INSERT INTO `station_status` VALUES ('1318', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961983', '1');
INSERT INTO `station_status` VALUES ('1319', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430961993', '1');
INSERT INTO `station_status` VALUES ('1320', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962004', '1');
INSERT INTO `station_status` VALUES ('1321', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962014', '1');
INSERT INTO `station_status` VALUES ('1322', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962023', '1');
INSERT INTO `station_status` VALUES ('1323', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962028', '1');
INSERT INTO `station_status` VALUES ('1324', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962033', '1');
INSERT INTO `station_status` VALUES ('1325', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962043', '1');
INSERT INTO `station_status` VALUES ('1326', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962053', '1');
INSERT INTO `station_status` VALUES ('1327', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962064', '1');
INSERT INTO `station_status` VALUES ('1328', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962074', '1');
INSERT INTO `station_status` VALUES ('1329', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962083', '1');
INSERT INTO `station_status` VALUES ('1330', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962093', '1');
INSERT INTO `station_status` VALUES ('1331', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962104', '1');
INSERT INTO `station_status` VALUES ('1332', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962114', '1');
INSERT INTO `station_status` VALUES ('1333', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962120', '1');
INSERT INTO `station_status` VALUES ('1334', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962123', '1');
INSERT INTO `station_status` VALUES ('1335', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962133', '1');
INSERT INTO `station_status` VALUES ('1336', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962144', '1');
INSERT INTO `station_status` VALUES ('1337', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962154', '1');
INSERT INTO `station_status` VALUES ('1338', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962164', '1');
INSERT INTO `station_status` VALUES ('1339', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962171', '1');
INSERT INTO `station_status` VALUES ('1340', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962174', '1');
INSERT INTO `station_status` VALUES ('1341', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962183', '1');
INSERT INTO `station_status` VALUES ('1342', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962194', '1');
INSERT INTO `station_status` VALUES ('1343', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962204', '1');
INSERT INTO `station_status` VALUES ('1344', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962213', '1');
INSERT INTO `station_status` VALUES ('1345', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962221', '1');
INSERT INTO `station_status` VALUES ('1346', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962223', '1');
INSERT INTO `station_status` VALUES ('1347', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962234', '1');
INSERT INTO `station_status` VALUES ('1348', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962244', '1');
INSERT INTO `station_status` VALUES ('1349', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962254', '1');
INSERT INTO `station_status` VALUES ('1350', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962260', '1');
INSERT INTO `station_status` VALUES ('1351', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962264', '1');
INSERT INTO `station_status` VALUES ('1352', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962273', '1');
INSERT INTO `station_status` VALUES ('1353', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962284', '1');
INSERT INTO `station_status` VALUES ('1354', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962294', '1');
INSERT INTO `station_status` VALUES ('1355', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962304', '1');
INSERT INTO `station_status` VALUES ('1356', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962314', '1');
INSERT INTO `station_status` VALUES ('1357', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962324', '1');
INSERT INTO `station_status` VALUES ('1358', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962334', '1');
INSERT INTO `station_status` VALUES ('1359', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962344', '1');
INSERT INTO `station_status` VALUES ('1360', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962354', '1');
INSERT INTO `station_status` VALUES ('1361', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962364', '1');
INSERT INTO `station_status` VALUES ('1362', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962374', '1');
INSERT INTO `station_status` VALUES ('1363', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962384', '1');
INSERT INTO `station_status` VALUES ('1364', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962390', '1');
INSERT INTO `station_status` VALUES ('1365', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962394', '1');
INSERT INTO `station_status` VALUES ('1366', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962404', '1');
INSERT INTO `station_status` VALUES ('1367', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962414', '1');
INSERT INTO `station_status` VALUES ('1368', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962425', '1');
INSERT INTO `station_status` VALUES ('1369', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962434', '1');
INSERT INTO `station_status` VALUES ('1370', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962444', '1');
INSERT INTO `station_status` VALUES ('1371', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962454', '1');
INSERT INTO `station_status` VALUES ('1372', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962464', '1');
INSERT INTO `station_status` VALUES ('1373', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962474', '1');
INSERT INTO `station_status` VALUES ('1374', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962480', '1');
INSERT INTO `station_status` VALUES ('1375', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962484', '1');
INSERT INTO `station_status` VALUES ('1376', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962494', '1');
INSERT INTO `station_status` VALUES ('1377', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962504', '1');
INSERT INTO `station_status` VALUES ('1378', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962514', '1');
INSERT INTO `station_status` VALUES ('1379', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962524', '1');
INSERT INTO `station_status` VALUES ('1380', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962534', '1');
INSERT INTO `station_status` VALUES ('1381', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962544', '1');
INSERT INTO `station_status` VALUES ('1382', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962554', '1');
INSERT INTO `station_status` VALUES ('1383', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962564', '1');
INSERT INTO `station_status` VALUES ('1384', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962574', '1');
INSERT INTO `station_status` VALUES ('1385', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962584', '1');
INSERT INTO `station_status` VALUES ('1386', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962594', '1');
INSERT INTO `station_status` VALUES ('1387', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962605', '1');
INSERT INTO `station_status` VALUES ('1388', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962614', '1');
INSERT INTO `station_status` VALUES ('1389', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962624', '1');
INSERT INTO `station_status` VALUES ('1390', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962634', '1');
INSERT INTO `station_status` VALUES ('1391', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962645', '1');
INSERT INTO `station_status` VALUES ('1392', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962655', '1');
INSERT INTO `station_status` VALUES ('1393', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962664', '1');
INSERT INTO `station_status` VALUES ('1394', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962674', '1');
INSERT INTO `station_status` VALUES ('1395', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962684', '1');
INSERT INTO `station_status` VALUES ('1396', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962695', '1');
INSERT INTO `station_status` VALUES ('1397', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962705', '1');
INSERT INTO `station_status` VALUES ('1398', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962714', '1');
INSERT INTO `station_status` VALUES ('1399', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962724', '1');
INSERT INTO `station_status` VALUES ('1400', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962735', '1');
INSERT INTO `station_status` VALUES ('1401', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962745', '1');
INSERT INTO `station_status` VALUES ('1402', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962754', '1');
INSERT INTO `station_status` VALUES ('1403', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962764', '1');
INSERT INTO `station_status` VALUES ('1404', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962769', '1');
INSERT INTO `station_status` VALUES ('1405', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962775', '1');
INSERT INTO `station_status` VALUES ('1406', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962784', '1');
INSERT INTO `station_status` VALUES ('1407', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962795', '1');
INSERT INTO `station_status` VALUES ('1408', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962806', '1');
INSERT INTO `station_status` VALUES ('1409', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962814', '1');
INSERT INTO `station_status` VALUES ('1410', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962824', '1');
INSERT INTO `station_status` VALUES ('1411', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962835', '1');
INSERT INTO `station_status` VALUES ('1412', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962845', '1');
INSERT INTO `station_status` VALUES ('1413', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962855', '1');
INSERT INTO `station_status` VALUES ('1414', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962864', '1');
INSERT INTO `station_status` VALUES ('1415', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962875', '1');
INSERT INTO `station_status` VALUES ('1416', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962882', '1');
INSERT INTO `station_status` VALUES ('1417', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962885', '1');
INSERT INTO `station_status` VALUES ('1418', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962895', '1');
INSERT INTO `station_status` VALUES ('1419', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962905', '1');
INSERT INTO `station_status` VALUES ('1420', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962915', '1');
INSERT INTO `station_status` VALUES ('1421', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962925', '1');
INSERT INTO `station_status` VALUES ('1422', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962934', '1');
INSERT INTO `station_status` VALUES ('1423', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962945', '1');
INSERT INTO `station_status` VALUES ('1424', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962955', '1');
INSERT INTO `station_status` VALUES ('1425', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962963', '1');
INSERT INTO `station_status` VALUES ('1426', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962965', '1');
INSERT INTO `station_status` VALUES ('1427', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962975', '1');
INSERT INTO `station_status` VALUES ('1428', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962985', '1');
INSERT INTO `station_status` VALUES ('1429', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430962994', '1');
INSERT INTO `station_status` VALUES ('1430', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963005', '1');
INSERT INTO `station_status` VALUES ('1431', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963015', '1');
INSERT INTO `station_status` VALUES ('1432', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963025', '1');
INSERT INTO `station_status` VALUES ('1433', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963035', '1');
INSERT INTO `station_status` VALUES ('1434', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963045', '1');
INSERT INTO `station_status` VALUES ('1435', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963055', '1');
INSERT INTO `station_status` VALUES ('1436', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963065', '1');
INSERT INTO `station_status` VALUES ('1437', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963075', '1');
INSERT INTO `station_status` VALUES ('1438', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963085', '1');
INSERT INTO `station_status` VALUES ('1439', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963095', '1');
INSERT INTO `station_status` VALUES ('1440', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963105', '1');
INSERT INTO `station_status` VALUES ('1441', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963115', '1');
INSERT INTO `station_status` VALUES ('1442', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963125', '1');
INSERT INTO `station_status` VALUES ('1443', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963135', '1');
INSERT INTO `station_status` VALUES ('1444', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963145', '1');
INSERT INTO `station_status` VALUES ('1445', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963155', '1');
INSERT INTO `station_status` VALUES ('1446', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963165', '1');
INSERT INTO `station_status` VALUES ('1447', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963175', '1');
INSERT INTO `station_status` VALUES ('1448', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963185', '1');
INSERT INTO `station_status` VALUES ('1449', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963195', '1');
INSERT INTO `station_status` VALUES ('1450', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963205', '1');
INSERT INTO `station_status` VALUES ('1451', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963215', '1');
INSERT INTO `station_status` VALUES ('1452', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963225', '1');
INSERT INTO `station_status` VALUES ('1453', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963235', '1');
INSERT INTO `station_status` VALUES ('1454', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963239', '1');
INSERT INTO `station_status` VALUES ('1455', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963245', '1');
INSERT INTO `station_status` VALUES ('1456', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963255', '1');
INSERT INTO `station_status` VALUES ('1457', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963265', '1');
INSERT INTO `station_status` VALUES ('1458', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963276', '1');
INSERT INTO `station_status` VALUES ('1459', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963285', '1');
INSERT INTO `station_status` VALUES ('1460', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963295', '1');
INSERT INTO `station_status` VALUES ('1461', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963305', '1');
INSERT INTO `station_status` VALUES ('1462', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963315', '1');
INSERT INTO `station_status` VALUES ('1463', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963325', '1');
INSERT INTO `station_status` VALUES ('1464', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963335', '1');
INSERT INTO `station_status` VALUES ('1465', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963345', '1');
INSERT INTO `station_status` VALUES ('1466', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963355', '1');
INSERT INTO `station_status` VALUES ('1467', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963363', '1');
INSERT INTO `station_status` VALUES ('1468', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963365', '1');
INSERT INTO `station_status` VALUES ('1469', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963375', '1');
INSERT INTO `station_status` VALUES ('1470', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963386', '1');
INSERT INTO `station_status` VALUES ('1471', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963396', '1');
INSERT INTO `station_status` VALUES ('1472', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963405', '1');
INSERT INTO `station_status` VALUES ('1473', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963415', '1');
INSERT INTO `station_status` VALUES ('1474', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963426', '1');
INSERT INTO `station_status` VALUES ('1475', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963436', '1');
INSERT INTO `station_status` VALUES ('1476', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963446', '1');
INSERT INTO `station_status` VALUES ('1477', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963455', '1');
INSERT INTO `station_status` VALUES ('1478', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963465', '1');
INSERT INTO `station_status` VALUES ('1479', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963476', '1');
INSERT INTO `station_status` VALUES ('1480', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963486', '1');
INSERT INTO `station_status` VALUES ('1481', '13', '533db2&ECAPRO&status&ERROR&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963495', '1');
INSERT INTO `station_status` VALUES ('1482', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963547', '1');
INSERT INTO `station_status` VALUES ('1483', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963840', '1');
INSERT INTO `station_status` VALUES ('1484', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430963950', '1');
INSERT INTO `station_status` VALUES ('1485', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964001', '1');
INSERT INTO `station_status` VALUES ('1486', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964052', '1');
INSERT INTO `station_status` VALUES ('1487', '13', '533db2&ECAPRO&status&ARMING&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964103', '1');
INSERT INTO `station_status` VALUES ('1488', '13', '533db2&ECAPRO&status&ARMING&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964154', '1');
INSERT INTO `station_status` VALUES ('1489', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964204', '1');
INSERT INTO `station_status` VALUES ('1490', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964255', '1');
INSERT INTO `station_status` VALUES ('1491', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964305', '1');
INSERT INTO `station_status` VALUES ('1492', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964356', '1');
INSERT INTO `station_status` VALUES ('1493', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964407', '1');
INSERT INTO `station_status` VALUES ('1494', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964457', '1');
INSERT INTO `station_status` VALUES ('1495', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964509', '1');
INSERT INTO `station_status` VALUES ('1496', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964599', '1');
INSERT INTO `station_status` VALUES ('1497', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964650', '1');
INSERT INTO `station_status` VALUES ('1498', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964703', '1');
INSERT INTO `station_status` VALUES ('1499', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964754', '1');
INSERT INTO `station_status` VALUES ('1500', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964858', '1');
INSERT INTO `station_status` VALUES ('1501', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964909', '1');
INSERT INTO `station_status` VALUES ('1502', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430964960', '1');
INSERT INTO `station_status` VALUES ('1503', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965157', '1');
INSERT INTO `station_status` VALUES ('1504', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965208', '1');
INSERT INTO `station_status` VALUES ('1505', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965259', '1');
INSERT INTO `station_status` VALUES ('1506', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965310', '1');
INSERT INTO `station_status` VALUES ('1507', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965360', '1');
INSERT INTO `station_status` VALUES ('1508', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965411', '1');
INSERT INTO `station_status` VALUES ('1509', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965503', '1');
INSERT INTO `station_status` VALUES ('1510', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965553', '1');
INSERT INTO `station_status` VALUES ('1511', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965604', '1');
INSERT INTO `station_status` VALUES ('1512', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965655', '1');
INSERT INTO `station_status` VALUES ('1513', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965747', '1');
INSERT INTO `station_status` VALUES ('1514', '13', '533db2&ECAPRO&status&DISARM&8&34&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965797', '1');
INSERT INTO `station_status` VALUES ('1515', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965855', '1');
INSERT INTO `station_status` VALUES ('1516', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430965905', '1');
INSERT INTO `station_status` VALUES ('1517', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966212', '1');
INSERT INTO `station_status` VALUES ('1518', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966263', '1');
INSERT INTO `station_status` VALUES ('1519', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966314', '1');
INSERT INTO `station_status` VALUES ('1520', '13', '533db2&ECAPRO&status&DISARM&8&50&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966405', '1');
INSERT INTO `station_status` VALUES ('1521', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966448', '1');
INSERT INTO `station_status` VALUES ('1522', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966729', '1');
INSERT INTO `station_status` VALUES ('1523', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966820', '1');
INSERT INTO `station_status` VALUES ('1524', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966871', '1');
INSERT INTO `station_status` VALUES ('1525', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966922', '1');
INSERT INTO `station_status` VALUES ('1526', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430966972', '1');
INSERT INTO `station_status` VALUES ('1527', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967064', '1');
INSERT INTO `station_status` VALUES ('1528', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967114', '1');
INSERT INTO `station_status` VALUES ('1529', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967165', '1');
INSERT INTO `station_status` VALUES ('1530', '13', '533db2&ECAPRO&status&ARMING&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967216', '1');
INSERT INTO `station_status` VALUES ('1531', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967257', '1');
INSERT INTO `station_status` VALUES ('1532', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967267', '1');
INSERT INTO `station_status` VALUES ('1533', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967277', '1');
INSERT INTO `station_status` VALUES ('1534', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967287', '1');
INSERT INTO `station_status` VALUES ('1535', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967297', '1');
INSERT INTO `station_status` VALUES ('1536', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967307', '1');
INSERT INTO `station_status` VALUES ('1537', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967317', '1');
INSERT INTO `station_status` VALUES ('1538', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967327', '1');
INSERT INTO `station_status` VALUES ('1539', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967337', '1');
INSERT INTO `station_status` VALUES ('1540', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967347', '1');
INSERT INTO `station_status` VALUES ('1541', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967358', '1');
INSERT INTO `station_status` VALUES ('1542', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967367', '1');
INSERT INTO `station_status` VALUES ('1543', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967377', '1');
INSERT INTO `station_status` VALUES ('1544', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967387', '1');
INSERT INTO `station_status` VALUES ('1545', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967423', '1');
INSERT INTO `station_status` VALUES ('1546', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967434', '1');
INSERT INTO `station_status` VALUES ('1547', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967444', '1');
INSERT INTO `station_status` VALUES ('1548', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967453', '1');
INSERT INTO `station_status` VALUES ('1549', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967463', '1');
INSERT INTO `station_status` VALUES ('1550', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967474', '1');
INSERT INTO `station_status` VALUES ('1551', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967484', '1');
INSERT INTO `station_status` VALUES ('1552', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967493', '1');
INSERT INTO `station_status` VALUES ('1553', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967504', '1');
INSERT INTO `station_status` VALUES ('1554', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967514', '1');
INSERT INTO `station_status` VALUES ('1555', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967524', '1');
INSERT INTO `station_status` VALUES ('1556', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967534', '1');
INSERT INTO `station_status` VALUES ('1557', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967544', '1');
INSERT INTO `station_status` VALUES ('1558', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967554', '1');
INSERT INTO `station_status` VALUES ('1559', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967564', '1');
INSERT INTO `station_status` VALUES ('1560', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967574', '1');
INSERT INTO `station_status` VALUES ('1561', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967584', '1');
INSERT INTO `station_status` VALUES ('1562', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967594', '1');
INSERT INTO `station_status` VALUES ('1563', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967604', '1');
INSERT INTO `station_status` VALUES ('1564', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967614', '1');
INSERT INTO `station_status` VALUES ('1565', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967624', '1');
INSERT INTO `station_status` VALUES ('1566', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967634', '1');
INSERT INTO `station_status` VALUES ('1567', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967644', '1');
INSERT INTO `station_status` VALUES ('1568', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967654', '1');
INSERT INTO `station_status` VALUES ('1569', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967664', '1');
INSERT INTO `station_status` VALUES ('1570', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967674', '1');
INSERT INTO `station_status` VALUES ('1571', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967684', '1');
INSERT INTO `station_status` VALUES ('1572', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967694', '1');
INSERT INTO `station_status` VALUES ('1573', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967704', '1');
INSERT INTO `station_status` VALUES ('1574', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967714', '1');
INSERT INTO `station_status` VALUES ('1575', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967724', '1');
INSERT INTO `station_status` VALUES ('1576', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967734', '1');
INSERT INTO `station_status` VALUES ('1577', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967744', '1');
INSERT INTO `station_status` VALUES ('1578', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967754', '1');
INSERT INTO `station_status` VALUES ('1579', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967765', '1');
INSERT INTO `station_status` VALUES ('1580', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967775', '1');
INSERT INTO `station_status` VALUES ('1581', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967784', '1');
INSERT INTO `station_status` VALUES ('1582', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967794', '1');
INSERT INTO `station_status` VALUES ('1583', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967805', '1');
INSERT INTO `station_status` VALUES ('1584', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967815', '1');
INSERT INTO `station_status` VALUES ('1585', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967824', '1');
INSERT INTO `station_status` VALUES ('1586', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967835', '1');
INSERT INTO `station_status` VALUES ('1587', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967845', '1');
INSERT INTO `station_status` VALUES ('1588', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967854', '1');
INSERT INTO `station_status` VALUES ('1589', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967864', '1');
INSERT INTO `station_status` VALUES ('1590', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967874', '1');
INSERT INTO `station_status` VALUES ('1591', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967885', '1');
INSERT INTO `station_status` VALUES ('1592', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967895', '1');
INSERT INTO `station_status` VALUES ('1593', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967905', '1');
INSERT INTO `station_status` VALUES ('1594', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967914', '1');
INSERT INTO `station_status` VALUES ('1595', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967925', '1');
INSERT INTO `station_status` VALUES ('1596', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967935', '1');
INSERT INTO `station_status` VALUES ('1597', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967944', '1');
INSERT INTO `station_status` VALUES ('1598', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967954', '1');
INSERT INTO `station_status` VALUES ('1599', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967964', '1');
INSERT INTO `station_status` VALUES ('1600', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967975', '1');
INSERT INTO `station_status` VALUES ('1601', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967985', '1');
INSERT INTO `station_status` VALUES ('1602', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430967995', '1');
INSERT INTO `station_status` VALUES ('1603', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968005', '1');
INSERT INTO `station_status` VALUES ('1604', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968015', '1');
INSERT INTO `station_status` VALUES ('1605', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968025', '1');
INSERT INTO `station_status` VALUES ('1606', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968035', '1');
INSERT INTO `station_status` VALUES ('1607', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968096', '1');
INSERT INTO `station_status` VALUES ('1608', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968106', '1');
INSERT INTO `station_status` VALUES ('1609', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968116', '1');
INSERT INTO `station_status` VALUES ('1610', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968126', '1');
INSERT INTO `station_status` VALUES ('1611', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968136', '1');
INSERT INTO `station_status` VALUES ('1612', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968146', '1');
INSERT INTO `station_status` VALUES ('1613', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968156', '1');
INSERT INTO `station_status` VALUES ('1614', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968166', '1');
INSERT INTO `station_status` VALUES ('1615', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968176', '1');
INSERT INTO `station_status` VALUES ('1616', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968186', '1');
INSERT INTO `station_status` VALUES ('1617', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968197', '1');
INSERT INTO `station_status` VALUES ('1618', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968206', '1');
INSERT INTO `station_status` VALUES ('1619', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968216', '1');
INSERT INTO `station_status` VALUES ('1620', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968226', '1');
INSERT INTO `station_status` VALUES ('1621', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968236', '1');
INSERT INTO `station_status` VALUES ('1622', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968246', '1');
INSERT INTO `station_status` VALUES ('1623', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968256', '1');
INSERT INTO `station_status` VALUES ('1624', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968266', '1');
INSERT INTO `station_status` VALUES ('1625', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968277', '1');
INSERT INTO `station_status` VALUES ('1626', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968286', '1');
INSERT INTO `station_status` VALUES ('1627', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968296', '1');
INSERT INTO `station_status` VALUES ('1628', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968306', '1');
INSERT INTO `station_status` VALUES ('1629', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968316', '1');
INSERT INTO `station_status` VALUES ('1630', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968327', '1');
INSERT INTO `station_status` VALUES ('1631', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968336', '1');
INSERT INTO `station_status` VALUES ('1632', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968346', '1');
INSERT INTO `station_status` VALUES ('1633', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968357', '1');
INSERT INTO `station_status` VALUES ('1634', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968366', '1');
INSERT INTO `station_status` VALUES ('1635', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968376', '1');
INSERT INTO `station_status` VALUES ('1636', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968386', '1');
INSERT INTO `station_status` VALUES ('1637', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968397', '1');
INSERT INTO `station_status` VALUES ('1638', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968407', '1');
INSERT INTO `station_status` VALUES ('1639', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968416', '1');
INSERT INTO `station_status` VALUES ('1640', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968426', '1');
INSERT INTO `station_status` VALUES ('1641', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968437', '1');
INSERT INTO `station_status` VALUES ('1642', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968447', '1');
INSERT INTO `station_status` VALUES ('1643', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968456', '1');
INSERT INTO `station_status` VALUES ('1644', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968466', '1');
INSERT INTO `station_status` VALUES ('1645', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968476', '1');
INSERT INTO `station_status` VALUES ('1646', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968487', '1');
INSERT INTO `station_status` VALUES ('1647', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968497', '1');
INSERT INTO `station_status` VALUES ('1648', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968506', '1');
INSERT INTO `station_status` VALUES ('1649', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968516', '1');
INSERT INTO `station_status` VALUES ('1650', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968527', '1');
INSERT INTO `station_status` VALUES ('1651', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968537', '1');
INSERT INTO `station_status` VALUES ('1652', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968546', '1');
INSERT INTO `station_status` VALUES ('1653', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968557', '1');
INSERT INTO `station_status` VALUES ('1654', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968567', '1');
INSERT INTO `station_status` VALUES ('1655', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968577', '1');
INSERT INTO `station_status` VALUES ('1656', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968587', '1');
INSERT INTO `station_status` VALUES ('1657', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968597', '1');
INSERT INTO `station_status` VALUES ('1658', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968606', '1');
INSERT INTO `station_status` VALUES ('1659', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968617', '1');
INSERT INTO `station_status` VALUES ('1660', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968627', '1');
INSERT INTO `station_status` VALUES ('1661', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968636', '1');
INSERT INTO `station_status` VALUES ('1662', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968646', '1');
INSERT INTO `station_status` VALUES ('1663', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968657', '1');
INSERT INTO `station_status` VALUES ('1664', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968667', '1');
INSERT INTO `station_status` VALUES ('1665', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968676', '1');
INSERT INTO `station_status` VALUES ('1666', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968686', '1');
INSERT INTO `station_status` VALUES ('1667', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968697', '1');
INSERT INTO `station_status` VALUES ('1668', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968707', '1');
INSERT INTO `station_status` VALUES ('1669', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968717', '1');
INSERT INTO `station_status` VALUES ('1670', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968727', '1');
INSERT INTO `station_status` VALUES ('1671', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968737', '1');
INSERT INTO `station_status` VALUES ('1672', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968747', '1');
INSERT INTO `station_status` VALUES ('1673', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968757', '1');
INSERT INTO `station_status` VALUES ('1674', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968767', '1');
INSERT INTO `station_status` VALUES ('1675', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968777', '1');
INSERT INTO `station_status` VALUES ('1676', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968787', '1');
INSERT INTO `station_status` VALUES ('1677', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968797', '1');
INSERT INTO `station_status` VALUES ('1678', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968807', '1');
INSERT INTO `station_status` VALUES ('1679', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968817', '1');
INSERT INTO `station_status` VALUES ('1680', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968827', '1');
INSERT INTO `station_status` VALUES ('1681', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968837', '1');
INSERT INTO `station_status` VALUES ('1682', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968847', '1');
INSERT INTO `station_status` VALUES ('1683', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968857', '1');
INSERT INTO `station_status` VALUES ('1684', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968867', '1');
INSERT INTO `station_status` VALUES ('1685', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968877', '1');
INSERT INTO `station_status` VALUES ('1686', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968887', '1');
INSERT INTO `station_status` VALUES ('1687', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968897', '1');
INSERT INTO `station_status` VALUES ('1688', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968907', '1');
INSERT INTO `station_status` VALUES ('1689', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968917', '1');
INSERT INTO `station_status` VALUES ('1690', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968927', '1');
INSERT INTO `station_status` VALUES ('1691', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968937', '1');
INSERT INTO `station_status` VALUES ('1692', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968947', '1');
INSERT INTO `station_status` VALUES ('1693', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968958', '1');
INSERT INTO `station_status` VALUES ('1694', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968967', '1');
INSERT INTO `station_status` VALUES ('1695', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968977', '1');
INSERT INTO `station_status` VALUES ('1696', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968987', '1');
INSERT INTO `station_status` VALUES ('1697', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430968997', '1');
INSERT INTO `station_status` VALUES ('1698', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969008', '1');
INSERT INTO `station_status` VALUES ('1699', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969017', '1');
INSERT INTO `station_status` VALUES ('1700', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969027', '1');
INSERT INTO `station_status` VALUES ('1701', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969038', '1');
INSERT INTO `station_status` VALUES ('1702', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969047', '1');
INSERT INTO `station_status` VALUES ('1703', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969057', '1');
INSERT INTO `station_status` VALUES ('1704', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969067', '1');
INSERT INTO `station_status` VALUES ('1705', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969077', '1');
INSERT INTO `station_status` VALUES ('1706', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969088', '1');
INSERT INTO `station_status` VALUES ('1707', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969098', '1');
INSERT INTO `station_status` VALUES ('1708', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969107', '1');
INSERT INTO `station_status` VALUES ('1709', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969117', '1');
INSERT INTO `station_status` VALUES ('1710', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969128', '1');
INSERT INTO `station_status` VALUES ('1711', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969138', '1');
INSERT INTO `station_status` VALUES ('1712', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969147', '1');
INSERT INTO `station_status` VALUES ('1713', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969157', '1');
INSERT INTO `station_status` VALUES ('1714', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969167', '1');
INSERT INTO `station_status` VALUES ('1715', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969178', '1');
INSERT INTO `station_status` VALUES ('1716', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969188', '1');
INSERT INTO `station_status` VALUES ('1717', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969198', '1');
INSERT INTO `station_status` VALUES ('1718', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969207', '1');
INSERT INTO `station_status` VALUES ('1719', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969218', '1');
INSERT INTO `station_status` VALUES ('1720', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969228', '1');
INSERT INTO `station_status` VALUES ('1721', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969237', '1');
INSERT INTO `station_status` VALUES ('1722', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969247', '1');
INSERT INTO `station_status` VALUES ('1723', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969258', '1');
INSERT INTO `station_status` VALUES ('1724', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969268', '1');
INSERT INTO `station_status` VALUES ('1725', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969278', '1');
INSERT INTO `station_status` VALUES ('1726', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969288', '1');
INSERT INTO `station_status` VALUES ('1727', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969297', '1');
INSERT INTO `station_status` VALUES ('1728', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969308', '1');
INSERT INTO `station_status` VALUES ('1729', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969318', '1');
INSERT INTO `station_status` VALUES ('1730', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969327', '1');
INSERT INTO `station_status` VALUES ('1731', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969338', '1');
INSERT INTO `station_status` VALUES ('1732', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969348', '1');
INSERT INTO `station_status` VALUES ('1733', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969358', '1');
INSERT INTO `station_status` VALUES ('1734', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969368', '1');
INSERT INTO `station_status` VALUES ('1735', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969378', '1');
INSERT INTO `station_status` VALUES ('1736', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969388', '1');
INSERT INTO `station_status` VALUES ('1737', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969398', '1');
INSERT INTO `station_status` VALUES ('1738', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969408', '1');
INSERT INTO `station_status` VALUES ('1739', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969418', '1');
INSERT INTO `station_status` VALUES ('1740', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969428', '1');
INSERT INTO `station_status` VALUES ('1741', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969438', '1');
INSERT INTO `station_status` VALUES ('1742', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969448', '1');
INSERT INTO `station_status` VALUES ('1743', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969458', '1');
INSERT INTO `station_status` VALUES ('1744', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969468', '1');
INSERT INTO `station_status` VALUES ('1745', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969478', '1');
INSERT INTO `station_status` VALUES ('1746', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969488', '1');
INSERT INTO `station_status` VALUES ('1747', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969498', '1');
INSERT INTO `station_status` VALUES ('1748', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969509', '1');
INSERT INTO `station_status` VALUES ('1749', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969518', '1');
INSERT INTO `station_status` VALUES ('1750', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969528', '1');
INSERT INTO `station_status` VALUES ('1751', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969539', '1');
INSERT INTO `station_status` VALUES ('1752', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969548', '1');
INSERT INTO `station_status` VALUES ('1753', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969558', '1');
INSERT INTO `station_status` VALUES ('1754', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969568', '1');
INSERT INTO `station_status` VALUES ('1755', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969578', '1');
INSERT INTO `station_status` VALUES ('1756', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969589', '1');
INSERT INTO `station_status` VALUES ('1757', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969598', '1');
INSERT INTO `station_status` VALUES ('1758', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969608', '1');
INSERT INTO `station_status` VALUES ('1759', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969618', '1');
INSERT INTO `station_status` VALUES ('1760', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969629', '1');
INSERT INTO `station_status` VALUES ('1761', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969639', '1');
INSERT INTO `station_status` VALUES ('1762', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969648', '1');
INSERT INTO `station_status` VALUES ('1763', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969658', '1');
INSERT INTO `station_status` VALUES ('1764', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969669', '1');
INSERT INTO `station_status` VALUES ('1765', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969679', '1');
INSERT INTO `station_status` VALUES ('1766', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969688', '1');
INSERT INTO `station_status` VALUES ('1767', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969698', '1');
INSERT INTO `station_status` VALUES ('1768', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969708', '1');
INSERT INTO `station_status` VALUES ('1769', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969719', '1');
INSERT INTO `station_status` VALUES ('1770', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969729', '1');
INSERT INTO `station_status` VALUES ('1771', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969739', '1');
INSERT INTO `station_status` VALUES ('1772', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969749', '1');
INSERT INTO `station_status` VALUES ('1773', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969759', '1');
INSERT INTO `station_status` VALUES ('1774', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969769', '1');
INSERT INTO `station_status` VALUES ('1775', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969778', '1');
INSERT INTO `station_status` VALUES ('1776', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969788', '1');
INSERT INTO `station_status` VALUES ('1777', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969798', '1');
INSERT INTO `station_status` VALUES ('1778', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969809', '1');
INSERT INTO `station_status` VALUES ('1779', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969819', '1');
INSERT INTO `station_status` VALUES ('1780', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969828', '1');
INSERT INTO `station_status` VALUES ('1781', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969838', '1');
INSERT INTO `station_status` VALUES ('1782', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969849', '1');
INSERT INTO `station_status` VALUES ('1783', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969859', '1');
INSERT INTO `station_status` VALUES ('1784', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969868', '1');
INSERT INTO `station_status` VALUES ('1785', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969878', '1');
INSERT INTO `station_status` VALUES ('1786', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969889', '1');
INSERT INTO `station_status` VALUES ('1787', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969899', '1');
INSERT INTO `station_status` VALUES ('1788', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969909', '1');
INSERT INTO `station_status` VALUES ('1789', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969919', '1');
INSERT INTO `station_status` VALUES ('1790', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969929', '1');
INSERT INTO `station_status` VALUES ('1791', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969939', '1');
INSERT INTO `station_status` VALUES ('1792', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969949', '1');
INSERT INTO `station_status` VALUES ('1793', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969959', '1');
INSERT INTO `station_status` VALUES ('1794', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969969', '1');
INSERT INTO `station_status` VALUES ('1795', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969979', '1');
INSERT INTO `station_status` VALUES ('1796', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969989', '1');
INSERT INTO `station_status` VALUES ('1797', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430969999', '1');
INSERT INTO `station_status` VALUES ('1798', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970009', '1');
INSERT INTO `station_status` VALUES ('1799', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970019', '1');
INSERT INTO `station_status` VALUES ('1800', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970029', '1');
INSERT INTO `station_status` VALUES ('1801', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970039', '1');
INSERT INTO `station_status` VALUES ('1802', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970050', '1');
INSERT INTO `station_status` VALUES ('1803', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970059', '1');
INSERT INTO `station_status` VALUES ('1804', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970069', '1');
INSERT INTO `station_status` VALUES ('1805', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970079', '1');
INSERT INTO `station_status` VALUES ('1806', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970089', '1');
INSERT INTO `station_status` VALUES ('1807', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970099', '1');
INSERT INTO `station_status` VALUES ('1808', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970110', '1');
INSERT INTO `station_status` VALUES ('1809', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970119', '1');
INSERT INTO `station_status` VALUES ('1810', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970129', '1');
INSERT INTO `station_status` VALUES ('1811', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970139', '1');
INSERT INTO `station_status` VALUES ('1812', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970149', '1');
INSERT INTO `station_status` VALUES ('1813', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970159', '1');
INSERT INTO `station_status` VALUES ('1814', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970169', '1');
INSERT INTO `station_status` VALUES ('1815', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970179', '1');
INSERT INTO `station_status` VALUES ('1816', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970190', '1');
INSERT INTO `station_status` VALUES ('1817', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970200', '1');
INSERT INTO `station_status` VALUES ('1818', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970209', '1');
INSERT INTO `station_status` VALUES ('1819', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970219', '1');
INSERT INTO `station_status` VALUES ('1820', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970230', '1');
INSERT INTO `station_status` VALUES ('1821', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970240', '1');
INSERT INTO `station_status` VALUES ('1822', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970249', '1');
INSERT INTO `station_status` VALUES ('1823', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970259', '1');
INSERT INTO `station_status` VALUES ('1824', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970270', '1');
INSERT INTO `station_status` VALUES ('1825', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970280', '1');
INSERT INTO `station_status` VALUES ('1826', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970290', '1');
INSERT INTO `station_status` VALUES ('1827', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970299', '1');
INSERT INTO `station_status` VALUES ('1828', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970310', '1');
INSERT INTO `station_status` VALUES ('1829', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970320', '1');
INSERT INTO `station_status` VALUES ('1830', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970329', '1');
INSERT INTO `station_status` VALUES ('1831', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970339', '1');
INSERT INTO `station_status` VALUES ('1832', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970350', '1');
INSERT INTO `station_status` VALUES ('1833', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970360', '1');
INSERT INTO `station_status` VALUES ('1834', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970369', '1');
INSERT INTO `station_status` VALUES ('1835', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970380', '1');
INSERT INTO `station_status` VALUES ('1836', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970390', '1');
INSERT INTO `station_status` VALUES ('1837', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970400', '1');
INSERT INTO `station_status` VALUES ('1838', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970410', '1');
INSERT INTO `station_status` VALUES ('1839', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970420', '1');
INSERT INTO `station_status` VALUES ('1840', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970430', '1');
INSERT INTO `station_status` VALUES ('1841', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970440', '1');
INSERT INTO `station_status` VALUES ('1842', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970449', '1');
INSERT INTO `station_status` VALUES ('1843', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970460', '1');
INSERT INTO `station_status` VALUES ('1844', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970470', '1');
INSERT INTO `station_status` VALUES ('1845', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970480', '1');
INSERT INTO `station_status` VALUES ('1846', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970490', '1');
INSERT INTO `station_status` VALUES ('1847', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970500', '1');
INSERT INTO `station_status` VALUES ('1848', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970510', '1');
INSERT INTO `station_status` VALUES ('1849', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970520', '1');
INSERT INTO `station_status` VALUES ('1850', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970530', '1');
INSERT INTO `station_status` VALUES ('1851', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970540', '1');
INSERT INTO `station_status` VALUES ('1852', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970550', '1');
INSERT INTO `station_status` VALUES ('1853', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970560', '1');
INSERT INTO `station_status` VALUES ('1854', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970570', '1');
INSERT INTO `station_status` VALUES ('1855', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970580', '1');
INSERT INTO `station_status` VALUES ('1856', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970590', '1');
INSERT INTO `station_status` VALUES ('1857', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970601', '1');
INSERT INTO `station_status` VALUES ('1858', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970610', '1');
INSERT INTO `station_status` VALUES ('1859', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970620', '1');
INSERT INTO `station_status` VALUES ('1860', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970630', '1');
INSERT INTO `station_status` VALUES ('1861', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970640', '1');
INSERT INTO `station_status` VALUES ('1862', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970650', '1');
INSERT INTO `station_status` VALUES ('1863', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970660', '1');
INSERT INTO `station_status` VALUES ('1864', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970670', '1');
INSERT INTO `station_status` VALUES ('1865', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970680', '1');
INSERT INTO `station_status` VALUES ('1866', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970690', '1');
INSERT INTO `station_status` VALUES ('1867', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970700', '1');
INSERT INTO `station_status` VALUES ('1868', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970710', '1');
INSERT INTO `station_status` VALUES ('1869', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970721', '1');
INSERT INTO `station_status` VALUES ('1870', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970730', '1');
INSERT INTO `station_status` VALUES ('1871', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970740', '1');
INSERT INTO `station_status` VALUES ('1872', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970750', '1');
INSERT INTO `station_status` VALUES ('1873', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970760', '1');
INSERT INTO `station_status` VALUES ('1874', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970771', '1');
INSERT INTO `station_status` VALUES ('1875', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970780', '1');
INSERT INTO `station_status` VALUES ('1876', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970790', '1');
INSERT INTO `station_status` VALUES ('1877', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970800', '1');
INSERT INTO `station_status` VALUES ('1878', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970810', '1');
INSERT INTO `station_status` VALUES ('1879', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970821', '1');
INSERT INTO `station_status` VALUES ('1880', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970830', '1');
INSERT INTO `station_status` VALUES ('1881', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970840', '1');
INSERT INTO `station_status` VALUES ('1882', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970850', '1');
INSERT INTO `station_status` VALUES ('1883', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970861', '1');
INSERT INTO `station_status` VALUES ('1884', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970871', '1');
INSERT INTO `station_status` VALUES ('1885', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970880', '1');
INSERT INTO `station_status` VALUES ('1886', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970891', '1');
INSERT INTO `station_status` VALUES ('1887', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970901', '1');
INSERT INTO `station_status` VALUES ('1888', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970911', '1');
INSERT INTO `station_status` VALUES ('1889', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970920', '1');
INSERT INTO `station_status` VALUES ('1890', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970931', '1');
INSERT INTO `station_status` VALUES ('1891', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970941', '1');
INSERT INTO `station_status` VALUES ('1892', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970951', '1');
INSERT INTO `station_status` VALUES ('1893', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970960', '1');
INSERT INTO `station_status` VALUES ('1894', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970970', '1');
INSERT INTO `station_status` VALUES ('1895', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970981', '1');
INSERT INTO `station_status` VALUES ('1896', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430970991', '1');
INSERT INTO `station_status` VALUES ('1897', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971001', '1');
INSERT INTO `station_status` VALUES ('1898', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971010', '1');
INSERT INTO `station_status` VALUES ('1899', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971021', '1');
INSERT INTO `station_status` VALUES ('1900', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971031', '1');
INSERT INTO `station_status` VALUES ('1901', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971041', '1');
INSERT INTO `station_status` VALUES ('1902', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971051', '1');
INSERT INTO `station_status` VALUES ('1903', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971061', '1');
INSERT INTO `station_status` VALUES ('1904', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971071', '1');
INSERT INTO `station_status` VALUES ('1905', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971081', '1');
INSERT INTO `station_status` VALUES ('1906', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971091', '1');
INSERT INTO `station_status` VALUES ('1907', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971101', '1');
INSERT INTO `station_status` VALUES ('1908', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971111', '1');
INSERT INTO `station_status` VALUES ('1909', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971121', '1');
INSERT INTO `station_status` VALUES ('1910', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971131', '1');
INSERT INTO `station_status` VALUES ('1911', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971141', '1');
INSERT INTO `station_status` VALUES ('1912', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971151', '1');
INSERT INTO `station_status` VALUES ('1913', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971161', '1');
INSERT INTO `station_status` VALUES ('1914', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971171', '1');
INSERT INTO `station_status` VALUES ('1915', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971181', '1');
INSERT INTO `station_status` VALUES ('1916', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971184', '1');
INSERT INTO `station_status` VALUES ('1917', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971192', '1');
INSERT INTO `station_status` VALUES ('1918', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971195', '1');
INSERT INTO `station_status` VALUES ('1919', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971201', '1');
INSERT INTO `station_status` VALUES ('1920', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971204', '1');
INSERT INTO `station_status` VALUES ('1921', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971211', '1');
INSERT INTO `station_status` VALUES ('1922', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971215', '1');
INSERT INTO `station_status` VALUES ('1923', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971221', '1');
INSERT INTO `station_status` VALUES ('1924', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971225', '1');
INSERT INTO `station_status` VALUES ('1925', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971231', '1');
INSERT INTO `station_status` VALUES ('1926', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971234', '1');
INSERT INTO `station_status` VALUES ('1927', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971241', '1');
INSERT INTO `station_status` VALUES ('1928', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971245', '1');
INSERT INTO `station_status` VALUES ('1929', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971252', '1');
INSERT INTO `station_status` VALUES ('1930', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971261', '1');
INSERT INTO `station_status` VALUES ('1931', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971271', '1');
INSERT INTO `station_status` VALUES ('1932', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971281', '1');
INSERT INTO `station_status` VALUES ('1933', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971291', '1');
INSERT INTO `station_status` VALUES ('1934', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971301', '1');
INSERT INTO `station_status` VALUES ('1935', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971311', '1');
INSERT INTO `station_status` VALUES ('1936', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971321', '1');
INSERT INTO `station_status` VALUES ('1937', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971331', '1');
INSERT INTO `station_status` VALUES ('1938', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971341', '1');
INSERT INTO `station_status` VALUES ('1939', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971351', '1');
INSERT INTO `station_status` VALUES ('1940', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971361', '1');
INSERT INTO `station_status` VALUES ('1941', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971372', '1');
INSERT INTO `station_status` VALUES ('1942', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971382', '1');
INSERT INTO `station_status` VALUES ('1943', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971391', '1');
INSERT INTO `station_status` VALUES ('1944', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971401', '1');
INSERT INTO `station_status` VALUES ('1945', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971412', '1');
INSERT INTO `station_status` VALUES ('1946', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971422', '1');
INSERT INTO `station_status` VALUES ('1947', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971431', '1');
INSERT INTO `station_status` VALUES ('1948', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971441', '1');
INSERT INTO `station_status` VALUES ('1949', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971451', '1');
INSERT INTO `station_status` VALUES ('1950', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971462', '1');
INSERT INTO `station_status` VALUES ('1951', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971468', '1');
INSERT INTO `station_status` VALUES ('1952', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971472', '1');
INSERT INTO `station_status` VALUES ('1953', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971478', '1');
INSERT INTO `station_status` VALUES ('1954', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971481', '1');
INSERT INTO `station_status` VALUES ('1955', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971488', '1');
INSERT INTO `station_status` VALUES ('1956', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971491', '1');
INSERT INTO `station_status` VALUES ('1957', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971498', '1');
INSERT INTO `station_status` VALUES ('1958', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971501', '1');
INSERT INTO `station_status` VALUES ('1959', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971512', '1');
INSERT INTO `station_status` VALUES ('1960', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971522', '1');
INSERT INTO `station_status` VALUES ('1961', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971532', '1');
INSERT INTO `station_status` VALUES ('1962', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971541', '1');
INSERT INTO `station_status` VALUES ('1963', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971552', '1');
INSERT INTO `station_status` VALUES ('1964', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971562', '1');
INSERT INTO `station_status` VALUES ('1965', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971572', '1');
INSERT INTO `station_status` VALUES ('1966', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971582', '1');
INSERT INTO `station_status` VALUES ('1967', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971591', '1');
INSERT INTO `station_status` VALUES ('1968', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971602', '1');
INSERT INTO `station_status` VALUES ('1969', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971612', '1');
INSERT INTO `station_status` VALUES ('1970', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971621', '1');
INSERT INTO `station_status` VALUES ('1971', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971632', '1');
INSERT INTO `station_status` VALUES ('1972', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971642', '1');
INSERT INTO `station_status` VALUES ('1973', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971652', '1');
INSERT INTO `station_status` VALUES ('1974', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971657', '1');
INSERT INTO `station_status` VALUES ('1975', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971662', '1');
INSERT INTO `station_status` VALUES ('1976', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971667', '1');
INSERT INTO `station_status` VALUES ('1977', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971672', '1');
INSERT INTO `station_status` VALUES ('1978', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971677', '1');
INSERT INTO `station_status` VALUES ('1979', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971682', '1');
INSERT INTO `station_status` VALUES ('1980', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971692', '1');
INSERT INTO `station_status` VALUES ('1981', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971702', '1');
INSERT INTO `station_status` VALUES ('1982', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971712', '1');
INSERT INTO `station_status` VALUES ('1983', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971722', '1');
INSERT INTO `station_status` VALUES ('1984', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971732', '1');
INSERT INTO `station_status` VALUES ('1985', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971742', '1');
INSERT INTO `station_status` VALUES ('1986', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971753', '1');
INSERT INTO `station_status` VALUES ('1987', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971756', '1');
INSERT INTO `station_status` VALUES ('1988', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971762', '1');
INSERT INTO `station_status` VALUES ('1989', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971766', '1');
INSERT INTO `station_status` VALUES ('1990', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971772', '1');
INSERT INTO `station_status` VALUES ('1991', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971776', '1');
INSERT INTO `station_status` VALUES ('1992', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971782', '1');
INSERT INTO `station_status` VALUES ('1993', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971786', '1');
INSERT INTO `station_status` VALUES ('1994', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971792', '1');
INSERT INTO `station_status` VALUES ('1995', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971796', '1');
INSERT INTO `station_status` VALUES ('1996', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971802', '1');
INSERT INTO `station_status` VALUES ('1997', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971806', '1');
INSERT INTO `station_status` VALUES ('1998', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971813', '1');
INSERT INTO `station_status` VALUES ('1999', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971816', '1');
INSERT INTO `station_status` VALUES ('2000', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971822', '1');
INSERT INTO `station_status` VALUES ('2001', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971826', '1');
INSERT INTO `station_status` VALUES ('2002', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971832', '1');
INSERT INTO `station_status` VALUES ('2003', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971836', '1');
INSERT INTO `station_status` VALUES ('2004', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971842', '1');
INSERT INTO `station_status` VALUES ('2005', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971847', '1');
INSERT INTO `station_status` VALUES ('2006', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971852', '1');
INSERT INTO `station_status` VALUES ('2007', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971856', '1');
INSERT INTO `station_status` VALUES ('2008', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971862', '1');
INSERT INTO `station_status` VALUES ('2009', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971866', '1');
INSERT INTO `station_status` VALUES ('2010', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971872', '1');
INSERT INTO `station_status` VALUES ('2011', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971883', '1');
INSERT INTO `station_status` VALUES ('2012', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971887', '1');
INSERT INTO `station_status` VALUES ('2013', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971892', '1');
INSERT INTO `station_status` VALUES ('2014', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971897', '1');
INSERT INTO `station_status` VALUES ('2015', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971902', '1');
INSERT INTO `station_status` VALUES ('2016', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971908', '1');
INSERT INTO `station_status` VALUES ('2017', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971912', '1');
INSERT INTO `station_status` VALUES ('2018', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971918', '1');
INSERT INTO `station_status` VALUES ('2019', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971922', '1');
INSERT INTO `station_status` VALUES ('2020', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971927', '1');
INSERT INTO `station_status` VALUES ('2021', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971932', '1');
INSERT INTO `station_status` VALUES ('2022', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971943', '1');
INSERT INTO `station_status` VALUES ('2023', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971953', '1');
INSERT INTO `station_status` VALUES ('2024', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971962', '1');
INSERT INTO `station_status` VALUES ('2025', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971972', '1');
INSERT INTO `station_status` VALUES ('2026', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971983', '1');
INSERT INTO `station_status` VALUES ('2027', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430971992', '1');
INSERT INTO `station_status` VALUES ('2028', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972004', '1');
INSERT INTO `station_status` VALUES ('2029', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972012', '1');
INSERT INTO `station_status` VALUES ('2030', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972022', '1');
INSERT INTO `station_status` VALUES ('2031', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972033', '1');
INSERT INTO `station_status` VALUES ('2032', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972043', '1');
INSERT INTO `station_status` VALUES ('2033', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972052', '1');
INSERT INTO `station_status` VALUES ('2034', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972062', '1');
INSERT INTO `station_status` VALUES ('2035', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972073', '1');
INSERT INTO `station_status` VALUES ('2036', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972083', '1');
INSERT INTO `station_status` VALUES ('2037', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972093', '1');
INSERT INTO `station_status` VALUES ('2038', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972102', '1');
INSERT INTO `station_status` VALUES ('2039', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972104', '1');
INSERT INTO `station_status` VALUES ('2040', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972105', '1');
INSERT INTO `station_status` VALUES ('2041', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972107', '1');
INSERT INTO `station_status` VALUES ('2042', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972108', '1');
INSERT INTO `station_status` VALUES ('2043', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972110', '1');
INSERT INTO `station_status` VALUES ('2044', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972111', '1');
INSERT INTO `station_status` VALUES ('2045', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972114', '1');
INSERT INTO `station_status` VALUES ('2046', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972122', '1');
INSERT INTO `station_status` VALUES ('2047', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972132', '1');
INSERT INTO `station_status` VALUES ('2048', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972143', '1');
INSERT INTO `station_status` VALUES ('2049', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972153', '1');
INSERT INTO `station_status` VALUES ('2050', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972162', '1');
INSERT INTO `station_status` VALUES ('2051', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972172', '1');
INSERT INTO `station_status` VALUES ('2052', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972183', '1');
INSERT INTO `station_status` VALUES ('2053', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972184', '1');
INSERT INTO `station_status` VALUES ('2054', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972193', '1');
INSERT INTO `station_status` VALUES ('2055', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972202', '1');
INSERT INTO `station_status` VALUES ('2056', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972212', '1');
INSERT INTO `station_status` VALUES ('2057', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972223', '1');
INSERT INTO `station_status` VALUES ('2058', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972225', '1');
INSERT INTO `station_status` VALUES ('2059', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972227', '1');
INSERT INTO `station_status` VALUES ('2060', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972228', '1');
INSERT INTO `station_status` VALUES ('2061', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972229', '1');
INSERT INTO `station_status` VALUES ('2062', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972231', '1');
INSERT INTO `station_status` VALUES ('2063', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972233', '1');
INSERT INTO `station_status` VALUES ('2064', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972234', '1');
INSERT INTO `station_status` VALUES ('2065', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972243', '1');
INSERT INTO `station_status` VALUES ('2066', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972253', '1');
INSERT INTO `station_status` VALUES ('2067', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972262', '1');
INSERT INTO `station_status` VALUES ('2068', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972273', '1');
INSERT INTO `station_status` VALUES ('2069', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972275', '1');
INSERT INTO `station_status` VALUES ('2070', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972277', '1');
INSERT INTO `station_status` VALUES ('2071', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972278', '1');
INSERT INTO `station_status` VALUES ('2072', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972280', '1');
INSERT INTO `station_status` VALUES ('2073', '13', '533db2&ECAPRO&status&OK&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972281', '1');
INSERT INTO `station_status` VALUES ('2074', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972284', '1');
INSERT INTO `station_status` VALUES ('2075', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972293', '1');
INSERT INTO `station_status` VALUES ('2076', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972303', '1');
INSERT INTO `station_status` VALUES ('2077', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972313', '1');
INSERT INTO `station_status` VALUES ('2078', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972323', '1');
INSERT INTO `station_status` VALUES ('2079', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972333', '1');
INSERT INTO `station_status` VALUES ('2080', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972343', '1');
INSERT INTO `station_status` VALUES ('2081', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972353', '1');
INSERT INTO `station_status` VALUES ('2082', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972357', '1');
INSERT INTO `station_status` VALUES ('2083', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972364', '1');
INSERT INTO `station_status` VALUES ('2084', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972373', '1');
INSERT INTO `station_status` VALUES ('2085', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972383', '1');
INSERT INTO `station_status` VALUES ('2086', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972393', '1');
INSERT INTO `station_status` VALUES ('2087', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972399', '1');
INSERT INTO `station_status` VALUES ('2088', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972404', '1');
INSERT INTO `station_status` VALUES ('2089', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972413', '1');
INSERT INTO `station_status` VALUES ('2090', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972423', '1');
INSERT INTO `station_status` VALUES ('2091', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972433', '1');
INSERT INTO `station_status` VALUES ('2092', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972443', '1');
INSERT INTO `station_status` VALUES ('2093', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972453', '1');
INSERT INTO `station_status` VALUES ('2094', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972463', '1');
INSERT INTO `station_status` VALUES ('2095', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972473', '1');
INSERT INTO `station_status` VALUES ('2096', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972483', '1');
INSERT INTO `station_status` VALUES ('2097', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972485', '1');
INSERT INTO `station_status` VALUES ('2098', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972493', '1');
INSERT INTO `station_status` VALUES ('2099', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972503', '1');
INSERT INTO `station_status` VALUES ('2100', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972514', '1');
INSERT INTO `station_status` VALUES ('2101', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972524', '1');
INSERT INTO `station_status` VALUES ('2102', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972525', '1');
INSERT INTO `station_status` VALUES ('2103', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972533', '1');
INSERT INTO `station_status` VALUES ('2104', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972544', '1');
INSERT INTO `station_status` VALUES ('2105', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972553', '1');
INSERT INTO `station_status` VALUES ('2106', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972563', '1');
INSERT INTO `station_status` VALUES ('2107', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972573', '1');
INSERT INTO `station_status` VALUES ('2108', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972583', '1');
INSERT INTO `station_status` VALUES ('2109', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972593', '1');
INSERT INTO `station_status` VALUES ('2110', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972604', '1');
INSERT INTO `station_status` VALUES ('2111', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972608', '1');
INSERT INTO `station_status` VALUES ('2112', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972613', '1');
INSERT INTO `station_status` VALUES ('2113', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972623', '1');
INSERT INTO `station_status` VALUES ('2114', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972634', '1');
INSERT INTO `station_status` VALUES ('2115', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972644', '1');
INSERT INTO `station_status` VALUES ('2116', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972651', '1');
INSERT INTO `station_status` VALUES ('2117', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972653', '1');
INSERT INTO `station_status` VALUES ('2118', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972663', '1');
INSERT INTO `station_status` VALUES ('2119', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972673', '1');
INSERT INTO `station_status` VALUES ('2120', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972683', '1');
INSERT INTO `station_status` VALUES ('2121', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972694', '1');
INSERT INTO `station_status` VALUES ('2122', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972704', '1');
INSERT INTO `station_status` VALUES ('2123', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972713', '1');
INSERT INTO `station_status` VALUES ('2124', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972723', '1');
INSERT INTO `station_status` VALUES ('2125', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972734', '1');
INSERT INTO `station_status` VALUES ('2126', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972744', '1');
INSERT INTO `station_status` VALUES ('2127', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972754', '1');
INSERT INTO `station_status` VALUES ('2128', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972763', '1');
INSERT INTO `station_status` VALUES ('2129', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972773', '1');
INSERT INTO `station_status` VALUES ('2130', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972784', '1');
INSERT INTO `station_status` VALUES ('2131', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972794', '1');
INSERT INTO `station_status` VALUES ('2132', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972803', '1');
INSERT INTO `station_status` VALUES ('2133', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972813', '1');
INSERT INTO `station_status` VALUES ('2134', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972824', '1');
INSERT INTO `station_status` VALUES ('2135', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972834', '1');
INSERT INTO `station_status` VALUES ('2136', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972844', '1');
INSERT INTO `station_status` VALUES ('2137', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972853', '1');
INSERT INTO `station_status` VALUES ('2138', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972864', '1');
INSERT INTO `station_status` VALUES ('2139', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972874', '1');
INSERT INTO `station_status` VALUES ('2140', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972883', '1');
INSERT INTO `station_status` VALUES ('2141', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972893', '1');
INSERT INTO `station_status` VALUES ('2142', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972904', '1');
INSERT INTO `station_status` VALUES ('2143', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972914', '1');
INSERT INTO `station_status` VALUES ('2144', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972923', '1');
INSERT INTO `station_status` VALUES ('2145', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972934', '1');
INSERT INTO `station_status` VALUES ('2146', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972944', '1');
INSERT INTO `station_status` VALUES ('2147', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972954', '1');
INSERT INTO `station_status` VALUES ('2148', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972964', '1');
INSERT INTO `station_status` VALUES ('2149', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972974', '1');
INSERT INTO `station_status` VALUES ('2150', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972984', '1');
INSERT INTO `station_status` VALUES ('2151', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430972994', '1');
INSERT INTO `station_status` VALUES ('2152', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973004', '1');
INSERT INTO `station_status` VALUES ('2153', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973014', '1');
INSERT INTO `station_status` VALUES ('2154', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973024', '1');
INSERT INTO `station_status` VALUES ('2155', '13', '533db2&ECAPRO&status&OK&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973034', '1');
INSERT INTO `station_status` VALUES ('2156', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973661', '1');
INSERT INTO `station_status` VALUES ('2157', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973744', '1');
INSERT INTO `station_status` VALUES ('2158', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973785', '1');
INSERT INTO `station_status` VALUES ('2159', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973868', '1');
INSERT INTO `station_status` VALUES ('2160', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973910', '1');
INSERT INTO `station_status` VALUES ('2161', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430973952', '1');
INSERT INTO `station_status` VALUES ('2162', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974035', '1');
INSERT INTO `station_status` VALUES ('2163', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974077', '1');
INSERT INTO `station_status` VALUES ('2164', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974159', '1');
INSERT INTO `station_status` VALUES ('2165', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974202', '1');
INSERT INTO `station_status` VALUES ('2166', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974285', '1');
INSERT INTO `station_status` VALUES ('2167', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974327', '1');
INSERT INTO `station_status` VALUES ('2168', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974369', '1');
INSERT INTO `station_status` VALUES ('2169', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974451', '1');
INSERT INTO `station_status` VALUES ('2170', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974493', '1');
INSERT INTO `station_status` VALUES ('2171', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974575', '1');
INSERT INTO `station_status` VALUES ('2172', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974617', '1');
INSERT INTO `station_status` VALUES ('2173', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974700', '1');
INSERT INTO `station_status` VALUES ('2174', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974742', '1');
INSERT INTO `station_status` VALUES ('2175', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974826', '1');
INSERT INTO `station_status` VALUES ('2176', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974868', '1');
INSERT INTO `station_status` VALUES ('2177', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974910', '1');
INSERT INTO `station_status` VALUES ('2178', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430974993', '1');
INSERT INTO `station_status` VALUES ('2179', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975035', '1');
INSERT INTO `station_status` VALUES ('2180', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975117', '1');
INSERT INTO `station_status` VALUES ('2181', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975159', '1');
INSERT INTO `station_status` VALUES ('2182', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975242', '1');
INSERT INTO `station_status` VALUES ('2183', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975284', '1');
INSERT INTO `station_status` VALUES ('2184', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975366', '1');
INSERT INTO `station_status` VALUES ('2185', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975410', '1');
INSERT INTO `station_status` VALUES ('2186', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975452', '1');
INSERT INTO `station_status` VALUES ('2187', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975534', '1');
INSERT INTO `station_status` VALUES ('2188', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975577', '1');
INSERT INTO `station_status` VALUES ('2189', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975660', '1');
INSERT INTO `station_status` VALUES ('2190', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975702', '1');
INSERT INTO `station_status` VALUES ('2191', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975784', '1');
INSERT INTO `station_status` VALUES ('2192', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975826', '1');
INSERT INTO `station_status` VALUES ('2193', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975908', '1');
INSERT INTO `station_status` VALUES ('2194', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975950', '1');
INSERT INTO `station_status` VALUES ('2195', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430975993', '1');
INSERT INTO `station_status` VALUES ('2196', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976075', '1');
INSERT INTO `station_status` VALUES ('2197', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976117', '1');
INSERT INTO `station_status` VALUES ('2198', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976200', '1');
INSERT INTO `station_status` VALUES ('2199', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976241', '1');
INSERT INTO `station_status` VALUES ('2200', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976324', '1');
INSERT INTO `station_status` VALUES ('2201', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976366', '1');
INSERT INTO `station_status` VALUES ('2202', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976448', '1');
INSERT INTO `station_status` VALUES ('2203', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976490', '1');
INSERT INTO `station_status` VALUES ('2204', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976532', '1');
INSERT INTO `station_status` VALUES ('2205', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976616', '1');
INSERT INTO `station_status` VALUES ('2206', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976658', '1');
INSERT INTO `station_status` VALUES ('2207', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976740', '1');
INSERT INTO `station_status` VALUES ('2208', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976782', '1');
INSERT INTO `station_status` VALUES ('2209', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976865', '1');
INSERT INTO `station_status` VALUES ('2210', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976907', '1');
INSERT INTO `station_status` VALUES ('2211', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430976949', '1');
INSERT INTO `station_status` VALUES ('2212', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977031', '1');
INSERT INTO `station_status` VALUES ('2213', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977074', '1');
INSERT INTO `station_status` VALUES ('2214', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977157', '1');
INSERT INTO `station_status` VALUES ('2215', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977200', '1');
INSERT INTO `station_status` VALUES ('2216', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977283', '1');
INSERT INTO `station_status` VALUES ('2217', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977325', '1');
INSERT INTO `station_status` VALUES ('2218', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977408', '1');
INSERT INTO `station_status` VALUES ('2219', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977450', '1');
INSERT INTO `station_status` VALUES ('2220', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977492', '1');
INSERT INTO `station_status` VALUES ('2221', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977575', '1');
INSERT INTO `station_status` VALUES ('2222', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977617', '1');
INSERT INTO `station_status` VALUES ('2223', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977699', '1');
INSERT INTO `station_status` VALUES ('2224', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977741', '1');
INSERT INTO `station_status` VALUES ('2225', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977824', '1');
INSERT INTO `station_status` VALUES ('2226', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977866', '1');
INSERT INTO `station_status` VALUES ('2227', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977908', '1');
INSERT INTO `station_status` VALUES ('2228', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430977991', '1');
INSERT INTO `station_status` VALUES ('2229', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978033', '1');
INSERT INTO `station_status` VALUES ('2230', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978116', '1');
INSERT INTO `station_status` VALUES ('2231', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978158', '1');
INSERT INTO `station_status` VALUES ('2232', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978241', '1');
INSERT INTO `station_status` VALUES ('2233', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978282', '1');
INSERT INTO `station_status` VALUES ('2234', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978365', '1');
INSERT INTO `station_status` VALUES ('2235', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978408', '1');
INSERT INTO `station_status` VALUES ('2236', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978450', '1');
INSERT INTO `station_status` VALUES ('2237', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978533', '1');
INSERT INTO `station_status` VALUES ('2238', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978575', '1');
INSERT INTO `station_status` VALUES ('2239', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978658', '1');
INSERT INTO `station_status` VALUES ('2240', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978700', '1');
INSERT INTO `station_status` VALUES ('2241', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978782', '1');
INSERT INTO `station_status` VALUES ('2242', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978824', '1');
INSERT INTO `station_status` VALUES ('2243', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978907', '1');
INSERT INTO `station_status` VALUES ('2244', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978949', '1');
INSERT INTO `station_status` VALUES ('2245', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430978993', '1');
INSERT INTO `station_status` VALUES ('2246', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979075', '1');
INSERT INTO `station_status` VALUES ('2247', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979117', '1');
INSERT INTO `station_status` VALUES ('2248', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979200', '1');
INSERT INTO `station_status` VALUES ('2249', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979242', '1');
INSERT INTO `station_status` VALUES ('2250', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979325', '1');
INSERT INTO `station_status` VALUES ('2251', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979367', '1');
INSERT INTO `station_status` VALUES ('2252', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979409', '1');
INSERT INTO `station_status` VALUES ('2253', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979491', '1');
INSERT INTO `station_status` VALUES ('2254', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979533', '1');
INSERT INTO `station_status` VALUES ('2255', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979617', '1');
INSERT INTO `station_status` VALUES ('2256', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979659', '1');
INSERT INTO `station_status` VALUES ('2257', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979741', '1');
INSERT INTO `station_status` VALUES ('2258', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979783', '1');
INSERT INTO `station_status` VALUES ('2259', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979866', '1');
INSERT INTO `station_status` VALUES ('2260', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979908', '1');
INSERT INTO `station_status` VALUES ('2261', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430979950', '1');
INSERT INTO `station_status` VALUES ('2262', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980032', '1');
INSERT INTO `station_status` VALUES ('2263', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980075', '1');
INSERT INTO `station_status` VALUES ('2264', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980157', '1');
INSERT INTO `station_status` VALUES ('2265', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980200', '1');
INSERT INTO `station_status` VALUES ('2266', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980282', '1');
INSERT INTO `station_status` VALUES ('2267', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980324', '1');
INSERT INTO `station_status` VALUES ('2268', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980407', '1');
INSERT INTO `station_status` VALUES ('2269', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980449', '1');
INSERT INTO `station_status` VALUES ('2270', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980491', '1');
INSERT INTO `station_status` VALUES ('2271', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980574', '1');
INSERT INTO `station_status` VALUES ('2272', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980616', '1');
INSERT INTO `station_status` VALUES ('2273', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980699', '1');
INSERT INTO `station_status` VALUES ('2274', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980741', '1');
INSERT INTO `station_status` VALUES ('2275', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980824', '1');
INSERT INTO `station_status` VALUES ('2276', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980866', '1');
INSERT INTO `station_status` VALUES ('2277', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980949', '1');
INSERT INTO `station_status` VALUES ('2278', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430980991', '1');
INSERT INTO `station_status` VALUES ('2279', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981033', '1');
INSERT INTO `station_status` VALUES ('2280', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981116', '1');
INSERT INTO `station_status` VALUES ('2281', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981158', '1');
INSERT INTO `station_status` VALUES ('2282', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981240', '1');
INSERT INTO `station_status` VALUES ('2283', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981283', '1');
INSERT INTO `station_status` VALUES ('2284', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981365', '1');
INSERT INTO `station_status` VALUES ('2285', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981409', '1');
INSERT INTO `station_status` VALUES ('2286', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981451', '1');
INSERT INTO `station_status` VALUES ('2287', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981534', '1');
INSERT INTO `station_status` VALUES ('2288', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981576', '1');
INSERT INTO `station_status` VALUES ('2289', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981658', '1');
INSERT INTO `station_status` VALUES ('2290', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981701', '1');
INSERT INTO `station_status` VALUES ('2291', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981783', '1');
INSERT INTO `station_status` VALUES ('2292', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981825', '1');
INSERT INTO `station_status` VALUES ('2293', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981908', '1');
INSERT INTO `station_status` VALUES ('2294', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981950', '1');
INSERT INTO `station_status` VALUES ('2295', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430981992', '1');
INSERT INTO `station_status` VALUES ('2296', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982075', '1');
INSERT INTO `station_status` VALUES ('2297', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982117', '1');
INSERT INTO `station_status` VALUES ('2298', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982200', '1');
INSERT INTO `station_status` VALUES ('2299', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982242', '1');
INSERT INTO `station_status` VALUES ('2300', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982325', '1');
INSERT INTO `station_status` VALUES ('2301', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982366', '1');
INSERT INTO `station_status` VALUES ('2302', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982408', '1');
INSERT INTO `station_status` VALUES ('2303', '13', '533db2&ECAPRO&status&ARMING&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982491', '1');
INSERT INTO `station_status` VALUES ('2304', '13', '533db2&ECAPRO&status&DISARM&8&1&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982533', '1');
INSERT INTO `station_status` VALUES ('2305', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982617', '1');
INSERT INTO `station_status` VALUES ('2306', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982659', '1');
INSERT INTO `station_status` VALUES ('2307', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982742', '1');
INSERT INTO `station_status` VALUES ('2308', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982784', '1');
INSERT INTO `station_status` VALUES ('2309', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982867', '1');
INSERT INTO `station_status` VALUES ('2310', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982908', '1');
INSERT INTO `station_status` VALUES ('2311', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430982950', '1');
INSERT INTO `station_status` VALUES ('2312', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983033', '1');
INSERT INTO `station_status` VALUES ('2313', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983075', '1');
INSERT INTO `station_status` VALUES ('2314', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983158', '1');
INSERT INTO `station_status` VALUES ('2315', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983201', '1');
INSERT INTO `station_status` VALUES ('2316', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983284', '1');
INSERT INTO `station_status` VALUES ('2317', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983326', '1');
INSERT INTO `station_status` VALUES ('2318', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983408', '1');
INSERT INTO `station_status` VALUES ('2319', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983450', '1');
INSERT INTO `station_status` VALUES ('2320', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983492', '1');
INSERT INTO `station_status` VALUES ('2321', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983575', '1');
INSERT INTO `station_status` VALUES ('2322', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983617', '1');
INSERT INTO `station_status` VALUES ('2323', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983700', '1');
INSERT INTO `station_status` VALUES ('2324', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983741', '1');
INSERT INTO `station_status` VALUES ('2325', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983826', '1');
INSERT INTO `station_status` VALUES ('2326', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983868', '1');
INSERT INTO `station_status` VALUES ('2327', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983910', '1');
INSERT INTO `station_status` VALUES ('2328', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430983992', '1');
INSERT INTO `station_status` VALUES ('2329', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984034', '1');
INSERT INTO `station_status` VALUES ('2330', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984117', '1');
INSERT INTO `station_status` VALUES ('2331', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984159', '1');
INSERT INTO `station_status` VALUES ('2332', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984241', '1');
INSERT INTO `station_status` VALUES ('2333', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984283', '1');
INSERT INTO `station_status` VALUES ('2334', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984365', '1');
INSERT INTO `station_status` VALUES ('2335', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984409', '1');
INSERT INTO `station_status` VALUES ('2336', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984451', '1');
INSERT INTO `station_status` VALUES ('2337', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984534', '1');
INSERT INTO `station_status` VALUES ('2338', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984576', '1');
INSERT INTO `station_status` VALUES ('2339', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984658', '1');
INSERT INTO `station_status` VALUES ('2340', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984700', '1');
INSERT INTO `station_status` VALUES ('2341', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984782', '1');
INSERT INTO `station_status` VALUES ('2342', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984824', '1');
INSERT INTO `station_status` VALUES ('2343', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984907', '1');
INSERT INTO `station_status` VALUES ('2344', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984949', '1');
INSERT INTO `station_status` VALUES ('2345', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430984992', '1');
INSERT INTO `station_status` VALUES ('2346', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985074', '1');
INSERT INTO `station_status` VALUES ('2347', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985116', '1');
INSERT INTO `station_status` VALUES ('2348', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985198', '1');
INSERT INTO `station_status` VALUES ('2349', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985240', '1');
INSERT INTO `station_status` VALUES ('2350', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985323', '1');
INSERT INTO `station_status` VALUES ('2351', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985365', '1');
INSERT INTO `station_status` VALUES ('2352', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985447', '1');
INSERT INTO `station_status` VALUES ('2353', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985489', '1');
INSERT INTO `station_status` VALUES ('2354', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985531', '1');
INSERT INTO `station_status` VALUES ('2355', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985615', '1');
INSERT INTO `station_status` VALUES ('2356', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985657', '1');
INSERT INTO `station_status` VALUES ('2357', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985740', '1');
INSERT INTO `station_status` VALUES ('2358', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985782', '1');
INSERT INTO `station_status` VALUES ('2359', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985864', '1');
INSERT INTO `station_status` VALUES ('2360', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985906', '1');
INSERT INTO `station_status` VALUES ('2361', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430985949', '1');
INSERT INTO `station_status` VALUES ('2362', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986031', '1');
INSERT INTO `station_status` VALUES ('2363', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986073', '1');
INSERT INTO `station_status` VALUES ('2364', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986155', '1');
INSERT INTO `station_status` VALUES ('2365', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986198', '1');
INSERT INTO `station_status` VALUES ('2366', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986281', '1');
INSERT INTO `station_status` VALUES ('2367', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986322', '1');
INSERT INTO `station_status` VALUES ('2368', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986405', '1');
INSERT INTO `station_status` VALUES ('2369', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986446', '1');
INSERT INTO `station_status` VALUES ('2370', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986488', '1');
INSERT INTO `station_status` VALUES ('2371', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986571', '1');
INSERT INTO `station_status` VALUES ('2372', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986613', '1');
INSERT INTO `station_status` VALUES ('2373', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986695', '1');
INSERT INTO `station_status` VALUES ('2374', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986737', '1');
INSERT INTO `station_status` VALUES ('2375', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986821', '1');
INSERT INTO `station_status` VALUES ('2376', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986862', '1');
INSERT INTO `station_status` VALUES ('2377', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986945', '1');
INSERT INTO `station_status` VALUES ('2378', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430986987', '1');
INSERT INTO `station_status` VALUES ('2379', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987029', '1');
INSERT INTO `station_status` VALUES ('2380', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987111', '1');
INSERT INTO `station_status` VALUES ('2381', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987153', '1');
INSERT INTO `station_status` VALUES ('2382', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987236', '1');
INSERT INTO `station_status` VALUES ('2383', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987278', '1');
INSERT INTO `station_status` VALUES ('2384', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987360', '1');
INSERT INTO `station_status` VALUES ('2385', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987403', '1');
INSERT INTO `station_status` VALUES ('2386', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987485', '1');
INSERT INTO `station_status` VALUES ('2387', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987527', '1');
INSERT INTO `station_status` VALUES ('2388', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987569', '1');
INSERT INTO `station_status` VALUES ('2389', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987652', '1');
INSERT INTO `station_status` VALUES ('2390', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987694', '1');
INSERT INTO `station_status` VALUES ('2391', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987777', '1');
INSERT INTO `station_status` VALUES ('2392', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987819', '1');
INSERT INTO `station_status` VALUES ('2393', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987902', '1');
INSERT INTO `station_status` VALUES ('2394', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430987943', '1');
INSERT INTO `station_status` VALUES ('2395', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988027', '1');
INSERT INTO `station_status` VALUES ('2396', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988069', '1');
INSERT INTO `station_status` VALUES ('2397', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988111', '1');
INSERT INTO `station_status` VALUES ('2398', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988194', '1');
INSERT INTO `station_status` VALUES ('2399', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988235', '1');
INSERT INTO `station_status` VALUES ('2400', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988318', '1');
INSERT INTO `station_status` VALUES ('2401', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988360', '1');
INSERT INTO `station_status` VALUES ('2402', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988442', '1');
INSERT INTO `station_status` VALUES ('2403', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988484', '1');
INSERT INTO `station_status` VALUES ('2404', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988567', '1');
INSERT INTO `station_status` VALUES ('2405', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988610', '1');
INSERT INTO `station_status` VALUES ('2406', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988652', '1');
INSERT INTO `station_status` VALUES ('2407', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988735', '1');
INSERT INTO `station_status` VALUES ('2408', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988777', '1');
INSERT INTO `station_status` VALUES ('2409', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988859', '1');
INSERT INTO `station_status` VALUES ('2410', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988901', '1');
INSERT INTO `station_status` VALUES ('2411', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430988984', '1');
INSERT INTO `station_status` VALUES ('2412', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989026', '1');
INSERT INTO `station_status` VALUES ('2413', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989108', '1');
INSERT INTO `station_status` VALUES ('2414', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989150', '1');
INSERT INTO `station_status` VALUES ('2415', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989194', '1');
INSERT INTO `station_status` VALUES ('2416', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989276', '1');
INSERT INTO `station_status` VALUES ('2417', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989318', '1');
INSERT INTO `station_status` VALUES ('2418', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989401', '1');
INSERT INTO `station_status` VALUES ('2419', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989443', '1');
INSERT INTO `station_status` VALUES ('2420', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989525', '1');
INSERT INTO `station_status` VALUES ('2421', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989567', '1');
INSERT INTO `station_status` VALUES ('2422', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989609', '1');
INSERT INTO `station_status` VALUES ('2423', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989691', '1');
INSERT INTO `station_status` VALUES ('2424', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989733', '1');
INSERT INTO `station_status` VALUES ('2425', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989817', '1');
INSERT INTO `station_status` VALUES ('2426', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989858', '1');
INSERT INTO `station_status` VALUES ('2427', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989941', '1');
INSERT INTO `station_status` VALUES ('2428', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430989983', '1');
INSERT INTO `station_status` VALUES ('2429', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990066', '1');
INSERT INTO `station_status` VALUES ('2430', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990107', '1');
INSERT INTO `station_status` VALUES ('2431', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990150', '1');
INSERT INTO `station_status` VALUES ('2432', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990233', '1');
INSERT INTO `station_status` VALUES ('2433', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990274', '1');
INSERT INTO `station_status` VALUES ('2434', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990357', '1');
INSERT INTO `station_status` VALUES ('2435', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990399', '1');
INSERT INTO `station_status` VALUES ('2436', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990482', '1');
INSERT INTO `station_status` VALUES ('2437', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990524', '1');
INSERT INTO `station_status` VALUES ('2438', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990606', '1');
INSERT INTO `station_status` VALUES ('2439', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990648', '1');
INSERT INTO `station_status` VALUES ('2440', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990690', '1');
INSERT INTO `station_status` VALUES ('2441', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990773', '1');
INSERT INTO `station_status` VALUES ('2442', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990815', '1');
INSERT INTO `station_status` VALUES ('2443', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990897', '1');
INSERT INTO `station_status` VALUES ('2444', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430990939', '1');
INSERT INTO `station_status` VALUES ('2445', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991023', '1');
INSERT INTO `station_status` VALUES ('2446', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991065', '1');
INSERT INTO `station_status` VALUES ('2447', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991147', '1');
INSERT INTO `station_status` VALUES ('2448', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991189', '1');
INSERT INTO `station_status` VALUES ('2449', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991231', '1');
INSERT INTO `station_status` VALUES ('2450', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991314', '1');
INSERT INTO `station_status` VALUES ('2451', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991356', '1');
INSERT INTO `station_status` VALUES ('2452', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991439', '1');
INSERT INTO `station_status` VALUES ('2453', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991481', '1');
INSERT INTO `station_status` VALUES ('2454', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991563', '1');
INSERT INTO `station_status` VALUES ('2455', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991606', '1');
INSERT INTO `station_status` VALUES ('2456', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991688', '1');
INSERT INTO `station_status` VALUES ('2457', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991730', '1');
INSERT INTO `station_status` VALUES ('2458', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991772', '1');
INSERT INTO `station_status` VALUES ('2459', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991855', '1');
INSERT INTO `station_status` VALUES ('2460', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991896', '1');
INSERT INTO `station_status` VALUES ('2461', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430991979', '1');
INSERT INTO `station_status` VALUES ('2462', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992021', '1');
INSERT INTO `station_status` VALUES ('2463', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992103', '1');
INSERT INTO `station_status` VALUES ('2464', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992145', '1');
INSERT INTO `station_status` VALUES ('2465', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992229', '1');
INSERT INTO `station_status` VALUES ('2466', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992271', '1');
INSERT INTO `station_status` VALUES ('2467', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992312', '1');
INSERT INTO `station_status` VALUES ('2468', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992395', '1');
INSERT INTO `station_status` VALUES ('2469', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992437', '1');
INSERT INTO `station_status` VALUES ('2470', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992520', '1');
INSERT INTO `station_status` VALUES ('2471', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992562', '1');
INSERT INTO `station_status` VALUES ('2472', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992644', '1');
INSERT INTO `station_status` VALUES ('2473', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992686', '1');
INSERT INTO `station_status` VALUES ('2474', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992729', '1');
INSERT INTO `station_status` VALUES ('2475', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992812', '1');
INSERT INTO `station_status` VALUES ('2476', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992854', '1');
INSERT INTO `station_status` VALUES ('2477', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992937', '1');
INSERT INTO `station_status` VALUES ('2478', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430992979', '1');
INSERT INTO `station_status` VALUES ('2479', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993061', '1');
INSERT INTO `station_status` VALUES ('2480', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993103', '1');
INSERT INTO `station_status` VALUES ('2481', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993186', '1');
INSERT INTO `station_status` VALUES ('2482', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993228', '1');
INSERT INTO `station_status` VALUES ('2483', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993270', '1');
INSERT INTO `station_status` VALUES ('2484', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993353', '1');
INSERT INTO `station_status` VALUES ('2485', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993395', '1');
INSERT INTO `station_status` VALUES ('2486', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993478', '1');
INSERT INTO `station_status` VALUES ('2487', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993520', '1');
INSERT INTO `station_status` VALUES ('2488', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993602', '1');
INSERT INTO `station_status` VALUES ('2489', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993645', '1');
INSERT INTO `station_status` VALUES ('2490', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993727', '1');
INSERT INTO `station_status` VALUES ('2491', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993769', '1');
INSERT INTO `station_status` VALUES ('2492', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993811', '1');
INSERT INTO `station_status` VALUES ('2493', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993894', '1');
INSERT INTO `station_status` VALUES ('2494', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430993936', '1');
INSERT INTO `station_status` VALUES ('2495', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994020', '1');
INSERT INTO `station_status` VALUES ('2496', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994062', '1');
INSERT INTO `station_status` VALUES ('2497', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994145', '1');
INSERT INTO `station_status` VALUES ('2498', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994187', '1');
INSERT INTO `station_status` VALUES ('2499', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994228', '1');
INSERT INTO `station_status` VALUES ('2500', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994311', '1');
INSERT INTO `station_status` VALUES ('2501', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994353', '1');
INSERT INTO `station_status` VALUES ('2502', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994435', '1');
INSERT INTO `station_status` VALUES ('2503', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994477', '1');
INSERT INTO `station_status` VALUES ('2504', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994560', '1');
INSERT INTO `station_status` VALUES ('2505', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994604', '1');
INSERT INTO `station_status` VALUES ('2506', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994686', '1');
INSERT INTO `station_status` VALUES ('2507', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994728', '1');
INSERT INTO `station_status` VALUES ('2508', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994770', '1');
INSERT INTO `station_status` VALUES ('2509', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994852', '1');
INSERT INTO `station_status` VALUES ('2510', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994894', '1');
INSERT INTO `station_status` VALUES ('2511', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430994976', '1');
INSERT INTO `station_status` VALUES ('2512', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995018', '1');
INSERT INTO `station_status` VALUES ('2513', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995101', '1');
INSERT INTO `station_status` VALUES ('2514', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995143', '1');
INSERT INTO `station_status` VALUES ('2515', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995227', '1');
INSERT INTO `station_status` VALUES ('2516', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995269', '1');
INSERT INTO `station_status` VALUES ('2517', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995310', '1');
INSERT INTO `station_status` VALUES ('2518', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995393', '1');
INSERT INTO `station_status` VALUES ('2519', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995435', '1');
INSERT INTO `station_status` VALUES ('2520', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995517', '1');
INSERT INTO `station_status` VALUES ('2521', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995559', '1');
INSERT INTO `station_status` VALUES ('2522', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995642', '1');
INSERT INTO `station_status` VALUES ('2523', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995684', '1');
INSERT INTO `station_status` VALUES ('2524', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995766', '1');
INSERT INTO `station_status` VALUES ('2525', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995809', '1');
INSERT INTO `station_status` VALUES ('2526', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995851', '1');
INSERT INTO `station_status` VALUES ('2527', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995934', '1');
INSERT INTO `station_status` VALUES ('2528', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430995976', '1');
INSERT INTO `station_status` VALUES ('2529', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996058', '1');
INSERT INTO `station_status` VALUES ('2530', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996100', '1');
INSERT INTO `station_status` VALUES ('2531', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996183', '1');
INSERT INTO `station_status` VALUES ('2532', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996225', '1');
INSERT INTO `station_status` VALUES ('2533', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996308', '1');
INSERT INTO `station_status` VALUES ('2534', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996350', '1');
INSERT INTO `station_status` VALUES ('2535', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996393', '1');
INSERT INTO `station_status` VALUES ('2536', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996476', '1');
INSERT INTO `station_status` VALUES ('2537', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996518', '1');
INSERT INTO `station_status` VALUES ('2538', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996600', '1');
INSERT INTO `station_status` VALUES ('2539', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996642', '1');
INSERT INTO `station_status` VALUES ('2540', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996725', '1');
INSERT INTO `station_status` VALUES ('2541', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996767', '1');
INSERT INTO `station_status` VALUES ('2542', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996809', '1');
INSERT INTO `station_status` VALUES ('2543', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996891', '1');
INSERT INTO `station_status` VALUES ('2544', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430996933', '1');
INSERT INTO `station_status` VALUES ('2545', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997017', '1');
INSERT INTO `station_status` VALUES ('2546', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997059', '1');
INSERT INTO `station_status` VALUES ('2547', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997142', '1');
INSERT INTO `station_status` VALUES ('2548', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997184', '1');
INSERT INTO `station_status` VALUES ('2549', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997266', '1');
INSERT INTO `station_status` VALUES ('2550', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997308', '1');
INSERT INTO `station_status` VALUES ('2551', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997350', '1');
INSERT INTO `station_status` VALUES ('2552', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997433', '1');
INSERT INTO `station_status` VALUES ('2553', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997475', '1');
INSERT INTO `station_status` VALUES ('2554', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997557', '1');
INSERT INTO `station_status` VALUES ('2555', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997600', '1');
INSERT INTO `station_status` VALUES ('2556', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997682', '1');
INSERT INTO `station_status` VALUES ('2557', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997724', '1');
INSERT INTO `station_status` VALUES ('2558', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997807', '1');
INSERT INTO `station_status` VALUES ('2559', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997849', '1');
INSERT INTO `station_status` VALUES ('2560', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997890', '1');
INSERT INTO `station_status` VALUES ('2561', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430997973', '1');
INSERT INTO `station_status` VALUES ('2562', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998015', '1');
INSERT INTO `station_status` VALUES ('2563', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998097', '1');
INSERT INTO `station_status` VALUES ('2564', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998139', '1');
INSERT INTO `station_status` VALUES ('2565', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998223', '1');
INSERT INTO `station_status` VALUES ('2566', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998265', '1');
INSERT INTO `station_status` VALUES ('2567', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998348', '1');
INSERT INTO `station_status` VALUES ('2568', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998390', '1');
INSERT INTO `station_status` VALUES ('2569', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998432', '1');
INSERT INTO `station_status` VALUES ('2570', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998515', '1');
INSERT INTO `station_status` VALUES ('2571', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998557', '1');
INSERT INTO `station_status` VALUES ('2572', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998639', '1');
INSERT INTO `station_status` VALUES ('2573', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998681', '1');
INSERT INTO `station_status` VALUES ('2574', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998764', '1');
INSERT INTO `station_status` VALUES ('2575', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998807', '1');
INSERT INTO `station_status` VALUES ('2576', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998849', '1');
INSERT INTO `station_status` VALUES ('2577', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998932', '1');
INSERT INTO `station_status` VALUES ('2578', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430998974', '1');
INSERT INTO `station_status` VALUES ('2579', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999056', '1');
INSERT INTO `station_status` VALUES ('2580', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999098', '1');
INSERT INTO `station_status` VALUES ('2581', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999180', '1');
INSERT INTO `station_status` VALUES ('2582', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999222', '1');
INSERT INTO `station_status` VALUES ('2583', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999305', '1');
INSERT INTO `station_status` VALUES ('2584', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999347', '1');
INSERT INTO `station_status` VALUES ('2585', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999389', '1');
INSERT INTO `station_status` VALUES ('2586', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999472', '1');
INSERT INTO `station_status` VALUES ('2587', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999514', '1');
INSERT INTO `station_status` VALUES ('2588', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999596', '1');
INSERT INTO `station_status` VALUES ('2589', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999638', '1');
INSERT INTO `station_status` VALUES ('2590', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999721', '1');
INSERT INTO `station_status` VALUES ('2591', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999763', '1');
INSERT INTO `station_status` VALUES ('2592', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999845', '1');
INSERT INTO `station_status` VALUES ('2593', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999887', '1');
INSERT INTO `station_status` VALUES ('2594', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430999930', '1');
INSERT INTO `station_status` VALUES ('2595', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000014', '1');
INSERT INTO `station_status` VALUES ('2596', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000056', '1');
INSERT INTO `station_status` VALUES ('2597', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000139', '1');
INSERT INTO `station_status` VALUES ('2598', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000181', '1');
INSERT INTO `station_status` VALUES ('2599', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000263', '1');
INSERT INTO `station_status` VALUES ('2600', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000305', '1');
INSERT INTO `station_status` VALUES ('2601', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000388', '1');
INSERT INTO `station_status` VALUES ('2602', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000430', '1');
INSERT INTO `station_status` VALUES ('2603', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000472', '1');
INSERT INTO `station_status` VALUES ('2604', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000554', '1');
INSERT INTO `station_status` VALUES ('2605', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000597', '1');
INSERT INTO `station_status` VALUES ('2606', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000680', '1');
INSERT INTO `station_status` VALUES ('2607', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000722', '1');
INSERT INTO `station_status` VALUES ('2608', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000805', '1');
INSERT INTO `station_status` VALUES ('2609', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000847', '1');
INSERT INTO `station_status` VALUES ('2610', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000889', '1');
INSERT INTO `station_status` VALUES ('2611', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431000971', '1');
INSERT INTO `station_status` VALUES ('2612', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001014', '1');
INSERT INTO `station_status` VALUES ('2613', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001096', '1');
INSERT INTO `station_status` VALUES ('2614', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001138', '1');
INSERT INTO `station_status` VALUES ('2615', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001222', '1');
INSERT INTO `station_status` VALUES ('2616', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001264', '1');
INSERT INTO `station_status` VALUES ('2617', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001346', '1');
INSERT INTO `station_status` VALUES ('2618', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001388', '1');
INSERT INTO `station_status` VALUES ('2619', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001430', '1');
INSERT INTO `station_status` VALUES ('2620', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001512', '1');
INSERT INTO `station_status` VALUES ('2621', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001555', '1');
INSERT INTO `station_status` VALUES ('2622', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001637', '1');
INSERT INTO `station_status` VALUES ('2623', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001679', '1');
INSERT INTO `station_status` VALUES ('2624', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001762', '1');
INSERT INTO `station_status` VALUES ('2625', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001806', '1');
INSERT INTO `station_status` VALUES ('2626', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001888', '1');
INSERT INTO `station_status` VALUES ('2627', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001930', '1');
INSERT INTO `station_status` VALUES ('2628', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431001973', '1');
INSERT INTO `station_status` VALUES ('2629', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002055', '1');
INSERT INTO `station_status` VALUES ('2630', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002097', '1');
INSERT INTO `station_status` VALUES ('2631', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002179', '1');
INSERT INTO `station_status` VALUES ('2632', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002222', '1');
INSERT INTO `station_status` VALUES ('2633', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002305', '1');
INSERT INTO `station_status` VALUES ('2634', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002347', '1');
INSERT INTO `station_status` VALUES ('2635', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002390', '1');
INSERT INTO `station_status` VALUES ('2636', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002473', '1');
INSERT INTO `station_status` VALUES ('2637', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002515', '1');
INSERT INTO `station_status` VALUES ('2638', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002597', '1');
INSERT INTO `station_status` VALUES ('2639', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002639', '1');
INSERT INTO `station_status` VALUES ('2640', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002722', '1');
INSERT INTO `station_status` VALUES ('2641', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002764', '1');
INSERT INTO `station_status` VALUES ('2642', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002846', '1');
INSERT INTO `station_status` VALUES ('2643', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002888', '1');
INSERT INTO `station_status` VALUES ('2644', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431002930', '1');
INSERT INTO `station_status` VALUES ('2645', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003014', '1');
INSERT INTO `station_status` VALUES ('2646', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003055', '1');
INSERT INTO `station_status` VALUES ('2647', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003138', '1');
INSERT INTO `station_status` VALUES ('2648', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003180', '1');
INSERT INTO `station_status` VALUES ('2649', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003262', '1');
INSERT INTO `station_status` VALUES ('2650', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003304', '1');
INSERT INTO `station_status` VALUES ('2651', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003387', '1');
INSERT INTO `station_status` VALUES ('2652', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003429', '1');
INSERT INTO `station_status` VALUES ('2653', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003470', '1');
INSERT INTO `station_status` VALUES ('2654', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003553', '1');
INSERT INTO `station_status` VALUES ('2655', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003596', '1');
INSERT INTO `station_status` VALUES ('2656', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003678', '1');
INSERT INTO `station_status` VALUES ('2657', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003720', '1');
INSERT INTO `station_status` VALUES ('2658', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003803', '1');
INSERT INTO `station_status` VALUES ('2659', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003844', '1');
INSERT INTO `station_status` VALUES ('2660', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003927', '1');
INSERT INTO `station_status` VALUES ('2661', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431003969', '1');
INSERT INTO `station_status` VALUES ('2662', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004010', '1');
INSERT INTO `station_status` VALUES ('2663', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004093', '1');
INSERT INTO `station_status` VALUES ('2664', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004135', '1');
INSERT INTO `station_status` VALUES ('2665', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004220', '1');
INSERT INTO `station_status` VALUES ('2666', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004262', '1');
INSERT INTO `station_status` VALUES ('2667', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004344', '1');
INSERT INTO `station_status` VALUES ('2668', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004386', '1');
INSERT INTO `station_status` VALUES ('2669', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004428', '1');
INSERT INTO `station_status` VALUES ('2670', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004511', '1');
INSERT INTO `station_status` VALUES ('2671', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004553', '1');
INSERT INTO `station_status` VALUES ('2672', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004635', '1');
INSERT INTO `station_status` VALUES ('2673', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004678', '1');
INSERT INTO `station_status` VALUES ('2674', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004760', '1');
INSERT INTO `station_status` VALUES ('2675', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004804', '1');
INSERT INTO `station_status` VALUES ('2676', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004886', '1');
INSERT INTO `station_status` VALUES ('2677', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004928', '1');
INSERT INTO `station_status` VALUES ('2678', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431004970', '1');
INSERT INTO `station_status` VALUES ('2679', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005053', '1');
INSERT INTO `station_status` VALUES ('2680', '13', '533db2&ECAPRO&status&DISARM&8&17&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005095', '1');
INSERT INTO `station_status` VALUES ('2681', '13', '533db2&ECAPRO&status&DISARM&8&17&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005177', '1');
INSERT INTO `station_status` VALUES ('2682', '13', '533db2&ECAPRO&status&DISARM&8&17&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005219', '1');
INSERT INTO `station_status` VALUES ('2683', '13', '533db2&ECAPRO&status&DISARM&8&49&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005302', '1');
INSERT INTO `station_status` VALUES ('2684', '13', '533db2&ECAPRO&status&DISARM&8&49&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005345', '1');
INSERT INTO `station_status` VALUES ('2685', '13', '533db2&ECAPRO&status&DISARM&8&49&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431005429', '1');
INSERT INTO `station_status` VALUES ('2686', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108490', '1');
INSERT INTO `station_status` VALUES ('2687', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108533', '1');
INSERT INTO `station_status` VALUES ('2688', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108575', '1');
INSERT INTO `station_status` VALUES ('2689', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108658', '1');
INSERT INTO `station_status` VALUES ('2690', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108700', '1');
INSERT INTO `station_status` VALUES ('2691', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108782', '1');
INSERT INTO `station_status` VALUES ('2692', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108824', '1');
INSERT INTO `station_status` VALUES ('2693', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108907', '1');
INSERT INTO `station_status` VALUES ('2694', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108949', '1');
INSERT INTO `station_status` VALUES ('2695', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431108993', '1');
INSERT INTO `station_status` VALUES ('2696', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109076', '1');
INSERT INTO `station_status` VALUES ('2697', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109118', '1');
INSERT INTO `station_status` VALUES ('2698', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109201', '1');
INSERT INTO `station_status` VALUES ('2699', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109243', '1');
INSERT INTO `station_status` VALUES ('2700', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109326', '1');
INSERT INTO `station_status` VALUES ('2701', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109368', '1');
INSERT INTO `station_status` VALUES ('2702', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109411', '1');
INSERT INTO `station_status` VALUES ('2703', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109494', '1');
INSERT INTO `station_status` VALUES ('2704', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109536', '1');
INSERT INTO `station_status` VALUES ('2705', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109620', '1');
INSERT INTO `station_status` VALUES ('2706', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109662', '1');
INSERT INTO `station_status` VALUES ('2707', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109745', '1');
INSERT INTO `station_status` VALUES ('2708', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109787', '1');
INSERT INTO `station_status` VALUES ('2709', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109829', '1');
INSERT INTO `station_status` VALUES ('2710', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109911', '1');
INSERT INTO `station_status` VALUES ('2711', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431109953', '1');
INSERT INTO `station_status` VALUES ('2712', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110036', '1');
INSERT INTO `station_status` VALUES ('2713', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110078', '1');
INSERT INTO `station_status` VALUES ('2714', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110161', '1');
INSERT INTO `station_status` VALUES ('2715', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110204', '1');
INSERT INTO `station_status` VALUES ('2716', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110286', '1');
INSERT INTO `station_status` VALUES ('2717', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110328', '1');
INSERT INTO `station_status` VALUES ('2718', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110370', '1');
INSERT INTO `station_status` VALUES ('2719', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110453', '1');
INSERT INTO `station_status` VALUES ('2720', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110495', '1');
INSERT INTO `station_status` VALUES ('2721', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110578', '1');
INSERT INTO `station_status` VALUES ('2722', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110620', '1');
INSERT INTO `station_status` VALUES ('2723', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110703', '1');
INSERT INTO `station_status` VALUES ('2724', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110745', '1');
INSERT INTO `station_status` VALUES ('2725', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110829', '1');
INSERT INTO `station_status` VALUES ('2726', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110871', '1');
INSERT INTO `station_status` VALUES ('2727', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110913', '1');
INSERT INTO `station_status` VALUES ('2728', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431110996', '1');
INSERT INTO `station_status` VALUES ('2729', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111039', '1');
INSERT INTO `station_status` VALUES ('2730', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111122', '1');
INSERT INTO `station_status` VALUES ('2731', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111164', '1');
INSERT INTO `station_status` VALUES ('2732', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111247', '1');
INSERT INTO `station_status` VALUES ('2733', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111289', '1');
INSERT INTO `station_status` VALUES ('2734', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111331', '1');
INSERT INTO `station_status` VALUES ('2735', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111414', '1');
INSERT INTO `station_status` VALUES ('2736', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111456', '1');
INSERT INTO `station_status` VALUES ('2737', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111539', '1');
INSERT INTO `station_status` VALUES ('2738', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111582', '1');
INSERT INTO `station_status` VALUES ('2739', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111665', '1');
INSERT INTO `station_status` VALUES ('2740', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111707', '1');
INSERT INTO `station_status` VALUES ('2741', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111749', '1');
INSERT INTO `station_status` VALUES ('2742', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111832', '1');
INSERT INTO `station_status` VALUES ('2743', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111874', '1');
INSERT INTO `station_status` VALUES ('2744', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111956', '1');
INSERT INTO `station_status` VALUES ('2745', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431111999', '1');
INSERT INTO `station_status` VALUES ('2746', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112082', '1');
INSERT INTO `station_status` VALUES ('2747', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112125', '1');
INSERT INTO `station_status` VALUES ('2748', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112207', '1');
INSERT INTO `station_status` VALUES ('2749', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112249', '1');
INSERT INTO `station_status` VALUES ('2750', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112291', '1');
INSERT INTO `station_status` VALUES ('2751', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112374', '1');
INSERT INTO `station_status` VALUES ('2752', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112416', '1');
INSERT INTO `station_status` VALUES ('2753', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112499', '1');
INSERT INTO `station_status` VALUES ('2754', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112541', '1');
INSERT INTO `station_status` VALUES ('2755', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112624', '1');
INSERT INTO `station_status` VALUES ('2756', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112666', '1');
INSERT INTO `station_status` VALUES ('2757', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112708', '1');
INSERT INTO `station_status` VALUES ('2758', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112791', '1');
INSERT INTO `station_status` VALUES ('2759', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112833', '1');
INSERT INTO `station_status` VALUES ('2760', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112916', '1');
INSERT INTO `station_status` VALUES ('2761', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431112958', '1');
INSERT INTO `station_status` VALUES ('2762', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113041', '1');
INSERT INTO `station_status` VALUES ('2763', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113082', '1');
INSERT INTO `station_status` VALUES ('2764', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113165', '1');
INSERT INTO `station_status` VALUES ('2765', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113208', '1');
INSERT INTO `station_status` VALUES ('2766', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113250', '1');
INSERT INTO `station_status` VALUES ('2767', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113333', '1');
INSERT INTO `station_status` VALUES ('2768', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113375', '1');
INSERT INTO `station_status` VALUES ('2769', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113458', '1');
INSERT INTO `station_status` VALUES ('2770', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113500', '1');
INSERT INTO `station_status` VALUES ('2771', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113582', '1');
INSERT INTO `station_status` VALUES ('2772', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113624', '1');
INSERT INTO `station_status` VALUES ('2773', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113707', '1');
INSERT INTO `station_status` VALUES ('2774', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113749', '1');
INSERT INTO `station_status` VALUES ('2775', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113792', '1');
INSERT INTO `station_status` VALUES ('2776', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113875', '1');
INSERT INTO `station_status` VALUES ('2777', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431113917', '1');
INSERT INTO `station_status` VALUES ('2778', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114000', '1');
INSERT INTO `station_status` VALUES ('2779', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114042', '1');
INSERT INTO `station_status` VALUES ('2780', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114124', '1');
INSERT INTO `station_status` VALUES ('2781', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114166', '1');
INSERT INTO `station_status` VALUES ('2782', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114208', '1');
INSERT INTO `station_status` VALUES ('2783', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114291', '1');
INSERT INTO `station_status` VALUES ('2784', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114333', '1');
INSERT INTO `station_status` VALUES ('2785', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114416', '1');
INSERT INTO `station_status` VALUES ('2786', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114458', '1');
INSERT INTO `station_status` VALUES ('2787', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114541', '1');
INSERT INTO `station_status` VALUES ('2788', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114585', '1');
INSERT INTO `station_status` VALUES ('2789', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114668', '1');
INSERT INTO `station_status` VALUES ('2790', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114710', '1');
INSERT INTO `station_status` VALUES ('2791', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114752', '1');
INSERT INTO `station_status` VALUES ('2792', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114835', '1');
INSERT INTO `station_status` VALUES ('2793', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114877', '1');
INSERT INTO `station_status` VALUES ('2794', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431114960', '1');
INSERT INTO `station_status` VALUES ('2795', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115002', '1');
INSERT INTO `station_status` VALUES ('2796', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115085', '1');
INSERT INTO `station_status` VALUES ('2797', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115127', '1');
INSERT INTO `station_status` VALUES ('2798', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115170', '1');
INSERT INTO `station_status` VALUES ('2799', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115253', '1');
INSERT INTO `station_status` VALUES ('2800', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115295', '1');
INSERT INTO `station_status` VALUES ('2801', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115378', '1');
INSERT INTO `station_status` VALUES ('2802', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115420', '1');
INSERT INTO `station_status` VALUES ('2803', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115502', '1');
INSERT INTO `station_status` VALUES ('2804', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115544', '1');
INSERT INTO `station_status` VALUES ('2805', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115628', '1');
INSERT INTO `station_status` VALUES ('2806', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115670', '1');
INSERT INTO `station_status` VALUES ('2807', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115712', '1');
INSERT INTO `station_status` VALUES ('2808', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115795', '1');
INSERT INTO `station_status` VALUES ('2809', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115837', '1');
INSERT INTO `station_status` VALUES ('2810', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115920', '1');
INSERT INTO `station_status` VALUES ('2811', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431115962', '1');
INSERT INTO `station_status` VALUES ('2812', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116045', '1');
INSERT INTO `station_status` VALUES ('2813', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116087', '1');
INSERT INTO `station_status` VALUES ('2814', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116129', '1');
INSERT INTO `station_status` VALUES ('2815', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116213', '1');
INSERT INTO `station_status` VALUES ('2816', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116256', '1');
INSERT INTO `station_status` VALUES ('2817', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116338', '1');
INSERT INTO `station_status` VALUES ('2818', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116380', '1');
INSERT INTO `station_status` VALUES ('2819', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116463', '1');
INSERT INTO `station_status` VALUES ('2820', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116505', '1');
INSERT INTO `station_status` VALUES ('2821', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116588', '1');
INSERT INTO `station_status` VALUES ('2822', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116630', '1');
INSERT INTO `station_status` VALUES ('2823', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116672', '1');
INSERT INTO `station_status` VALUES ('2824', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116755', '1');
INSERT INTO `station_status` VALUES ('2825', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116798', '1');
INSERT INTO `station_status` VALUES ('2826', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116880', '1');
INSERT INTO `station_status` VALUES ('2827', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431116923', '1');
INSERT INTO `station_status` VALUES ('2828', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117006', '1');
INSERT INTO `station_status` VALUES ('2829', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117048', '1');
INSERT INTO `station_status` VALUES ('2830', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117090', '1');
INSERT INTO `station_status` VALUES ('2831', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117173', '1');
INSERT INTO `station_status` VALUES ('2832', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117215', '1');
INSERT INTO `station_status` VALUES ('2833', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117297', '1');
INSERT INTO `station_status` VALUES ('2834', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117340', '1');
INSERT INTO `station_status` VALUES ('2835', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117423', '1');
INSERT INTO `station_status` VALUES ('2836', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117465', '1');
INSERT INTO `station_status` VALUES ('2837', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117548', '1');
INSERT INTO `station_status` VALUES ('2838', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117591', '1');
INSERT INTO `station_status` VALUES ('2839', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117633', '1');
INSERT INTO `station_status` VALUES ('2840', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117840', '1');
INSERT INTO `station_status` VALUES ('2841', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117890', '1');
INSERT INTO `station_status` VALUES ('2842', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117940', '1');
INSERT INTO `station_status` VALUES ('2843', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431117992', '1');
INSERT INTO `station_status` VALUES ('2844', '13', '533db2&ECAPRO&status&DISARM&8&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118083', '1');
INSERT INTO `station_status` VALUES ('2845', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118135', '1');
INSERT INTO `station_status` VALUES ('2846', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118184', '1');
INSERT INTO `station_status` VALUES ('2847', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118235', '1');
INSERT INTO `station_status` VALUES ('2848', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118327', '1');
INSERT INTO `station_status` VALUES ('2849', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118377', '1');
INSERT INTO `station_status` VALUES ('2850', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118428', '1');
INSERT INTO `station_status` VALUES ('2851', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118478', '1');
INSERT INTO `station_status` VALUES ('2852', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118734', '1');
INSERT INTO `station_status` VALUES ('2853', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118784', '1');
INSERT INTO `station_status` VALUES ('2854', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118835', '1');
INSERT INTO `station_status` VALUES ('2855', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118926', '1');
INSERT INTO `station_status` VALUES ('2856', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431118976', '1');
INSERT INTO `station_status` VALUES ('2857', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119152', '1');
INSERT INTO `station_status` VALUES ('2858', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119400', '1');
INSERT INTO `station_status` VALUES ('2859', '13', '533db2&ECAPRO&status&DISARM&8&2&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119525', '1');
INSERT INTO `station_status` VALUES ('2860', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119586', '1');
INSERT INTO `station_status` VALUES ('2861', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119637', '1');
INSERT INTO `station_status` VALUES ('2862', '13', '533db2&ECAPRO&status&DISARM&8&3&33&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119680', '1');
INSERT INTO `station_status` VALUES ('2863', '13', '533db2&ECAPRO&status&DISARM&8&3&33&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119771', '1');
INSERT INTO `station_status` VALUES ('2864', '13', '533db2&ECAPRO&status&DISARM&8&1&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119813', '1');
INSERT INTO `station_status` VALUES ('2865', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119863', '1');
INSERT INTO `station_status` VALUES ('2866', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431119914', '1');
INSERT INTO `station_status` VALUES ('2867', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120006', '1');
INSERT INTO `station_status` VALUES ('2868', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120056', '1');
INSERT INTO `station_status` VALUES ('2869', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120108', '1');
INSERT INTO `station_status` VALUES ('2870', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120159', '1');
INSERT INTO `station_status` VALUES ('2871', '13', '533db2&ECAPRO&status&DISARM&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120250', '1');
INSERT INTO `station_status` VALUES ('2872', '13', '533db2&ECAPRO&status&ARMING&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120292', '1');
INSERT INTO `station_status` VALUES ('2873', '13', '533db2&ECAPRO&status&ARMING&8&0&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120343', '1');
INSERT INTO `station_status` VALUES ('2874', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120395', '1');
INSERT INTO `station_status` VALUES ('2875', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120477', '1');
INSERT INTO `station_status` VALUES ('2876', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120519', '1');
INSERT INTO `station_status` VALUES ('2877', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120602', '1');
INSERT INTO `station_status` VALUES ('2878', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120644', '1');
INSERT INTO `station_status` VALUES ('2879', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120729', '1');
INSERT INTO `station_status` VALUES ('2880', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120772', '1');
INSERT INTO `station_status` VALUES ('2881', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120815', '1');
INSERT INTO `station_status` VALUES ('2882', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120897', '1');
INSERT INTO `station_status` VALUES ('2883', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431120939', '1');
INSERT INTO `station_status` VALUES ('2884', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121022', '1');
INSERT INTO `station_status` VALUES ('2885', '13', '533db2&ECAPRO&status&ARMING&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121064', '1');
INSERT INTO `station_status` VALUES ('2886', '13', '533db2&ECAPRO&status&DISARM&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121147', '1');
INSERT INTO `station_status` VALUES ('2887', '13', '533db2&ECAPRO&status&DISARM&8&32&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121190', '1');
INSERT INTO `station_status` VALUES ('2888', '13', '533db2&ECAPRO&status&DISARM&8&40&35&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121273', '1');
INSERT INTO `station_status` VALUES ('2889', '13', '533db2&ECAPRO&status&DISARM&8&40&39&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121316', '1');
INSERT INTO `station_status` VALUES ('2890', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121361', '1');
INSERT INTO `station_status` VALUES ('2891', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121448', '1');
INSERT INTO `station_status` VALUES ('2892', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121492', '1');
INSERT INTO `station_status` VALUES ('2893', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121536', '1');
INSERT INTO `station_status` VALUES ('2894', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121623', '1');
INSERT INTO `station_status` VALUES ('2895', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121667', '1');
INSERT INTO `station_status` VALUES ('2896', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121754', '1');
INSERT INTO `station_status` VALUES ('2897', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121798', '1');
INSERT INTO `station_status` VALUES ('2898', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121842', '1');
INSERT INTO `station_status` VALUES ('2899', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121930', '1');
INSERT INTO `station_status` VALUES ('2900', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431121974', '1');
INSERT INTO `station_status` VALUES ('2901', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122018', '1');
INSERT INTO `station_status` VALUES ('2902', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122105', '1');
INSERT INTO `station_status` VALUES ('2903', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122149', '1');
INSERT INTO `station_status` VALUES ('2904', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122236', '1');
INSERT INTO `station_status` VALUES ('2905', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122280', '1');
INSERT INTO `station_status` VALUES ('2906', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122325', '1');
INSERT INTO `station_status` VALUES ('2907', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122412', '1');
INSERT INTO `station_status` VALUES ('2908', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122457', '1');
INSERT INTO `station_status` VALUES ('2909', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122503', '1');
INSERT INTO `station_status` VALUES ('2910', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122589', '1');
INSERT INTO `station_status` VALUES ('2911', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122634', '1');
INSERT INTO `station_status` VALUES ('2912', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122678', '1');
INSERT INTO `station_status` VALUES ('2913', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122764', '1');
INSERT INTO `station_status` VALUES ('2914', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122809', '1');
INSERT INTO `station_status` VALUES ('2915', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122895', '1');
INSERT INTO `station_status` VALUES ('2916', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122940', '1');
INSERT INTO `station_status` VALUES ('2917', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431122986', '1');
INSERT INTO `station_status` VALUES ('2918', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123073', '1');
INSERT INTO `station_status` VALUES ('2919', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123118', '1');
INSERT INTO `station_status` VALUES ('2920', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123162', '1');
INSERT INTO `station_status` VALUES ('2921', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123249', '1');
INSERT INTO `station_status` VALUES ('2922', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123293', '1');
INSERT INTO `station_status` VALUES ('2923', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123337', '1');
INSERT INTO `station_status` VALUES ('2924', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123424', '1');
INSERT INTO `station_status` VALUES ('2925', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123468', '1');
INSERT INTO `station_status` VALUES ('2926', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123555', '1');
INSERT INTO `station_status` VALUES ('2927', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123599', '1');
INSERT INTO `station_status` VALUES ('2928', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123643', '1');
INSERT INTO `station_status` VALUES ('2929', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123731', '1');
INSERT INTO `station_status` VALUES ('2930', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123775', '1');
INSERT INTO `station_status` VALUES ('2931', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123819', '1');
INSERT INTO `station_status` VALUES ('2932', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123906', '1');
INSERT INTO `station_status` VALUES ('2933', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123950', '1');
INSERT INTO `station_status` VALUES ('2934', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431123994', '1');
INSERT INTO `station_status` VALUES ('2935', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124080', '1');
INSERT INTO `station_status` VALUES ('2936', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124124', '1');
INSERT INTO `station_status` VALUES ('2937', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124211', '1');
INSERT INTO `station_status` VALUES ('2938', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124255', '1');
INSERT INTO `station_status` VALUES ('2939', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124301', '1');
INSERT INTO `station_status` VALUES ('2940', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124389', '1');
INSERT INTO `station_status` VALUES ('2941', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124433', '1');
INSERT INTO `station_status` VALUES ('2942', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124477', '1');
INSERT INTO `station_status` VALUES ('2943', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124563', '1');
INSERT INTO `station_status` VALUES ('2944', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124607', '1');
INSERT INTO `station_status` VALUES ('2945', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124694', '1');
INSERT INTO `station_status` VALUES ('2946', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124738', '1');
INSERT INTO `station_status` VALUES ('2947', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124782', '1');
INSERT INTO `station_status` VALUES ('2948', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124869', '1');
INSERT INTO `station_status` VALUES ('2949', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124914', '1');
INSERT INTO `station_status` VALUES ('2950', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431124958', '1');
INSERT INTO `station_status` VALUES ('2951', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125044', '1');
INSERT INTO `station_status` VALUES ('2952', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125088', '1');
INSERT INTO `station_status` VALUES ('2953', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125175', '1');
INSERT INTO `station_status` VALUES ('2954', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125220', '1');
INSERT INTO `station_status` VALUES ('2955', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125264', '1');
INSERT INTO `station_status` VALUES ('2956', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125350', '1');
INSERT INTO `station_status` VALUES ('2957', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125394', '1');
INSERT INTO `station_status` VALUES ('2958', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125439', '1');
INSERT INTO `station_status` VALUES ('2959', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125526', '1');
INSERT INTO `station_status` VALUES ('2960', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125571', '1');
INSERT INTO `station_status` VALUES ('2961', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125615', '1');
INSERT INTO `station_status` VALUES ('2962', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125701', '1');
INSERT INTO `station_status` VALUES ('2963', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125746', '1');
INSERT INTO `station_status` VALUES ('2964', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125833', '1');
INSERT INTO `station_status` VALUES ('2965', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125876', '1');
INSERT INTO `station_status` VALUES ('2966', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431125920', '1');
INSERT INTO `station_status` VALUES ('2967', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126007', '1');
INSERT INTO `station_status` VALUES ('2968', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126051', '1');
INSERT INTO `station_status` VALUES ('2969', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126096', '1');
INSERT INTO `station_status` VALUES ('2970', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126183', '1');
INSERT INTO `station_status` VALUES ('2971', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126227', '1');
INSERT INTO `station_status` VALUES ('2972', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126314', '1');
INSERT INTO `station_status` VALUES ('2973', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126358', '1');
INSERT INTO `station_status` VALUES ('2974', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126402', '1');
INSERT INTO `station_status` VALUES ('2975', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126488', '1');
INSERT INTO `station_status` VALUES ('2976', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126532', '1');
INSERT INTO `station_status` VALUES ('2977', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126576', '1');
INSERT INTO `station_status` VALUES ('2978', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126663', '1');
INSERT INTO `station_status` VALUES ('2979', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126709', '1');
INSERT INTO `station_status` VALUES ('2980', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126796', '1');
INSERT INTO `station_status` VALUES ('2981', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126840', '1');
INSERT INTO `station_status` VALUES ('2982', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126884', '1');
INSERT INTO `station_status` VALUES ('2983', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431126970', '1');
INSERT INTO `station_status` VALUES ('2984', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127014', '1');
INSERT INTO `station_status` VALUES ('2985', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127058', '1');
INSERT INTO `station_status` VALUES ('2986', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127145', '1');
INSERT INTO `station_status` VALUES ('2987', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127189', '1');
INSERT INTO `station_status` VALUES ('2988', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127276', '1');
INSERT INTO `station_status` VALUES ('2989', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127321', '1');
INSERT INTO `station_status` VALUES ('2990', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127365', '1');
INSERT INTO `station_status` VALUES ('2991', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127451', '1');
INSERT INTO `station_status` VALUES ('2992', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127495', '1');
INSERT INTO `station_status` VALUES ('2993', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127540', '1');
INSERT INTO `station_status` VALUES ('2994', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127626', '1');
INSERT INTO `station_status` VALUES ('2995', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127670', '1');
INSERT INTO `station_status` VALUES ('2996', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127714', '1');
INSERT INTO `station_status` VALUES ('2997', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127801', '1');
INSERT INTO `station_status` VALUES ('2998', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127845', '1');
INSERT INTO `station_status` VALUES ('2999', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127933', '1');
INSERT INTO `station_status` VALUES ('3000', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431127977', '1');
INSERT INTO `station_status` VALUES ('3001', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128021', '1');
INSERT INTO `station_status` VALUES ('3002', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128107', '1');
INSERT INTO `station_status` VALUES ('3003', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128151', '1');
INSERT INTO `station_status` VALUES ('3004', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128195', '1');
INSERT INTO `station_status` VALUES ('3005', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128282', '1');
INSERT INTO `station_status` VALUES ('3006', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128326', '1');
INSERT INTO `station_status` VALUES ('3007', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128413', '1');
INSERT INTO `station_status` VALUES ('3008', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128458', '1');
INSERT INTO `station_status` VALUES ('3009', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128504', '1');
INSERT INTO `station_status` VALUES ('3010', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128590', '1');
INSERT INTO `station_status` VALUES ('3011', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128634', '1');
INSERT INTO `station_status` VALUES ('3012', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128678', '1');
INSERT INTO `station_status` VALUES ('3013', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128765', '1');
INSERT INTO `station_status` VALUES ('3014', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128809', '1');
INSERT INTO `station_status` VALUES ('3015', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128896', '1');
INSERT INTO `station_status` VALUES ('3016', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128940', '1');
INSERT INTO `station_status` VALUES ('3017', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431128984', '1');
INSERT INTO `station_status` VALUES ('3018', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129070', '1');
INSERT INTO `station_status` VALUES ('3019', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129115', '1');
INSERT INTO `station_status` VALUES ('3020', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129159', '1');
INSERT INTO `station_status` VALUES ('3021', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129246', '1');
INSERT INTO `station_status` VALUES ('3022', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129290', '1');
INSERT INTO `station_status` VALUES ('3023', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129334', '1');
INSERT INTO `station_status` VALUES ('3024', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129421', '1');
INSERT INTO `station_status` VALUES ('3025', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129465', '1');
INSERT INTO `station_status` VALUES ('3026', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129552', '1');
INSERT INTO `station_status` VALUES ('3027', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129596', '1');
INSERT INTO `station_status` VALUES ('3028', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129640', '1');
INSERT INTO `station_status` VALUES ('3029', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129729', '1');
INSERT INTO `station_status` VALUES ('3030', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129773', '1');
INSERT INTO `station_status` VALUES ('3031', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129817', '1');
INSERT INTO `station_status` VALUES ('3032', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129904', '1');
INSERT INTO `station_status` VALUES ('3033', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431129949', '1');
INSERT INTO `station_status` VALUES ('3034', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130035', '1');
INSERT INTO `station_status` VALUES ('3035', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130079', '1');
INSERT INTO `station_status` VALUES ('3036', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130123', '1');
INSERT INTO `station_status` VALUES ('3037', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130210', '1');
INSERT INTO `station_status` VALUES ('3038', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130254', '1');
INSERT INTO `station_status` VALUES ('3039', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130299', '1');
INSERT INTO `station_status` VALUES ('3040', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130386', '1');
INSERT INTO `station_status` VALUES ('3041', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130430', '1');
INSERT INTO `station_status` VALUES ('3042', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130474', '1');
INSERT INTO `station_status` VALUES ('3043', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130561', '1');
INSERT INTO `station_status` VALUES ('3044', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130605', '1');
INSERT INTO `station_status` VALUES ('3045', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130692', '1');
INSERT INTO `station_status` VALUES ('3046', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130736', '1');
INSERT INTO `station_status` VALUES ('3047', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130780', '1');
INSERT INTO `station_status` VALUES ('3048', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130867', '1');
INSERT INTO `station_status` VALUES ('3049', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130912', '1');
INSERT INTO `station_status` VALUES ('3050', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431130957', '1');
INSERT INTO `station_status` VALUES ('3051', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131044', '1');
INSERT INTO `station_status` VALUES ('3052', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131088', '1');
INSERT INTO `station_status` VALUES ('3053', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131175', '1');
INSERT INTO `station_status` VALUES ('3054', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131219', '1');
INSERT INTO `station_status` VALUES ('3055', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131263', '1');
INSERT INTO `station_status` VALUES ('3056', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131350', '1');
INSERT INTO `station_status` VALUES ('3057', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131394', '1');
INSERT INTO `station_status` VALUES ('3058', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131438', '1');
INSERT INTO `station_status` VALUES ('3059', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131526', '1');
INSERT INTO `station_status` VALUES ('3060', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131570', '1');
INSERT INTO `station_status` VALUES ('3061', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131614', '1');
INSERT INTO `station_status` VALUES ('3062', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131700', '1');
INSERT INTO `station_status` VALUES ('3063', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131744', '1');
INSERT INTO `station_status` VALUES ('3064', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131831', '1');
INSERT INTO `station_status` VALUES ('3065', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131875', '1');
INSERT INTO `station_status` VALUES ('3066', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431131919', '1');
INSERT INTO `station_status` VALUES ('3067', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132006', '1');
INSERT INTO `station_status` VALUES ('3068', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132050', '1');
INSERT INTO `station_status` VALUES ('3069', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132095', '1');
INSERT INTO `station_status` VALUES ('3070', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132182', '1');
INSERT INTO `station_status` VALUES ('3071', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132226', '1');
INSERT INTO `station_status` VALUES ('3072', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132312', '1');
INSERT INTO `station_status` VALUES ('3073', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132356', '1');
INSERT INTO `station_status` VALUES ('3074', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132400', '1');
INSERT INTO `station_status` VALUES ('3075', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132487', '1');
INSERT INTO `station_status` VALUES ('3076', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132531', '1');
INSERT INTO `station_status` VALUES ('3077', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132575', '1');
INSERT INTO `station_status` VALUES ('3078', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132662', '1');
INSERT INTO `station_status` VALUES ('3079', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132708', '1');
INSERT INTO `station_status` VALUES ('3080', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132795', '1');
INSERT INTO `station_status` VALUES ('3081', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132839', '1');
INSERT INTO `station_status` VALUES ('3082', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132883', '1');
INSERT INTO `station_status` VALUES ('3083', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431132970', '1');
INSERT INTO `station_status` VALUES ('3084', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133014', '1');
INSERT INTO `station_status` VALUES ('3085', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133058', '1');
INSERT INTO `station_status` VALUES ('3086', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133144', '1');
INSERT INTO `station_status` VALUES ('3087', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133189', '1');
INSERT INTO `station_status` VALUES ('3088', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133275', '1');
INSERT INTO `station_status` VALUES ('3089', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133321', '1');
INSERT INTO `station_status` VALUES ('3090', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133365', '1');
INSERT INTO `station_status` VALUES ('3091', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133452', '1');
INSERT INTO `station_status` VALUES ('3092', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133496', '1');
INSERT INTO `station_status` VALUES ('3093', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133540', '1');
INSERT INTO `station_status` VALUES ('3094', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133626', '1');
INSERT INTO `station_status` VALUES ('3095', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133670', '1');
INSERT INTO `station_status` VALUES ('3096', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133715', '1');
INSERT INTO `station_status` VALUES ('3097', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133801', '1');
INSERT INTO `station_status` VALUES ('3098', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133846', '1');
INSERT INTO `station_status` VALUES ('3099', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133933', '1');
INSERT INTO `station_status` VALUES ('3100', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431133977', '1');
INSERT INTO `station_status` VALUES ('3101', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134021', '1');
INSERT INTO `station_status` VALUES ('3102', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134108', '1');
INSERT INTO `station_status` VALUES ('3103', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134152', '1');
INSERT INTO `station_status` VALUES ('3104', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134197', '1');
INSERT INTO `station_status` VALUES ('3105', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134283', '1');
INSERT INTO `station_status` VALUES ('3106', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134328', '1');
INSERT INTO `station_status` VALUES ('3107', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134415', '1');
INSERT INTO `station_status` VALUES ('3108', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134459', '1');
INSERT INTO `station_status` VALUES ('3109', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134503', '1');
INSERT INTO `station_status` VALUES ('3110', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134590', '1');
INSERT INTO `station_status` VALUES ('3111', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134634', '1');
INSERT INTO `station_status` VALUES ('3112', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134678', '1');
INSERT INTO `station_status` VALUES ('3113', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134765', '1');
INSERT INTO `station_status` VALUES ('3114', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134810', '1');
INSERT INTO `station_status` VALUES ('3115', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134854', '1');
INSERT INTO `station_status` VALUES ('3116', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134940', '1');
INSERT INTO `station_status` VALUES ('3117', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431134984', '1');
INSERT INTO `station_status` VALUES ('3118', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135071', '1');
INSERT INTO `station_status` VALUES ('3119', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135117', '1');
INSERT INTO `station_status` VALUES ('3120', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135161', '1');
INSERT INTO `station_status` VALUES ('3121', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135248', '1');
INSERT INTO `station_status` VALUES ('3122', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135292', '1');
INSERT INTO `station_status` VALUES ('3123', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135336', '1');
INSERT INTO `station_status` VALUES ('3124', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135423', '1');
INSERT INTO `station_status` VALUES ('3125', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135467', '1');
INSERT INTO `station_status` VALUES ('3126', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135554', '1');
INSERT INTO `station_status` VALUES ('3127', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135598', '1');
INSERT INTO `station_status` VALUES ('3128', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135642', '1');
INSERT INTO `station_status` VALUES ('3129', '13', '533db2&ECAPRO&status&DISARM&8&0&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135730', '1');
INSERT INTO `station_status` VALUES ('3130', '13', '533db2&ECAPRO&status&DISARM&8&1&255&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135774', '1');
INSERT INTO `station_status` VALUES ('3131', '13', '533db2&ECAPRO&status&ARMING&8&0&254&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135818', '1');
INSERT INTO `station_status` VALUES ('3132', '13', '533db2&ECAPRO&status&ARMING&8&0&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135905', '1');
INSERT INTO `station_status` VALUES ('3133', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431135949', '1');
INSERT INTO `station_status` VALUES ('3134', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136036', '1');
INSERT INTO `station_status` VALUES ('3135', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136080', '1');
INSERT INTO `station_status` VALUES ('3136', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136124', '1');
INSERT INTO `station_status` VALUES ('3137', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136212', '1');
INSERT INTO `station_status` VALUES ('3138', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136256', '1');
INSERT INTO `station_status` VALUES ('3139', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136300', '1');
INSERT INTO `station_status` VALUES ('3140', '13', '533db2&ECAPRO&status&ARMING&8&33&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136387', '1');
INSERT INTO `station_status` VALUES ('3141', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136432', '1');
INSERT INTO `station_status` VALUES ('3142', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136476', '1');
INSERT INTO `station_status` VALUES ('3143', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136563', '1');
INSERT INTO `station_status` VALUES ('3144', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136607', '1');
INSERT INTO `station_status` VALUES ('3145', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136693', '1');
INSERT INTO `station_status` VALUES ('3146', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136737', '1');
INSERT INTO `station_status` VALUES ('3147', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136782', '1');
INSERT INTO `station_status` VALUES ('3148', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136869', '1');
INSERT INTO `station_status` VALUES ('3149', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136914', '1');
INSERT INTO `station_status` VALUES ('3150', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431136958', '1');
INSERT INTO `station_status` VALUES ('3151', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137045', '1');
INSERT INTO `station_status` VALUES ('3152', '13', '533db2&ECAPRO&status&ARMING&8&9&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137089', '1');
INSERT INTO `station_status` VALUES ('3153', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137176', '1');
INSERT INTO `station_status` VALUES ('3154', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137220', '1');
INSERT INTO `station_status` VALUES ('3155', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137264', '1');
INSERT INTO `station_status` VALUES ('3156', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137351', '1');
INSERT INTO `station_status` VALUES ('3157', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137395', '1');
INSERT INTO `station_status` VALUES ('3158', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137439', '1');
INSERT INTO `station_status` VALUES ('3159', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137526', '1');
INSERT INTO `station_status` VALUES ('3160', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137570', '1');
INSERT INTO `station_status` VALUES ('3161', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137615', '1');
INSERT INTO `station_status` VALUES ('3162', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137702', '1');
INSERT INTO `station_status` VALUES ('3163', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137746', '1');
INSERT INTO `station_status` VALUES ('3164', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137832', '1');
INSERT INTO `station_status` VALUES ('3165', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137877', '1');
INSERT INTO `station_status` VALUES ('3166', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431137920', '1');
INSERT INTO `station_status` VALUES ('3167', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138007', '1');
INSERT INTO `station_status` VALUES ('3168', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138051', '1');
INSERT INTO `station_status` VALUES ('3169', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138096', '1');
INSERT INTO `station_status` VALUES ('3170', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138183', '1');
INSERT INTO `station_status` VALUES ('3171', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138228', '1');
INSERT INTO `station_status` VALUES ('3172', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138314', '1');
INSERT INTO `station_status` VALUES ('3173', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138358', '1');
INSERT INTO `station_status` VALUES ('3174', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138402', '1');
INSERT INTO `station_status` VALUES ('3175', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138489', '1');
INSERT INTO `station_status` VALUES ('3176', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138533', '1');
INSERT INTO `station_status` VALUES ('3177', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138577', '1');
INSERT INTO `station_status` VALUES ('3178', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138664', '1');
INSERT INTO `station_status` VALUES ('3179', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138709', '1');
INSERT INTO `station_status` VALUES ('3180', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138796', '1');
INSERT INTO `station_status` VALUES ('3181', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138840', '1');
INSERT INTO `station_status` VALUES ('3182', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138884', '1');
INSERT INTO `station_status` VALUES ('3183', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431138970', '1');
INSERT INTO `station_status` VALUES ('3184', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139015', '1');
INSERT INTO `station_status` VALUES ('3185', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139059', '1');
INSERT INTO `station_status` VALUES ('3186', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139146', '1');
INSERT INTO `station_status` VALUES ('3187', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139190', '1');
INSERT INTO `station_status` VALUES ('3188', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139234', '1');
INSERT INTO `station_status` VALUES ('3189', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139322', '1');
INSERT INTO `station_status` VALUES ('3190', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139367', '1');
INSERT INTO `station_status` VALUES ('3191', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139454', '1');
INSERT INTO `station_status` VALUES ('3192', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139498', '1');
INSERT INTO `station_status` VALUES ('3193', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139542', '1');
INSERT INTO `station_status` VALUES ('3194', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139629', '1');
INSERT INTO `station_status` VALUES ('3195', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139673', '1');
INSERT INTO `station_status` VALUES ('3196', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139717', '1');
INSERT INTO `station_status` VALUES ('3197', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139804', '1');
INSERT INTO `station_status` VALUES ('3198', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139848', '1');
INSERT INTO `station_status` VALUES ('3199', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139936', '1');
INSERT INTO `station_status` VALUES ('3200', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431139980', '1');
INSERT INTO `station_status` VALUES ('3201', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140024', '1');
INSERT INTO `station_status` VALUES ('3202', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140112', '1');
INSERT INTO `station_status` VALUES ('3203', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140156', '1');
INSERT INTO `station_status` VALUES ('3204', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140200', '1');
INSERT INTO `station_status` VALUES ('3205', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140286', '1');
INSERT INTO `station_status` VALUES ('3206', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140330', '1');
INSERT INTO `station_status` VALUES ('3207', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140374', '1');
INSERT INTO `station_status` VALUES ('3208', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140461', '1');
INSERT INTO `station_status` VALUES ('3209', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140506', '1');
INSERT INTO `station_status` VALUES ('3210', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140593', '1');
INSERT INTO `station_status` VALUES ('3211', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140638', '1');
INSERT INTO `station_status` VALUES ('3212', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140682', '1');
INSERT INTO `station_status` VALUES ('3213', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140768', '1');
INSERT INTO `station_status` VALUES ('3214', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140812', '1');
INSERT INTO `station_status` VALUES ('3215', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140857', '1');
INSERT INTO `station_status` VALUES ('3216', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140943', '1');
INSERT INTO `station_status` VALUES ('3217', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431140988', '1');
INSERT INTO `station_status` VALUES ('3218', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141075', '1');
INSERT INTO `station_status` VALUES ('3219', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141120', '1');
INSERT INTO `station_status` VALUES ('3220', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141164', '1');
INSERT INTO `station_status` VALUES ('3221', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141251', '1');
INSERT INTO `station_status` VALUES ('3222', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141295', '1');
INSERT INTO `station_status` VALUES ('3223', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141339', '1');
INSERT INTO `station_status` VALUES ('3224', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141426', '1');
INSERT INTO `station_status` VALUES ('3225', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141470', '1');
INSERT INTO `station_status` VALUES ('3226', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141514', '1');
INSERT INTO `station_status` VALUES ('3227', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141601', '1');
INSERT INTO `station_status` VALUES ('3228', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141644', '1');
INSERT INTO `station_status` VALUES ('3229', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141733', '1');
INSERT INTO `station_status` VALUES ('3230', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141776', '1');
INSERT INTO `station_status` VALUES ('3231', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141820', '1');
INSERT INTO `station_status` VALUES ('3232', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141907', '1');
INSERT INTO `station_status` VALUES ('3233', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141951', '1');
INSERT INTO `station_status` VALUES ('3234', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431141994', '1');
INSERT INTO `station_status` VALUES ('3235', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142081', '1');
INSERT INTO `station_status` VALUES ('3236', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142125', '1');
INSERT INTO `station_status` VALUES ('3237', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142212', '1');
INSERT INTO `station_status` VALUES ('3238', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142256', '1');
INSERT INTO `station_status` VALUES ('3239', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142301', '1');
INSERT INTO `station_status` VALUES ('3240', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142388', '1');
INSERT INTO `station_status` VALUES ('3241', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142432', '1');
INSERT INTO `station_status` VALUES ('3242', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142476', '1');
INSERT INTO `station_status` VALUES ('3243', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142563', '1');
INSERT INTO `station_status` VALUES ('3244', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142607', '1');
INSERT INTO `station_status` VALUES ('3245', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142694', '1');
INSERT INTO `station_status` VALUES ('3246', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142738', '1');
INSERT INTO `station_status` VALUES ('3247', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142782', '1');
INSERT INTO `station_status` VALUES ('3248', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142869', '1');
INSERT INTO `station_status` VALUES ('3249', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142914', '1');
INSERT INTO `station_status` VALUES ('3250', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431142958', '1');
INSERT INTO `station_status` VALUES ('3251', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143044', '1');
INSERT INTO `station_status` VALUES ('3252', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143088', '1');
INSERT INTO `station_status` VALUES ('3253', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143175', '1');
INSERT INTO `station_status` VALUES ('3254', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143219', '1');
INSERT INTO `station_status` VALUES ('3255', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143263', '1');
INSERT INTO `station_status` VALUES ('3256', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143350', '1');
INSERT INTO `station_status` VALUES ('3257', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143394', '1');
INSERT INTO `station_status` VALUES ('3258', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143438', '1');
INSERT INTO `station_status` VALUES ('3259', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143526', '1');
INSERT INTO `station_status` VALUES ('3260', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143570', '1');
INSERT INTO `station_status` VALUES ('3261', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143614', '1');
INSERT INTO `station_status` VALUES ('3262', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143701', '1');
INSERT INTO `station_status` VALUES ('3263', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143745', '1');
INSERT INTO `station_status` VALUES ('3264', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143833', '1');
INSERT INTO `station_status` VALUES ('3265', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143877', '1');
INSERT INTO `station_status` VALUES ('3266', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431143921', '1');
INSERT INTO `station_status` VALUES ('3267', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144008', '1');
INSERT INTO `station_status` VALUES ('3268', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144052', '1');
INSERT INTO `station_status` VALUES ('3269', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144098', '1');
INSERT INTO `station_status` VALUES ('3270', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144185', '1');
INSERT INTO `station_status` VALUES ('3271', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144229', '1');
INSERT INTO `station_status` VALUES ('3272', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144316', '1');
INSERT INTO `station_status` VALUES ('3273', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144360', '1');
INSERT INTO `station_status` VALUES ('3274', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144404', '1');
INSERT INTO `station_status` VALUES ('3275', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144490', '1');
INSERT INTO `station_status` VALUES ('3276', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144534', '1');
INSERT INTO `station_status` VALUES ('3277', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144578', '1');
INSERT INTO `station_status` VALUES ('3278', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144665', '1');
INSERT INTO `station_status` VALUES ('3279', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144711', '1');
INSERT INTO `station_status` VALUES ('3280', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144755', '1');
INSERT INTO `station_status` VALUES ('3281', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144842', '1');
INSERT INTO `station_status` VALUES ('3282', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144886', '1');
INSERT INTO `station_status` VALUES ('3283', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431144973', '1');
INSERT INTO `station_status` VALUES ('3284', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145017', '1');
INSERT INTO `station_status` VALUES ('3285', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145061', '1');
INSERT INTO `station_status` VALUES ('3286', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145148', '1');
INSERT INTO `station_status` VALUES ('3287', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145192', '1');
INSERT INTO `station_status` VALUES ('3288', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145236', '1');
INSERT INTO `station_status` VALUES ('3289', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145323', '1');
INSERT INTO `station_status` VALUES ('3290', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145367', '1');
INSERT INTO `station_status` VALUES ('3291', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145454', '1');
INSERT INTO `station_status` VALUES ('3292', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145498', '1');
INSERT INTO `station_status` VALUES ('3293', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145542', '1');
INSERT INTO `station_status` VALUES ('3294', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145629', '1');
INSERT INTO `station_status` VALUES ('3295', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145673', '1');
INSERT INTO `station_status` VALUES ('3296', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145717', '1');
INSERT INTO `station_status` VALUES ('3297', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145804', '1');
INSERT INTO `station_status` VALUES ('3298', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145848', '1');
INSERT INTO `station_status` VALUES ('3299', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145935', '1');
INSERT INTO `station_status` VALUES ('3300', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431145979', '1');
INSERT INTO `station_status` VALUES ('3301', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146023', '1');
INSERT INTO `station_status` VALUES ('3302', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146110', '1');
INSERT INTO `station_status` VALUES ('3303', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146153', '1');
INSERT INTO `station_status` VALUES ('3304', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146198', '1');
INSERT INTO `station_status` VALUES ('3305', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146284', '1');
INSERT INTO `station_status` VALUES ('3306', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146328', '1');
INSERT INTO `station_status` VALUES ('3307', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146415', '1');
INSERT INTO `station_status` VALUES ('3308', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146459', '1');
INSERT INTO `station_status` VALUES ('3309', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146504', '1');
INSERT INTO `station_status` VALUES ('3310', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146591', '1');
INSERT INTO `station_status` VALUES ('3311', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146635', '1');
INSERT INTO `station_status` VALUES ('3312', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146679', '1');
INSERT INTO `station_status` VALUES ('3313', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146765', '1');
INSERT INTO `station_status` VALUES ('3314', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146809', '1');
INSERT INTO `station_status` VALUES ('3315', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146853', '1');
INSERT INTO `station_status` VALUES ('3316', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146940', '1');
INSERT INTO `station_status` VALUES ('3317', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431146984', '1');
INSERT INTO `station_status` VALUES ('3318', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147071', '1');
INSERT INTO `station_status` VALUES ('3319', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147116', '1');
INSERT INTO `station_status` VALUES ('3320', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147160', '1');
INSERT INTO `station_status` VALUES ('3321', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147247', '1');
INSERT INTO `station_status` VALUES ('3322', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147291', '1');
INSERT INTO `station_status` VALUES ('3323', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147335', '1');
INSERT INTO `station_status` VALUES ('3324', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147422', '1');
INSERT INTO `station_status` VALUES ('3325', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147466', '1');
INSERT INTO `station_status` VALUES ('3326', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147553', '1');
INSERT INTO `station_status` VALUES ('3327', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147597', '1');
INSERT INTO `station_status` VALUES ('3328', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147640', '1');
INSERT INTO `station_status` VALUES ('3329', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147729', '1');
INSERT INTO `station_status` VALUES ('3330', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147773', '1');
INSERT INTO `station_status` VALUES ('3331', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147817', '1');
INSERT INTO `station_status` VALUES ('3332', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147904', '1');
INSERT INTO `station_status` VALUES ('3333', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431147948', '1');
INSERT INTO `station_status` VALUES ('3334', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148035', '1');
INSERT INTO `station_status` VALUES ('3335', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148078', '1');
INSERT INTO `station_status` VALUES ('3336', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148122', '1');
INSERT INTO `station_status` VALUES ('3337', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148209', '1');
INSERT INTO `station_status` VALUES ('3338', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148253', '1');
INSERT INTO `station_status` VALUES ('3339', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148299', '1');
INSERT INTO `station_status` VALUES ('3340', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148385', '1');
INSERT INTO `station_status` VALUES ('3341', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148430', '1');
INSERT INTO `station_status` VALUES ('3342', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148474', '1');
INSERT INTO `station_status` VALUES ('3343', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148560', '1');
INSERT INTO `station_status` VALUES ('3344', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148604', '1');
INSERT INTO `station_status` VALUES ('3345', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148691', '1');
INSERT INTO `station_status` VALUES ('3346', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148735', '1');
INSERT INTO `station_status` VALUES ('3347', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148779', '1');
INSERT INTO `station_status` VALUES ('3348', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148865', '1');
INSERT INTO `station_status` VALUES ('3349', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148911', '1');
INSERT INTO `station_status` VALUES ('3350', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431148955', '1');
INSERT INTO `station_status` VALUES ('3351', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149041', '1');
INSERT INTO `station_status` VALUES ('3352', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149085', '1');
INSERT INTO `station_status` VALUES ('3353', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149172', '1');
INSERT INTO `station_status` VALUES ('3354', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149216', '1');
INSERT INTO `station_status` VALUES ('3355', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149260', '1');
INSERT INTO `station_status` VALUES ('3356', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149347', '1');
INSERT INTO `station_status` VALUES ('3357', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149391', '1');
INSERT INTO `station_status` VALUES ('3358', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149436', '1');
INSERT INTO `station_status` VALUES ('3359', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149523', '1');
INSERT INTO `station_status` VALUES ('3360', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149567', '1');
INSERT INTO `station_status` VALUES ('3361', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149654', '1');
INSERT INTO `station_status` VALUES ('3362', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149698', '1');
INSERT INTO `station_status` VALUES ('3363', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149742', '1');
INSERT INTO `station_status` VALUES ('3364', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149829', '1');
INSERT INTO `station_status` VALUES ('3365', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149873', '1');
INSERT INTO `station_status` VALUES ('3366', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431149917', '1');
INSERT INTO `station_status` VALUES ('3367', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150003', '1');
INSERT INTO `station_status` VALUES ('3368', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150047', '1');
INSERT INTO `station_status` VALUES ('3369', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150135', '1');
INSERT INTO `station_status` VALUES ('3370', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150179', '1');
INSERT INTO `station_status` VALUES ('3371', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150223', '1');
INSERT INTO `station_status` VALUES ('3372', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150310', '1');
INSERT INTO `station_status` VALUES ('3373', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150354', '1');
INSERT INTO `station_status` VALUES ('3374', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150398', '1');
INSERT INTO `station_status` VALUES ('3375', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150485', '1');
INSERT INTO `station_status` VALUES ('3376', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150529', '1');
INSERT INTO `station_status` VALUES ('3377', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150573', '1');
INSERT INTO `station_status` VALUES ('3378', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150660', '1');
INSERT INTO `station_status` VALUES ('3379', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150705', '1');
INSERT INTO `station_status` VALUES ('3380', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150792', '1');
INSERT INTO `station_status` VALUES ('3381', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150837', '1');
INSERT INTO `station_status` VALUES ('3382', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150881', '1');
INSERT INTO `station_status` VALUES ('3383', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431150967', '1');
INSERT INTO `station_status` VALUES ('3384', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151011', '1');
INSERT INTO `station_status` VALUES ('3385', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151056', '1');
INSERT INTO `station_status` VALUES ('3386', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151143', '1');
INSERT INTO `station_status` VALUES ('3387', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151186', '1');
INSERT INTO `station_status` VALUES ('3388', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151273', '1');
INSERT INTO `station_status` VALUES ('3389', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151318', '1');
INSERT INTO `station_status` VALUES ('3390', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151362', '1');
INSERT INTO `station_status` VALUES ('3391', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151449', '1');
INSERT INTO `station_status` VALUES ('3392', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151493', '1');
INSERT INTO `station_status` VALUES ('3393', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151537', '1');
INSERT INTO `station_status` VALUES ('3394', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151623', '1');
INSERT INTO `station_status` VALUES ('3395', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151668', '1');
INSERT INTO `station_status` VALUES ('3396', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151754', '1');
INSERT INTO `station_status` VALUES ('3397', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151798', '1');
INSERT INTO `station_status` VALUES ('3398', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151842', '1');
INSERT INTO `station_status` VALUES ('3399', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151930', '1');
INSERT INTO `station_status` VALUES ('3400', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431151974', '1');
INSERT INTO `station_status` VALUES ('3401', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152018', '1');
INSERT INTO `station_status` VALUES ('3402', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152105', '1');
INSERT INTO `station_status` VALUES ('3403', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152149', '1');
INSERT INTO `station_status` VALUES ('3404', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152235', '1');
INSERT INTO `station_status` VALUES ('3405', '13', '533db2&ECAPRO&status&ARMING&8&25&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152279', '1');
INSERT INTO `station_status` VALUES ('3406', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152323', '1');
INSERT INTO `station_status` VALUES ('3407', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152410', '1');
INSERT INTO `station_status` VALUES ('3408', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152454', '1');
INSERT INTO `station_status` VALUES ('3409', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152500', '1');
INSERT INTO `station_status` VALUES ('3410', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152587', '1');
INSERT INTO `station_status` VALUES ('3411', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152631', '1');
INSERT INTO `station_status` VALUES ('3412', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152675', '1');
INSERT INTO `station_status` VALUES ('3413', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152762', '1');
INSERT INTO `station_status` VALUES ('3414', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152806', '1');
INSERT INTO `station_status` VALUES ('3415', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152893', '1');
INSERT INTO `station_status` VALUES ('3416', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152936', '1');
INSERT INTO `station_status` VALUES ('3417', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431152980', '1');
INSERT INTO `station_status` VALUES ('3418', '13', '533db2&ECAPRO&status&ARMING&8&26&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153067', '1');
INSERT INTO `station_status` VALUES ('3419', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153113', '1');
INSERT INTO `station_status` VALUES ('3420', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153157', '1');
INSERT INTO `station_status` VALUES ('3421', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153244', '1');
INSERT INTO `station_status` VALUES ('3422', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153287', '1');
INSERT INTO `station_status` VALUES ('3423', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153374', '1');
INSERT INTO `station_status` VALUES ('3424', '13', '533db2&ECAPRO&status&ARMING&8&58&252&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153419', '1');
INSERT INTO `station_status` VALUES ('3425', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153463', '1');
INSERT INTO `station_status` VALUES ('3426', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153550', '1');
INSERT INTO `station_status` VALUES ('3427', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153594', '1');
INSERT INTO `station_status` VALUES ('3428', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153638', '1');
INSERT INTO `station_status` VALUES ('3429', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153726', '1');
INSERT INTO `station_status` VALUES ('3430', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153770', '1');
INSERT INTO `station_status` VALUES ('3431', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153814', '1');
INSERT INTO `station_status` VALUES ('3432', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153901', '1');
INSERT INTO `station_status` VALUES ('3433', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431153945', '1');
INSERT INTO `station_status` VALUES ('3434', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154032', '1');
INSERT INTO `station_status` VALUES ('3435', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154076', '1');
INSERT INTO `station_status` VALUES ('3436', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154120', '1');
INSERT INTO `station_status` VALUES ('3437', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154207', '1');
INSERT INTO `station_status` VALUES ('3438', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154251', '1');
INSERT INTO `station_status` VALUES ('3439', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154296', '1');
INSERT INTO `station_status` VALUES ('3440', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154383', '1');
INSERT INTO `station_status` VALUES ('3441', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154427', '1');
INSERT INTO `station_status` VALUES ('3442', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154513', '1');
INSERT INTO `station_status` VALUES ('3443', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154558', '1');
INSERT INTO `station_status` VALUES ('3444', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154602', '1');
INSERT INTO `station_status` VALUES ('3445', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154688', '1');
INSERT INTO `station_status` VALUES ('3446', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154732', '1');
INSERT INTO `station_status` VALUES ('3447', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154776', '1');
INSERT INTO `station_status` VALUES ('3448', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154863', '1');
INSERT INTO `station_status` VALUES ('3449', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154908', '1');
INSERT INTO `station_status` VALUES ('3450', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431154995', '1');
INSERT INTO `station_status` VALUES ('3451', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155039', '1');
INSERT INTO `station_status` VALUES ('3452', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155083', '1');
INSERT INTO `station_status` VALUES ('3453', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155170', '1');
INSERT INTO `station_status` VALUES ('3454', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155214', '1');
INSERT INTO `station_status` VALUES ('3455', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155258', '1');
INSERT INTO `station_status` VALUES ('3456', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155345', '1');
INSERT INTO `station_status` VALUES ('3457', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155389', '1');
INSERT INTO `station_status` VALUES ('3458', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155433', '1');
INSERT INTO `station_status` VALUES ('3459', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155522', '1');
INSERT INTO `station_status` VALUES ('3460', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155566', '1');
INSERT INTO `station_status` VALUES ('3461', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155653', '1');
INSERT INTO `station_status` VALUES ('3462', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155697', '1');
INSERT INTO `station_status` VALUES ('3463', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155741', '1');
INSERT INTO `station_status` VALUES ('3464', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155828', '1');
INSERT INTO `station_status` VALUES ('3465', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155872', '1');
INSERT INTO `station_status` VALUES ('3466', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431155916', '1');
INSERT INTO `station_status` VALUES ('3467', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156003', '1');
INSERT INTO `station_status` VALUES ('3468', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156047', '1');
INSERT INTO `station_status` VALUES ('3469', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156134', '1');
INSERT INTO `station_status` VALUES ('3470', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156178', '1');
INSERT INTO `station_status` VALUES ('3471', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156222', '1');
INSERT INTO `station_status` VALUES ('3472', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156309', '1');
INSERT INTO `station_status` VALUES ('3473', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156353', '1');
INSERT INTO `station_status` VALUES ('3474', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156398', '1');
INSERT INTO `station_status` VALUES ('3475', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156484', '1');
INSERT INTO `station_status` VALUES ('3476', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156528', '1');
INSERT INTO `station_status` VALUES ('3477', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156615', '1');
INSERT INTO `station_status` VALUES ('3478', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156659', '1');
INSERT INTO `station_status` VALUES ('3479', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156704', '1');
INSERT INTO `station_status` VALUES ('3480', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156791', '1');
INSERT INTO `station_status` VALUES ('3481', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156835', '1');
INSERT INTO `station_status` VALUES ('3482', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156878', '1');
INSERT INTO `station_status` VALUES ('3483', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431156965', '1');
INSERT INTO `station_status` VALUES ('3484', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157009', '1');
INSERT INTO `station_status` VALUES ('3485', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157053', '1');
INSERT INTO `station_status` VALUES ('3486', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157140', '1');
INSERT INTO `station_status` VALUES ('3487', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157184', '1');
INSERT INTO `station_status` VALUES ('3488', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157271', '1');
INSERT INTO `station_status` VALUES ('3489', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157316', '1');
INSERT INTO `station_status` VALUES ('3490', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157360', '1');
INSERT INTO `station_status` VALUES ('3491', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157447', '1');
INSERT INTO `station_status` VALUES ('3492', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157491', '1');
INSERT INTO `station_status` VALUES ('3493', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157535', '1');
INSERT INTO `station_status` VALUES ('3494', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157622', '1');
INSERT INTO `station_status` VALUES ('3495', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157666', '1');
INSERT INTO `station_status` VALUES ('3496', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157753', '1');
INSERT INTO `station_status` VALUES ('3497', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157797', '1');
INSERT INTO `station_status` VALUES ('3498', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157841', '1');
INSERT INTO `station_status` VALUES ('3499', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157930', '1');
INSERT INTO `station_status` VALUES ('3500', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431157974', '1');
INSERT INTO `station_status` VALUES ('3501', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158018', '1');
INSERT INTO `station_status` VALUES ('3502', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158105', '1');
INSERT INTO `station_status` VALUES ('3503', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158149', '1');
INSERT INTO `station_status` VALUES ('3504', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158193', '1');
INSERT INTO `station_status` VALUES ('3505', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158280', '1');
INSERT INTO `station_status` VALUES ('3506', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158324', '1');
INSERT INTO `station_status` VALUES ('3507', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158411', '1');
INSERT INTO `station_status` VALUES ('3508', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158455', '1');
INSERT INTO `station_status` VALUES ('3509', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158500', '1');
INSERT INTO `station_status` VALUES ('3510', '13', '533db2&ECAPRO&status&ARMING&8&62&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158587', '1');
INSERT INTO `station_status` VALUES ('3511', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158631', '1');
INSERT INTO `station_status` VALUES ('3512', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158675', '1');
INSERT INTO `station_status` VALUES ('3513', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158762', '1');
INSERT INTO `station_status` VALUES ('3514', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158805', '1');
INSERT INTO `station_status` VALUES ('3515', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158892', '1');
INSERT INTO `station_status` VALUES ('3516', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158936', '1');
INSERT INTO `station_status` VALUES ('3517', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431158981', '1');
INSERT INTO `station_status` VALUES ('3518', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159067', '1');
INSERT INTO `station_status` VALUES ('3519', '13', '533db2&ECAPRO&status&ARMING&8&61&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159112', '1');
INSERT INTO `station_status` VALUES ('3520', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159156', '1');
INSERT INTO `station_status` VALUES ('3521', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159243', '1');
INSERT INTO `station_status` VALUES ('3522', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159287', '1');
INSERT INTO `station_status` VALUES ('3523', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159373', '1');
INSERT INTO `station_status` VALUES ('3524', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159417', '1');
INSERT INTO `station_status` VALUES ('3525', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159461', '1');
INSERT INTO `station_status` VALUES ('3526', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159548', '1');
INSERT INTO `station_status` VALUES ('3527', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159593', '1');
INSERT INTO `station_status` VALUES ('3528', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159638', '1');
INSERT INTO `station_status` VALUES ('3529', '13', '533db2&ECAPRO&status&ARMING&8&1&60&0&0&0&0&0&0&0&0&0&0\n', '1', '1431159726', '1');

-- ----------------------------
-- Table structure for `station_status_controller`
-- ----------------------------
DROP TABLE IF EXISTS `station_status_controller`;
CREATE TABLE `station_status_controller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) DEFAULT '0',
  `output_dec` int(11) DEFAULT NULL,
  `configure_dec` int(11) DEFAULT NULL,
  `security_mode` int(11) DEFAULT NULL COMMENT '0: off | 1: on',
  `created_at` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0' COMMENT '0: not | 1: updated',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of station_status_controller
-- ----------------------------
INSERT INTO `station_status_controller` VALUES ('1', '13', '33', '32', '1', '1430956097', '1');
INSERT INTO `station_status_controller` VALUES ('2', '13', '65', '32', null, '1430958426', '1');
INSERT INTO `station_status_controller` VALUES ('3', '13', '0', '32', '1', '1430958576', '1');
INSERT INTO `station_status_controller` VALUES ('4', '13', '1', '32', '1', '1430960241', '1');
INSERT INTO `station_status_controller` VALUES ('5', '13', '1', '32', null, '1430960695', '1');
INSERT INTO `station_status_controller` VALUES ('6', '13', '1', '32', null, '1430961816', '1');
INSERT INTO `station_status_controller` VALUES ('7', '13', '2', '0', '1', '1430961877', '1');
INSERT INTO `station_status_controller` VALUES ('8', '13', '34', '0', null, '1430964128', '1');
INSERT INTO `station_status_controller` VALUES ('9', '13', '32', '0', null, '1430964231', '1');
INSERT INTO `station_status_controller` VALUES ('10', '13', '64', '0', '1', '1430964899', '1');
INSERT INTO `station_status_controller` VALUES ('11', '13', '64', '0', null, '1430966927', '1');
INSERT INTO `station_status_controller` VALUES ('12', '13', '32', '0', null, '1430967285', '1');
INSERT INTO `station_status_controller` VALUES ('13', '13', '32', '0', '1', '1430967295', '1');
INSERT INTO `station_status_controller` VALUES ('14', '13', '1', '0', '1', '1430978784', '1');
INSERT INTO `station_status_controller` VALUES ('15', '13', '17', '32', null, '1431004980', '1');
INSERT INTO `station_status_controller` VALUES ('16', '13', '17', '0', null, '1431005097', '1');
INSERT INTO `station_status_controller` VALUES ('17', '13', null, null, '1', '1431005288', '0');

-- ----------------------------
-- Table structure for `station_status_handler`
-- ----------------------------
DROP TABLE IF EXISTS `station_status_handler`;
CREATE TABLE `station_status_handler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equip_id` int(11) DEFAULT '0',
  `station_id` int(11) DEFAULT '0',
  `type` int(3) DEFAULT '1' COMMENT '1:equipment | 2:sensor(security)',
  `status` int(11) DEFAULT '0',
  `configure` int(11) DEFAULT '0',
  `updated` int(11) DEFAULT '0',
  `created_at` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of station_status_handler
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
  `warning_type` int(11) DEFAULT '0' COMMENT 'loại cảnh báo',
  `station_id` int(11) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `warning_time` int(11) DEFAULT NULL COMMENT 'thời điểm cảnh báo',
  `read` int(3) DEFAULT '0' COMMENT '0: chưa xem | 1: đã xem',
  PRIMARY KEY (`id`),
  KEY `FkWarningType` (`warning_type`),
  CONSTRAINT `FkWarningType` FOREIGN KEY (`warning_type`) REFERENCES `warning_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='Bảng Cảnh báo';

-- ----------------------------
-- Records of warning
-- ----------------------------
INSERT INTO `warning` VALUES ('14', '1', '13', 'bao_chay_lon', '1430220326', '1');
INSERT INTO `warning` VALUES ('15', '1', '13', 'bao_chay_lon', '1430390802', '1');
INSERT INTO `warning` VALUES ('16', '1', '13', 'bi_dot_nhap', '1430390872', '1');
INSERT INTO `warning` VALUES ('17', '1', '13', 'bao_chay_lon', '1430391100', '1');
INSERT INTO `warning` VALUES ('18', '1', '13', 'bi_dot_nhap', '1430391194', '1');
INSERT INTO `warning` VALUES ('19', '1', '13', 'bi_dot_nhap', '1430391596', '1');
INSERT INTO `warning` VALUES ('20', '1', '13', 'bao_chay_lon', '1430391605', '1');
INSERT INTO `warning` VALUES ('21', '1', '13', 'bao_chay_lon', '1430409192', '1');
INSERT INTO `warning` VALUES ('22', '1', '13', 'bao_chay_lon', '1430409551', '1');
INSERT INTO `warning` VALUES ('23', '1', '13', 'bao_chay_lon', '1430409567', '1');
INSERT INTO `warning` VALUES ('24', '1', '13', 'bao_chay_lon', '1430409657', '1');
INSERT INTO `warning` VALUES ('25', '1', '13', 'bao_chay_lon', '1430409701', '1');
INSERT INTO `warning` VALUES ('26', '1', '13', 'bao_chay_lon', '1430409859', '1');
INSERT INTO `warning` VALUES ('27', '1', '13', 'bao_chay_lon', '1430409908', '1');
INSERT INTO `warning` VALUES ('28', '1', '13', 'mat dien luoi', '1430412041', '1');
INSERT INTO `warning` VALUES ('29', '1', '13', 'mat dien luoi', '1430412351', '1');
INSERT INTO `warning` VALUES ('30', '1', '13', 'mat dien luoi', '1430412363', '1');
INSERT INTO `warning` VALUES ('31', '1', '13', 'mat dien luoi', '1430412507', '1');
INSERT INTO `warning` VALUES ('32', '1', '13', 'mat dien luoi', '1430412590', '1');
INSERT INTO `warning` VALUES ('33', '1', '13', 'mat dien luoi', '1430412681', '1');
INSERT INTO `warning` VALUES ('34', '1', '13', 'mat dien luoi', '1430412806', '1');
INSERT INTO `warning` VALUES ('35', '1', '13', 'mat dien luoi', '1430413110', '1');
INSERT INTO `warning` VALUES ('36', '1', '13', 'mat dien luoi', '1430413178', '1');
INSERT INTO `warning` VALUES ('37', '1', '13', 'mat dien luoi', '1430413295', '1');
INSERT INTO `warning` VALUES ('38', '1', '13', 'mat dien luoi', '1430415125', '1');
INSERT INTO `warning` VALUES ('39', '1', '13', 'mat dien luoi', '1430415127', '1');
INSERT INTO `warning` VALUES ('40', '1', '13', 'mat dien luoi', '1430415129', '1');
INSERT INTO `warning` VALUES ('41', '1', '13', 'mat dien luoi', '1430415559', '1');
INSERT INTO `warning` VALUES ('42', '1', '13', 'mat dien luoi', '1430415562', '1');
INSERT INTO `warning` VALUES ('43', '1', '13', 'mat dien luoi', '1430415563', '1');
INSERT INTO `warning` VALUES ('44', '1', '13', 'mat dien luoi', '1430415928', '1');
INSERT INTO `warning` VALUES ('45', '1', '13', 'mat dien luoi', '1430415930', '1');
INSERT INTO `warning` VALUES ('46', '1', '13', 'mat dien luoi', '1430415932', '1');
INSERT INTO `warning` VALUES ('47', '1', '13', 'mat dien luoi', '1430415952', '1');
INSERT INTO `warning` VALUES ('48', '1', '13', 'mat dien luoi', '1430415954', '1');
INSERT INTO `warning` VALUES ('49', '1', '13', 'mat dien luoi', '1430415956', '1');
INSERT INTO `warning` VALUES ('50', '1', '13', 'khong co internet', '1430417057', '1');
INSERT INTO `warning` VALUES ('51', '1', '13', 'khong co internet', '1430417181', '1');
INSERT INTO `warning` VALUES ('52', '1', '13', 'khong co internet', '1430417278', '1');
INSERT INTO `warning` VALUES ('53', '1', '13', 'khong co internet', '1430418433', '1');
INSERT INTO `warning` VALUES ('54', '1', '13', 'khong co internet', '1430421638', '1');
INSERT INTO `warning` VALUES ('55', '1', '13', 'khong co internet', '1430421707', '1');
INSERT INTO `warning` VALUES ('56', '1', '13', 'khong co internet', '1430421880', '1');
INSERT INTO `warning` VALUES ('57', '1', '13', 'khong co internet', '1430422150', '1');
INSERT INTO `warning` VALUES ('58', '1', '13', 'khong co internet', '1430422279', '1');
INSERT INTO `warning` VALUES ('59', '1', '13', 'khong co internet', '1430422748', '1');
INSERT INTO `warning` VALUES ('60', '1', '13', 'khong co internet', '1430423103', '1');
INSERT INTO `warning` VALUES ('61', '1', '13', 'khong co internet', '1430424055', '1');
INSERT INTO `warning` VALUES ('62', '1', '13', 'khong co internet', '1430424217', '1');
INSERT INTO `warning` VALUES ('63', '1', '13', 'khong co internet', '1430472166', '1');
INSERT INTO `warning` VALUES ('64', '1', '13', 'khong co internet', '1430472394', '1');
INSERT INTO `warning` VALUES ('65', '1', '13', 'khong co internet', '1430472716', '1');
INSERT INTO `warning` VALUES ('66', '1', '13', 'khong co internet', '1430472890', '1');
INSERT INTO `warning` VALUES ('67', '1', '13', 'khong co internet', '1430473677', '1');
INSERT INTO `warning` VALUES ('68', '1', '13', 'khong co internet', '1430473859', '1');
INSERT INTO `warning` VALUES ('69', '1', '13', 'khong co internet', '1430473930', '1');
INSERT INTO `warning` VALUES ('70', '1', '13', 'khong co internet', '1430474026', '1');
INSERT INTO `warning` VALUES ('71', '1', '13', 'khong co internet', '1430474084', '1');
INSERT INTO `warning` VALUES ('72', '1', '13', 'khong co internet', '1430474121', '1');
INSERT INTO `warning` VALUES ('73', '1', '13', 'khong co internet', '1430476383', '1');
INSERT INTO `warning` VALUES ('74', '1', '13', 'khong co internet', '1430476737', '1');
INSERT INTO `warning` VALUES ('75', '1', '13', 'khong co internet', '1430476957', '1');
INSERT INTO `warning` VALUES ('76', '1', '13', 'khong co internet', '1430477026', '1');
INSERT INTO `warning` VALUES ('77', '1', '13', 'khong co internet', '1430477143', '1');
INSERT INTO `warning` VALUES ('78', '1', '13', 'khong co internet', '1430477323', '1');
INSERT INTO `warning` VALUES ('79', '1', '13', 'khong co internet', '1430477343', '1');
INSERT INTO `warning` VALUES ('80', '1', '13', 'khong co internet', '1430477662', '1');
INSERT INTO `warning` VALUES ('81', '1', '13', 'khong co internet', '1430477847', '1');
INSERT INTO `warning` VALUES ('82', '1', '13', 'khong co internet', '1430496742', '1');
INSERT INTO `warning` VALUES ('83', '1', '13', 'mat dien luoi', '1430582207', '1');
INSERT INTO `warning` VALUES ('84', '1', '13', 'mat dien luoi', '1430582751', '1');
INSERT INTO `warning` VALUES ('85', '1', '13', 'mat dien luoi', '1430582914', '1');
INSERT INTO `warning` VALUES ('86', '1', '13', 'mat dien luoi', '1430583176', '1');
INSERT INTO `warning` VALUES ('87', '1', '13', 'mat dien luoi', '1430583194', '1');
INSERT INTO `warning` VALUES ('88', '1', '13', 'mat dien luoi', '1430583786', '1');
INSERT INTO `warning` VALUES ('89', '1', '13', 'mat dien luoi', '1430623017', '1');

-- ----------------------------
-- Table structure for `warning_picture`
-- ----------------------------
DROP TABLE IF EXISTS `warning_picture`;
CREATE TABLE `warning_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warning_id` int(11) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `created_at` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `PkWarning` (`warning_id`),
  CONSTRAINT `PkWarning` FOREIGN KEY (`warning_id`) REFERENCES `warning` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of warning_picture
-- ----------------------------
INSERT INTO `warning_picture` VALUES ('16', '14', '2015/04/28/alarm_266.jpg', '1430220328');
INSERT INTO `warning_picture` VALUES ('17', '14', '2015/04/28/alarm_271.jpg', '1430220328');
INSERT INTO `warning_picture` VALUES ('18', '14', '2015/04/28/alarm_278.jpg', '1430220328');
INSERT INTO `warning_picture` VALUES ('19', '15', '2015/04/30/alarm_428668.jpg', '1430390804');
INSERT INTO `warning_picture` VALUES ('20', '15', '2015/04/30/alarm_426516.jpg', '1430390804');
INSERT INTO `warning_picture` VALUES ('21', '15', '2015/04/30/alarm_431876.jpg', '1430390804');
INSERT INTO `warning_picture` VALUES ('22', '17', '2015/04/30/alarm_405059.jpg', '1430391102');
INSERT INTO `warning_picture` VALUES ('23', '17', '2015/04/30/alarm_411933.jpg', '1430391102');
INSERT INTO `warning_picture` VALUES ('24', '17', '2015/04/30/alarm_417511.jpg', '1430391102');
INSERT INTO `warning_picture` VALUES ('25', '19', '2015/04/30/alarm_564630.jpg', '1430391598');
INSERT INTO `warning_picture` VALUES ('26', '19', '2015/04/30/alarm_577090.jpg', '1430391598');
INSERT INTO `warning_picture` VALUES ('27', '19', '2015/04/30/alarm_586790.jpg', '1430391598');
INSERT INTO `warning_picture` VALUES ('28', '20', '2015/04/30/alarm_051088.jpg', '1430391607');
INSERT INTO `warning_picture` VALUES ('29', '20', '2015/04/30/alarm_063513.jpg', '1430391607');
INSERT INTO `warning_picture` VALUES ('30', '20', '2015/04/30/alarm_068380.jpg', '1430391607');
INSERT INTO `warning_picture` VALUES ('31', '21', '2015/04/30/alarm_124906.jpg', '1430409195');
INSERT INTO `warning_picture` VALUES ('32', '21', '2015/04/30/alarm_138460.jpg', '1430409195');
INSERT INTO `warning_picture` VALUES ('33', '21', '2015/04/30/alarm_148182.jpg', '1430409195');
INSERT INTO `warning_picture` VALUES ('34', '22', '2015/04/30/alarm_123268.jpg', '1430409554');
INSERT INTO `warning_picture` VALUES ('35', '22', '2015/04/30/alarm_129128.jpg', '1430409554');
INSERT INTO `warning_picture` VALUES ('36', '22', '2015/04/30/alarm_136962.jpg', '1430409554');
INSERT INTO `warning_picture` VALUES ('37', '23', '2015/04/30/alarm_272172.jpg', '1430409569');
INSERT INTO `warning_picture` VALUES ('38', '23', '2015/04/30/alarm_289991.jpg', '1430409569');
INSERT INTO `warning_picture` VALUES ('39', '23', '2015/04/30/alarm_299961.jpg', '1430409569');
INSERT INTO `warning_picture` VALUES ('40', '24', '2015/04/30/alarm_575666.jpg', '1430409659');
INSERT INTO `warning_picture` VALUES ('41', '24', '2015/04/30/alarm_572564.jpg', '1430409659');
INSERT INTO `warning_picture` VALUES ('42', '24', '2015/04/30/alarm_587401.jpg', '1430409659');
INSERT INTO `warning_picture` VALUES ('43', '25', '2015/04/30/alarm_411336.jpg', '1430409703');
INSERT INTO `warning_picture` VALUES ('44', '25', '2015/04/30/alarm_415938.jpg', '1430409703');
INSERT INTO `warning_picture` VALUES ('45', '25', '2015/04/30/alarm_422219.jpg', '1430409703');
INSERT INTO `warning_picture` VALUES ('46', '26', '2015/04/30/alarm_194504.jpg', '1430409860');
INSERT INTO `warning_picture` VALUES ('47', '26', '2015/04/30/alarm_195021.jpg', '1430409860');
INSERT INTO `warning_picture` VALUES ('48', '26', '2015/04/30/alarm_209443.jpg', '1430409860');
INSERT INTO `warning_picture` VALUES ('49', '27', '2015/04/30/alarm_081497.jpg', '1430409910');
INSERT INTO `warning_picture` VALUES ('50', '27', '2015/04/30/alarm_096325.jpg', '1430409910');
INSERT INTO `warning_picture` VALUES ('51', '27', '2015/04/30/alarm_091400.jpg', '1430409910');
INSERT INTO `warning_picture` VALUES ('52', '28', '2015/04/30/alarm_416804.jpg', '1430412043');
INSERT INTO `warning_picture` VALUES ('53', '28', '2015/04/30/alarm_426361.jpg', '1430412043');
INSERT INTO `warning_picture` VALUES ('54', '28', '2015/04/30/alarm_425804.jpg', '1430412043');
INSERT INTO `warning_picture` VALUES ('55', '29', '2015/04/30/alarm_511910.jpg', '1430412353');
INSERT INTO `warning_picture` VALUES ('56', '29', '2015/04/30/alarm_525337.jpg', '1430412353');
INSERT INTO `warning_picture` VALUES ('57', '29', '2015/04/30/alarm_522417.jpg', '1430412353');
INSERT INTO `warning_picture` VALUES ('58', '30', '2015/04/30/alarm_035276.jpg', '1430412365');
INSERT INTO `warning_picture` VALUES ('59', '30', '2015/04/30/alarm_045725.jpg', '1430412365');
INSERT INTO `warning_picture` VALUES ('60', '30', '2015/04/30/alarm_055655.jpg', '1430412365');
INSERT INTO `warning_picture` VALUES ('61', '31', '2015/04/30/alarm_284570.jpg', '1430412509');
INSERT INTO `warning_picture` VALUES ('62', '31', '2015/04/30/alarm_285456.jpg', '1430412509');
INSERT INTO `warning_picture` VALUES ('63', '31', '2015/04/30/alarm_295114.jpg', '1430412509');
INSERT INTO `warning_picture` VALUES ('64', '32', '2015/04/30/alarm_502463.jpg', '1430412592');
INSERT INTO `warning_picture` VALUES ('65', '32', '2015/04/30/alarm_518648.jpg', '1430412592');
INSERT INTO `warning_picture` VALUES ('66', '32', '2015/04/30/alarm_515486.jpg', '1430412592');
INSERT INTO `warning_picture` VALUES ('67', '33', '2015/04/30/alarm_218154.jpg', '1430412683');
INSERT INTO `warning_picture` VALUES ('68', '33', '2015/04/30/alarm_224694.jpg', '1430412683');
INSERT INTO `warning_picture` VALUES ('69', '33', '2015/04/30/alarm_234925.jpg', '1430412683');
INSERT INTO `warning_picture` VALUES ('70', '34', '2015/04/30/alarm_264780.jpg', '1430412808');
INSERT INTO `warning_picture` VALUES ('71', '34', '2015/04/30/alarm_269876.jpg', '1430412808');
INSERT INTO `warning_picture` VALUES ('72', '34', '2015/04/30/alarm_278978.jpg', '1430412808');
INSERT INTO `warning_picture` VALUES ('73', '35', '2015/04/30/alarm_309841.jpg', '1430413112');
INSERT INTO `warning_picture` VALUES ('74', '35', '2015/04/30/alarm_305146.jpg', '1430413112');
INSERT INTO `warning_picture` VALUES ('75', '35', '2015/04/30/alarm_313970.jpg', '1430413112');
INSERT INTO `warning_picture` VALUES ('76', '36', '2015/04/30/alarm_384798.jpg', '1430413180');
INSERT INTO `warning_picture` VALUES ('77', '36', '2015/04/30/alarm_391335.jpg', '1430413180');
INSERT INTO `warning_picture` VALUES ('78', '36', '2015/04/30/alarm_397395.jpg', '1430413180');
INSERT INTO `warning_picture` VALUES ('79', '37', '2015/05/01/alarm_357379.jpg', '1430413296');
INSERT INTO `warning_picture` VALUES ('80', '37', '2015/05/01/alarm_352847.jpg', '1430413296');
INSERT INTO `warning_picture` VALUES ('81', '37', '2015/05/01/alarm_368143.jpg', '1430413296');
INSERT INTO `warning_picture` VALUES ('82', '38', '2015/05/01/alarm_059043.jpg', '1430415127');
INSERT INTO `warning_picture` VALUES ('83', '38', '2015/05/01/alarm_066067.jpg', '1430415127');
INSERT INTO `warning_picture` VALUES ('84', '38', '2015/05/01/alarm_079489.jpg', '1430415127');
INSERT INTO `warning_picture` VALUES ('85', '39', '2015/05/01/alarm_084283.jpg', '1430415129');
INSERT INTO `warning_picture` VALUES ('86', '39', '2015/05/01/alarm_086485.jpg', '1430415129');
INSERT INTO `warning_picture` VALUES ('87', '39', '2015/05/01/alarm_096730.jpg', '1430415129');
INSERT INTO `warning_picture` VALUES ('88', '40', '2015/05/01/alarm_098011.jpg', '1430415131');
INSERT INTO `warning_picture` VALUES ('89', '40', '2015/05/01/alarm_101280.jpg', '1430415131');
INSERT INTO `warning_picture` VALUES ('90', '40', '2015/05/01/alarm_116018.jpg', '1430415131');
INSERT INTO `warning_picture` VALUES ('91', '41', '2015/05/01/alarm_197810.jpg', '1430415561');
INSERT INTO `warning_picture` VALUES ('92', '41', '2015/05/01/alarm_209289.jpg', '1430415561');
INSERT INTO `warning_picture` VALUES ('93', '41', '2015/05/01/alarm_213863.jpg', '1430415561');
INSERT INTO `warning_picture` VALUES ('94', '42', '2015/05/01/alarm_224615.jpg', '1430415563');
INSERT INTO `warning_picture` VALUES ('95', '42', '2015/05/01/alarm_224289.jpg', '1430415563');
INSERT INTO `warning_picture` VALUES ('96', '42', '2015/05/01/alarm_231800.jpg', '1430415563');
INSERT INTO `warning_picture` VALUES ('97', '43', '2015/05/01/alarm_232583.jpg', '1430415565');
INSERT INTO `warning_picture` VALUES ('98', '43', '2015/05/01/alarm_242917.jpg', '1430415565');
INSERT INTO `warning_picture` VALUES ('99', '43', '2015/05/01/alarm_258836.jpg', '1430415565');
INSERT INTO `warning_picture` VALUES ('100', '44', '2015/05/01/alarm_288485.jpg', '1430415930');
INSERT INTO `warning_picture` VALUES ('101', '44', '2015/05/01/alarm_299470.jpg', '1430415930');
INSERT INTO `warning_picture` VALUES ('102', '44', '2015/05/01/alarm_295281.jpg', '1430415930');
INSERT INTO `warning_picture` VALUES ('103', '45', '2015/05/01/alarm_302497.jpg', '1430415932');
INSERT INTO `warning_picture` VALUES ('104', '45', '2015/05/01/alarm_314938.jpg', '1430415932');
INSERT INTO `warning_picture` VALUES ('105', '45', '2015/05/01/alarm_313606.jpg', '1430415932');
INSERT INTO `warning_picture` VALUES ('106', '46', '2015/05/01/alarm_325732.jpg', '1430415934');
INSERT INTO `warning_picture` VALUES ('107', '46', '2015/05/01/alarm_335027.jpg', '1430415934');
INSERT INTO `warning_picture` VALUES ('108', '46', '2015/05/01/alarm_336787.jpg', '1430415934');
INSERT INTO `warning_picture` VALUES ('109', '47', '2015/05/01/alarm_521551.jpg', '1430415954');
INSERT INTO `warning_picture` VALUES ('110', '47', '2015/05/01/alarm_533644.jpg', '1430415954');
INSERT INTO `warning_picture` VALUES ('111', '47', '2015/05/01/alarm_547222.jpg', '1430415954');
INSERT INTO `warning_picture` VALUES ('112', '48', '2015/05/01/alarm_542145.jpg', '1430415956');
INSERT INTO `warning_picture` VALUES ('113', '48', '2015/05/01/alarm_556103.jpg', '1430415956');
INSERT INTO `warning_picture` VALUES ('114', '48', '2015/05/01/alarm_569835.jpg', '1430415956');
INSERT INTO `warning_picture` VALUES ('115', '49', '2015/05/01/alarm_569831.jpg', '1430415958');
INSERT INTO `warning_picture` VALUES ('116', '49', '2015/05/01/alarm_578116.jpg', '1430415958');
INSERT INTO `warning_picture` VALUES ('117', '49', '2015/05/01/alarm_587262.jpg', '1430415958');
INSERT INTO `warning_picture` VALUES ('118', '50', '2015/04/30/alarm_181856.jpg', '1430417060');
INSERT INTO `warning_picture` VALUES ('119', '50', '2015/04/30/alarm_188017.jpg', '1430417060');
INSERT INTO `warning_picture` VALUES ('120', '50', '2015/04/30/alarm_195595.jpg', '1430417060');
INSERT INTO `warning_picture` VALUES ('121', '51', '2015/04/30/alarm_211871.jpg', '1430417183');
INSERT INTO `warning_picture` VALUES ('122', '51', '2015/04/30/alarm_225304.jpg', '1430417183');
INSERT INTO `warning_picture` VALUES ('123', '51', '2015/04/30/alarm_238728.jpg', '1430417183');
INSERT INTO `warning_picture` VALUES ('124', '52', '2015/04/30/alarm_592636.jpg', '1430417280');
INSERT INTO `warning_picture` VALUES ('125', '52', '2015/04/30/alarm_591694.jpg', '1430417280');
INSERT INTO `warning_picture` VALUES ('126', '52', '2015/04/30/alarm_009087.jpg', '1430417280');
INSERT INTO `warning_picture` VALUES ('127', '53', '2015/04/30/alarm_139843.jpg', '1430418434');
INSERT INTO `warning_picture` VALUES ('128', '53', '2015/04/30/alarm_137746.jpg', '1430418434');
INSERT INTO `warning_picture` VALUES ('129', '53', '2015/04/30/alarm_147968.jpg', '1430418434');
INSERT INTO `warning_picture` VALUES ('130', '54', '2015/04/30/alarm_386928.jpg', '1430421640');
INSERT INTO `warning_picture` VALUES ('131', '54', '2015/04/30/alarm_392345.jpg', '1430421640');
INSERT INTO `warning_picture` VALUES ('132', '54', '2015/04/30/alarm_401008.jpg', '1430421640');
INSERT INTO `warning_picture` VALUES ('133', '55', '2015/04/30/alarm_479848.jpg', '1430421709');
INSERT INTO `warning_picture` VALUES ('134', '55', '2015/04/30/alarm_488004.jpg', '1430421709');
INSERT INTO `warning_picture` VALUES ('135', '55', '2015/04/30/alarm_485394.jpg', '1430421709');
INSERT INTO `warning_picture` VALUES ('136', '56', '2015/04/30/alarm_409880.jpg', '1430421882');
INSERT INTO `warning_picture` VALUES ('137', '56', '2015/04/30/alarm_413150.jpg', '1430421882');
INSERT INTO `warning_picture` VALUES ('138', '56', '2015/04/30/alarm_412945.jpg', '1430421882');
INSERT INTO `warning_picture` VALUES ('139', '57', '2015/04/30/alarm_105753.jpg', '1430422152');
INSERT INTO `warning_picture` VALUES ('140', '57', '2015/04/30/alarm_114601.jpg', '1430422152');
INSERT INTO `warning_picture` VALUES ('141', '57', '2015/04/30/alarm_122059.jpg', '1430422152');
INSERT INTO `warning_picture` VALUES ('142', '58', '2015/04/30/alarm_196699.jpg', '1430422281');
INSERT INTO `warning_picture` VALUES ('143', '58', '2015/04/30/alarm_207923.jpg', '1430422281');
INSERT INTO `warning_picture` VALUES ('144', '58', '2015/04/30/alarm_202157.jpg', '1430422281');
INSERT INTO `warning_picture` VALUES ('145', '59', '2015/04/30/alarm_089218.jpg', '1430422751');
INSERT INTO `warning_picture` VALUES ('146', '59', '2015/04/30/alarm_098685.jpg', '1430422751');
INSERT INTO `warning_picture` VALUES ('147', '59', '2015/04/30/alarm_104375.jpg', '1430422751');
INSERT INTO `warning_picture` VALUES ('148', '60', '2015/04/30/alarm_035294.jpg', '1430423105');
INSERT INTO `warning_picture` VALUES ('149', '60', '2015/04/30/alarm_049670.jpg', '1430423105');
INSERT INTO `warning_picture` VALUES ('150', '60', '2015/04/30/alarm_042215.jpg', '1430423105');
INSERT INTO `warning_picture` VALUES ('151', '61', '2015/04/30/alarm_556224.jpg', '1430424057');
INSERT INTO `warning_picture` VALUES ('152', '61', '2015/04/30/alarm_562647.jpg', '1430424057');
INSERT INTO `warning_picture` VALUES ('153', '61', '2015/04/30/alarm_579752.jpg', '1430424057');
INSERT INTO `warning_picture` VALUES ('154', '62', '2015/04/30/alarm_378971.jpg', '1430424219');
INSERT INTO `warning_picture` VALUES ('155', '62', '2015/04/30/alarm_388289.jpg', '1430424219');
INSERT INTO `warning_picture` VALUES ('156', '62', '2015/04/30/alarm_385250.jpg', '1430424219');
INSERT INTO `warning_picture` VALUES ('157', '63', '2015/05/01/alarm_472901.jpg', '1430472168');
INSERT INTO `warning_picture` VALUES ('158', '63', '2015/05/01/alarm_471977.jpg', '1430472168');
INSERT INTO `warning_picture` VALUES ('159', '63', '2015/05/01/alarm_486344.jpg', '1430472168');
INSERT INTO `warning_picture` VALUES ('160', '64', '2015/05/01/alarm_347373.jpg', '1430472396');
INSERT INTO `warning_picture` VALUES ('161', '64', '2015/05/01/alarm_357532.jpg', '1430472396');
INSERT INTO `warning_picture` VALUES ('162', '64', '2015/05/01/alarm_363290.jpg', '1430472396');
INSERT INTO `warning_picture` VALUES ('163', '65', '2015/05/01/alarm_574414.jpg', '1430472718');
INSERT INTO `warning_picture` VALUES ('164', '65', '2015/05/01/alarm_578812.jpg', '1430472718');
INSERT INTO `warning_picture` VALUES ('165', '65', '2015/05/01/alarm_581502.jpg', '1430472718');
INSERT INTO `warning_picture` VALUES ('166', '66', '2015/05/01/alarm_501068.jpg', '1430472892');
INSERT INTO `warning_picture` VALUES ('167', '66', '2015/05/01/alarm_515968.jpg', '1430472892');
INSERT INTO `warning_picture` VALUES ('168', '66', '2015/05/01/alarm_527822.jpg', '1430472892');
INSERT INTO `warning_picture` VALUES ('169', '67', '2015/05/01/alarm_578919.jpg', '1430473679');
INSERT INTO `warning_picture` VALUES ('170', '67', '2015/05/01/alarm_584570.jpg', '1430473679');
INSERT INTO `warning_picture` VALUES ('171', '67', '2015/05/01/alarm_593427.jpg', '1430473679');
INSERT INTO `warning_picture` VALUES ('172', '68', '2015/05/01/alarm_591401.jpg', '1430473861');
INSERT INTO `warning_picture` VALUES ('173', '68', '2015/05/01/alarm_009287.jpg', '1430473861');
INSERT INTO `warning_picture` VALUES ('174', '68', '2015/05/01/alarm_004749.jpg', '1430473861');
INSERT INTO `warning_picture` VALUES ('175', '69', '2015/05/01/alarm_101240.jpg', '1430473932');
INSERT INTO `warning_picture` VALUES ('176', '69', '2015/05/01/alarm_111928.jpg', '1430473932');
INSERT INTO `warning_picture` VALUES ('177', '69', '2015/05/01/alarm_129282.jpg', '1430473932');
INSERT INTO `warning_picture` VALUES ('178', '70', '2015/05/01/alarm_467977.jpg', '1430474028');
INSERT INTO `warning_picture` VALUES ('179', '70', '2015/05/01/alarm_478477.jpg', '1430474028');
INSERT INTO `warning_picture` VALUES ('180', '70', '2015/05/01/alarm_486040.jpg', '1430474028');
INSERT INTO `warning_picture` VALUES ('181', '71', '2015/05/01/alarm_443572.jpg', '1430474085');
INSERT INTO `warning_picture` VALUES ('182', '71', '2015/05/01/alarm_449443.jpg', '1430474085');
INSERT INTO `warning_picture` VALUES ('183', '71', '2015/05/01/alarm_456907.jpg', '1430474085');
INSERT INTO `warning_picture` VALUES ('184', '72', '2015/05/01/alarm_214229.jpg', '1430474123');
INSERT INTO `warning_picture` VALUES ('185', '72', '2015/05/01/alarm_229165.jpg', '1430474123');
INSERT INTO `warning_picture` VALUES ('186', '72', '2015/05/01/alarm_229908.jpg', '1430474123');
INSERT INTO `warning_picture` VALUES ('187', '73', '2015/05/01/alarm_044124.jpg', '1430476386');
INSERT INTO `warning_picture` VALUES ('188', '73', '2015/05/01/alarm_045212.jpg', '1430476386');
INSERT INTO `warning_picture` VALUES ('189', '73', '2015/05/01/alarm_054405.jpg', '1430476386');
INSERT INTO `warning_picture` VALUES ('190', '74', '2015/05/01/alarm_576840.jpg', '1430476739');
INSERT INTO `warning_picture` VALUES ('191', '74', '2015/05/01/alarm_583222.jpg', '1430476739');
INSERT INTO `warning_picture` VALUES ('192', '74', '2015/05/01/alarm_584209.jpg', '1430476739');
INSERT INTO `warning_picture` VALUES ('193', '75', '2015/05/01/alarm_385979.jpg', '1430476960');
INSERT INTO `warning_picture` VALUES ('194', '75', '2015/05/01/alarm_381366.jpg', '1430476960');
INSERT INTO `warning_picture` VALUES ('195', '75', '2015/05/01/alarm_397483.jpg', '1430476960');
INSERT INTO `warning_picture` VALUES ('196', '76', '2015/05/01/alarm_464771.jpg', '1430477028');
INSERT INTO `warning_picture` VALUES ('197', '76', '2015/05/01/alarm_479933.jpg', '1430477028');
INSERT INTO `warning_picture` VALUES ('198', '76', '2015/05/01/alarm_475412.jpg', '1430477028');
INSERT INTO `warning_picture` VALUES ('199', '77', '2015/05/01/alarm_431339.jpg', '1430477145');
INSERT INTO `warning_picture` VALUES ('200', '77', '2015/05/01/alarm_441566.jpg', '1430477145');
INSERT INTO `warning_picture` VALUES ('201', '77', '2015/05/01/alarm_449932.jpg', '1430477145');
INSERT INTO `warning_picture` VALUES ('202', '78', '2015/05/01/alarm_431355.jpg', '1430477325');
INSERT INTO `warning_picture` VALUES ('203', '78', '2015/05/01/alarm_442911.jpg', '1430477325');
INSERT INTO `warning_picture` VALUES ('204', '78', '2015/05/01/alarm_452493.jpg', '1430477325');
INSERT INTO `warning_picture` VALUES ('205', '79', '2015/05/01/alarm_031194.jpg', '1430477344');
INSERT INTO `warning_picture` VALUES ('206', '79', '2015/05/01/alarm_038038.jpg', '1430477344');
INSERT INTO `warning_picture` VALUES ('207', '79', '2015/05/01/alarm_045169.jpg', '1430477344');
INSERT INTO `warning_picture` VALUES ('208', '80', '2015/05/01/alarm_226143.jpg', '1430477664');
INSERT INTO `warning_picture` VALUES ('209', '80', '2015/05/01/alarm_231439.jpg', '1430477664');
INSERT INTO `warning_picture` VALUES ('210', '80', '2015/05/01/alarm_233805.jpg', '1430477664');
INSERT INTO `warning_picture` VALUES ('211', '81', '2015/05/01/alarm_273822.jpg', '1430477849');
INSERT INTO `warning_picture` VALUES ('212', '81', '2015/05/01/alarm_287497.jpg', '1430477849');
INSERT INTO `warning_picture` VALUES ('213', '81', '2015/05/01/alarm_298458.jpg', '1430477849');
INSERT INTO `warning_picture` VALUES ('214', '82', '2015/05/01/alarm_229067.jpg', '1430496744');
INSERT INTO `warning_picture` VALUES ('215', '82', '2015/05/01/alarm_223298.jpg', '1430496744');
INSERT INTO `warning_picture` VALUES ('216', '82', '2015/05/01/alarm_237188.jpg', '1430496744');
INSERT INTO `warning_picture` VALUES ('217', '83', '2015/05/02/alarm_481870.jpg', '1430582211');
INSERT INTO `warning_picture` VALUES ('218', '83', '2015/05/02/alarm_486762.jpg', '1430582211');
INSERT INTO `warning_picture` VALUES ('219', '83', '2015/05/02/alarm_493157.jpg', '1430582211');
INSERT INTO `warning_picture` VALUES ('220', '83', '2015/05/02/alarm_507831.jpg', '1430582211');
INSERT INTO `warning_picture` VALUES ('221', '83', '2015/05/02/alarm_511891.jpg', '1430582211');
INSERT INTO `warning_picture` VALUES ('222', '84', '2015/05/02/alarm_511476.jpg', '1430582754');
INSERT INTO `warning_picture` VALUES ('223', '84', '2015/05/02/alarm_521237.jpg', '1430582754');
INSERT INTO `warning_picture` VALUES ('224', '84', '2015/05/02/alarm_524271.jpg', '1430582754');
INSERT INTO `warning_picture` VALUES ('225', '84', '2015/05/02/alarm_536855.jpg', '1430582754');
INSERT INTO `warning_picture` VALUES ('226', '84', '2015/05/02/alarm_546024.jpg', '1430582754');
INSERT INTO `warning_picture` VALUES ('227', '85', '2015/05/02/alarm_347172.jpg', '1430582917');
INSERT INTO `warning_picture` VALUES ('228', '85', '2015/05/02/alarm_358569.jpg', '1430582917');
INSERT INTO `warning_picture` VALUES ('229', '85', '2015/05/02/alarm_354849.jpg', '1430582917');
INSERT INTO `warning_picture` VALUES ('230', '85', '2015/05/02/alarm_366512.jpg', '1430582917');
INSERT INTO `warning_picture` VALUES ('231', '85', '2015/05/02/alarm_363647.jpg', '1430582917');
INSERT INTO `warning_picture` VALUES ('232', '86', '2015/05/02/alarm_562718.jpg', '1430583179');
INSERT INTO `warning_picture` VALUES ('233', '86', '2015/05/02/alarm_574931.jpg', '1430583179');
INSERT INTO `warning_picture` VALUES ('234', '86', '2015/05/02/alarm_579748.jpg', '1430583179');
INSERT INTO `warning_picture` VALUES ('235', '86', '2015/05/02/alarm_584308.jpg', '1430583179');
INSERT INTO `warning_picture` VALUES ('236', '86', '2015/05/02/alarm_596316.jpg', '1430583179');
INSERT INTO `warning_picture` VALUES ('237', '87', '2015/05/02/alarm_141553.jpg', '1430583197');
INSERT INTO `warning_picture` VALUES ('238', '87', '2015/05/02/alarm_152759.jpg', '1430583197');
INSERT INTO `warning_picture` VALUES ('239', '87', '2015/05/02/alarm_154078.jpg', '1430583197');
INSERT INTO `warning_picture` VALUES ('240', '87', '2015/05/02/alarm_169293.jpg', '1430583197');
INSERT INTO `warning_picture` VALUES ('241', '87', '2015/05/02/alarm_165578.jpg', '1430583197');
INSERT INTO `warning_picture` VALUES ('242', '88', '2015/05/02/alarm_063198.jpg', '1430583789');
INSERT INTO `warning_picture` VALUES ('243', '88', '2015/05/02/alarm_071464.jpg', '1430583789');
INSERT INTO `warning_picture` VALUES ('244', '88', '2015/05/02/alarm_078579.jpg', '1430583789');
INSERT INTO `warning_picture` VALUES ('245', '88', '2015/05/02/alarm_088850.jpg', '1430583789');
INSERT INTO `warning_picture` VALUES ('246', '88', '2015/05/02/alarm_088506.jpg', '1430583789');
INSERT INTO `warning_picture` VALUES ('247', '89', '2015/05/03/alarm_574699.jpg', '1430623021');
INSERT INTO `warning_picture` VALUES ('248', '89', '2015/05/03/alarm_595183.jpg', '1430623021');
INSERT INTO `warning_picture` VALUES ('249', '89', '2015/05/03/alarm_594888.jpg', '1430623021');
INSERT INTO `warning_picture` VALUES ('250', '89', '2015/05/03/alarm_008001.jpg', '1430623021');
INSERT INTO `warning_picture` VALUES ('251', '89', '2015/05/03/alarm_019765.jpg', '1430623021');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Bảng Loại cảnh báo';

-- ----------------------------
-- Records of warning_type
-- ----------------------------
INSERT INTO `warning_type` VALUES ('1', '01', 'Báo động', '1');
