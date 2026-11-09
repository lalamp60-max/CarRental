<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>

<%
if(session.getAttribute("adminName") == null ||
   !"ADMIN".equals(session.getAttribute("role"))) {

    response.sendRedirect("admin-login.jsp");
    return;
}

List<HashMap<String,Object>> users =
    (List<HashMap<String,Object>>) request.getAttribute("users");

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Registered Users</title>

<style>

body {
    font-family: Arial;
    background: #eef2f7;
    margin: 0;
}

.container {
    padding: 40px;
    text-align: center;
}

table {
    width: 70%;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
}

th,td {
    padding: 15px;
    border: 1px solid #ddd;
}

th {
    background: #172a45;
    color: white;
}

</style>

</head>

<body>

<%@ include file="includes/admin-navbar.jsp" %>

<div class="container">

<h1>Registered Users</h1>

<table>

<tr>
<th>User ID</th>
<th>Roll Number</th>
</tr>

<%
if(users != null && !users.isEmpty()) {

    for(HashMap<String,Object> user : users) {
%>

<tr>

<td><%= user.get("user_id") %></td>

<td><%= user.get("roll_no") %></td>

</tr>

<%
    }

} else {
%>

<tr>
<td colspan="2">No Users Found</td>
</tr>

<%
}
%>

</table>

</div>

</body>

</html>