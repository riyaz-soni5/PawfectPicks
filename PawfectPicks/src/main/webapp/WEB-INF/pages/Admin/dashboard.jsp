<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%
if (session == null || session.getAttribute("userId") == null ||
!"admin".equals(session.getAttribute("role"))) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Dashboard</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/adminHeader.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/adminSideNav.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/dashboard.css"
    />
  </head>
  <body>
    <div class="admin-layout">
      <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>

      <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
      <div class="admin-dashboard">
        <h1>Dashboard</h1>

        <!-- SALES REPORT SECTION -->
        <section class="card sales-report">
          <h3>Sales Report</h3>
          <div class="chart-container">
            <img
              src="${pageContext.request.contextPath}/assets/img/sales_chart.png"
              alt="Sales Chart"
            />
          </div>
        </section>

        <!-- TABLES SECTION -->
        <div class="table-container">
          <!-- TOP PRODUCTS TABLE -->
          <section class="order-section top-product-table">
            <div class="order-header">
              <h2>Top Products</h2>
              <a
                href="${pageContext.request.contextPath}/manageproduct"
                class="btn add-btn"
                >Add New Product</a
              >
            </div>

            <div class="order-table">
              <div
                class="table-header"
                style="grid-template-columns: 3fr 1fr 1fr"
              >
                <div>Product</div>
                <div>Sales</div>
                <div>Rating</div>
              </div>

              <c:forEach var="product" items="${topProducts}">
                <div
                  class="table-row"
                  style="grid-template-columns: 3fr 1fr 1fr"
                >
                  <div class="product-info">
                    <img
                      src="data:image/png;base64,${product.base64Image}"
                      alt="${product.name}"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>${product.name}</h3>
                      <span class="badge category"
                        >${product.categoryName}</span
                      >
                      <span class="price">Rs ${product.price}</span>
                    </div>
                  </div>
                  <div>${product.totalSales}</div>
                  <div>
                    <c:set var="starsInt" value="${product.rating}" />
                    <c:forEach begin="1" end="${starsInt}" var="i"
                      >⭐️</c:forEach
                    >
                  </div>
                </div>
              </c:forEach>
            </div>
          </section>

          <!-- RECENT ORDERS TABLE -->
          <div class="order-section recent-order-table">
            <div class="order-header">
              <h2>Recent Orders</h2>
            </div>

            <div class="order-table">
              <div
                class="table-header"
                style="grid-template-columns: 1fr 3fr 1.5fr"
              >
                <div>Order ID</div>
                <div>Product</div>
                <div>Status</div>
              </div>

              <c:forEach var="order" items="${recentOrders}">
                <div
                  class="table-row"
                  style="grid-template-columns: 1fr 3fr 1.5fr"
                >
                  <div>${order.orderId}</div>
                  <div class="product-info">
                    <img
                      src="data:image/png;base64,${order.productImage}"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>${order.productName}</h3>
                      <span class="price">Rs ${order.price}</span>
                    </div>
                  </div>
                  <div class="status ${order.orderStatus.toLowerCase()}">
                    ${order.orderStatus}
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
