<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Create Account | Car Rental</title>

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

.register-box {
    background: white;
    width: 420px;
    padding: 40px;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

h1 {
    text-align: center;
    color: #172a45;
}

.subtitle {
    text-align: center;
    color: #777;
    margin-bottom: 25px;
}

label {
    display: block;
    margin-top: 18px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 13px;
    margin-top: 8px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
}

input:focus {
    outline: none;
    border-color: #ed5500;
}

button {
    width: 100%;
    padding: 14px;
    margin-top: 25px;
    background: #ed5500;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

button:hover {
    background: #c43d00;
}

.links {
    text-align: center;
    margin-top: 20px;
}

.links a {
    color: #ed5500;
    text-decoration: none;
    font-weight: bold;
}

.message {
    text-align: center;
    margin-top: 15px;
    font-weight: bold;
}

</style>

</head>

<body>

<div class="register-box">

    <h1>Create Account</h1>

    <p class="subtitle">
        Join Car Rental Management System
    </p>

    <form action="RegisterServlet" method="post">

        <label>Roll Number</label>

        <input type="text"
               name="roll_no"
               placeholder="Enter Your Roll Number"
               maxlength="30"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               placeholder="Create Password"
               minlength="6"
               maxlength="100"
               required>

        <label>Confirm Password</label>

        <input type="password"
               name="confirm_password"
               placeholder="Confirm Your Password"
               minlength="6"
               maxlength="100"
               required>

        <button type="submit">
            Create Account
        </button>

    </form>

    <% if("exists".equals(request.getParameter("error"))) { %>

        <p class="message" style="color:red;">
            Roll Number Already Registered!
        </p>

    <% } %>

    <% if("invalid".equals(request.getParameter("error"))) { %>

        <p class="message" style="color:red;">
            Invalid Details or Password Mismatch!
        </p>

    <% } %>

    <% if("failed".equals(request.getParameter("error"))) { %>

        <p class="message" style="color:red;">
            Registration Failed. Try Again!
        </p>

    <% } %>

    <div class="links">

        Already have an account?

        <a href="login.html">Login Here</a>

        <br><br>

        <a href="index.jsp">Back to Home</a>

    </div>

</div>

</body>

</html>