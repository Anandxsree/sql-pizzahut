PizzaHut Database Analysis
Welcome to the PizzaHut Database Analysis project! This repository contains SQL scripts to set up a database for PizzaHut and perform a variety of data analyses on orders, sales, and pizza preferences. The aim is to gain insights into total orders, revenue, popular pizza types, and more, using SQL.

Table of Contents
Project Overview

Prerequisites

Installation

Database Schema

SQL Queries

Usage

Contributing

License

Contact

Project Overview
This project showcases SQL skills for database creation and analysis using a fictional PizzaHut dataset. The primary goal is to perform insights-driven analysis on order and sales data. It includes:

Database Setup: SQL scripts to create the database and necessary tables.

Data Analysis: Queries to extract valuable information, such as total revenue, most ordered pizza types, and revenue distribution.

Stored Procedure: A stored procedure to filter pizzas by price range.

The repository is useful for developers, data analysts, or students looking to practice SQL and database management.

Prerequisites
To run the SQL scripts, you'll need the following:

MySQL (version 5.7 or later) or a compatible database system (e.g., MariaDB).

MySQL Client (e.g., MySQL Workbench, phpMyAdmin, or command-line interface).

Basic knowledge of SQL and database concepts.

Installation
Install MySQL
Download and install MySQL from mysql.com.

Alternatively, you can use a cloud-based MySQL service or Docker by running:

bash
Copy
Edit
docker run -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:latest
Clone the Repository
Clone the repository to your local machine:

bash
Copy
Edit
git clone https://github.com/your-username/pizzahut-database-analysis.git
cd pizzahut-database-analysis
Set Up the Database
Log in to your MySQL server:

bash
Copy
Edit
mysql -u root -p
Run the SQL scripts from the Database Schema section to create the database and tables.

Database Schema
The database consists of four tables: orders, order_details, pizzas, and pizza_types. Below is the SQL to set up the database and tables.

sql
Copy
Edit
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
SQL Queries
Below are SQL queries for analyzing the PizzaHut dataset:

Total Number of Orders:

sql
Copy
Edit
SELECT COUNT(order_id) AS total_orders FROM orders;
Total Revenue from Pizza Sales:

sql
Copy
Edit
SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_revenue
FROM order_details
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
Highest-Priced Pizza:

sql
Copy
Edit
SELECT pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
Most Common Pizza Size Ordered:

sql
Copy
Edit
SELECT pizzas.size, COUNT(order_details.order_details_id)
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY COUNT(order_details.quantity) DESC
LIMIT 1;
Top 5 Most Ordered Pizza Types:

sql
Copy
Edit
SELECT pizza_types.name, SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;
Stored Procedure: Pizzas Priced Between $10 and $20:

sql
Copy
Edit
DELIMITER $$

CREATE PROCEDURE yt()
BEGIN
    SELECT * FROM pizzahut.pizzas 
    WHERE pizzas.price BETWEEN 10 AND 20;
END$$

DELIMITER ;

CALL yt();
Top 3 Pizza Types by Revenue:

sql
Copy
Edit
SELECT pizza_types.name,
       SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
Percentage Contribution of Each Pizza Type to Total Revenue:

sql
Copy
Edit
SELECT pizza_types.category,
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
Set Up the Database
Execute the SQL in the Database Schema section to create the pizzahut database and tables.

Populate the tables with sample data (using CSV import or manual INSERT statements).

Run Queries
Execute the SQL queries in the SQL Queries section to analyze the data. You can run these in your MySQL client:

bash
Copy
Edit
mysql -u root -p pizzahut < queries.sql
Replace queries.sql with the filename containing your desired queries.

Analyze Results
Review the outputs of the queries to gain insights into sales performance, pizza popularity, and revenue distribution.

Contributing
Contributions are welcome! To contribute:

Fork the repository.

Create a new branch: git checkout -b feature/your-feature.

Make your changes (e.g., add new queries, improve documentation).

Commit your changes: git commit -m "Add your feature".

Push to your branch: git push origin feature/your-feature.

Open a pull request.

Please ensure your code follows the existing style and includes clear comments.
