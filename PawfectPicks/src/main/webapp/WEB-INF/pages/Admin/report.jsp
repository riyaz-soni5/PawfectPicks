<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <% if (session
== null || session.getAttribute("userId") == null ||
!"admin".equals(session.getAttribute("role"))) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Reports</title>
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
    <div class="admin-layout">
      <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>
      <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
      <main class="admin-dashboard">
        <h2>Reports</h2>
        <div class="charts-grid">
          <div class="chart-box">
            <h3>Sales Report</h3>
            <img
              src="${pageContext.request.contextPath}/assets/img/sales_chart2.png"
              alt="Sales Chart"
              class="chart-img"
            />
          </div>
          <div class="chart-box">
            <h3>Order Report</h3>
            <img
              src="${pageContext.request.contextPath}/assets/img/chart_3.png"
              alt="Order Chart"
              class="chart-img"
              style="width: 50%; align-self: center"
            />
          </div>
        </div>
        <div class="stats-grid">
          <div class="stat-card">Total Users <span>${totalUsers}</span></div>
          <div class="stat-card">
            Total Completed Orders <span>${completedOrders}</span>
          </div>
          <div class="stat-card">
            Total Processing Orders <span>${processingOrders}</span>
          </div>
          <div class="stat-card">Total Orders <span>${totalOrders}</span></div>
        </div>

        <div class="table-container">
          <!-- Top Products -->
          <div class="table-wrapper top-product-table" style="flex: 2">
            <section class="order-section">
              <div class="order-header">
                <h2>Top Products</h2>
                <div class="filter-container">
                  <button class="filter-btn" type="button">FILTERS</button>
                  <div class="filter-dropdown hidden">
                    <form
                      method="get"
                      action="${pageContext.request.contextPath}/report"
                    >
                      <button type="submit" name="categoryId" value="All">
                        All
                      </button>
                      <button type="submit" name="categoryId" value="1">
                        Dogs
                      </button>
                      <button type="submit" name="categoryId" value="2">
                        Cats
                      </button>
                      <button type="submit" name="categoryId" value="3">
                        Small Pets
                      </button>
                      <button type="submit" name="categoryId" value="4">
                        Aquatic
                      </button>
                    </form>
                  </div>
                </div>
              </div>

              <div class="order-table">
                <div
                  class="table-header"
                  style="grid-template-columns: 1fr 3fr 1fr 1fr 1fr"
                >
                  <div>Image</div>
                  <div>Product</div>
                  <div>Sales</div>
                  <div>Category</div>
                  <div>Rating</div>
                </div>

                <c:forEach var="product" items="${topProducts}">
                  <div
                    class="table-row"
                    style="grid-template-columns: 1fr 3fr 1fr 1fr 1fr"
                  >
                    <div class="product-img">
                      <img
                        src="data:image/png;base64,${product.base64Image}"
                        alt="${product.name}"
                      />
                    </div>
                    <div class="product-name">
                      <p class="product-name">${product.name}</p>
                      <p class="product-price">Rs ${product.price}</p>
                    </div>
                    <div>${product.totalSales}</div>
                    <div>
                      <span class="category-label"
                        >${product.categoryName}</span
                      >
                    </div>
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
          </div>

          <!-- Contact Messages -->
          <div
            class="table-wrapper contact-message-table order-section"
            style="flex: 1; height: 100%"
          >
            <div class="order-header">
              <h3>Contact Messages</h3>
            </div>
            <table class="dashboard-table order-table">
              <thead class="table-header">
                <tr>
                  <th>User ID</th>
                </tr>
                <tr>
                  <th>Message</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="msg" items="${contactMessages}">
                  <tr class="table-row">
                    <td>${msg.userId}</td>
                    <td>${msg.message}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const filterBtn = document.querySelector(".filter-btn");
        const dropdown = document.querySelector(".filter-dropdown");

        // Toggle dropdown on button click
        filterBtn.addEventListener("click", function (e) {
          e.stopPropagation();
          dropdown.classList.toggle("hidden");
        });

        // Prevent dropdown from closing when clicking inside it
        dropdown.addEventListener("click", function (e) {
          e.stopPropagation();
        });

        // Close dropdown when clicking outside
        document.addEventListener("click", function () {
          dropdown.classList.add("hidden");
        });
      });
    </script>
  </body>
</html>

