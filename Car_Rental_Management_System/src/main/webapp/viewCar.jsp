<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.carrental.model.Car" %>

<%!

// HTML Escape Method
public String escapeHTML(String value) {

    if(value == null) {
        return "";
    }

    return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
}

%>

<%

// Session Validation

HttpSession currentSession = request.getSession(false);

if(currentSession == null ||
   currentSession.getAttribute("role") == null) {

    response.sendRedirect("index.jsp");
    return;
}

String role = (String) currentSession.getAttribute("role");

boolean isAdmin = "ADMIN".equals(role);

if(!isAdmin && !"USER".equals(role)) {

    response.sendRedirect("index.jsp");
    return;
}

// Get Cars List From Servlet

List<Car> cars =
    (List<Car>) request.getAttribute("cars");

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>View Cars | Car Rental Management System</title>

<style>

/* General */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {

    font-family: Arial, sans-serif;

    background: linear-gradient(
        135deg,
        #141e30,
        #243b55
    );

    min-height: 100vh;

}

/* Navbar */

.navbar {

    background: #101d30;

    padding: 20px 6%;

    display: flex;

    justify-content: space-between;

    align-items: center;

    flex-wrap: wrap;

}

.navbar h2 {

    color: white;

    font-size: 24px;

}

.nav-links {

    display: flex;

    gap: 20px;

    align-items: center;

}

.nav-links a {

    color: white;

    text-decoration: none;

    font-weight: bold;

}

.nav-links a:hover {

    color: #ff6b35;

}

/* Main Container */

.container {

    width: 94%;

    max-width: 1250px;

    margin: 45px auto;

    background: white;

    padding: 35px;

    border-radius: 18px;

    box-shadow: 0 10px 30px
        rgba(0,0,0,0.3);

}

/* Heading */

.heading {

    text-align: center;

    margin-bottom: 30px;

}

.heading h1 {

    color: #172a45;

    font-size: 32px;

    margin-bottom: 10px;

}

.heading p {

    color: #777;

}

/* Table */

.table-wrapper {

    width: 100%;

    overflow-x: auto;

}

table {

    width: 100%;

    border-collapse: collapse;

    min-width: 850px;

}

thead {

    background: #172a45;

    color: white;

}

th, td {

    padding: 16px 12px;

    text-align: center;

    border-bottom: 1px solid #ddd;

}

th {

    font-size: 14px;

}

td {

    color: #333;

    font-size: 14px;

}

tbody tr:hover {

    background: #f2f5fa;

}

/* Status */

.status {

    display: inline-block;

    padding: 7px 13px;

    border-radius: 20px;

    font-weight: bold;

    font-size: 12px;

}

.available {

    background: #d4edda;

    color: #155724;

}

.rented {

    background: #f8d7da;

    color: #721c24;

}

/* Buttons */

.btn {

    display: inline-block;

    padding: 9px 14px;

    border-radius: 6px;

    text-decoration: none;

    border: none;

    cursor: pointer;

    color: white;

    font-weight: bold;

    font-size: 13px;

}

.edit {

    background: #007bff;

}

.edit:hover {

    background: #0056b3;

}

.delete {

    background: #dc3545;

}

.delete:hover {

    background: #a71d2a;

}

.actions {

    display: flex;

    justify-content: center;

    gap: 8px;

    align-items: center;

}

/* Empty Message */

.empty {

    text-align: center;

    padding: 35px;

    color: #777;

    font-size: 18px;

}

/* Back Button */

.back {

    display: inline-block;

    margin-top: 30px;

    padding: 12px 22px;

    background: #ed5500;

    color: white;

    text-decoration: none;

    border-radius: 8px;

    font-weight: bold;

}

.back:hover {

    background: #c43d00;

}

/* Footer */

.footer {

    text-align: center;

    color: white;

    padding: 25px;

}

/* Responsive */

@media(max-width: 600px) {

    .container {

        padding: 20px 12px;

    }

    .heading h1 {

        font-size: 24px;

    }

    .navbar {

        gap: 15px;

    }

}

</style>

</head>

<body>


<!-- NAVIGATION BAR -->

