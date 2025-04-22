<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Order - Pawfect Picks</title>
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
      href="${pageContext.request.contextPath}/css/manageOrder.css"
    />
  </head>
  <body>
    <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>

    <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
    <main class="main-content">
      <section class="order-section">
        <div class="order-header">
          <h2>Order</h2>
          <button class="filter-btn">FILTERS</button>
        </div>

        <div class="order-table">
          <div class="table-header">
            <div>Order ID</div>
            <div>Product</div>
            <div>Category</div>
            <div>Order Status</div>
            <div>Payment Status</div>
            <div>Actions</div>
          </div>

          <div class="table-row">
            <div>101</div>
            <div class="product-info">
              <div class="product-img placeholder-img"></div>
              <div>
                <p class="product-name">Boca Plush Mouse Cat Toy</p>
                <p class="product-price">Rs 250</p>
              </div>
            </div>
            <div><span class="category-label">Cats</span></div>
            <div class="status processing">Processing</div>
            <div class="status pending">Pending</div>
            <div class="action-buttons">
              <button class="btn view">&#128065;</button>
              <button class="btn update">&#8635;</button>
              <button class="btn delete">&#10006;</button>
            </div>
          </div>

          <!-- Repeat the row below as needed -->

          <!-- You can add more rows below similarly -->
        </div>
      </section>
    </main>
  </body>
</html>