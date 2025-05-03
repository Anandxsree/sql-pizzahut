CREATE DATABASE pizzahut;
use pizzahut;
CREATE TABLE orders(
  order_id INT PRIMARY KEY auto_increment,
  order_date DATE NOT NULL,
  order_time TIME NOT NULL
  
);

CREATE TABLE order_details (
  order_details_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  pizza_id VARCHAR(25) NOT NULL,
  quantity INT NOT NULL
);
