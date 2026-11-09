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

<h2>Car Rental</h2>

<div>
<a href="dashboard.jsp">Dashboard</a>
<a href="ViewCarServlet">Cars</a>
<a href="profile.jsp">Profile</a>
<a href="LogoutServlet">Logout</a>
</div>

</div>