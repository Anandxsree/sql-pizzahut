DELIMITER $$

CREATE PROCEDURE yt()
BEGIN
    SELECT * FROM pizzahut.pizzas 
    WHERE pizzas.price BETWEEN 10 AND 20;
END$$

DELIMITER ;
    
call yt();
