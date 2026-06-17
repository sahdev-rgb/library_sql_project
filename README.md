# 📚 Library Management System SQL Project

## 📖 Project Overview

The Library Management System is a SQL-based database project designed to manage and analyze library operations efficiently. This project demonstrates database design, data management, SQL querying, reporting, stored procedures, and business analytics using MySQL.

The system handles book inventory, member records, employee management, book issuance, returns, branch operations, and performance reporting.

---

## 🎯 Objectives

* Manage library books and member information
* Track book issuance and returns
* Monitor employee and branch performance
* Generate business reports and insights
* Implement CRUD operations and stored procedures
* Practice advanced SQL concepts used in real-world applications

---

## 🗂 Database Schema

### Tables

1. Branch
2. Employee
3. Books
4. Members
5. Issued Status
6. Return Status

### Relationships

* One Branch → Multiple Employees
* One Member → Multiple Book Issues
* One Book → Multiple Issue Records
* One Employee → Multiple Book Transactions

---

## 🛠 SQL Concepts Used

### Database Design

* CREATE DATABASE
* CREATE TABLE
* PRIMARY KEY
* FOREIGN KEY

### Data Manipulation

* INSERT
* UPDATE
* DELETE

### Querying

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING

### Advanced SQL

* JOINS
* Subqueries
* CTAS (Create Table As Select)
* Aggregate Functions
* Stored Procedures
* Data Analysis Queries

---

## 📊 Business Problems Solved

### 1. Book Management

* Add new books
* Update book availability
* Track rental prices

### 2. Member Management

* Register members
* Update member information
* Identify active members

### 3. Book Issuance & Returns

* Issue books
* Return books
* Update inventory automatically

### 4. Branch Performance Analysis

* Number of books issued
* Number of books returned
* Revenue generated from rentals

### 5. Employee Performance

* Top employees by issued books
* Employee-branch analysis

### 6. Overdue Book Tracking

* Identify members with overdue books
* Calculate overdue periods

---

## 🚀 Stored Procedures

### Book Issue Procedure

Automatically:

* Checks book availability
* Issues the book
* Updates book status

### Book Return Procedure

Automatically:

* Records return transaction
* Updates book availability
* Generates confirmation message

---

## 📈 Key Reports Generated

### Book Issue Summary

Tracks total book issues per title.

### Active Members Report

Identifies members who borrowed books in the last six months.

### Branch Performance Report

Shows:

* Books Issued
* Books Returned
* Total Rental Revenue

### Employee Performance Report

Identifies top-performing employees.

---

## 💻 Technologies Used

* MySQL
* SQL
* Relational Database Management System (RDBMS)

---

## 📚 Skills Demonstrated

* Database Design
* Data Modeling
* SQL Query Writing
* Data Analysis
* Business Intelligence
* Stored Procedures
* Reporting & Analytics
* Problem Solving

---

## 📌 Project Outcomes

This project demonstrates how SQL can be used to build a complete Library Management System while solving real business problems through data analysis and reporting. It showcases practical database development skills required for Data Analyst, Business Analyst, and SQL Developer roles.

---

### ⭐ If you found this project useful, feel free to star the repository.
