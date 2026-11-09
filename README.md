# 🚗 Car Rental Management System

A web-based **Car Rental Management System** developed using Java, JSP, Servlets, JDBC, and MySQL. This application helps administrators manage car details and customer bookings, while users can register, log in, search for cars, and book available vehicles.

## 📌 Project Overview

The Car Rental Management System is designed to simplify the process of renting cars online. It provides separate dashboards for Admin and Users.

The Admin can manage car records and customer bookings, while registered users can browse available cars and manage their bookings.

## ✨ Features

### 👨‍💼 Admin Module
- Admin Login
- Admin Dashboard
- Add New Cars
- View Car Details
- Update Car Details
- Delete Car Details
- View Registered Users
- Manage Customer Bookings
- Logout

### 👤 User Module
- User Registration
- User Login
- User Dashboard
- Browse Available Cars
- Search Cars
- Book a Car
- View My Bookings
- My Profile
- Logout

### ⚙️ System Features
- Database Connectivity using JDBC
- Session Management
- Role-Based Login (Admin and User)
- CRUD Operations
- Dynamic Web Pages using JSP and Servlets

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| HTML | Page Structure |
| CSS | Styling and UI Design |
| Java | Backend Programming |
| JSP | Dynamic Web Pages |
| Servlets | Request Processing |
| JDBC | Database Connectivity |
| MySQL | Database Management |
| Eclipse IDE | Development Environment |
| Apache Tomcat | Web Server |

## 🗄️ Database Details

**Database Name:** `CarRentalDB`

### Car Table

| Column Name | Data Type |
|---|---|
| car_id | INT (Primary Key, Auto Increment) |
| make | VARCHAR(50) |
| model | VARCHAR(50) |
| year | INT |
| rental_rate_per_day | DECIMAL(8,2) |
| availability_status | VARCHAR(20) |

Other database tables are used for Admin, Users, and booking-related functionality.

### Database Creation

```sql
CREATE DATABASE CarRentalDB;
USE CarRentalDB;
```

### Car Table Creation

```sql
CREATE TABLE Car (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    rental_rate_per_day DECIMAL(8, 2) NOT NULL,
    availability_status VARCHAR(20) NOT NULL
);
```

## 🔄 CRUD Operations

The system implements the four basic database operations:

| Operation | Servlet | Description |
|---|---|---|
| Create | AddCarServlet | Add new car details |
| Read | ViewCarServlet | Display car details |
| Update | UpdateCarServlet | Modify car details |
| Delete | DeleteCarServlet | Remove car details |

## 📂 Project Structure

```text
Car_Rental_Management_System/
│
├── Java Resources/
│   └── src/
│       └── com.carrental/
│           ├── controller/
│           │   ├── AdminLoginServlet.java
│           │   ├── UserLoginServlet.java
│           │   ├── RegisterServlet.java
│           │   ├── AddCarServlet.java
│           │   ├── ViewCarServlet.java
│           │   ├── UpdateCarServlet.java
│           │   ├── DeleteCarServlet.java
│           │   └── LogoutServlet.java
│           │
│           ├── model/
│           │   └── Car.java
│           │
│           └── util/
│               └── DBConnection.java
│
└── WebContent/
    ├── index.jsp
    ├── login.html
    ├── register.jsp
    ├── admin-login.jsp
    ├── dashboard.jsp
    ├── admin-dashboard.jsp
    ├── addCarForm.html
    ├── viewCar.jsp
    ├── updateCar.jsp
    ├── searchCar.jsp
    ├── bookCar.jsp
    ├── myBookings.jsp
    └── profile.jsp
```

*Note: The folder structure above represents the main project components. Actual filenames and folders may vary slightly.*

## 🚀 How to Run the Project

1. Install Java JDK and Eclipse IDE for Enterprise Java and Web Developers.
2. Install Apache Tomcat Server.
3. Install MySQL Server and MySQL Workbench.
4. Create the database `CarRentalDB` in MySQL.
5. Create the required database tables.
6. Import the project into Eclipse.
7. Add the MySQL Connector/J JAR to the project.
8. Configure database credentials in `DBConnection.java`.
9. Configure Apache Tomcat in Eclipse.
10. Right-click the project and select **Run As → Run on Server**.
11. Open the application in your browser.

## 🔌 Database Configuration

Update the database credentials in `DBConnection.java` according to your MySQL setup.

```java
private static final String URL =
    "jdbc:mysql://localhost:3306/CarRentalDB";

private static final String USERNAME = "root";
private static final String PASSWORD = "your_password";
```

Replace `your_password` with your MySQL password.

## 🎯 Project Objectives

- To develop an online car rental application.
- To implement CRUD operations using Java Servlets and JDBC.
- To manage car and customer booking information.
- To provide separate Admin and User functionalities.
- To understand Java Web Application development.

## 🌟 Advantages

- Easy management of car records.
- Separate Admin and User access.
- Simplified car searching and booking.
- Centralized database management.
- Reduces manual work.

## 🔮 Future Enhancements

- Online payment integration.
- Email and SMS notifications.
- Advanced car filtering.
- Customer reviews and ratings.
- Improved security and password encryption.

## 👩‍💻 Developed By

**Project Name:** Car Rental Management System

**Domain:** Advanced Java / Web Application Development

**Technologies:** Java, JSP, Servlets, JDBC, MySQL, HTML, CSS

---

⭐ If you find this project useful, consider giving this repository a star!
