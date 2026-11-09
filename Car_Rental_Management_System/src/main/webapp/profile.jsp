<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(session.getAttribute("userName") == null ||
   !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.html");
    return;
}

Object userId = request.getAttribute("userId");
Object rollNo = request.getAttribute("rollNo");

if(userId == null || rollNo == null) {
    response.sendRedirect("ProfileServlet");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile | Car Rental System</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg,#667eea,#764ba2);
    min-height: 100vh;
}

.navbar {
    background: #101d30;
    padding: 20px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}

.navbar h2 {
    color: white;
}

.navbar a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    margin-left: 18px;
}

.navbar a:hover {
    color: #ffcc80;
}

.container {
    display: flex;
    justify-content: center;
    padding: 60px 20px;
}

.profile-card {
    background: white;
    width: 450px;
    max-width: 100%;
    padding: 40px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 12px 35px rgba(0,0,0,0.25);
}

.profile-icon {
    width: 110px;
    height: 110px;
    background: linear-gradient(135deg,#667eea,#764ba2);
    border-radius: 50%;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 55px;
    color: white;
}

.profile-card h1 {
    color: #243b55;
    margin-top: 20px;
    margin-bottom: 10px;
}

.subtitle {
    color: #777;
    margin-bottom: 30px;
}

.details {
    text-align: left;
}

.detail-box {
    background: #f3f5fa;
    padding: 17px;
    margin-bottom: 15px;
    border-radius: 10px;
    border-left: 5px solid #667eea;
}

.detail-box label {
    display: block;
    color: #777;
    font-size: 13px;
    margin-bottom: 7px;
}

.detail-box span {
    font-size: 17px;
    color: #243b55;
    font-weight: bold;
    overflow-wrap: anywhere;
}

.buttons {
    margin-top: 30px;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 12px;
}

.buttons a {
    padding: 12px 20px;
    border-radius: 8px;
    text-decoration: none;
    color: white;
    background: #667eea;
    font-weight: bold;
}

.buttons a:hover {
    background: #764ba2;
}

.logout {
    background: #e74c3c !important;
}

.logout:hover {
    background: #c0392b !important;
}

.footer {
    text-align: center;
    color: white;
    padding: 20px;
}
</style>

</head>

<body>

<div class="navbar">

    <h2>&#128663; Car Rental System</h2>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="MyBookingsServlet">Bookings</a>
        <a href="LogoutServlet">Logout</a>
    </div>

</div>

<div class="container">

    <div class="profile-card">

        <div class="profile-icon">
            &#128100;
        </div>

        <h1>My Profile</h1>

        <p class="subtitle">
            Your account information
        </p>

        <div class="details">

            <div class="detail-box">
                <label>User ID</label>
                <span><%= userId %></span>
            </div>

            <div class="detail-box">
                <label>Roll Number</label>
                <span><%= rollNo %></span>
            </div>

            <div class="detail-box">
                <label>Account Type</label>
                <span>Normal User</span>
            </div>

            <div class="detail-box">
                <label>Login Username</label>
                <span><%= session.getAttribute("userName") %></span>
            </div>

        </div>

        <div class="buttons">

            <a href="dashboard.jsp">
                Back to Dashboard
            </a>

            <a href="LogoutServlet" class="logout">
                Logout
            </a>

        </div>

    </div>

</div>

<div class="footer">
    Car Rental Management System | Advanced Java Lab Project
</div>

</body>
</html>