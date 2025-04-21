<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminHeader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminSideNav.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>

<div class="admin-layout">

    <%@ include file="adminHeader.jsp" %>
    <%@ include file="adminSideNav.jsp" %>

    <div class="admin-dashboard">
        <h1>Dashboard</h1>

        <div class="sales-report">
            <h3>Sales Report</h3>
            <div class="chart-container"><img src="${pageContext.request.contextPath}/assets/img/chart.png" /></div>
        </div>

        <div class="dashboard-content">
            <div class="top-products">
                <div class="section-header">
                <h3>Top Products</h3>
                <a href="manage-products.jsp" class="add-btn">Add New Product</a>
            </div>
            <div class="table-container">
                <table class="dashboard-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Sales</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </div>
            <div class="recent-orders">
                <h3>Recent Orders</h3>
            <div class="table-container">
                <table class="dashboard-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Product</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </div>
        </div>
    </div>

</div>


</body>
</html>