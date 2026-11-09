<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
.navbar {
    background: #172a45;
    padding: 18px 5%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}

.navbar h2 {
    color: white;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin: 10px;
}

.navbar a:hover {
    color: #ff9800;
}
</style>

<div class="navbar">

<h2>Car Rental Admin</h2>

<div>
<a href="admin-dashboard.jsp">Dashboard</a>
<a href="addCarForm.html">Add Car</a>
<a href="ViewCarServlet">Manage Cars</a>
<a href="ViewUsersServlet">Users</a>
<a href="LogoutServlet">Logout</a>
</div>

</div>