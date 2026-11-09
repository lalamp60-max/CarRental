<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.carrental.model.Car" %>

<%
if(session.getAttribute("userName") == null ||
   !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.html");
    return;
}

List<Car> cars = (List<Car>)request.getAttribute("cars");
String keyword = (String)request.getAttribute("keyword");

if(cars == null) {
    response.sendRedirect("SearchCarServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Search Cars | Car Rental System</title>

<style>
* {
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 35px 15px;
    background: linear-gradient(135deg,#667eea,#764ba2);
    min-height: 100vh;
}

.container {
    max-width: 1050px;
    margin: auto;
    background: white;
    padding: 35px;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

h1 {
    text-align: center;
    color: #263b65;
    margin-bottom: 25px;
}

.search-form {
    display: flex;
    gap: 10px;
    margin-bottom: 25px;
}

.search-form input {
    flex: 1;
    padding: 13px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
}

button {
    background: #667eea;
    color: white;
    border: none;
    padding: 13px 22px;
    border-radius: 8px;
    cursor: pointer;
}

button:hover {
    background: #764ba2;
}

.table-wrapper {
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: collapse;
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

.book-btn {
    background: #667eea;
    color: white;
    padding: 9px 15px;
    border-radius: 6px;
    text-decoration: none;
    display: inline-block;
}

.book-btn:hover {
    background: #764ba2;
}

.back {
    display: inline-block;
    margin-top: 22px;
    color: #667eea;
    text-decoration: none;
    font-weight: bold;
}

.empty {
    text-align: center;
    padding: 20px;
    color: #777;
}

@media(max-width:600px) {
    .container {
        padding: 20px;
    }

    .search-form {
        flex-direction: column;
    }
}
</style>
</head>

<body>

<div class="container">

    <h1>&#128269; Search Available Cars</h1>

    <form action="SearchCarServlet" method="get" class="search-form">

        <input type="text"
               name="keyword"
               placeholder="Enter car make or model"
               value="<%= keyword == null ? "" : keyword %>">

        <button type="submit">Search</button>

    </form>

    <div class="table-wrapper">

    <table>

        <tr>
            <th>ID</th>
            <th>Make</th>
            <th>Model</th>
            <th>Year</th>
            <th>Price/Day</th>
            <th>Action</th>
        </tr>

        <%
        if(!cars.isEmpty()) {
            for(Car c : cars) {
        %>

        <tr>
            <td><%= c.getCarId() %></td>
            <td><%= c.getMake() %></td>
            <td><%= c.getModel() %></td>
            <td><%= c.getYear() %></td>
            <td>&#8377;<%= c.getRentalRatePerDay() %></td>

            <td>
                <a class="book-btn"
                   href="bookCar.jsp?carId=<%= c.getCarId() %>">
                    Book Now
                </a>
            </td>
        </tr>

        <%
            }
        } else {
        %>

        <tr>
            <td colspan="6" class="empty">
                No available cars found.
            </td>
        </tr>

        <% } %>

    </table>

    </div>

    <a class="back" href="dashboard.jsp">
        &#8592; Back to Dashboard
    </a>

</div>

</body>
</html>