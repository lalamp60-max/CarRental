<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(session.getAttribute("adminName") == null ||
   !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin-login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard | Car Rental System</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    min-height: 100vh;
    background: linear-gradient(135deg,#141e30,#243b55);
}

.navbar {
    background: #101d30;
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
    color: #ff914d;
}

.container {
    padding: 55px 20px;
    text-align: center;
    color: white;
}

.container h1 {
    font-size: 36px;
    margin-bottom: 15px;
}

.welcome {
    font-size: 21px;
    margin-bottom: 12px;
}

.subtitle {
    color: #dce3ed;
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
    width: 260px;
    padding: 30px 20px;
    border-radius: 18px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-9px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
}

.icon {
    font-size: 48px;
    margin-bottom: 15px;
}

.card h2 {
    font-size: 21px;
    margin-bottom: 12px;
}

.card p {
    color: #666;
    font-size: 14px;
    line-height: 1.6;
    min-height: 45px;
}

.card a {
    display: inline-block;
    background: #ed5500;
    color: white;
    padding: 12px 22px;
    text-decoration: none;
    border-radius: 8px;
    margin-top: 18px;
    font-weight: bold;
}

.card a:hover {
    background: #c43d00;
}

.logout a {
    background: #dc3545;
}

.logout a:hover {
    background: #a71d2a;
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
        &#128663; Car Rental Admin
    </div>

    <div class="nav-links">

        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="ViewCarServlet">Cars</a>
        <a href="ManageBookingsServlet">Bookings</a>
        <a href="LogoutServlet">Logout</a>

    </div>

</div>

<div class="container">

    <h1>Admin Dashboard</h1>

    <div class="welcome">
        Welcome, <b><%= session.getAttribute("adminName") %></b>!
        &#128075;
    </div>

    <p class="subtitle">
        Manage vehicles, users and customer reservations.
    </p>

    <div class="cards">

        <div class="card">
            <div class="icon">&#128663;</div>
            <h2>Add New Car</h2>
            <p>Add new vehicles with their details and rental prices.</p>
            <a href="addCarForm.html">Add Car</a>
        </div>

        <div class="card">
            <div class="icon">&#128694;</div>
            <h2>View All Cars</h2>
            <p>View all registered vehicles and their availability.</p>
            <a href="ViewCarServlet">View Cars</a>
        </div>

        <div class="card">
            <div class="icon">&#9881;</div>
            <h2>Manage Cars</h2>
            <p>Update vehicle information or delete existing cars.</p>
            <a href="ViewCarServlet">Manage Cars</a>
        </div>

        <div class="card">
            <div class="icon">&#128101;</div>
            <h2>Registered Users</h2>
            <p>View all users registered in the rental system.</p>
            <a href="ViewUsersServlet">View Users</a>
        </div>

        <div class="card">
            <div class="icon">&#128203;</div>
            <h2>Manage Bookings</h2>
            <p>View reservations and approve or reject booking requests.</p>
            <a href="ManageBookingsServlet">Manage Bookings</a>
        </div>

        <div class="card logout">
            <div class="icon">&#128682;</div>
            <h2>Logout</h2>
            <p>Securely logout from the administrator account.</p>
            <a href="LogoutServlet">Logout</a>
        </div>

    </div>

</div>

<div class="footer">
    <p>
        Car Rental Management System | Admin Panel
    </p>
</div>

</body>
</html>