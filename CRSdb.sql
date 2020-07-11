/*
 Navicat Premium Data Transfer

 Source Server         : FCNS
 Source Server Type    : MySQL
 Source Server Version : 100317
 Source Host           : 202.123.183.188:53306
 Source Schema         : CRSdb

 Target Server Type    : MySQL
 Target Server Version : 100317
 File Encoding         : 65001

 Date: 09/06/2020 16:21:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api_member
-- ----------------------------
DROP TABLE IF EXISTS `api_member`;
CREATE TABLE `api_member`  (
  `apiemail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apipassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apiaccectoken` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apistatus` enum('active','inactive','close') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dristric
-- ----------------------------
DROP TABLE IF EXISTS `dristric`;
CREATE TABLE `dristric`  (
  `dr_id` int(3) NOT NULL,
  `dr_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dr_name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pr_id` int(2) NOT NULL,
  PRIMARY KEY (`dr_id`) USING BTREE,
  INDEX `pr_id`(`pr_id`) USING BTREE,
  CONSTRAINT `dristric_ibfk_1` FOREIGN KEY (`pr_id`) REFERENCES `province` (`pr_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for province
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province`  (
  `pr_id` int(2) NOT NULL,
  `pr_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pr_name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pr_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_advertrise
-- ----------------------------
DROP TABLE IF EXISTS `tb_advertrise`;
CREATE TABLE `tb_advertrise`  (
  `imagepath` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tital` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `des` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `id` int(5) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_customer
-- ----------------------------
DROP TABLE IF EXISTS `tb_customer`;
CREATE TABLE `tb_customer`  (
  `cusid` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gender` enum('Male','Female') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `firstname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lastname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone_number` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `create_date` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `province_id` int(2) NOT NULL,
  `district_id` int(3) NOT NULL,
  `village_id` int(10) NOT NULL,
  `password` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('inactive','active','lock','close') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `token` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `reset_token` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `imagepath` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cusid`) USING BTREE,
  UNIQUE INDEX `username`(`username`(100)) USING BTREE,
  INDEX `province_id`(`province_id`) USING BTREE,
  INDEX `district_id`(`district_id`) USING BTREE,
  CONSTRAINT `tb_customer_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `province` (`pr_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_customer_ibfk_2` FOREIGN KEY (`district_id`) REFERENCES `dristric` (`dr_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_customer_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_customer_type`;
CREATE TABLE `tb_customer_type`  (
  `cus_ty_id` int(5) NOT NULL AUTO_INCREMENT,
  `cus_ty_name_lao` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cus_ty_description_lao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cus_ty_name_eng` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cus_ty_description_eng` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`cus_ty_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_package
-- ----------------------------
DROP TABLE IF EXISTS `tb_package`;
CREATE TABLE `tb_package`  (
  `package_id` int(5) NOT NULL AUTO_INCREMENT,
  `package_name_lao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `package_speed` decimal(10, 0) NOT NULL,
  `package_price` int(10) NOT NULL,
  `package_amount_months` int(10) NOT NULL,
  `tb_customer_type_id` int(5) NOT NULL,
  `package_name_eng` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imagepath` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `package_type` int(5) NULL DEFAULT NULL,
  PRIMARY KEY (`package_id`) USING BTREE,
  INDEX `tb_customer_type_id`(`tb_customer_type_id`) USING BTREE,
  INDEX `package_type`(`package_type`) USING BTREE,
  CONSTRAINT `tb_package_ibfk_1` FOREIGN KEY (`tb_customer_type_id`) REFERENCES `tb_customer_type` (`cus_ty_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_package_ibfk_2` FOREIGN KEY (`package_type`) REFERENCES `tb_package_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_package_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_package_type`;
CREATE TABLE `tb_package_type`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `package_type_lao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `package_type_eng` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_register
-- ----------------------------
DROP TABLE IF EXISTS `tb_register`;
CREATE TABLE `tb_register`  (
  `re_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_status` enum('unpaid','paid') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'unpaid',
  `created_date` date NOT NULL,
  `package_id` int(11) NOT NULL,
  `customer_type_id` int(11) NOT NULL,
  `customer_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `details` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lg` decimal(18, 7) NOT NULL,
  `lat` decimal(18, 7) NOT NULL,
  `distance` decimal(10, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`re_id`) USING BTREE,
  INDEX `package_id`(`package_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `customer_type_id`(`customer_type_id`) USING BTREE,
  CONSTRAINT `tb_register_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `tb_package` (`package_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_register_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `tb_customer` (`cusid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_register_ibfk_4` FOREIGN KEY (`customer_type_id`) REFERENCES `tb_customer_type` (`cus_ty_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_temp
-- ----------------------------
DROP TABLE IF EXISTS `tb_temp`;
CREATE TABLE `tb_temp`  (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `lg` decimal(20, 7) NULL DEFAULT NULL,
  `lat` decimal(20, 7) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `active_port` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`temp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for village
-- ----------------------------
DROP TABLE IF EXISTS `village`;
CREATE TABLE `village`  (
  `vill_id` int(10) UNSIGNED NOT NULL,
  `vill_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `vill_name_en` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dr_id` int(3) NOT NULL,
  PRIMARY KEY (`vill_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for view_customer
-- ----------------------------
DROP VIEW IF EXISTS `view_customer`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_customer` AS select `tb_customer`.`cusid` AS `cusid`,`tb_customer`.`gender` AS `gender`,`tb_customer`.`firstname` AS `firstname`,`tb_customer`.`lastname` AS `lastname`,`tb_customer`.`phone_number` AS `phone_number`,`tb_customer`.`email` AS `email`,`tb_customer`.`password` AS `password`,`tb_customer`.`username` AS `username`,`tb_customer`.`status` AS `status`,`province`.`pr_name` AS `pr_name`,`province`.`pr_name_en` AS `pr_name_en`,`dristric`.`dr_name` AS `dr_name`,`dristric`.`dr_name_en` AS `dr_name_en`,`village`.`vill_name` AS `vill_name`,`village`.`vill_name_en` AS `vill_name_en`,`tb_customer`.`imagepath` AS `imagepath`,`tb_customer`.`create_date` AS `create_date` from (((`tb_customer` join `province` on(`tb_customer`.`province_id` = `province`.`pr_id`)) join `dristric` on(`tb_customer`.`district_id` = `dristric`.`dr_id` and `province`.`pr_id` = `dristric`.`pr_id`)) join `village` on(`tb_customer`.`village_id` = `village`.`vill_id`));

-- ----------------------------
-- View structure for view_package
-- ----------------------------
DROP VIEW IF EXISTS `view_package`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_package` AS select `tb_package`.`package_id` AS `package_id`,`tb_package`.`package_name_lao` AS `package_name_lao`,`tb_package`.`package_speed` AS `package_speed`,`tb_package`.`package_price` AS `package_price`,`tb_package`.`package_amount_months` AS `package_amount_months`,`tb_package`.`tb_customer_type_id` AS `tb_customer_type_id`,`tb_package`.`package_name_eng` AS `package_name_eng`,`tb_customer_type`.`cus_ty_name_lao` AS `cus_ty_name_lao`,`tb_customer_type`.`cus_ty_description_lao` AS `cus_ty_description_lao`,`tb_customer_type`.`cus_ty_name_eng` AS `cus_ty_name_eng`,`tb_customer_type`.`cus_ty_description_eng` AS `cus_ty_description_eng` from (`tb_package` join `tb_customer_type` on(`tb_package`.`tb_customer_type_id` = `tb_customer_type`.`cus_ty_id`));

-- ----------------------------
-- View structure for view_register
-- ----------------------------
DROP VIEW IF EXISTS `view_register`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_register` AS select `tb_register`.`re_id` AS `re_id`,`tb_package`.`package_name_lao` AS `package_name_lao`,`tb_package`.`package_speed` AS `package_speed`,`tb_package`.`package_price` AS `package_price`,`tb_package`.`package_amount_months` AS `package_amount_months`,`tb_package`.`package_name_eng` AS `package_name_eng`,`tb_customer`.`cusid` AS `cusid`,`tb_customer`.`gender` AS `gender`,`tb_customer`.`firstname` AS `firstname`,`tb_customer`.`lastname` AS `lastname`,`tb_customer`.`phone_number` AS `phone_number`,`tb_customer`.`email` AS `email`,`province`.`pr_name` AS `pr_name`,`village`.`vill_name` AS `vill_name`,`dristric`.`dr_name` AS `dr_name`,`tb_register`.`payment_status` AS `payment_status`,`tb_register`.`details` AS `details`,`tb_register`.`lg` AS `lg`,`tb_register`.`lat` AS `lat`,`tb_customer_type`.`cus_ty_name_lao` AS `cus_ty_name_lao`,`tb_customer_type`.`cus_ty_name_eng` AS `cus_ty_name_eng` from ((((((`tb_register` join `tb_customer` on(`tb_register`.`customer_id` = `tb_customer`.`cusid`)) join `tb_customer_type` on(`tb_register`.`customer_type_id` = `tb_customer_type`.`cus_ty_id`)) join `tb_package` on(`tb_register`.`package_id` = `tb_package`.`package_id` and `tb_customer_type`.`cus_ty_id` = `tb_package`.`tb_customer_type_id`)) join `province` on(`tb_customer`.`province_id` = `province`.`pr_id`)) join `dristric` on(`tb_customer`.`district_id` = `dristric`.`dr_id` and `province`.`pr_id` = `dristric`.`pr_id`)) join `village` on(`tb_customer`.`village_id` = `village`.`vill_id`));

-- ----------------------------
-- Procedure structure for api_member_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `api_member_insert`;
delimiter ;;
CREATE PROCEDURE `api_member_insert`(IN `apiemail` VARCHAR(100),IN `apipassword` VARCHAR(100),IN `apistatus` enum('active','inactive', 'lock'),IN token VARCHAR(255))
BEGIN
	INSERT into api_member (apiemail,apipassword,apistatus,apiaccectoken) 
	VALUES 
	(apiemail,apipassword,apistatus,token);  
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_advertrise
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_advertrise`;
delimiter ;;
CREATE PROCEDURE `pcd_advertrise`()
BEGIN
	SELECT * FROM tb_advertrise;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_advertrise_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_advertrise_insert`;
delimiter ;;
CREATE PROCEDURE `pcd_advertrise_insert`(IN `email` VARCHAR(100),IN `password` VARCHAR(225),IN `statusapi` VARCHAR(50))
BEGIN
	
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_advertrise_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_advertrise_update`;
delimiter ;;
CREATE PROCEDURE `pcd_advertrise_update`(IN itemsid INT, IN `imagepath` VARCHAR(100),IN `tital` VARCHAR(100),IN `des` VARCHAR(200))
BEGIN

	UPDATE tb_advertrise set imagepath=imagepath,tital=tital,des=des WHERE id = itemsid;

	SELECT * FROM tb_advertrise where id = itemsid;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_customer_type
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_customer_type`;
delimiter ;;
CREATE PROCEDURE `pcd_customer_type`()
BEGIN
SELECT * FROM tb_customer_type;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_customer_type_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_customer_type_insert`;
delimiter ;;
CREATE PROCEDURE `pcd_customer_type_insert`(IN `cus_ty_name_lao` VARCHAR(100), IN `cus_ty_description_lao` VARCHAR(25),IN `cus_ty_name_eng` VARCHAR(100) , IN `cus_ty_description_eng` VARCHAR(255))
BEGIN
insert tb_customer_type (cus_ty_name_lao,
cus_ty_description_lao,
cus_ty_name_eng,
cus_ty_description_eng
)  VALUES (cus_ty_name_lao,
cus_ty_description_lao,
cus_ty_name_eng,
cus_ty_description_eng);
SELECT * FROM tb_customer_type where cus_ty_id =(SELECT MAX(cus_ty_id) from tb_customer_type);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_customer_type_one
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_customer_type_one`;
delimiter ;;
CREATE PROCEDURE `pcd_customer_type_one`(IN `id` int)
BEGIN
SELECT * FROM tb_customer_type where cus_ty_id = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_customer_type_update
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_customer_type_update`;
delimiter ;;
CREATE PROCEDURE `pcd_customer_type_update`(IN `custyid` int ,IN `cus_ty_name_lao` VARCHAR(100), IN `cus_ty_description_lao` VARCHAR(25),IN `cus_ty_name_eng` VARCHAR(100) , IN `cus_ty_description_eng` VARCHAR(255))
BEGIN

update tb_customer_type SET cus_ty_name_lao=cus_ty_name_lao,
cus_ty_description_lao=cus_ty_description_lao,
cus_ty_name_eng=cus_ty_name_eng,
cus_ty_description_eng=cus_ty_description_eng
  where cus_ty_id = custyid;

SELECT * FROM tb_customer_type where cus_ty_id = custyid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_Demologin
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_Demologin`;
delimiter ;;
CREATE PROCEDURE `pcd_Demologin`(IN `demousername` VARCHAR(255))
BEGIN
	SELECT
	tb_customer.cusid, 
	tb_customer.gender, 
	tb_customer.firstname, 
	tb_customer.lastname, 
	tb_customer.phone_number, 
	tb_customer.email, 
	tb_customer.`status`,
tb_customer.`password`	
FROM
	tb_customer
	where tb_customer.username = demousername or email = demousername or phone_number = demousername ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_district
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_district`;
delimiter ;;
CREATE PROCEDURE `pcd_district`(IN `id` int)
BEGIN
IF id <> 0  THEN
SELECT
	 	
	dristric.dr_id, 
	dristric.dr_name, 
	dristric.dr_name_en
FROM
	dristric
	INNER JOIN
	province
	ON 
		dristric.pr_id = province.pr_id
		where province.pr_id = id;
ELSE
SELECT
	 	
	dristric.dr_id, 
	dristric.dr_name, 
	dristric.dr_name_en
FROM
	dristric
	INNER JOIN
	province
	ON 
		dristric.pr_id = province.pr_id;
		
END IF;

	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_find_token
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_find_token`;
delimiter ;;
CREATE PROCEDURE `pcd_find_token`(IN `token` TEXT)
BEGIN
SELECT
	tb_customer.cusid, 
	tb_customer.gender, 
	tb_customer.firstname, 
	tb_customer.lastname, 
	tb_customer.phone_number, 
	tb_customer.email, 
	tb_customer.`status`,
tb_customer.`password`	
FROM
	tb_customer
	where tb_customer.token = token  ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_package
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_package`;
delimiter ;;
CREATE PROCEDURE `pcd_package`()
BEGIN
	SELECT
	tb_package.package_id, 
	tb_package.package_name_lao, 
	tb_package.package_speed, 
	tb_package.package_price, 
	tb_package.package_amount_months, 
	tb_package.package_name_eng, 
	tb_package.imagepath, 
	tb_package_type.package_type_lao, 
	tb_package_type.package_type_eng, 
	tb_customer_type.cus_ty_name_lao, 
	tb_customer_type.cus_ty_description_lao, 
	tb_customer_type.cus_ty_name_eng, 
	tb_customer_type.cus_ty_description_eng, 
	tb_customer_type.cus_ty_id, 
	tb_package.package_type
FROM
	tb_package
	INNER JOIN
	tb_package_type
	ON 
		tb_package.package_type = tb_package_type.id
	INNER JOIN
	tb_customer_type
	ON 
		tb_package.tb_customer_type_id = tb_customer_type.cus_ty_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_package_insert
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_package_insert`;
delimiter ;;
CREATE PROCEDURE `pcd_package_insert`(IN `package_name_lao` VARCHAR(255) ,
IN `package_speed` DECIMAL(10,0),IN `package_price` int,IN `package_amount_month` INT,
IN `tb_customer_type_id` INT,IN `package_name_eng` VARCHAR(255),IN `imagepath` VARCHAR(255),IN `package_type` int)
BEGIN

INSERT INTO tb_package 
(
package_name_lao,
package_speed,
package_price,
package_amount_months,
tb_customer_type_id,
package_name_eng,
imagepath,
package_type
) 
VALUES 
(
package_name_lao,
package_speed,
package_price,
package_amount_month,
tb_customer_type_id,
package_name_eng,
imagepath,
package_type
);


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_province
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_province`;
delimiter ;;
CREATE PROCEDURE `pcd_province`()
BEGIN
	SELECT * FROM province;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_register
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_register`;
delimiter ;;
CREATE PROCEDURE `pcd_register`(`cusid` varchar(100) ,
  `gender` enum('Male','Female') ,
  `firstname` varchar(100) ,
  `lastname` varchar(100) ,
  `phone_number` varchar(15)  ,
  `email` varchar(100)  , 
  `province_id` int,
  `district_id` int,
  `village_id` int,
  `passwords` text  ,
  `username` varchar(100)  , 
  `package_id` int ,
  `customer_type_id` int , 
  `details` varchar(255)  ,
  `lg` decimal(18,7)  ,
  `lat` decimal(18,7))
BEGIN
	START TRANSACTION;
	INSERT INTO tb_customer
	(
	cusid,
	gender,
	firstname,
	lastname,
	phone_number,
	email,
	province_id,
	district_id,
	village_id,
	password,
	username,
	create_date

	)
	VALUES
	(
			cusid,
			gender,
			firstname,
			lastname,
			phone_number,
			email,
			province_id,
			district_id,
			village_id,
			passwords,
			username,
			NOW()
		
	);		
INSERT INTO tb_register 
	(	re_id,
	created_date,
	package_id,
	customer_type_id,
	customer_id,
	details,
	lg,
	lat
	) 
	VALUES
	(
	0,
	NOW(),
	package_id,
	customer_type_id,
	cusid,
	details,
	lg,
	lat
	);	
	COMMIT ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_tempdata
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_tempdata`;
delimiter ;;
CREATE PROCEDURE `pcd_tempdata`()
BEGIN
	SELECT * FROM tb_temp;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_updatetoken
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_updatetoken`;
delimiter ;;
CREATE PROCEDURE `pcd_updatetoken`(IN `updatetoken` TEXT , IN `democusid` VARCHAR(100))
BEGIN
UPDATE
	tb_customer
	set token = updatetoken
	where cusid = democusid;
	SELECT token,cusid FROM 	tb_customer where  cusid = democusid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_update_customer
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_update_customer`;
delimiter ;;
CREATE PROCEDURE `pcd_update_customer`(IN `cusid` varchar(100),IN `gender` enum('Male','Female'),IN `firstname` varchar(100),IN `lastname` varchar(100),IN `phone` varchar(15),IN `email` varchar(100),IN `provinceid` int,IN `districtid` int,IN `villageid` int , IN `apiusername` varchar(100))
BEGIN
START TRANSACTION;
UPDATE tb_customer set gender=gender , firstname = firstname , lastname=lastname,phone_number=phone,email=email,province_id=provinceid , district_id=districtid , village_id=villageid , username = apiusername
where cusid = cusid;
SELECT * from view_customer where view_customer.cusid = cusid; 
COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_update_userpassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_update_userpassword`;
delimiter ;;
CREATE PROCEDURE `pcd_update_userpassword`(IN `cusid` varchar(100),IN `apiusername` varchar(100), IN `apipassword` varchar(100))
BEGIN
START TRANSACTION;
UPDATE tb_customer set username = apiusername , password = apipassword
where cusid = cusid;
SELECT * from view_customer where view_customer.cusid = cusid; 
COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_view_customer
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_view_customer`;
delimiter ;;
CREATE PROCEDURE `pcd_view_customer`()
BEGIN
	SELECT * from view_register;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_view_customer_one
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_view_customer_one`;
delimiter ;;
CREATE PROCEDURE `pcd_view_customer_one`(IN id VARCHAR(100))
BEGIN
	SELECT * from view_register where view_register.cusid = id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for pcd_village
-- ----------------------------
DROP PROCEDURE IF EXISTS `pcd_village`;
delimiter ;;
CREATE PROCEDURE `pcd_village`(IN `id` int)
BEGIN
IF id <> 0  THEN
SELECT	
	village.vill_name, 
	village.vill_name_en, 
	village.vill_id
	
FROM
	village
	INNER JOIN
	dristric
	ON 
		village.dr_id = dristric.dr_id
		where village.dr_id = id;
ELSE
SELECT	
	village.vill_name, 
	village.vill_name_en, 
	village.vill_id
	
FROM
	village
	INNER JOIN
	dristric
	ON 
		village.dr_id = dristric.dr_id;
		
END IF;

	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
