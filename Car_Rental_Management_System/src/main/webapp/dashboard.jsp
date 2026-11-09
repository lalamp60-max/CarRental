<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(session.getAttribute("userName") == null ||
   !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.html");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Dashboard | Car Rental System</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    min-height: 100vh;
    background: linear-gradient(135deg,#667eea,#764ba2);
}

.navbar {
    background: rgba(20,30,48,0.96);
    padding: 20px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}

.logo {
    color: white;
    font-size: 24px;
    font-weight: bold;
}

.nav-links {
    display: flex;
    gap: 22px;
    flex-wrap: wrap;
}

.nav-links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.nav-links a:hover {
    color: #ffcc80;
}

.container {
    text-align: center;
    padding: 55px 20px;
    color: white;
}

.container h1 {
    font-size: 35px;
    margin-bottom: 15px;
}

.welcome {
    font-size: 21px;
    margin-bottom: 12px;
}

.subtitle {
    color: #f0edff;
}

.cards {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 25px;
    max-width: 1200px;
    margin: 45px auto 0;
}

.card {
    background: white;
    color: #263238;
    width: 250px;
    padding: 30px 20px;
    border-radius: 18px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-9px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.3);
}

.icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.card h2 {
    margin-bottom: 12px;
    font-size: 21px;
}

.card p {
    color: #666;
    font-size: 14px;
    line-height: 1.6;
    min-height: 45px;
}

.card a {
    display: inline-block;
    background: #667eea;
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    margin-top: 18px;
    text-decoration: none;
    font-weight: bold;
}

.card a:hover {
    background: #764ba2;
}

.logout a {
    background: #dc3545;
}

.logout a:hover {
    background: #bd2130;
}

.footer {
    text-align: center;
    color: white;
    padding: 25px;
    margin-top: 25px;
}

@media(max-width:600px) {
    .navbar {
        flex-direction: column;
        gap: 15px;
    }

    .nav-links {
        justify-content: center;
    }

    .container h1 {
        font-size: 26px;
    }

    .card {
        width: 90%;
    }
}
</style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        &#128663; Car Rental System
    </div>

    <div class="nav-links">

        <a href="dashboard.jsp">Home</a>
        <a href="ViewCarServlet">Browse Cars</a>
        <a href="MyBookingsServlet">My Bookings</a>
        <a href="ProfileServlet">My Profile</a>
        <a href="LogoutServlet">Logout</a>

    </div>

</div>

<div class="container">

    <h1>Welcome to Car Rental Management System</h1>

    <div class="welcome">
        Hello, <b><%= session.getAttribute("userName") %></b>!
        &#128075;
    </div>

    <p class="subtitle">
        Find your perfect car and enjoy a comfortable journey.
    </p>

    <div class="cards">

        <div class="card">
            <div class="icon">&#128663;</div>
            <h2>Browse Cars</h2>
            <p>Explore available rental cars and check their prices.</p>
            <a href="ViewCarServlet">Explore Cars</a>
        </div>

        <div class="card">
            <div class="icon">&#128269;</div>
            <h2>Search Cars</h2>
            <p>Search vehicles by make or model.</p>
            <a href="SearchCarServlet">Search Now</a>
        </div>

        <div class="card">
            <div class="icon">&#128197;</div>
            <h2>My Bookings</h2>
            <p>View your reservations and booking status.</p>
            <a href="MyBookingsServlet">View Bookings</a>
        </div>

        <div class="card">
            <div class="icon">&#128100;</div>
            <h2>My Profile</h2>
            <p>View your account information and profile details.</p>
            <a href="ProfileServlet">View Profile</a>
        </div>

        <div class="card logout">
            <div class="icon">&#128682;</div>
            <h2>Logout</h2>
            <p>Securely logout from your account.</p>
            <a href="LogoutServlet">Logout</a>
        </div>

    </div>

</div>

<div class="footer">
    <p>
        Car Rental Management System |
        Advanced Java Lab Project
    </p>
</div>

</body>
</html>