<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<%
if(session.getAttribute("adminName") == null ||
   !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin-login.jsp");
    return;
}

List<Map<String,Object>> bookings =
    (List<Map<String,Object>>)request.getAttribute("bookings");

if(bookings == null) {
    response.sendRedirect("ManageBookingsServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Manage Bookings | Admin</title>

<style>
* {
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 35px 15px;
    background: linear-gradient(135deg,#141e30,#243b55);
    min-height: 100vh;
}

.container {
    max-width: 1250px;
    margin: auto;
    background: white;
    padding: 35px;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

h1 {
    color: #243b55;
    margin-bottom: 25px;
}

.table-wrapper {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 900px;
}

th,td {
    padding: 14px;
    border: 1px solid #ddd;
    text-align: center;
}

th {
    background: #243b55;
    color: white;
}

tr:hover {
    background: #f5f7fc;
}

button {
    padding: 9px 12px;
    border: none;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    margin: 3px;
}

.approve {
    background: #28a745;
}

.reject {
    background: #dc3545;
}

.approve:hover {
    background: #218838;
}

.reject:hover {
    background: #bd2130;
}

.back {
    display: inline-block;
    margin-top: 25px;
    color: #243b55;
    text-decoration: none;
    font-weight: bold;
}

.status {
    font-weight: bold;
}
</style>

</head>

<body>

<div class="container">

    <h1>&#128203; Manage Customer Bookings</h1>

    <div class="table-wrapper">

    <table>

        <tr>
            <th>Booking ID</th>
            <th>User</th>
            <th>Car</th>
            <th>Pickup</th>
            <th>Return</th>
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

            <td><%= b.get("user") %></td>

            <td><%= b.get("car") %></td>

            <td><%= b.get("pickup") %></td>

            <td><%= b.get("return") %></td>

            <td>&#8377;<%= b.get("amount") %></td>

            <td class="status">
                <%= b.get("status") %>
            </td>

            <td>

                <% if("PENDING".equals(b.get("status"))) { %>

                <form action="UpdateBookingStatusServlet"
                      method="post">

                    <input type="hidden"
                           name="bookingId"
                           value="<%= b.get("id") %>">

                    <button type="submit"
                            class="approve"
                            name="status"
                            value="APPROVED"
                            onclick="return confirm('Approve this booking?')">
                        Approve
                    </button>

                    <button type="submit"
                            class="reject"
                            name="status"
                            value="REJECTED"
                            onclick="return confirm('Reject this booking?')">
                        Reject
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
            <td colspan="8">
                No customer bookings found.
            </td>
        </tr>

        <% } %>

    </table>

    </div>

    <a href="admin-dashboard.jsp" class="back">
        &#8592; Back to Admin Dashboard
    </a>

</div>

</body>
</html>