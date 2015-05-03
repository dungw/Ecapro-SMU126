/*
Navicat MySQL Data Transfer

Source Server         : JF
Source Server Version : 50539
Source Host           : localhost:3306
Source Database       : ecapro-smu126

Target Server Type    : MYSQL
Target Server Version : 50539
File Encoding         : 65001

Date: 2015-05-03 15:47:58
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
INSERT INTO `equipment` VALUES ('9', 'Điều khiển dự phòng 3', '0', '8');
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
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment_status
-- ----------------------------
INSERT INTO `equipment_status` VALUES ('101', '1', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('102', '2', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('103', '3', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('104', '4', '13', 'TR01', '0', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('105', '5', '13', 'TR01', '1', '1', '0', '0');
INSERT INTO `equipment_status` VALUES ('106', '6', '13', 'TR01', '0', '1', '0', '0');
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
INSERT INTO `sensor_status` VALUES ('7', '1', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('8', '3', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('9', '4', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('10', '5', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('11', '6', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('12', '7', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('13', '8', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('14', '9', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('15', '10', '13', '0', '1');
INSERT INTO `sensor_status` VALUES ('16', '11', '13', '1', '1');
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
INSERT INTO `station` VALUES ('13', '533db2', 'Trạm số 1', '1', '1', '1', '', 'Vương Việt Dũng', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '21.027764', '105.834160', '0437555555', 'tram01@gmail.com', '1', '1', '5', '14.162.203.188', '31337');
INSERT INTO `station` VALUES ('14', '533db3', 'Trạm số 2', '2', '1', '2', '', '', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '20.992695', '105.777354', '', '', '1', '1', '5', '', '');
INSERT INTO `station` VALUES ('15', '533db4', 'Trạm số 3', '3', '2', '2', '', '', '', 'http://ecasmart.homelinux.com:8888/snapshot.cgi?user=ecaprovn&pwd=1q2w3e4r', 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r', '20.976988', '105.841641', '', '', '1', '1', '2', '', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 COMMENT='Bảng Trạng thái của trạm';

-- ----------------------------
-- Records of station_status
-- ----------------------------
INSERT INTO `station_status` VALUES ('2', '13', '13&TR12&status&ARMING&7&6&9&15.6&85.4&220&550&150&2000&15&15.5&24&24.5', '1', '1430087777', '1');
INSERT INTO `station_status` VALUES ('3', '13', '13&TR12&status&ARMING&7&6&9&15.6&85.4&220&550&150&2000&15&15.5&24&24.5', '1', '1430087796', '1');
INSERT INTO `station_status` VALUES ('4', '13', '13&TR12&status&ARMING&7&6&9&15.6&85.4&220&550&150&2000&15&15.5&24&24.5', '1', '1430089623', '1');
INSERT INTO `station_status` VALUES ('5', '13', '13&TR12&status&ARMING&7&6&9&15.6&85.4&220&550&150&2000&15&15.5&24&24.5', '1', '1430089744', '1');
INSERT INTO `station_status` VALUES ('6', '13', '13&TR12&status&ARMING&7&6&9&15.6&85.4&220&550&150&2000&15&15.5&24&24.5', '1', '1430102701', '1');
INSERT INTO `station_status` VALUES ('7', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430252082', '1');
INSERT INTO `station_status` VALUES ('8', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0', '1', '1430252689', '1');
INSERT INTO `station_status` VALUES ('9', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0', '1', '1430252828', '1');
INSERT INTO `station_status` VALUES ('10', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430252923', '1');
INSERT INTO `station_status` VALUES ('11', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0\n', '1', '1430253375', '1');
INSERT INTO `station_status` VALUES ('12', '13', '533db2&ECAPRO&status&DISARM&0&0&0&0&0&0&0&0&0&0&0&0&0', '1', '1430328509', '1');
INSERT INTO `station_status` VALUES ('13', '13', '533db2&ECAPRO&status&DISARM&1&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430328549', '1');
INSERT INTO `station_status` VALUES ('14', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430390804', '1');
INSERT INTO `station_status` VALUES ('15', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430391102', '1');
INSERT INTO `station_status` VALUES ('16', '13', '533db2&TR01&alarm&bi_dot_nhap', '1', '1430391598', '1');
INSERT INTO `station_status` VALUES ('17', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430391607', '1');
INSERT INTO `station_status` VALUES ('18', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409195', '1');
INSERT INTO `station_status` VALUES ('19', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409554', '1');
INSERT INTO `station_status` VALUES ('20', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409569', '1');
INSERT INTO `station_status` VALUES ('21', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409659', '1');
INSERT INTO `station_status` VALUES ('22', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409703', '1');
INSERT INTO `station_status` VALUES ('23', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409861', '1');
INSERT INTO `station_status` VALUES ('24', '13', '533db2&TR01&alarm&bao_chay_lon', '1', '1430409910', '1');
INSERT INTO `station_status` VALUES ('25', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412043', '1');
INSERT INTO `station_status` VALUES ('26', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412353', '1');
INSERT INTO `station_status` VALUES ('27', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412365', '1');
INSERT INTO `station_status` VALUES ('28', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412509', '1');
INSERT INTO `station_status` VALUES ('29', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412592', '1');
INSERT INTO `station_status` VALUES ('30', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412683', '1');
INSERT INTO `station_status` VALUES ('31', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430412808', '1');
INSERT INTO `station_status` VALUES ('32', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430413112', '1');
INSERT INTO `station_status` VALUES ('33', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430413180', '1');
INSERT INTO `station_status` VALUES ('34', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430413296', '1');
INSERT INTO `station_status` VALUES ('35', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415127', '1');
INSERT INTO `station_status` VALUES ('36', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415129', '1');
INSERT INTO `station_status` VALUES ('37', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415131', '1');
INSERT INTO `station_status` VALUES ('38', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415561', '1');
INSERT INTO `station_status` VALUES ('39', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415563', '1');
INSERT INTO `station_status` VALUES ('40', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415565', '1');
INSERT INTO `station_status` VALUES ('41', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415930', '1');
INSERT INTO `station_status` VALUES ('42', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415932', '1');
INSERT INTO `station_status` VALUES ('43', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415934', '1');
INSERT INTO `station_status` VALUES ('44', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415954', '1');
INSERT INTO `station_status` VALUES ('45', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415956', '1');
INSERT INTO `station_status` VALUES ('46', '13', '533db2&TR01&alarm&mat dien luoi', '1', '1430415958', '1');
INSERT INTO `station_status` VALUES ('47', '13', '533db2&TR01&alarm&khong co internet', '1', '1430417060', '1');
INSERT INTO `station_status` VALUES ('48', '13', '533db2&TR01&alarm&khong co internet', '1', '1430417183', '1');
INSERT INTO `station_status` VALUES ('49', '13', '533db2&TR01&alarm&khong co internet', '1', '1430417280', '1');
INSERT INTO `station_status` VALUES ('50', '13', '533db2&TR01&alarm&khong co internet', '1', '1430418434', '1');
INSERT INTO `station_status` VALUES ('51', '13', '533db2&TR01&alarm&khong co internet', '1', '1430421640', '1');
INSERT INTO `station_status` VALUES ('52', '13', '533db2&TR01&alarm&khong co internet', '1', '1430421709', '1');
INSERT INTO `station_status` VALUES ('53', '13', '533db2&TR01&alarm&khong co internet', '1', '1430421882', '1');
INSERT INTO `station_status` VALUES ('54', '13', '533db2&TR01&alarm&khong co internet', '1', '1430422153', '1');
INSERT INTO `station_status` VALUES ('55', '13', '533db2&TR01&alarm&khong co internet', '1', '1430422281', '1');
INSERT INTO `station_status` VALUES ('56', '13', '533db2&TR01&alarm&khong co internet', '1', '1430422751', '1');
INSERT INTO `station_status` VALUES ('57', '13', '533db2&TR01&alarm&khong co internet', '1', '1430423105', '1');
INSERT INTO `station_status` VALUES ('58', '13', '533db2&TR01&alarm&khong co internet', '1', '1430424057', '1');
INSERT INTO `station_status` VALUES ('59', '13', '533db2&TR01&alarm&khong co internet', '1', '1430424219', '1');
INSERT INTO `station_status` VALUES ('60', '13', '533db2&TR01&alarm&khong co internet', '1', '1430472168', '1');
INSERT INTO `station_status` VALUES ('61', '13', '533db2&TR01&alarm&khong co internet', '1', '1430472396', '1');
INSERT INTO `station_status` VALUES ('62', '13', '533db2&TR01&alarm&khong co internet', '1', '1430472719', '1');
INSERT INTO `station_status` VALUES ('63', '13', '533db2&TR01&alarm&khong co internet', '1', '1430472892', '1');
INSERT INTO `station_status` VALUES ('64', '13', '533db2&TR01&alarm&khong co internet', '1', '1430473679', '1');
INSERT INTO `station_status` VALUES ('65', '13', '533db2&TR01&alarm&khong co internet', '1', '1430473861', '1');
INSERT INTO `station_status` VALUES ('66', '13', '533db2&TR01&alarm&khong co internet', '1', '1430473932', '1');
INSERT INTO `station_status` VALUES ('67', '13', '533db2&TR01&alarm&khong co internet', '1', '1430474028', '1');
INSERT INTO `station_status` VALUES ('68', '13', '533db2&TR01&alarm&khong co internet', '1', '1430474085', '1');
INSERT INTO `station_status` VALUES ('69', '13', '533db2&TR01&alarm&khong co internet', '1', '1430474123', '1');
INSERT INTO `station_status` VALUES ('70', '13', '533db2&TR01&alarm&khong co internet', '1', '1430476386', '1');
INSERT INTO `station_status` VALUES ('71', '13', '533db2&TR01&alarm&khong co internet', '1', '1430476739', '1');
INSERT INTO `station_status` VALUES ('72', '13', '533db2&TR01&alarm&khong co internet', '1', '1430476960', '1');
INSERT INTO `station_status` VALUES ('73', '13', '533db2&TR01&alarm&khong co internet', '1', '1430477028', '1');
INSERT INTO `station_status` VALUES ('74', '13', '533db2&TR01&alarm&khong co internet', '1', '1430477145', '1');
INSERT INTO `station_status` VALUES ('75', '13', '533db2&TR01&alarm&khong co internet', '1', '1430477325', '1');
INSERT INTO `station_status` VALUES ('76', '13', '533db2&TR01&alarm&khong co internet', '1', '1430477344', '1');
INSERT INTO `station_status` VALUES ('77', '13', '533db2&TR01&alarm&khong co internet', '1', '1430477664', '1');
INSERT INTO `station_status` VALUES ('78', '13', '533db2&TR01&alarm&khong co internet', '2', '1430477850', '1');
INSERT INTO `station_status` VALUES ('79', '13', '533db2&TR01&alarm&khong co internet', '1', '1430496744', '1');
INSERT INTO `station_status` VALUES ('80', '13', '533db2&Trạm số 1&&0906600788&Công việc thế nào rồi?', '2', '1430549382', '1');
INSERT INTO `station_status` VALUES ('81', '13', '533db2&Trạm số 1&&0906600788&Công việc thế nào rồi?', '1', '1430549384', '1');
INSERT INTO `station_status` VALUES ('82', '13', '533db2&Trạm số 1&&0906600788&Công việc thế nào rồi?', '2', '1430549601', '1');
INSERT INTO `station_status` VALUES ('83', '13', '533db2&Trạm số 1&&0906600788&Công việc thế nào rồi?', '1', '1430549601', '1');
INSERT INTO `station_status` VALUES ('84', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '2', '1430549655', '1');
INSERT INTO `station_status` VALUES ('85', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '1', '1430549655', '1');
INSERT INTO `station_status` VALUES ('86', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '2', '1430549772', '1');
INSERT INTO `station_status` VALUES ('87', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '1', '1430549772', '1');
INSERT INTO `station_status` VALUES ('88', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '2', '1430549830', '1');
INSERT INTO `station_status` VALUES ('89', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '1', '1430549830', '1');
INSERT INTO `station_status` VALUES ('90', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '2', '1430549980', '1');
INSERT INTO `station_status` VALUES ('91', '13', '533db2&Trạm số 1&&0906600788&how is the work?', '2', '1430550070', '1');
INSERT INTO `station_status` VALUES ('92', '13', '533db2&ECAPRO&status&DISARM&1&38&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430550826', '1');
INSERT INTO `station_status` VALUES ('93', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430550870', '1');
INSERT INTO `station_status` VALUES ('94', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430550957', '1');
INSERT INTO `station_status` VALUES ('95', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551000', '1');
INSERT INTO `station_status` VALUES ('96', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551045', '1');
INSERT INTO `station_status` VALUES ('97', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551132', '1');
INSERT INTO `station_status` VALUES ('98', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551175', '1');
INSERT INTO `station_status` VALUES ('99', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551219', '1');
INSERT INTO `station_status` VALUES ('100', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551306', '1');
INSERT INTO `station_status` VALUES ('101', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551350', '1');
INSERT INTO `station_status` VALUES ('102', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551437', '1');
INSERT INTO `station_status` VALUES ('103', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551480', '1');
INSERT INTO `station_status` VALUES ('104', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551525', '1');
INSERT INTO `station_status` VALUES ('105', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551612', '1');
INSERT INTO `station_status` VALUES ('106', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551656', '1');
INSERT INTO `station_status` VALUES ('107', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551701', '1');
INSERT INTO `station_status` VALUES ('108', '13', '533db2&ECAPRO&status&DISARM&1&6&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551787', '1');
INSERT INTO `station_status` VALUES ('109', '13', '533db2&ECAPRO&status&DISARM&1&5&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551831', '1');
INSERT INTO `station_status` VALUES ('110', '13', '533db2&ECAPRO&status&DISARM&1&5&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551918', '1');
INSERT INTO `station_status` VALUES ('111', '13', '533db2&ECAPRO&status&DISARM&1&5&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430551962', '1');
INSERT INTO `station_status` VALUES ('112', '13', '533db2&ECAPRO&status&DISARM&1&5&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552006', '1');
INSERT INTO `station_status` VALUES ('113', '13', '533db2&ECAPRO&status&DISARM&1&5&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552092', '1');
INSERT INTO `station_status` VALUES ('114', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552136', '1');
INSERT INTO `station_status` VALUES ('115', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552180', '1');
INSERT INTO `station_status` VALUES ('116', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552267', '1');
INSERT INTO `station_status` VALUES ('117', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552311', '1');
INSERT INTO `station_status` VALUES ('118', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552399', '1');
INSERT INTO `station_status` VALUES ('119', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552443', '1');
INSERT INTO `station_status` VALUES ('120', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552487', '1');
INSERT INTO `station_status` VALUES ('121', '13', '533db2&ECAPRO&status&DISARM&1&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552537', '1');
INSERT INTO `station_status` VALUES ('122', '13', '533db2&ECAPRO&status&DISARM&2&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552597', '1');
INSERT INTO `station_status` VALUES ('123', '13', '533db2&ECAPRO&status&DISARM&8&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552657', '1');
INSERT INTO `station_status` VALUES ('124', '13', '533db2&ECAPRO&status&DISARM&8&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552717', '1');
INSERT INTO `station_status` VALUES ('125', '13', '533db2&ECAPRO&status&DISARM&8&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552777', '1');
INSERT INTO `station_status` VALUES ('126', '13', '533db2&ECAPRO&status&DISARM&8&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552839', '1');
INSERT INTO `station_status` VALUES ('127', '13', '533db2&ECAPRO&status&DISARM&8&7&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430552896', '1');
INSERT INTO `station_status` VALUES ('128', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430582212', '1');
INSERT INTO `station_status` VALUES ('129', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582576', '1');
INSERT INTO `station_status` VALUES ('130', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582659', '1');
INSERT INTO `station_status` VALUES ('131', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582701', '1');
INSERT INTO `station_status` VALUES ('132', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582743', '1');
INSERT INTO `station_status` VALUES ('133', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430582754', '1');
INSERT INTO `station_status` VALUES ('134', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582825', '1');
INSERT INTO `station_status` VALUES ('135', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582867', '1');
INSERT INTO `station_status` VALUES ('136', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430582917', '1');
INSERT INTO `station_status` VALUES ('137', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582949', '1');
INSERT INTO `station_status` VALUES ('138', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430582991', '1');
INSERT INTO `station_status` VALUES ('139', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583075', '1');
INSERT INTO `station_status` VALUES ('140', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583117', '1');
INSERT INTO `station_status` VALUES ('141', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430583180', '1');
INSERT INTO `station_status` VALUES ('142', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430583197', '1');
INSERT INTO `station_status` VALUES ('143', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583199', '1');
INSERT INTO `station_status` VALUES ('144', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583241', '1');
INSERT INTO `station_status` VALUES ('145', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583283', '1');
INSERT INTO `station_status` VALUES ('146', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583365', '1');
INSERT INTO `station_status` VALUES ('147', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583407', '1');
INSERT INTO `station_status` VALUES ('148', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583490', '1');
INSERT INTO `station_status` VALUES ('149', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583532', '1');
INSERT INTO `station_status` VALUES ('150', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583614', '1');
INSERT INTO `station_status` VALUES ('151', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583657', '1');
INSERT INTO `station_status` VALUES ('152', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583739', '1');
INSERT INTO `station_status` VALUES ('153', '13', '533db2&ECAPRO&status&DISARM&8&2&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583781', '1');
INSERT INTO `station_status` VALUES ('154', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430583789', '1');
INSERT INTO `station_status` VALUES ('155', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583823', '1');
INSERT INTO `station_status` VALUES ('156', '13', '533db2&Tram_so_1&status&1&6&32', '1', '1430583824', '1');
INSERT INTO `station_status` VALUES ('157', '13', '533db2&ECAPRO&status&DISARM&8&1&32&0&0&0&0&0&0&0&0&0&0\n', '1', '1430583906', '1');
INSERT INTO `station_status` VALUES ('158', '13', '533db2&Tram_so_1&alarm&mat dien luoi', '1', '1430623021', '1');

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
