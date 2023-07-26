/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 19/07/2023 15:15:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '奶茶专区');
INSERT INTO `category` VALUES (2, '甜品/蛋糕');
INSERT INTO `category` VALUES (3, '包子/早点');
INSERT INTO `category` VALUES (4, '午饭套餐');
INSERT INTO `category` VALUES (5, '肉类炒菜');
INSERT INTO `category` VALUES (6, '素菜专区');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '买家地址',
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '买家联系方式',
  `status` int NULL DEFAULT 0 COMMENT '状态，0：普通用户，1：会员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 'byh', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', '5A124', '123456', 1);
INSERT INTO `customer` VALUES (2, 'li4', '123', '茂南区', '18123456789', 0);
INSERT INTO `customer` VALUES (3, 'wang5', '123', 'wodedizhi ', '1112424212', 1);
INSERT INTO `customer` VALUES (4, 'zzf', '123456', '广东省茂名市', '13512345678', 0);
INSERT INTO `customer` VALUES (5, 'hcb', '123456', '广东省茂名市', '13512345678', 0);

-- ----------------------------
-- Table structure for order_
-- ----------------------------
DROP TABLE IF EXISTS `order_`;
CREATE TABLE `order_`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '买家地址',
  `status` int NULL DEFAULT 0 COMMENT '支付状态，0：未支付，1：正在发货，2：已发货，3：已收货',
  `cstid` int NULL DEFAULT NULL COMMENT '买家id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cstid`(`cstid` ASC) USING BTREE,
  CONSTRAINT `order__ibfk_1` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_
