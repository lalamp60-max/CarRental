<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.carrental.model.Car" %>

<%
if(!"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin-login.jsp");
    return;
}

Car car = (Car) request.getAttribute("car");

if(car == null) {
    response.sendRedirect("ViewCarServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Car</title>

<style>
body {
    font-family: Arial;
    background: #eaf0f8;
}

.form-box {
    background: white;
    width: 400px;
    margin: 50px auto;
    padding: 35px;
    border-radius: 15px;
}

input,select {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    box-sizing: border-box;
}

button {
    width: 100%;
    padding: 13px;
    background: #ed5500;
    color: white;
    border: none;
    border-radius: 7px;
}
</style>
</head>

<body>

<%@ include file="includes/admin-navbar.jsp" %>

<div class="form-box">

<h2>Update Car Details</h2>

<form action="UpdateCarServlet" method="post">

<input type="hidden" name="car_id"
value="<%= car.getCarId() %>">

<label>Make</label>
<input type="text" name="make"
value="<%= car.getMake() %>" required>

<label>Model</label>
<input type="text" name="model"
value="<%= car.getModel() %>" required>

<label>Year</label>
<input type="number" name="year"
value="<%= car.getYear() %>" required>

<label>Rental Rate Per Day</label>
<input type="number" step="0.01"
name="rental_rate_per_day"
value="<%= car.getRentalRatePerDay() %>" required>

<label>Availability</label>

<select name="availability_status">

<option value="Available"
<%= "Available".equals(car.getAvailabilityStatus()) ? "selected" : "" %>>
Available
</option>

<option value="Rented"
<%= "Rented".equals(car.getAvailabilityStatus()) ? "selected" : "" %>>
Rented
</option>

</select>

<button type="submit">Update Car</button>

</form>

</div>

</body>
</html>