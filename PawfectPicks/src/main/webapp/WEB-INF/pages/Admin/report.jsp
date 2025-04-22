<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminHeader.jsp" %>
<%@ include file="adminSideNav.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Reports - Pawfect Picks</title>
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
      href="${pageContext.request.contextPath}/css/report.css"
    />
</head>
<body>
	<div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>

    <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
  <main class="main-content">
    <h2>Reports</h2>

    <div class="charts-grid">
      <div class="chart-box">
        <h3>Sales Report</h3>
        <img src="assets/sales-chart.png" alt="Sales Chart" class="chart-img"/>
      </div>
      <div class="chart-box">
        <h3>Order Report</h3>
        <img src="assets/order-chart.png" alt="Order Chart" class="chart-img"/>
      </div>
    </div>

    <div class="stats-grid">
      <div class="stat-card">Total Users <span>100</span></div>
      <div class="stat-card">Total Completed Order <span>10</span></div>
      <div class="stat-card">Total Processing Order <span>5</span></div>
      <div class="stat-card">Total Order <span>15</span></div>
    </div>

    <div class="top-products">
      <h3>Top Products</h3>
      <div class="product-row">
        <img src="assets/kibbles.png" alt="Kibbles" class="product-img"/>
        <div class="product-info">
          <strong>Kibbles’n Bites</strong>
          <p class="category-tag">Dogs</p>
          <p class="price">Rs 1000</p>
        </div>
        <div class="product-sales">50</div>
        <div class="product-rating">★★★★★</div>
      </div>

      <div class="product-row">
        <img src="assets/dogball.png" alt="Toy Ball" class="product-img"/>
        <div class="product-info">
          <strong>Toy Ball For Dogs</strong>
          <p class="category-tag">Dogs</p>
          <p class="price">Rs 200</p>
        </div>
        <div class="product-sales">48</div>
        <div class="product-rating">★★★★★</div>
      </div>
    </div>
  </main>
</body>
</html>