-- ----------------------------
INSERT INTO `order_` VALUES (1, '202305142258590224781', '姓名：小黄,邮箱：2452286529@qq.com,配送地址：广东省茂名市,手机号：13512345678', 2, 4);
INSERT INTO `order_` VALUES (2, '202305151204219744719', '姓名：利昂内尔梅溪,邮箱：1179748533@qq.com,配送地址：广东省茂名市,手机号：13512345678', 1, 4);
INSERT INTO `order_` VALUES (4, '202305312158041601705', '姓名：利昂内尔梅溪,邮箱：1179748533@qq.com,配送地址：广东省茂名市,手机号：13512345678', 2, 5);
INSERT INTO `order_` VALUES (5, '202306041114166079475', '姓名：利昂内尔梅溪,邮箱：1179748533@qq.com,配送地址：广东省茂名市,手机号：13512345678', 2, 5);

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int NULL DEFAULT NULL COMMENT '商品id',
  `oid` int NULL DEFAULT NULL COMMENT '订单id',
  `cstid` int NULL DEFAULT NULL COMMENT '买家id',
  `number` int NULL DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid` ASC) USING BTREE,
  INDEX `oid`(`oid` ASC) USING BTREE,
  INDEX `cstid`(`cstid` ASC) USING BTREE,
  CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `order_` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `orderitem_ibfk_3` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES (1, 4, 1, 1, 5);
INSERT INTO `orderitem` VALUES (2, 5, 1, 1, 1);
INSERT INTO `orderitem` VALUES (3, 3, 2, 1, 1);
INSERT INTO `orderitem` VALUES (4, 2, NULL, 1, 1);
INSERT INTO `orderitem` VALUES (5, 4, 4, 1, 3);
INSERT INTO `orderitem` VALUES (6, 5, 1, 1, 2);
INSERT INTO `orderitem` VALUES (7, 8, 2, 1, 1);
INSERT INTO `orderitem` VALUES (8, 10, NULL, 1, 11);
INSERT INTO `orderitem` VALUES (9, 1, 4, 1, 14);
INSERT INTO `orderitem` VALUES (10, 2, 1, 1, 4);
INSERT INTO `orderitem` VALUES (11, 1, 2, NULL, 2);
INSERT INTO `orderitem` VALUES (12, 14, NULL, NULL, 1);
INSERT INTO `orderitem` VALUES (13, 2, 4, NULL, 1);
INSERT INTO `orderitem` VALUES (14, 1, 1, NULL, 1);
INSERT INTO `orderitem` VALUES (18, 2, 5, 5, 1);
INSERT INTO `orderitem` VALUES (19, 1, NULL, 5, 1);
INSERT INTO `orderitem` VALUES (20, 9, NULL, 5, 1);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission_desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '删除分类', '删除分类', '/category/delCategory');
INSERT INTO `permission` VALUES (2, '分类列表', '查看分类列表', '/category/list');
INSERT INTO `permission` VALUES (3, '修改分类页面', '修改分类页面', '/category/editCategory');
INSERT INTO `permission` VALUES (4, '添加商品分类', '添加商品分类', '/category/addCategory');
INSERT INTO `permission` VALUES (5, '查看管理员列表', '查看管理员列表', '/config/listUser');
INSERT INTO `permission` VALUES (6, '查看角色列表', '可增删改查', '/config/listRole');
INSERT INTO `permission` VALUES (7, '查看权限列表', '无', '/config/listPermission');
INSERT INTO `permission` VALUES (8, '修改管理员信息界面', '修改界面', '/config/editUser');
INSERT INTO `permission` VALUES (9, '更新管理员信息', '无', '/config/updateUser');
INSERT INTO `permission` VALUES (10, '管理员删除', '删除', '/config/deleteUser');
INSERT INTO `permission` VALUES (11, '添加管理员界面', '无', '/config/adminAdd');
INSERT INTO `permission` VALUES (12, '添加管理员', '无', '/config/addUser');
INSERT INTO `permission` VALUES (13, '商品列表', '查看商品列表', '/product/list');
INSERT INTO `permission` VALUES (14, '添加商品', '添加上线商品', '/product/addProduct');
INSERT INTO `permission` VALUES (15, '删除商品', '暂无', '/product/deleteProduct');
INSERT INTO `permission` VALUES (16, '修改商品界面', '暂无', '/product/editProduct');
INSERT INTO `permission` VALUES (17, '更新商品', '暂无', '/product/updateProduct');
INSERT INTO `permission` VALUES (18, '添加商品界面', '暂无', '/product/productAddUI');
INSERT INTO `permission` VALUES (19, '商品上线', '暂无', '/product/enableStatus');
INSERT INTO `permission` VALUES (20, '商品下线', '暂无', '/product/stopStatus');
INSERT INTO `permission` VALUES (21, '订单发货', '暂无', '/order/orderDelivery');
INSERT INTO `permission` VALUES (22, '查看订单项', '暂无', '/order/seeOrderItem');
INSERT INTO `permission` VALUES (23, '评论列表', '暂无', '/review/list');
INSERT INTO `permission` VALUES (24, '删除评论', '暂无', '/review/del');
INSERT INTO `permission` VALUES (25, '查看订单列表', '暂无', '/order/list');
INSERT INTO `permission` VALUES (26, '添加权限UI', '暂无', '/config/adminPerAddUI');
INSERT INTO `permission` VALUES (27, '添加权限', '暂无', '/config/addPermission');
INSERT INTO `permission` VALUES (28, '删除权限', '暂无', '/config/deletePermission');
INSERT INTO `permission` VALUES (29, '修改权限ui', '暂无', '/config/editPermission');
INSERT INTO `permission` VALUES (30, '更新权限', '暂无', '/config/updatePermission');
INSERT INTO `permission` VALUES (31, '查看用户列表', '暂无', '/customer/list');
INSERT INTO `permission` VALUES (32, '删除角色', '暂无', '/config/deleteRole');
INSERT INTO `permission` VALUES (33, '添加管理员UI', '暂无', '/config/adminAdd');
INSERT INTO `permission` VALUES (34, '添加管理员', '暂未', '/config/addUser');
INSERT INTO `permission` VALUES (35, '修改角色UI', '暂无', '/config/editRole');
INSERT INTO `permission` VALUES (36, '修改角色', '暂无', '/config/updateRole');
INSERT INTO `permission` VALUES (37, '添加角色UI', '暂无', '/config/addRoleUI');
INSERT INTO `permission` VALUES (38, '添加角色', '暂无', '/config/addRole');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `price` float(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `zan` int NULL DEFAULT NULL COMMENT '赞',
  `number` int NULL DEFAULT NULL COMMENT '销量',
  `status` int NULL DEFAULT 1 COMMENT '状态，1：上线，0：下线',
  `imageurl` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片url',
  `miaoshu` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品描述',
  `cid` int NULL DEFAULT NULL COMMENT '分类id',
  `bid` bigint NULL DEFAULT NULL COMMENT '商家id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_ibfk_1`(`cid` ASC) USING BTREE,
  INDEX `product_ibfk_2`(`bid` ASC) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`bid`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '红豆布丁烧奶', 9.00, 54, 94, 1, 'product/1.jpg', '软糯红豆嫩布丁，鲜香甘甜，浓郁的奶香与红豆完美相融，满足感充分体现在你的唇齿和心间', 1, 3);
