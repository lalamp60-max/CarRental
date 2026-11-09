<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(session.getAttribute("adminName") != null &&
   "ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin-dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
body {
    font-family: Arial;
    background: linear-gradient(135deg,#141e30,#243b55);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.login-box {
    background: white;
    padding: 40px;
    width: 370px;
    border-radius: 18px;
    text-align: center;
}

input {
    width: 100%;
    padding: 13px;
    margin: 12px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
}

button {
    width: 100%;
    padding: 13px;
    background: #ed5500;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

a {
    color: #ed5500;
    text-decoration: none;
}

.error {
    color: red;
    margin: 12px;
}
</style>
</head>

<body>

<div class="login-box">

<h2>Admin Login</h2>
<p>Access Administration Panel</p>

<%
String error = request.getParameter("error");

if("1".equals(error)) {
%>
<p class="error">Invalid Admin Credentials!</p>
<%
} else if("2".equals(error)) {
%>
<p class="error">Database Connection Error!</p>
<%
}
%>

<form action="AdminLoginServlet" method="post">

<input type="text" name="username"
placeholder="Admin Username" required>

<input type="password" name="password"
placeholder="Admin Password" required>

<button type="submit">Login</button>

</form>

<br>
<a href="index.jsp">Back to Home</a>

</div>

</body>
</html>