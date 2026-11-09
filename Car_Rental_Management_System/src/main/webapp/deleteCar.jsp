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
<title>Delete Car</title>

<style>
body {
    font-family: Arial;
    background: #eef2f7;
    text-align: center;
    padding: 100px;
}

.box {
    background: white;
    padding: 40px;
    max-width: 450px;
    margin: auto;
    border-radius: 15px;
}

a {
    background: #ed5500;
    color: white;
    padding: 12px 20px;
    text-decoration: none;
    border-radius: 8px;
}
</style>
</head>

<body>

<%@ include file="includes/admin-navbar.jsp" %>

<div class="box">

<h2>Car Deleted Successfully!</h2>

<p>The selected car record has been deleted.</p>

<a href="ViewCarServlet">Back to Cars</a>

</div>

</body>
</html>