<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(session.getAttribute("userName") != null &&
   "USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login</title>

<style>
body {
    font-family: Arial;
    background: linear-gradient(135deg,#667eea,#764ba2);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.box {
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
    background: #667eea;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}

.error {
    color: red;
    margin: 12px;
}
</style>
</head>

<body>

<div class="box">

<h2>User Login</h2>

<%
String error = request.getParameter("error");

if("1".equals(error)) {
%>
<p class="error">Invalid Roll Number or Password!</p>
<%
} else if("2".equals(error)) {
%>
<p class="error">Database Error!</p>
<%
}
%>

<form action="UserLoginServlet" method="post">

<input type="text" name="roll_no"
placeholder="Enter Roll Number" required>

<input type="password" name="password"
placeholder="Enter Password" required>

<button type="submit">Login</button>

</form>

<br>
<a href="index.jsp">Back to Home</a>

</div>

</body>
</html>