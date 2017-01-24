DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE `raja_db`.`pay_bill`(IN get_order_id INT,IN get_seat_number INT)
   
	BEGIN
          DECLARE statuses VARCHAR(20);

                  SET statuses=(SELECT statuss FROM order_details WHERE order_id=get_order_id);

                  IF(statuses='ordered')

                  THEN

                  UPDATE order_details SET statuss='billed' WHERE order_id=get_order_id;

                  UPDATE seed_seat SET stat='available' WHERE seat_no=get_seat_number;

                  ELSE

                  SELECT 'you cannot make payement to canceled order' AS statement;

                  END IF;
	END$$

DELIMITER ;