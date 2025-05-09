<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
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
              src="${pageContext.request.contextPath}/assets/img/chart.png"
              alt="Sales Chart"
            />
          </div>
        </section>

        <!-- TABLES SECTION -->
        <div class="table-container">
          <!-- TOP PRODUCTS TABLE -->
          <div class="table-wrapper top-product-table">
            <table class="dashboard-table">
              <thead>
                <tr class="table-header-row">
                  <th><h3>Top Products</h3></th>
                  <th></th>
                  <th class="text-right">
                    <a href="manage-products.jsp" class="btn add-btn">Add New Product</a>
                  </th>
                </tr>
                <tr>
                  <th>Product</th>
                  <th>Sales</th>
                  <th>Rating</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/pet_food_2.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Kibbles'n Bites</h3>
                      <span class="badge category">Dogs</span>
                      <span class="price">Rs 1000</span>
                    </div>
                  </td>
                  <td>50</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/dog_toy.webp"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Toy Ball</h3>
                      <span class="badge category">Dogs</span>
                      <span class="price">RS 200</span>
                    </div>
                  </td>
                  <td>48</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/pet_cage.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Small Pet Cage</h3>
                      <span class="badge category">Small Pets</span>
                      <span class="price">RS 650</span>
                    </div>
                  </td>
                  <td>30</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/pet_food_1.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Pedigree</h3>
                      <span class="badge category">Dogs</span>
                      <span class="price">RS 1200</span>
                    </div>
                  </td>
                  <td>29</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/cat_toy_2.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Mini Teaser Wand Cat Toy</h3>
                      <span class="badge category">Cats</span>
                      <span class="price">RS 1200</span>
                    </div>
                  </td>
                  <td>20</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
                <tr>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/food_2.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Guinea Pig Food</h3>
                      <span class="badge category">Small Pets</span>
                      <span class="price">RS 800</span>
                    </div>
                  </td>
                  <td>10</td>
                  <td>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/ratings.webp"
                      alt="rating"
                      class="rating-stars"
                    />
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- RECENT ORDERS TABLE -->
          <div class="table-wrapper recent-orders-table">
            <table class="dashboard-table">
              <thead>
                <tr class="table-header-row">
                  <th colspan="3">Recent Orders</th>
                </tr>
                <tr>
                  <th>Order ID</th>
                  <th>Product</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>101</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/cat_toy_1.webp"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Boca Plush Mouse Cat Toy</h3>
                      <span class="price">Rs 250</span>
                    </div>
                  </td>
                  <td class="status processing">Processing</td>
                </tr>
                <tr>
                  <td>102</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/food_3.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Guinea Pig Food</h3>
                      <span class="price">Rs 800</span>
                    </div>
                  </td>
                  <td class="status processing">Processing</td>
                </tr>
                <tr>
                  <td>103</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/pet_cage.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Small Pet Cage</h3>
                      <span class="price">Rs 650</span>
                    </div>
                  </td>
                  <td class="status complete">Complete</td>
                </tr>
                <tr>
                  <td>104</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/aquarium_decoration.webp"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Fish Gear Rock Hill Aquarium</h3>
                      <span class="price">Rs 500</span>
                    </div>
                  </td>
                  <td class="status complete">Complete</td>
                </tr>
                <tr>
                  <td>105</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/cat_toy_2.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Mini Teaser Wand Cat Toy</h3>
                      <span class="price">Rs 500</span>
                    </div>
                  </td>
                  <td class="status complete">Complete</td>
                </tr>
                <tr>
                  <td>106</td>
                  <td class="product-info">
                    <img
                      src="${pageContext.request.contextPath}/assets/products/pet_food_1.png"
                      alt="product"
                      class="product-img"
                    />
                    <div class="product-meta">
                      <h3>Pedigree</h3>
                      <span class="price">Rs 1200</span>
                    </div>
                  </td>
                  <td class="status complete">Complete</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>