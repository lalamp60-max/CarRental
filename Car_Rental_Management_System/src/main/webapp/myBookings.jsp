<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<%
if(session.getAttribute("userName") == null ||
   !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.html");
    return;
}

List<Map<String,Object>> bookings =
    (List<Map<String,Object>>)request.getAttribute("bookings");

if(bookings == null) {
    response.sendRedirect("MyBookingsServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Bookings | Car Rental System</title>

<style>
* {
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 40px 15px;
    background: linear-gradient(135deg,#667eea,#764ba2);
    min-height: 100vh;
}

.container {
    max-width: 1200px;
    margin: auto;
    padding: 35px;
    background: white;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

h1 {
    color: #263b65;
    margin-bottom: 25px;
}

.table-wrapper {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 800px;
}

th,td {
    padding: 14px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #263b65;
    color: white;
}

tr:hover {
    background: #f4f5ff;
}

.status {
    padding: 7px 12px;
    border-radius: 20px;
    font-weight: bold;
    font-size: 12px;
    background: #fff3cd;
    color: #856404;
}

.cancel-btn {
    background: #dc3545;
    color: white;
    border: none;
    padding: 9px 14px;
    border-radius: 6px;
    cursor: pointer;
}

.cancel-btn:hover {
    background: #bd2130;
}

.back {
    display: inline-block;
    margin-top: 25px;
    text-decoration: none;
    color: #667eea;
    font-weight: bold;
}

.empty {
    text-align: center;
    padding: 25px;
    color: #777;
}
</style>

</head>

<body>

<div class="container">

    <h1>&#128197; My Bookings</h1>

    <div class="table-wrapper">

    <table>

        <tr>
            <th>ID</th>
            <th>Car</th>
            <th>Pickup</th>
            <th>Return</th>
            <th>Days</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
        if(!bookings.isEmpty()) {
            for(Map<String,Object> b : bookings) {
        %>

        <tr>

            <td><%= b.get("id") %></td>

            <td><%= b.get("car") %></td>

            <td><%= b.get("pickup") %></td>

            <td><%= b.get("return") %></td>

            <td><%= b.get("days") %></td>

            <td>&#8377;<%= b.get("amount") %></td>

            <td>
                <span class="status">
                    <%= b.get("status") %>
                </span>
            </td>

            <td>

                <% if("PENDING".equals(b.get("status"))) { %>

                <form action="CancelBookingServlet" method="post">

                    <input type="hidden"
                           name="bookingId"
                           value="<%= b.get("id") %>">

                    <button type="submit"
                            class="cancel-btn"
                            onclick="return confirm('Are you sure you want to cancel this booking?')">
                        Cancel
                    </button>

                </form>

                <% } else { %>
                    -
                <% } %>

            </td>

        </tr>

        <%
            }
        } else {
        %>

        <tr>
            <td colspan="8" class="empty">
                No bookings found.
            </td>
        </tr>

        <% } %>

    </table>

    </div>

    <a href="dashboard.jsp" class="back">
        &#8592; Back to Dashboard
    </a>

</div>

</body>
</html>