INSERT INTO `product` VALUES (2, '焦糖珍奶', 10.00, 98, 103, 1, 'product/2.jpg', '奶茶中的经典款，用不过时，焦糖的甜珍奶的鲜，永远有人喜欢。', 1, 3);
INSERT INTO `product` VALUES (3, '葡萄柚益菌多', 15.00, 45, 63, 1, 'product/3.jpg', '新鲜葡萄柚与优菌多相遇，酸甜的滋味在唇齿间流转，只需闭上眼用心品味这让人欲罢不能的清爽感。', 1, 3);
INSERT INTO `product` VALUES (4, '芒果布丁奶绿', 13.00, 41, 43, 1, 'product/4.jpg', '清香可口的海南大金煌与柔滑香的甜奶布丁，层层叠加，混搭滋味，随心选择。', 1, 3);
INSERT INTO `product` VALUES (5, '金桔柠檬茶', 18.00, 72, 168, 1, 'product/5.jpg', '打破传统奶盖与茶饮分离的做法，将咸奶盖与芒果冰均匀融合。芒果冰的爽滑细腻与咸奶盖的香浓完美融合，口感清甜饱满，独家特制芒砂糖将芒果本身的香甜气息发挥到极致。', 1, 4);
INSERT INTO `product` VALUES (6, '蜂蜜柚子茶', 18.00, 74, 159, 1, 'product/6.jpg', '不仅是味道清香可口，更是一款有美白祛斑、嫩肤养颜功效的食品。蜂蜜中含有的L－半胱氨酸具有排毒作用，具有一定的祛斑效果。', 1, 5);
INSERT INTO `product` VALUES (7, '巧克力水果蛋糕', 68.00, 75, 101, 1, 'product/7.jpg', '本店蛋糕现做现卖，由于蛋糕的特殊性，请顾客提前义雄安史预定。联系电话：12312345678', 2, 4);
INSERT INTO `product` VALUES (8, '心心相印', 88.00, 45, 99, 1, 'product/8.jpg', '为了保证蛋糕的新鲜！所有商品均为顾客下单现做！为了不耽误亲们的宝贵时间，请尽量提前一小时下单！详情致电：12312345678', 2, 4);
INSERT INTO `product` VALUES (9, '美味奶油蛋糕', 45.00, 45, 56, 1, 'product/9.jpg', '本店蛋糕现做现卖，请顾客朋友提前预定电话：12312345678', 2, 4);
INSERT INTO `product` VALUES (10, '至尊奶油蛋糕', 98.00, 235, 420, 1, 'product/10.jpg', '本店蛋糕现做现卖，由于蛋糕的特殊性，请顾客提前2小时预定。联系电话：12312345678', 2, 5);
INSERT INTO `product` VALUES (11, '丰盛果园', 133.00, 356, 2762, 1, 'product/11.jpg', '（15人餐）本店蛋糕现做现卖，请顾客提亲1小时预定，联系电话：12312345678', 2, 5);
INSERT INTO `product` VALUES (12, '太阳花', 166.00, 124, 369, 1, 'product/12.jpg', '（20人餐）本店蛋糕现做现卖，请顾客提前一小时预定。联系电话：12312345678', 2, 5);
INSERT INTO `product` VALUES (13, '初见', 105.00, 124, 234, 1, 'product/13.jpg', '（12餐）本店蛋糕现做现卖，请顾客提前一小时预定，联系电话：12312345678', 2, 6);
INSERT INTO `product` VALUES (14, '香辣鸡腿堡', 5.00, 124, 254, 1, 'product/14.jpg', '开业特惠，豪吃不贵！限时特价商品', 3, 6);
INSERT INTO `product` VALUES (15, '墨西哥肌肉卷', 19.00, 453, 454, 1, 'product/15.jpg', '里面用的是番茄酱哈', 3, 6);
INSERT INTO `product` VALUES (16, '爆浆鸡排', 12.00, 45, 4654, 1, 'product/16.jpg', '香脆可口', 3, 6);
INSERT INTO `product` VALUES (17, '椰奶芝士蛋糕', 11.00, 54, 132, 1, 'product/17.jpg', '该商品暂无描述', 3, 6);
INSERT INTO `product` VALUES (18, '南瓜脆皮芝士包', 8.00, 15, 232, 1, 'product/18.jpg', '暂无商品信息', 3, 6);
INSERT INTO `product` VALUES (19, '核桃布里奥斯', 23.00, 33, 323, 1, 'product/19.jpg', '定制设计', 3, 5);
INSERT INTO `product` VALUES (20, '卤肉配牛丸', 45.00, 45, 555, 1, 'product/20.jpg', '把简单的事情做到不简单，这就是我们存在的意义。优质猪后腿肉，在浓郁的老卤的怀抱中千回百转。30余味的精选香料与肉块的完美融合。', 4, 5);
INSERT INTO `product` VALUES (25, '雪花鸡排饭', 42.00, 444, 444, 1, 'product/25.jpg', '鸡腿+脆骨肠+配菜+饮料+米饭', 4, 5);
INSERT INTO `product` VALUES (26, '劲爆麻辣牛肉饭', 35.00, 23, 43, 1, 'product/26.jpg', '牛排+脆骨肠+配菜+饮料+米饭', 4, 5);
INSERT INTO `product` VALUES (27, '蜜汁牛排饭', 25.00, 34, 53, 1, 'product/27.jpg', '牛排+脆骨肠+配菜+饮料+米饭', 4, 5);
INSERT INTO `product` VALUES (28, '小熊卤肉饭', 23.00, 34, 23, 1, 'product/28.jpg', '卤香十足，香甜可口，回味无穷，超级好吃', 4, 5);
INSERT INTO `product` VALUES (29, '法式炸鸡饭', 23.00, 43, 65, 1, 'product/29.jpg', '暂无介绍', 4, 5);
INSERT INTO `product` VALUES (30, '清蒸大闸蟹', 98.00, 456, 998, 1, 'product/30.jpg', '3.5重的大公蟹，肉质鲜美，淘宝都卖一百四五一只，本店只卖98', 5, 6);
INSERT INTO `product` VALUES (31, '单煎牛排', 45.00, 98, 564, 1, 'product/31.jpg', '只提供新鲜牛排', 6, 4);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '该用户默认给出了好评！！！' COMMENT '评论内容',
  `cstid` int NULL DEFAULT NULL COMMENT '用户id',
  `pid` int NULL DEFAULT NULL COMMENT '商品id',
  `createtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cstid`(`cstid` ASC) USING BTREE,
  INDEX `pid`(`pid` ASC) USING BTREE,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`cstid`) REFERENCES `customer` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, '我是评论', 1, 4, '2023-05-25 10:52:37');