<div class="navbar">

    <h2>Car Rental System</h2>

    <div class="nav-links">

        <% if(isAdmin) { %>

            <a href="admin-dashboard.jsp">
                Dashboard
            </a>

        <% } else { %>

            <a href="dashboard.jsp">
                Dashboard
            </a>

        <% } %>

        <a href="LogoutServlet">
            Logout
        </a>

    </div>

</div>


<!-- MAIN CONTAINER -->

<div class="container">

    <div class="heading">

        <h1>Available Car Details</h1>

        <p>View and manage car rental information</p>

    </div>


    <!-- SUCCESS MESSAGES -->

    <% if("1".equals(request.getParameter("updated"))) { %>

        <p style="color:green;text-align:center;margin-bottom:20px;">
            Car Updated Successfully!
        </p>

    <% } %>


    <% if("1".equals(request.getParameter("deleted"))) { %>

        <p style="color:green;text-align:center;margin-bottom:20px;">
            Car Deleted Successfully!
        </p>

    <% } %>


    <% if("0".equals(request.getParameter("updated"))) { %>

        <p style="color:red;text-align:center;margin-bottom:20px;">
            Car Not Found or No Changes Made!
        </p>

    <% } %>


    <% if("0".equals(request.getParameter("deleted"))) { %>

        <p style="color:red;text-align:center;margin-bottom:20px;">
            Car Not Found!
        </p>

    <% } %>


    <!-- CAR TABLE -->

    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>Car ID</th>

                    <th>Make</th>

                    <th>Model</th>

                    <th>Year</th>

                    <th>Rental Rate / Day</th>

                    <th>Availability</th>

                    <% if(isAdmin) { %>

                        <th>Actions</th>

                    <% } %>

                </tr>

            </thead>


            <tbody>

                <%

                if(cars != null && !cars.isEmpty()) {

                    for(Car car : cars) {

                        String status =
                            car.getAvailabilityStatus();

                %>


                <tr>

                    <!-- Car ID -->

                    <td>
                        <%= car.getCarId() %>
                    </td>


                    <!-- Make -->

                    <td>
                        <%= escapeHTML(car.getMake()) %>
                    </td>


                    <!-- Model -->

                    <td>
                        <%= escapeHTML(car.getModel()) %>
                    </td>


                    <!-- Year -->

                    <td>
                        <%= car.getYear() %>
                    </td>


                    <!-- Rental Rate -->

                    <td>
                        ₹ <%= String.format("%.2f",
                            car.getRentalRatePerDay()) %>
                    </td>


                    <!-- Availability -->

                    <td>

                        <span class="status
                        <%= "Available".equalsIgnoreCase(status)
                            ? "available" : "rented" %>">

                            <%= escapeHTML(status) %>

                        </span>

                    </td>


                    <!-- ADMIN ACTIONS -->

                    <% if(isAdmin) { %>

                    <td>

                        <div class="actions">


                            <!-- Edit -->

                            <a class="btn edit"
                               href="UpdateCarServlet?id=<%= car.getCarId() %>">

                                Edit

                            </a>


                            <!-- Delete -->

                            <form action="DeleteCarServlet"
                                  method="post"
                                  style="display:inline;">

                                <input type="hidden"
                                       name="id"
                                       value="<%= car.getCarId() %>">

                                <button type="submit"
                                        class="btn delete"
                                        onclick="return confirm('Are you sure you want to delete this car?');">

                                    Delete

                                </button>

                            </form>


                        </div>

                    </td>

                    <% } %>


                </tr>


                <%

                    }

                } else {

                %>


                <tr>

                    <td colspan="<%= isAdmin ? 7 : 6 %>"
                        class="empty">

                        No Cars Found!

                    </td>

                </tr>


                <%

                }

                %>

            </tbody>

        </table>

    </div>


    <!-- BACK BUTTON -->

    <% if(isAdmin) { %>

        <a href="admin-dashboard.jsp" class="back">
            ← Back to Admin Dashboard
        </a>

    <% } else { %>

        <a href="dashboard.jsp" class="back">
            ← Back to User Dashboard
        </a>

    <% } %>


</div>


<!-- FOOTER -->

<div class="footer">

    <p>Car Rental Management System | Advanced Java Lab Project</p>

</div>


</body>

</html>