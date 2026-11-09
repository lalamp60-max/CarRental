<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,com.carrental.util.DBConnection" %>

<%
if(session.getAttribute("userName") == null ||
   !"USER".equals(session.getAttribute("role"))) {
    response.sendRedirect("login.html");
    return;
}

String carIdParam = request.getParameter("carId");

if(carIdParam == null || !carIdParam.matches("\\d+")) {
    response.sendRedirect("SearchCarServlet");
    return;
}

int carId = Integer.parseInt(carIdParam);

String make = "";
String model = "";
double price = 0;
boolean found = false;

try(Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT make,model,rental_rate_per_day FROM Car " +
        "WHERE car_id=? AND LOWER(availability_status)='available'")) {

    ps.setInt(1,carId);

    try(ResultSet rs = ps.executeQuery()) {
        if(rs.next()) {
            make = rs.getString("make");
            model = rs.getString("model");
            price = rs.getDouble("rental_rate_per_day");
            found = true;
        }
    }
}

if(!found) {
    response.sendRedirect("ViewCarServlet");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Book Car | Car Rental System</title>

<style>
* {
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    margin: 0;
    background: linear-gradient(135deg,#667eea,#764ba2);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.box {
    width: 500px;
    max-width: 100%;
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

.car-details {
    background: #f1f3ff;
    padding: 18px;
    border-radius: 10px;
    margin-bottom: 25px;
}

.car-details h2 {
    color: #263b65;
    margin-top: 0;
}

.car-details p {
    font-size: 17px;
}

label {
    display: block;
    margin-top: 18px;
    margin-bottom: 8px;
    font-weight: bold;
}

input {
    width: 100%;
    padding: 13px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 15px;
}

button {
    width: 100%;
    margin-top: 25px;
    padding: 14px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
}

button:hover {
    background: #764ba2;
}

.back {
    display: block;
    margin-top: 20px;
    text-align: center;
    color: #667eea;
    text-decoration: none;
}
</style>

</head>

<body>

<div class="box">

    <h1>&#128663; Book Your Car</h1>

    <div class="car-details">

        <h2><%= make %> <%= model %></h2>

        <p>
            <b>Rental Price:</b>
            &#8377;<%= price %> per day
        </p>

    </div>

    <form action="BookCarServlet" method="post">

        <input type="hidden" name="carId" value="<%= carId %>">

        <label>Pickup Date</label>

        <input type="date"
               name="pickup_date"
               id="pickup"
               min="<%= java.time.LocalDate.now() %>"
               required>

        <label>Return Date</label>

        <input type="date"
               name="return_date"
               id="returned"
               required>

        <button type="submit">
            Confirm Booking
        </button>

    </form>

    <a class="back" href="SearchCarServlet">
        Back to Search
    </a>

</div>

<script>
const pickup = document.getElementById("pickup");
const returned = document.getElementById("returned");

pickup.addEventListener("change", function() {
    returned.min = pickup.value;

    if(returned.value && returned.value <= pickup.value) {
        returned.value = "";
    }
});
</script>

</body>
</html>