INSERT INTO `review` VALUES (2, 'w is pl ', 1, 5, '2023-05-25 10:54:24');
INSERT INTO `review` VALUES (3, 'aa', 1, 4, '2023-05-25 17:15:37');
INSERT INTO `review` VALUES (4, '我是一条评论', 1, 4, '2023-05-25 17:50:33');
INSERT INTO `review` VALUES (5, 'kl0', 1, 4, '2023-05-25 20:38:35');
INSERT INTO `review` VALUES (6, '77777', 1, 4, '2023-05-26 09:36:30');
INSERT INTO `review` VALUES (7, 'pjia ', 1, 4, '2023-05-26 09:38:49');
INSERT INTO `review` VALUES (8, '我是评价', 1, 2, '2023-05-26 09:41:12');
INSERT INTO `review` VALUES (9, '测试评价', 1, 10, '2023-05-27 16:32:08');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_desc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'admin', '超级管理员');
INSERT INTO `role` VALUES (2, 'productManager', '商品管理员');
INSERT INTO `role` VALUES (3, '游客', '只能查看，不能增删改');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rid` bigint NULL DEFAULT NULL,
  `pid` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (1, 3, 2);
INSERT INTO `role_permission` VALUES (2, 3, 5);
INSERT INTO `role_permission` VALUES (3, 3, 6);
INSERT INTO `role_permission` VALUES (4, 3, 7);
INSERT INTO `role_permission` VALUES (5, 3, 13);
INSERT INTO `role_permission` VALUES (6, 3, 22);
INSERT INTO `role_permission` VALUES (7, 3, 23);
INSERT INTO `role_permission` VALUES (8, 3, 25);
INSERT INTO `role_permission` VALUES (9, 1, 38);
INSERT INTO `role_permission` VALUES (10, 1, 37);
INSERT INTO `role_permission` VALUES (11, 1, 36);
INSERT INTO `role_permission` VALUES (12, 1, 35);
INSERT INTO `role_permission` VALUES (13, 1, 34);
INSERT INTO `role_permission` VALUES (14, 1, 33);
INSERT INTO `role_permission` VALUES (15, 1, 32);
INSERT INTO `role_permission` VALUES (16, 1, 31);
INSERT INTO `role_permission` VALUES (17, 1, 30);
INSERT INTO `role_permission` VALUES (18, 1, 29);
INSERT INTO `role_permission` VALUES (19, 1, 28);
INSERT INTO `role_permission` VALUES (20, 1, 27);
INSERT INTO `role_permission` VALUES (21, 1, 26);
INSERT INTO `role_permission` VALUES (22, 1, 25);
INSERT INTO `role_permission` VALUES (23, 1, 24);
INSERT INTO `role_permission` VALUES (24, 1, 23);
INSERT INTO `role_permission` VALUES (25, 1, 22);
INSERT INTO `role_permission` VALUES (26, 1, 21);
INSERT INTO `role_permission` VALUES (27, 1, 20);
INSERT INTO `role_permission` VALUES (28, 1, 19);
INSERT INTO `role_permission` VALUES (29, 1, 18);
INSERT INTO `role_permission` VALUES (30, 1, 17);
INSERT INTO `role_permission` VALUES (31, 1, 16);
INSERT INTO `role_permission` VALUES (32, 1, 15);
INSERT INTO `role_permission` VALUES (33, 1, 14);
INSERT INTO `role_permission` VALUES (34, 1, 13);
INSERT INTO `role_permission` VALUES (35, 1, 12);
INSERT INTO `role_permission` VALUES (36, 1, 11);
INSERT INTO `role_permission` VALUES (37, 1, 10);
INSERT INTO `role_permission` VALUES (38, 1, 9);
INSERT INTO `role_permission` VALUES (39, 1, 8);
INSERT INTO `role_permission` VALUES (40, 1, 7);
INSERT INTO `role_permission` VALUES (41, 1, 6);
INSERT INTO `role_permission` VALUES (42, 1, 5);
INSERT INTO `role_permission` VALUES (43, 1, 4);
INSERT INTO `role_permission` VALUES (44, 1, 3);
INSERT INTO `role_permission` VALUES (45, 1, 2);
INSERT INTO `role_permission` VALUES (46, 1, 1);
INSERT INTO `role_permission` VALUES (47, 2, 25);
INSERT INTO `role_permission` VALUES (48, 2, 23);
INSERT INTO `role_permission` VALUES (49, 2, 22);
INSERT INTO `role_permission` VALUES (50, 2, 21);
INSERT INTO `role_permission` VALUES (51, 2, 20);
INSERT INTO `role_permission` VALUES (52, 2, 19);
INSERT INTO `role_permission` VALUES (53, 2, 18);
INSERT INTO `role_permission` VALUES (54, 2, 17);
INSERT INTO `role_permission` VALUES (55, 2, 16);
INSERT INTO `role_permission` VALUES (56, 2, 15);
INSERT INTO `role_permission` VALUES (57, 2, 14);
INSERT INTO `role_permission` VALUES (58, 2, 13);
INSERT INTO `role_permission` VALUES (59, 2, 4);
INSERT INTO `role_permission` VALUES (60, 2, 3);
INSERT INTO `role_permission` VALUES (61, 2, 2);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员姓名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员密码',
  `status` int NULL DEFAULT NULL COMMENT '状态，1：启用，0：停用',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '暂无' COMMENT '商家管理员地址',
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lasttime` date NULL DEFAULT NULL COMMENT '最后登陆时间',
  `deleted` int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '小白', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '暂无', '12445242532', '2023-06-09', 0);
