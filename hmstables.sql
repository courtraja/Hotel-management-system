CREATE TABLE `seed_session` (
  `id` INT(6) NOT NULL AUTO_INCREMENT,
  `sessions` VARCHAR(20) DEFAULT NULL,
  `from_time` TIME DEFAULT NULL,
  `to_time` TIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) 

INSERT  INTO `seed_session`(`id`,`sessions`,`from_time`,`to_time`) VALUES 

(1,'Break_fast','08:00:00','11:00:00'),

(2,'Lunch','11:15:00','15:00:00'),

(3,'Refreshment','15:15:00','23:00:00'),

(4,'Dinner','00:00:00','07:00:00');

CREATE TABLE `seed_seat` (
  `seat_no` INT(6) NOT NULL AUTO_INCREMENT,
  `stat` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`seat_no`)
)

INSERT  INTO `seed_seat`(`seat_no`,`stat`) VALUES 

(11,'allotted'),

(12,'allotted'),

(13,'available'),

(14,'available'),

(15,'available'),

(16,'available'),

(17,'available'),

(18,'available'),

(19,'available'),

(20,'available');


CREATE TABLE `seed_food` (
  `foo_id` INT(6) NOT NULL,
  `food_name` VARCHAR(20) DEFAULT NULL,
  `food_price` INT(6) DEFAULT NULL,
  PRIMARY KEY (`foo_id`)
) 

INSERT  INTO `seed_food`(`foo_id`,`food_name`,`food_price`) VALUES 

(1,'idly',10),

(2,'vada',5),

(3,'dosa',10),

(4,'poori',20),

(5,'pongal',20),

(6,'coffee',10),

(7,'tea',10),

(8,'south-indian-meals',40),

(9,'north-indian-thali',50),

(10,'variety-rice',40),

(11,'snacks',20),

(12,'fried-rice',50),

(13,'chapatti',20),

(14,'chat-items',30);


CREATE TABLE `order_details` (
  `id` INT(6) NOT NULL AUTO_INCREMENT,
  `seat_no` INT(6) DEFAULT NULL,
  `order_id` INT(6) DEFAULT NULL,
  `price` INT(10) DEFAULT NULL,
  `statuss` VARCHAR(20) DEFAULT NULL,
  `ordered_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;



INSERT  INTO `order_details`(`id`,`seat_no`,`order_id`,`price`,`statuss`,`ordered_date`) VALUES 

(6,11,1,90,'ordered','2017-01-19 00:34:08');



CREATE TABLE `food_ordered` (
  `id` INT(6) NOT NULL AUTO_INCREMENT,
  `order_id` INT(6) DEFAULT NULL,
  `food_id` INT(6) DEFAULT NULL,
  `quantity` INT(6) DEFAULT NULL,
  `price` INT(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) 

INSERT  INTO `food_ordered`(`id`,`order_id`,`food_id`,`quantity`,`price`) VALUES 

(5,1,16,1,30),

(6,1,16,2,60);


CREATE TABLE `order_max` (
  `id` INT(6) NOT NULL AUTO_INCREMENT,
  `max_order` INT(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) 

INSERT  INTO `order_max`(`id`,`max_order`) VALUES 

(1,5);

CREATE TABLE `food_table` (
  `s_id` INT(6) NOT NULL,
  `foo_id` INT(6) NOT NULL,
  `session_id` INT(6) NOT NULL,
  `quantity_of_food` INT(6) DEFAULT NULL,
  PRIMARY KEY (`foo_id`,`session_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `food_table_ibfk_2` FOREIGN KEY (`foo_id`) REFERENCES `seed_food` (`foo_id`),
  CONSTRAINT `food_table_ibfk_3` FOREIGN KEY (`session_id`) REFERENCES `seed_session` (`id`)
) 

/*Data for the table `food_table` */

INSERT  INTO `food_table`(`s_id`,`foo_id`,`session_id`,`quantity_of_food`) VALUES 

(1,1,1,100),

(2,2,1,100),

(3,3,1,100),

(4,4,1,100),

(5,5,1,100),

(6,6,1,100),

(11,6,3,200),

(7,7,1,100),

(12,7,3,200),

(8,8,2,75),

(9,9,2,75),

(10,10,2,75),

(13,11,3,200),

(14,12,4,100),

(15,13,4,100),

(16,14,4,100);


