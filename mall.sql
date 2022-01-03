/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : 81.69.235.254:3306
 Source Schema         : mall

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 12/23/2021 11:32:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT 'user_id外键',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人的电话号，可以与用户的电话号不同',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收货人姓名',
  `province` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '省份',
  `city` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市',
  `county` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区/县',
  `address_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细地址',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `address` VALUES (30,22, '18270860452', '廖睿', '北京市', '北京市', '东城区', '新建区学府大道南昌大学19栋学生公寓');
INSERT INTO `address` VALUES (29,15, '12312341234', '吴新宇', '江西省', '南昌市', '新建区', '新建区学府大道南昌大学19栋学生公寓');
INSERT INTO `address` VALUES (28,15, '12312341234', '姜淼', '江西省', '南昌市', '新建区', '新建区学府大道南昌大学19栋学生公寓');
INSERT INTO `address` VALUES (27,15, '12312341234', '刘小龙', '江西省', '南昌市', '新建区', '新建区学府大道南昌大学19栋学生公寓');
INSERT INTO `address` VALUES (26,15, '12312341234', '魏文奇', '江西省', '南昌市', '新建区', '新建区学府大道南昌大学19栋学生公寓');
INSERT INTO `address` VALUES (25,15, '12312341234', '何泽怡', '江西省', '西安市', '新建区', '新建区学府大道南昌大学21栋学生公寓');
INSERT INTO `address` VALUES (24,15, '12312341234', '廖睿', '江西省', '南昌市', '新建区', '新建区学府大道南昌大学19栋学生公寓');

DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise`  (
    `user_id` int(11) NOT NULL,
    `product_id` int(11) NOT NULL,
    `app_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '暂无评价',
    PRIMARY KEY (`user_id`, `product_id`) USING BTREE,
                            INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`, `product_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

INSERT INTO `collect` VALUES (1, 1);
INSERT INTO `collect` VALUES (6, 1);
INSERT INTO `collect` VALUES (1, 2);
INSERT INTO `collect` VALUES (6, 2);
INSERT INTO `collect` VALUES (1, 3);
INSERT INTO `collect` VALUES (5, 3);
INSERT INTO `collect` VALUES (15,10);
INSERT INTO `collect` VALUES (5,15);
INSERT INTO `collect` VALUES (15,15);
INSERT INTO `collect` VALUES (15, 18);
INSERT INTO `collect` VALUES (15, 19);
INSERT INTO `collect` VALUES (13, 45);
INSERT INTO `collect` VALUES (13, 46);
INSERT INTO `collect` VALUES (3, 69);

DROP TABLE IF EXISTS `logistic_com`;
CREATE TABLE `logistic_com`  (
  `logistic_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '物流公司id',
  `com_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物流公司名',
  PRIMARY KEY (`logistic_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `logistic_com` VALUES (1, '顺丰');
INSERT INTO `logistic_com` VALUES (2, '圆通');
INSERT INTO `logistic_com` VALUES (3, '韵达');
INSERT INTO `logistic_com` VALUES (4, 'ems');
INSERT INTO `logistic_com` VALUES (5, '中通');
INSERT INTO `logistic_com` VALUES (6, '菜鸟');

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `order_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `product_id` int(20) NOT NULL COMMENT '货物id',
  `product_num` int(10) NOT NULL COMMENT '货物数量',
  `price` double(20, 2) NOT NULL COMMENT '金额,货物的单价',
  `buyer_id` int(20) NOT NULL COMMENT '买家id',
  `seller_id` int(20) NOT NULL COMMENT '卖家id',
  `order_time` datetime NOT NULL COMMENT '生成时间',
  `buyer_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '买家地址',
  `seller_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卖家地址',
  `logistic_id` int(10) UNSIGNED NULL DEFAULT 1 COMMENT '物流公司id',
  `status` int(5) NOT NULL DEFAULT 0 COMMENT '订单状态；0--未发货，1--已发货，2--已签收',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `seller_id` int(20) NOT NULL COMMENT '卖家id',
  `product_type_id` int(20) NULL DEFAULT NULL COMMENT '类型id',
  `product_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货品名字',
  `product_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片路径',
  `price` double(20, 2) NOT NULL COMMENT '价格',
  `discount_price` double(20, 2) NULL DEFAULT NULL COMMENT '优惠价',
  `storage` int(20) NOT NULL COMMENT '库存',
  `sale` int(20) NULL DEFAULT NULL COMMENT '销量',
  `state` int(1) NOT NULL COMMENT '1：上架 ;  0 : 下架',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `product_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品描述',
  PRIMARY KEY (`product_id`) USING BTREE,
  INDEX `product_type`(`product_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `product` VALUES (10, 2, 1, '上衣', '1.jpg', 100.00, 94.00, 50, 10, 1, '2021-12-20 22:16:33', NULL, '一个短款上衣');
INSERT INTO `product` VALUES (11, 2, 1, '裙子', '2.jpg', 80.00, 75.00, 40, 12, 1, '2021-12-21 16:03:05', NULL, '一个丝绒长裙');
INSERT INTO `product` VALUES (12, 2, 1, '围巾', '3.jpg', 30.00, 28.00, 91, 50, 1, '2021-12-20 22:16:33', NULL, '羊毛针织围巾');
INSERT INTO `product` VALUES (13, 2, 1, '裤子', '4.jpg', 88.00, 80.00, 100, 40, 1, '2021-12-20 22:16:33', NULL, '牛仔短裤');
INSERT INTO `product` VALUES (14, 2, 6, '耳环', '5.jpg', 20.00, 16.00, 100, 50, 1, '2021-12-20 22:16:33', NULL, '银色流苏耳环');
INSERT INTO `product` VALUES (15, 2, 6, '项链', '6.jpg', 50.00, 45.00, 100, 20, 1, '2021-12-20 22:16:33', NULL, '锁骨链');
INSERT INTO `product` VALUES (16, 2, 6, '戒指', '7.jpg', 25.00, 20.00, 100, 40, 1, '2021-12-20 22:16:33', NULL, '情侣对戒');
INSERT INTO `product` VALUES (17, 2, 8, '饼干', '8.jpg', 5.00, 5.00, 100, 80, 1, '2021-12-20 22:16:33', NULL, '威化饼干');
INSERT INTO `product` VALUES (18, 2, 8, '面包', '9.jpg', 10.00, 8.00, 100, 99, 0, '2021-12-20 22:16:33', NULL, '肉松面包');
INSERT INTO `product` VALUES (19, 2, 8, '糖果', '10.jpg', 3.00, 2.00, 100, 66, 1, '2021-12-20 22:16:33', NULL, '巧克力味糖果');
INSERT INTO `product` VALUES (20, 2, 10, '耳机', '11.jpg', 200.00, 180.00, 200, 150, 1, '2021-12-20 22:16:33', NULL, '索尼耳机');
INSERT INTO `product` VALUES (21, 2, 10, '鼠标', '12.jpg', 50.00, 45.00, 500, 300, 1, '2021-12-20 22:16:33', NULL, '无线鼠标');
INSERT INTO `product` VALUES (71, 1, 12, 'VIP', '0.jpg', 0.00, 0.00, 999, 999, 1, '2021-12-31 20:00:59', NULL, '免费成为本网站的VIP！');

DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type`  (
  `product_type_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '货物分类id',
  `product_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名',
  PRIMARY KEY (`product_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `product_type` VALUES (1, '衣服');
INSERT INTO `product_type` VALUES (6, '饰品');
INSERT INTO `product_type` VALUES (8, '食品');
INSERT INTO `product_type` VALUES (10, '数码产品');

DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `product_id` int(20) NOT NULL COMMENT '货物id',
  `buyer_id` int(20) NOT NULL COMMENT '买家id',
  `price` double(20, 2) NOT NULL COMMENT '加入购物车时的商品单价',
  `num` int(20) NOT NULL COMMENT '货物数量',
  PRIMARY KEY (`product_id`, `buyer_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `shopping_cart` VALUES (21, 15, 45, 2);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名，登录用',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户类型 0管理员 1商家 2客户',
  `sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE COMMENT '用户名索引',
  UNIQUE INDEX `phone_number`(`phone_number`) USING BTREE COMMENT '手机号索引'
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

INSERT INTO `user` VALUES (1, 'admin', '18008597777', '管理员赵二', '123456789', '0', '男', NULL);
INSERT INTO `user` VALUES (2, 'shangjia', '13985391112', '卖家张三', '123456789', '1', '女', NULL);

SET FOREIGN_KEY_CHECKS = 1;