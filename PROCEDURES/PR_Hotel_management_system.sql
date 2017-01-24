USE `raja_db`;


DELIMITER $$

CREATE
   
    PROCEDURE `raja_db`.`hotel_management_systems`(IN food_name VARCHAR(50),IN get_quantity VARCHAR(20),IN get_order_id INT,IN no_of_item INT,IN get_seat_number INT)
   
	BEGIN
         DECLARE first_name VARCHAR(20);

    DECLARE fname VARCHAR(20);

    DECLARE food_id VARCHAR(20);

    DECLARE first_quantity VARCHAR(20) ;  

    DECLARE quants VARCHAR(20);

    
    DECLARE cnt INT DEFAULT 0;
    DECLARE sess_id INT;

    DECLARE food_quantity INT;

    DECLARE fd_price INT;

    DECLARE final_price INT;

    DECLARE total_price INT;

    DECLARE i INT DEFAULT 0;
    
    IF NOT EXISTS(SELECT order_id FROM order_details WHERE order_id=get_order_id)
    THEN 

    IF (SELECT max_order FROM order_max WHERE order_max.id=1)>=no_of_item

            THEN 

            

           IF (SELECT stat FROM seed_seat WHERE seed_seat.seat_no=get_seat_number)='available'

           THEN 

                

              loop_exe : LOOP

               IF(i=no_of_item)

               THEN 

               LEAVE loop_exe;

                  END IF;

           SET first_name=(SELECT SUBSTRING_INDEX(food_name,',','1'));

           SET fname=(SELECT CONCAT(first_name,','));

           SET food_name= (SELECT REPLACE(food_name,fname,' '));

           SET food_name =(SELECT LTRIM(food_name));

           SET sess_id=(SELECT id FROM seed_session WHERE CURTIME() BETWEEN from_time AND to_time);

           SET food_id=(SELECT food_table.`s_id` FROM food_table JOIN seed_session JOIN seed_food WHERE food_table.`session_id`=seed_session.`id`
                        AND seed_food.foo_id=food_table.foo_id AND seed_food.food_name=first_name 
                        AND food_table.session_id=sess_id AND CURRENT_TIME() BETWEEN seed_session.`from_time` AND seed_session.`to_time`);         

           SET first_quantity=(SELECT SUBSTRING_INDEX(get_quantity,',','1'));

           SET quants=(SELECT CONCAT(first_quantity,','));

           SET get_quantity=(SELECT REPLACE(get_quantity,quants,' '));

           SET get_quantity=(SELECT LTRIM(get_quantity));

           

           SET food_quantity=(SELECT quantity_of_food FROM food_table WHERE s_id=food_id);

           

           IF EXISTS(SELECT seed_food.food_name FROM seed_food JOIN food_table WHERE seed_food.foo_id=food_table.foo_id AND food_table.s_id=food_id)

           THEN

		IF (food_quantity>=first_quantity)

		THEN

            

			IF CURTIME() BETWEEN (SELECT from_time FROM seed_session WHERE seed_session.id=sess_id) AND

			(SELECT to_time FROM seed_session WHERE seed_session.id=sess_id)

			THEN

			SELECT "your order is placed" AS statement;

			UPDATE food_table SET food_table.quantity_of_food=food_table.quantity_of_food-first_quantity WHERE s_id=food_id;

			SET fd_price=(SELECT food_price FROM seed_food JOIN food_table WHERE seed_food.foo_id=food_table.foo_id AND food_table.s_id=food_id);

			SET final_price=(fd_price*first_quantity);

			INSERT INTO food_ordered(order_id,food_name,quantity,price) VALUES(get_order_id,first_name,first_quantity,final_price);
                        SET cnt=cnt+1;
			ELSE 

			SELECT "ordered food from proper category" AS statement;

			END IF;

                  ELSE

		  SELECT "quantity not available" AS statement;

                  END IF; 

          ELSE 

         SELECT "food not in list" AS statement;

         END IF;

            SET i=i+1;

            END   LOOP;
     IF (cnt=no_of_item)
        THEN 
            SET total_price=(SELECT  SUM(price) FROM food_ordered WHERE order_id=get_order_id);

                  INSERT INTO order_details(seat_no,order_id,price,statuss,ordered_date) VALUES(get_seat_number,get_order_id,total_price,'ordered',NOW());

                   UPDATE seed_seat SET stat='allotted' WHERE seed_seat.seat_no=get_seat_number;
                  

       END IF;           

            ELSE SELECT "seat is not availabe,try another seat" AS statement;

            END IF;
       ELSE

                 SELECT "you can order only 5 item per order" AS statement;
            END IF;
       ELSE
           
              SELECT "invalid order id" AS statement;
          END IF;
	END$$

DELIMITER ;