use brototype;

DELIMITER $$

CREATE procedure broto()

begin
     select Customers.CustomerID , count(Orders.OrderID) from Customers join orders 
 on Orders.CustomerID = Customers.CustomerID;
end $$

DELIMITER ;

CALL broto();
