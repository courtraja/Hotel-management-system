DELIMITER $$

ALTER ALGORITHM=UNDEFINED DEFINER=`dev_user`@`%` SQL SECURITY DEFINER VIEW `remaining_quantity` AS (
SELECT
  `seed_food`.`foo_id`            AS `foo_id`,
  `seed_food`.`food_name`         AS `food_name`,
  `seed_food`.`food_price`        AS `food_price`,
  `seed_session`.`sessions`       AS `sessions`,
  `food_table`.`quantity_of_food` AS `quantity_of_food`
FROM ((`seed_food`
    JOIN `food_table`)
   JOIN `seed_session`)
WHERE ((`seed_food`.`foo_id` = `food_table`.`foo_id`)
       AND (`seed_session`.`id` = `food_table`.`session_id`)))$$

DELIMITER ;