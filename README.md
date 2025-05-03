PizzaHut Database Analysis
Welcome to the PizzaHut Database Analysis project! This repository contains SQL scripts to set up a database for PizzaHut and perform various analyses on order and sales data. The queries provide insights into total orders, revenue, popular pizza types, and more.
Table of Contents

Project Overview
Prerequisites
Installation
Database Schema
SQL Queries
Total Number of Orders
Total Revenue from Pizza Sales
Highest-Priced Pizza
Most Common Pizza Size Ordered
Top 5 Most Ordered Pizza Types
Stored Procedure: Pizzas Priced Between $10 and $20
Top 3 Pizza Types by Revenue
Percentage Contribution of Each Pizza Type to Total Revenue


Usage
Contributing
License
Contact

Project Overview
This project demonstrates SQL skills for database creation and analysis using a fictional PizzaHut dataset. It includes scripts to:

Create a MySQL database and tables for orders and order details.
Analyze sales data to extract insights like total revenue, most ordered pizzas, and revenue distribution.
Implement a stored procedure for filtering pizzas by price range.

The repository is designed for developers, data analysts, or students learning SQL and database management.
Prerequisites
To run the SQL scripts, you need:

MySQL (version 5.7 or later) or a compatible database system (e.g., MariaDB).
A MySQL client (e.g., MySQL Workbench, phpMyAdmin, or command-line interface).
Basic knowledge of SQL and database concepts.

Installation

Install MySQL:

Download and install MySQL from mysql.com.
Alternatively, use a cloud-based MySQL service or Docker:docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:latest




Clone the Repository:
git clone https://github.com/your-username/pizzahut-database-analysis.git
cd pizzahut-database-analysis


Set Up the Database:

Log in to your MySQL server:mysql -u root -p


Run the SQL scripts provided in the Database Schema section to create the database and tables.



Database Schema
The database consists of four tables: orders, order_details, pizzas, and pizza_types. Below is the SQL to set up the database and tables.
-- Create Database
CREATE DATABASE pizzahut;
USE pizzahut;

-- Orders Table
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  order_date DATE NOT NULL,
  order_time TIME NOT NULL
);

-- Order Details Table
CREATE TABLE order_details (
  order_details_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  pizza_id VARCHAR(25) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Pizzas Table (Assumed Schema)
CREATE TABLE pizzas (
  pizza_id VARCHAR(25) PRIMARY KEY,
  pizza_type_id VARCHAR(25) NOT NULL,
  size VARCHAR(10) NOT NULL,
  price DECIMAL(5,2) NOT NULL
);

-- Pizza Types Table (Assumed Schema)
CREATE TABLE pizza_types (
  pizza_type_id VARCHAR(25) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL
);

Notes:

The pizzas and pizza_types tables are assumed based on the queries provided. Adjust their schema if your dataset differs.
Foreign key constraints are added for referential integrity where applicable.
Populate the tables with sample data to test the queries. Sample data is not included but can be generated or imported as needed.

SQL Queries
Below are the SQL queries for analyzing the PizzaHut dataset, along with their purposes.
1. Total Number of Orders
Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders FROM orders;

2. Total Revenue from Pizza Sales
Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS TOTAL_REVENUE 
FROM order_details 
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;

3. Highest-Priced Pizza
Identify the pizza with the highest price.
SELECT pizza_types.name, pizzas.price 
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC 
LIMIT 1;

4. Most Common Pizza Size Ordered
Identify the most frequently ordered pizza size.
SELECT pizzas.size, COUNT(order_details.order_details_id) 
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.quantity) DESC 
LIMIT 1;

5. Top 5 Most Ordered Pizza Types
List the top 5 pizza types by order quantity.
SELECT pizza_types.name, SUM(order_details.quantity) AS quantity 
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC 
LIMIT 5;

6. Stored Procedure: Pizzas Priced Between $10 and $20
Create and call a stored procedure to retrieve pizzas with prices between $10 and $20.
DELIMITER $$

CREATE PROCEDURE yt()
BEGIN
    SELECT * FROM pizzahut.pizzas 
    WHERE pizzas.price BETWEEN 10 AND 20;
END$$

DELIMITER ;

CALL yt();

7. Top 3 Pizza Types by Revenue
Determine the top 3 pizza types based on revenue.
SELECT pizza_types.name, 
       SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types 
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name 
ORDER BY revenue DESC 
LIMIT 3;

8. Percentage Contribution of Each Pizza Type to Total Revenue
Calculate the percentage contribution of each pizza category to total revenue.
SELECT 
  pizza_types.category, 
  ROUND(SUM(order_details.quantity * pizzas.price) * 100.0 / 
        (SELECT SUM(order_details.quantity * pizzas.price)
         FROM order_details 
         JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id), 2) AS revenue_percentage
FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue_percentage DESC
LIMIT 3;

Usage

Set Up the Database:

Execute the SQL in the Database Schema section to create the pizzahut database and tables.
Populate the tables with sample data (e.g., via CSV import or manual INSERT statements).


Run Queries:

Use a MySQL client to execute the queries in the SQL Queries section.
Example using MySQL command line:mysql -u root -p pizzahut < queries.sql


Replace queries.sql with a file containing the desired queries.


Analyze Results:

Review query outputs to gain insights into sales performance, popular items, and revenue distribution.
Optionally, visualize results using tools like Python (e.g., Matplotlib) or BI tools (e.g., Tableau).


Extend the Project:

Add more queries to analyze other aspects (e.g., orders by time of day, customer demographics).
Integrate with a front-end application to display results dynamically.



Contributing
Contributions are welcome! To contribute:

Fork the repository.
Create a new branch (git checkout -b feature/your-feature).
Make your changes (e.g., add new queries, improve documentation).
Commit your changes (git commit -m "Add your feature").
Push to the branch (git push origin feature/your-feature).
Open a pull request.

Please ensure your code follows the existing style and includes clear comments.
License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact
For questions or feedback, please contact:

Your Name: anandsreekumar025@gmail.com
GitHub: AnandXsree

Happy analyzing!
