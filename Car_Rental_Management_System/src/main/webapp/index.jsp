<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Car Rental Management System</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial;
    background: linear-gradient(135deg,#141e30,#243b55);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    text-align: center;
    color: white;
    padding: 30px;
}

h1 {
    font-size: 40px;
}

p {
    color: #ddd;
    font-size: 17px;
}

.cards {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 25px;
    margin-top: 40px;
}

.card {
    background: white;
    color: #222;
    width: 260px;
    padding: 35px 25px;
    border-radius: 18px;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-10px);
}

.card h2 {
    color: #172a45;
}

.btn {
    display: inline-block;
    background: #ed5500;
    color: white;
    text-decoration: none;
    padding: 13px 25px;
    border-radius: 8px;
    margin-top: 15px;
    font-weight: bold;
}

.btn:hover {
    background: #c43d00;
}

</style>

</head>

<body>

<div class="container">

    <h1>🚗 Car Rental Management System</h1>

    <p>Find Your Perfect Ride With Us!</p>

    <div class="cards">

        <div class="card">

            <h2>👤 User Login</h2>

            <p>Login to your account and explore cars.</p>

            <a href="login.html" class="btn">
                User Login
            </a>

        </div>


        <div class="card">

            <h2>📝 Create Account</h2>

            <p>New here? Register your account.</p>

            <a href="register.jsp" class="btn">
                Register
            </a>

        </div>


        <div class="card">

            <h2>🔐 Admin Login</h2>

            <p>Administrator access to manage the system.</p>

            <a href="admin-login.jsp" class="btn">
                Admin Login
            </a>

        </div>

    </div>

</div>

</body>

</html>