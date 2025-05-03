PizzaHut Database Analysis
This project demonstrates SQL skills for database creation and analysis using a fictional PizzaHut dataset. It includes scripts to:

Create a MySQL database and tables for orders and order details.

Analyze sales data to extract insights like total revenue, most ordered pizzas, and revenue distribution.

Implement a stored procedure for filtering pizzas by price range.

The repository is designed for developers, data analysts, or students learning SQL and database management.


Table of Contents
Project Overview

Prerequisites

Installation

Database Schema

SQL Queries

1. Total Number of Orders

2. Total Revenue from Pizza Sales

3. Highest-Priced Pizza

4. Most Common Pizza Size Ordered

5. Top 5 Most Ordered Pizza Types

6. Stored Procedure: Pizzas Priced Between $10 and $20

7. Top 3 Pizza Types by Revenue

8. Percentage Contribution of Each Pizza Type to Total Revenue

Usage

Contributing

License

Contact


Project Overview
This project includes SQL scripts to set up a database for PizzaHut and perform various analyses on the dataset. The goal is to extract valuable business insights such as:

Total number of orders

Revenue analysis

Most popular pizzas

Pizza pricing information



Prerequisites
Before you can run the SQL scripts, ensure that you have the following:

MySQL (version 5.7 or later) or a compatible database system Mysql.

A MySQL client such as MySQL Workbench, phpMyAdmin, or the command-line interface.

Basic knowledge of SQL and database concepts.


nstallation
Install MySQL:

Download and install MySQL from mysql.com.

Alternatively, you can use a cloud-based MySQL service or Docker:

docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:latest


Clone the Repository:
git clone https://github.com//Anandxsree/sql-pizzahut.git
cd pizzahut-database-analysis


Log in to your MySQL server:
mysql -u root -p


Database Schema
The database consists of four main tables: orders, order_details, pizzas, and pizza_types. Here's the SQL script to create the database and the tables:


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

-- Pizzas Table
CREATE TABLE pizzas (
  pizza_id VARCHAR(25) PRIMARY KEY,
  pizza_type_id VARCHAR(25) NOT NULL,
  size VARCHAR(10) NOT NULL,
  price DECIMAL(5,2) NOT NULL
);

-- Pizza Types Table
CREATE TABLE pizza_types (
  pizza_type_id VARCHAR(25) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL
);




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



Example using MySQL command line:

mysql -u root -p pizzahut < queries.sql



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

Please ensure your code follows the existing style and includes clear comments
