<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if(!"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin-login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Car Status</title>
<style>
body {
    font-family: Arial;
    background: #eaf0f8;
    text-align: center;
    padding: 100px;
}
.box {
    background: white;
    padding: 40px;
    max-width: 500px;
    margin: auto;
    border-radius: 15px;
}
a {
    display: inline-block;
    background: #ed5500;
    color: white;
    padding: 12px 20px;
    text-decoration: none;
    border-radius: 8px;
    margin: 10px;
}
</style>
</head>

<body>

<%@ include file="includes/admin-navbar.jsp" %>

<div class="box">

<h2>Car Operation Status</h2>

<p><%= request.getAttribute("message") != null
    ? request.getAttribute("message")
    : "Car operation completed." %></p>

<a href="addCarForm.html">Add Another Car</a>

<a href="ViewCarServlet">View Cars</a>

</div>

</body>
</html>