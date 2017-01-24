DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE `raja_db`.`cancel`(IN get_order_id INT,IN get_seat_number INT)
	BEGIN
          DECLARE statuses VARCHAR(20);

	SET statuses=(SELECT statuss FROM order_details WHERE order_id=get_order_id);

	IF(statuses='ordered')

	THEN

              UPDATE order_details SET order_details.statuss='cancelled' WHERE order_id=get_order_id;

              UPDATE seed_seat SET stat='available' WHERE seat_no=get_seat_number;

              SELECT 'your order has been cancel' AS statement;

              ELSE

              SELECT 'billed order cannot be cancelled' AS statement;

              END IF;
	END$$

DELIMITER ;