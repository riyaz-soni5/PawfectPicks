<!-- adminSideNav.jsp -->

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminSideNav.css">

<div class="admin-sidenav">
    <ul>
        <li><img src="${pageContext.request.contextPath}/assets/icons/dashboard.png" /><span><a href="./dashboard.jsp">Dashboard</a></span></li>
        <li><img src="${pageContext.request.contextPath}/assets/icons/products.png" /><span><a href="./manageProducts.jsp">Manage Product</a></span></li>
        <li><img src="${pageContext.request.contextPath}/assets/icons/orders.png" /><span><a href="./dashboard.jsp">Manage Order</a></span></li>
        <li><img src="${pageContext.request.contextPath}/assets/icons/announcements.png" /><span><a href="./dashboard.jsp">Promotions/ <br>Announcement</a></span></li>
        <li><img src="${pageContext.request.contextPath}/assets/icons/reports.png" /><span>Reports</span></li>
    </ul>
</div>