/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : course_design_3_bookmanager

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2019-06-12 10:33:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bookadmin
-- ----------------------------
DROP TABLE IF EXISTS `bookadmin`;
CREATE TABLE `bookadmin` (
  `AdId` varchar(20) NOT NULL,
  `AdName` varchar(20) NOT NULL,
  `AdPassword` varchar(20) NOT NULL,
  `AdPhone` varchar(20) NOT NULL,
  `AdEmail` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AdId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookadmin
-- ----------------------------
INSERT INTO `bookadmin` VALUES ('111111', '李四', 'root', '15215078134', '15215078130@qq.com');
INSERT INTO `bookadmin` VALUES ('222222', 'root', 'root', '12377777', 'kj@qq.com');
INSERT INTO `bookadmin` VALUES ('333333', '张三', 'admin', '13211888349', '13211888349@qq.com');

-- ----------------------------
-- Table structure for bookinfo
-- ----------------------------
DROP TABLE IF EXISTS `bookinfo`;
CREATE TABLE `bookinfo` (
  `BookId` varchar(20) NOT NULL,
  `BookName` varchar(20) NOT NULL,
  `Author` varchar(20) NOT NULL,
  `Translator` varchar(20) DEFAULT NULL,
  `Price` float(10,2) NOT NULL DEFAULT '0.00',
  `ISBNCode` varchar(20) NOT NULL,
  `ComeUpTime` datetime NOT NULL,
  `PublishCompany` varchar(20) NOT NULL,
  `State` int(11) NOT NULL DEFAULT '1',
  `EnteringMen` varchar(20) NOT NULL,
  `EnteringDate` datetime NOT NULL,
  PRIMARY KEY (`BookId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bookinfo
-- ----------------------------
INSERT INTO `bookinfo` VALUES ('', 'sdf', 'sdfsdf', 'sdf', '78.00', 'sdf', '2012-01-03 00:00:00', 'sdf', '1', 'sdf', '2019-05-30 01:57:46');
INSERT INTO `bookinfo` VALUES ('1', 'c语言', 'ghjk', 'hjk', '67.90', 'ghjkl', '2019-05-14 14:41:27', 'sdsdfg', '0', 'erty', '2019-05-24 14:41:50');
INSERT INTO `bookinfo` VALUES ('2', '数学', '阿旺', '李四', '69.00', 'ISBN编码111', '2015-04-09 00:00:00', 'ddd出版社', '0', '张三', '2019-05-07 14:20:49');
INSERT INTO `bookinfo` VALUES ('3', '英语', '阿天', '刘前', '90.50', '333', '2019-05-08 14:28:43', 'dfdsa出版社', '1', '五刘', '2019-05-07 14:29:11');
INSERT INTO `bookinfo` VALUES ('4', 'c语言', 'ghjk', '张三', '67.90', 'ghjkl', '2013-03-25 00:00:00', 'sdsdfg', '0', '刘将', '2019-05-14 14:33:20');
INSERT INTO `bookinfo` VALUES ('5', '程序设计第二版', '张三', '张飒', '89.00', '435435', '2019-05-11 00:00:00', '工业出版社', '1', '赵六', '2019-05-31 12:59:11');
INSERT INTO `bookinfo` VALUES ('6', '语言', '是的发生的', '水电费', '56.00', '5546', '2019-05-12 00:00:00', '电饭锅', '1', 'erect', '2019-05-31 10:43:40');

-- ----------------------------
-- Table structure for borrowrecords
-- ----------------------------
DROP TABLE IF EXISTS `borrowrecords`;
CREATE TABLE `borrowrecords` (
  `BorrowID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(20) NOT NULL,
  `BookId` varchar(20) NOT NULL,
  `BookName` varchar(20) NOT NULL,
  `BorrowTime` datetime NOT NULL,
  `ShouldTime` datetime NOT NULL,
  `ReturnTime` datetime DEFAULT NULL,
  `State` int(11) NOT NULL,
  PRIMARY KEY (`BorrowID`,`UserId`,`BookId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrowrecords
-- ----------------------------
INSERT INTO `borrowrecords` VALUES ('1', '11603990711', '1', 'c语言', '2019-05-15 23:02:29', '2019-05-31 23:02:35', '2019-05-07 23:51:03', '0');
INSERT INTO `borrowrecords` VALUES ('2', '11603990711', '2', '数学', '2019-05-15 23:03:24', '2019-05-30 23:03:28', '2019-05-01 23:51:10', '0');
INSERT INTO `borrowrecords` VALUES ('3', '11603990711', '3', '英语', '2019-05-01 00:33:41', '2019-05-31 00:33:48', '2019-05-28 09:07:38', '1');
INSERT INTO `borrowrecords` VALUES ('12', '11603990711', '4', 'c语言', '2019-05-26 02:35:13', '2019-06-26 02:35:13', '2019-05-26 12:27:34', '1');
INSERT INTO `borrowrecords` VALUES ('15', '11603990711', '4', 'c语言', '2019-05-26 12:43:08', '2019-06-26 12:43:08', '2019-05-26 12:52:33', '1');
INSERT INTO `borrowrecords` VALUES ('16', '11603990711', '5', '程序设计', '2019-05-26 12:59:58', '2019-06-26 12:59:58', '2019-05-26 13:00:43', '1');
INSERT INTO `borrowrecords` VALUES ('18', '11603990711', '5', '程序设计', '2019-05-26 13:35:38', '2019-06-26 13:35:38', '2019-05-26 13:35:49', '1');
INSERT INTO `borrowrecords` VALUES ('19', '11603990711', '3', '英语', '2019-05-28 09:08:37', '2019-06-28 09:08:37', '2019-05-30 20:38:05', '1');
INSERT INTO `borrowrecords` VALUES ('20', '11603990718', '4', 'c语言', '2019-05-30 00:18:04', '2019-06-30 00:18:04', '2019-06-15 00:28:24', '1');
INSERT INTO `borrowrecords` VALUES ('21', '11603990711', '4', 'c语言', '2019-05-30 00:29:28', '2019-06-30 00:29:28', '2019-06-13 00:32:46', '1');
INSERT INTO `borrowrecords` VALUES ('22', '11603990711', '4', 'c语言', '2019-05-30 00:33:04', '2019-06-30 00:33:04', '2019-05-30 00:49:08', '1');
INSERT INTO `borrowrecords` VALUES ('23', '11603990716', '4', 'c语言', '2019-05-30 19:24:26', '2019-06-30 19:24:26', '2019-05-30 19:25:21', '1');
INSERT INTO `borrowrecords` VALUES ('24', '11603990711', '4', 'c语言', '2019-05-30 20:17:28', '2019-06-30 20:17:28', '2019-05-30 20:18:16', '1');
INSERT INTO `borrowrecords` VALUES ('25', '11603990715', '5', '程序设计', '2019-05-30 20:37:11', '2019-06-30 20:37:11', '2019-05-30 20:37:47', '1');
INSERT INTO `borrowrecords` VALUES ('26', '11603990711', '4', 'c语言', '2019-05-30 20:44:52', '2019-06-30 20:44:52', '2019-05-30 20:45:08', '1');
INSERT INTO `borrowrecords` VALUES ('27', '11603990711', '4', 'c语言', '2019-05-31 10:42:40', '2019-06-30 10:42:40', null, '0');

-- ----------------------------
-- Table structure for systemadmin
-- ----------------------------
DROP TABLE IF EXISTS `systemadmin`;
CREATE TABLE `systemadmin` (
  `AdminId` varchar(20) NOT NULL,
  `AdminName` varchar(20) NOT NULL,
  `AdminPassword` varchar(20) NOT NULL,
  `AdminPhone` varchar(20) NOT NULL,
  `AdminEmail` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AdminId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemadmin
-- ----------------------------
INSERT INTO `systemadmin` VALUES ('111111', 'sysadmin', 'root', '456545654', '4565456@qq.com');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `UserId` varchar(20) NOT NULL,
  `UserName` varchar(20) NOT NULL,
  `PassWord` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('11603990711', '李镇才', 'admin');
INSERT INTO `user` VALUES ('11603990715', '东方闪电', 'root');
INSERT INTO `user` VALUES ('11603990716', 'zhang', 'root');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `UserId` varchar(20) NOT NULL,
  `Departments` varchar(20) NOT NULL,
  `Major` varchar(20) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(20) DEFAULT NULL,
  `Max` int(11) NOT NULL,
  `Time` int(11) NOT NULL,
  `LendedNum` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('11603990711', '计算机科学与工程学院', '计算机科学与技术', '15215078000', '2961136411@qq.com', '15', '33', '2');
INSERT INTO `userinfo` VALUES ('11603990715', '是的', '水电费', '14343553', '似懂非懂是', '10', '30', '0');
INSERT INTO `userinfo` VALUES ('11603990716', '计算机科学与工程学院', '计算机', '143267890', '999@qq.com', '15', '30', '0');