INSERT INTO `user` VALUES (2, 'visitor', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '暂无', '12456458532', '2023-05-25', 0);
INSERT INTO `user` VALUES (3, '避风港', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '茂南区', '18123456789', '2023-05-25', 0);
INSERT INTO `user` VALUES (4, '小熊早餐店', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '电白区', '12453265428', '2023-05-25', 0);
INSERT INTO `user` VALUES (5, '美味私厨', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '化州', '15123456789', '2023-05-25', 0);
INSERT INTO `user` VALUES (6, '川西食府', '$2a$10$zInBOQr9d1SYtCTzmJtHjuokGd20dlVtC5qRcV3IpMU0Yu04.3Njm', 1, '高州', '12452253264', '2023-05-25', 0);
INSERT INTO `user` VALUES (43, 'string', '$2a$10$.u.P06sjeZ1mbkeewP66Gu2vOUxgqMfwfQ9C2JOrVC4XjmSVll0LG', 1, '广东省茂名市', '13512345678', NULL, 0);
INSERT INTO `user` VALUES (44, 'admin', '$2a$10$VNg0wc9AvA5KPHXKIqLdhe41TcSWg/CDQwULRIi0W/G/bC5ngyR3a', 0, '茂南区', '18123456789', NULL, 0);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` bigint NULL DEFAULT NULL,
  `rid` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 13, 2);
INSERT INTO `user_role` VALUES (3, 14, 2);
INSERT INTO `user_role` VALUES (4, 15, 2);
INSERT INTO `user_role` VALUES (5, 16, 2);
INSERT INTO `user_role` VALUES (6, 3, 3);
INSERT INTO `user_role` VALUES (8, 32, 2);
INSERT INTO `user_role` VALUES (9, 35, 1);
INSERT INTO `user_role` VALUES (10, 35, 2);

-- ----------------------------
-- Table structure for zixun
-- ----------------------------
DROP TABLE IF EXISTS `zixun`;
CREATE TABLE `zixun`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资讯内容',
  `cstid` int NULL DEFAULT NULL COMMENT '客户id',
  `status` int NULL DEFAULT 0 COMMENT '审核状态，1：通过，0：未通过;',
  `fabudate` datetime NULL DEFAULT NULL COMMENT '发布时间;',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of zixun
-- ----------------------------
INSERT INTO `zixun` VALUES (1, '我是第一条资讯', 1, 1, '2023-05-25 14:53:29');
INSERT INTO `zixun` VALUES (2, '我是第二个', 1, 1, '2023-05-25 18:05:42');
INSERT INTO `zixun` VALUES (3, 'aaaa', 1, 1, '2023-05-25 15:06:38');
INSERT INTO `zixun` VALUES (4, '我是一条没审核的资讯', 1, 0, '2023-05-25 15:20:07');
INSERT INTO `zixun` VALUES (6, '我想发布一条资讯', 1, 1, '2023-05-25 11:19:57');
INSERT INTO `zixun` VALUES (7, '666六六六', 5, 0, '2023-05-30 18:45:42');
INSERT INTO `zixun` VALUES (8, '666六六六', 5, 1, '2023-05-30 18:45:45');
INSERT INTO `zixun` VALUES (9, '666六六六', 5, 0, '2023-05-30 18:45:46');
INSERT INTO `zixun` VALUES (10, '666六六六', 5, 0, '2023-05-30 18:45:46');
INSERT INTO `zixun` VALUES (14, '你好', 5, 0, '2023-05-30 18:51:17');

SET FOREIGN_KEY_CHECKS = 1;
