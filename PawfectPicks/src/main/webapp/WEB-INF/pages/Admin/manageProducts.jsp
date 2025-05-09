<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Products</title>
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
      href="${pageContext.request.contextPath}/css/manageProducts.css"
    />
  </head>
  <body>
    <div class="admin-layout">
      <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>

      <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>

      <main class="admin-dashboard">
        <h1 class="page-title">Products</h1>

        <!-- Add Product Form -->
        <section class="add-product-form">
          <h2 class="form-title">Add Product</h2>

          <div class="form-grid">
            <div class="image-upload-container">
              <div class="upload-icon-wrapper">
                <div class="upload-icon">
                  <div class="upload-icon-plus"></div>
                </div>
              </div>
              <span class="upload-text">Upload photo</span>
              <input type="file" id="productImage" class="hidden-input" />
            </div>

            <div class="fields-container">
              <div class="fields-left">
                <div class="form-group">
                  <label for="productName">Product Name</label>
                  <input type="text" id="productName" name="productName" />
                </div>

                <div class="category-price-grid">
                  <div class="form-group">
                    <label for="productCategory">Product Category</label>
                    <input
                      type="text"
                      id="productCategory"
                      name="productCategory"
                    />
                  </div>
                  <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" id="price" name="price" />
                  </div>
                </div>

                <div class="button-group">
                  <button type="submit" class="submit-button">ADD</button>
                </div>
              </div>

              <div class="form-group description-group">
                <label for="productDescriptions">Product Descriptions</label>
                <textarea
                  id="productDescriptions"
                  name="productDescriptions"
                  rows="7"
                ></textarea>
              </div>
            </div>
          </div>
        </section>

        <!-- Product List -->
        <section class="product-list">
          <h2 class="list-title">All Product List</h2>
          <table class="product-table">
            <thead>
              <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Category</th>
                <th>Rating</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Kibbles'n Bites</td>
                <td>Rs 1000</td>
                <td>KST</td>
                <td>
                  <img
                    src="${pageContext.request.contextPath}/assets/img/rating-stars.png"
                    class="rating-stars"
                    alt="rating"
                  />
                </td>
                <td><button class="action-btn">Delete</button></td>
              </tr>
              <tr>
                <td>Guinea Pig Food</td>
                <td>Rs 800</td>
                <td>GUILFAR</td>
                <td>
                  <img
                    src="${pageContext.request.contextPath}/assets/img/rating-stars.png"
                    class="rating-stars"
                    alt="rating"
                  />
                </td>
                <td><button class="action-btn">Delete</button></td>
              </tr>
              <tr>
                <td>Kibbles'n Bites</td>
                <td>Rs 500</td>
                <td>KONIGS</td>
                <td>
                  <img
                    src="${pageContext.request.contextPath}/assets/img/rating-stars.png"
                    class="rating-stars"
                    alt="rating"
                  />
                </td>
                <td><button class="action-btn">Delete</button></td>
              </tr>
              <tr>
                <td>Kibbles'n Bites</td>
                <td>Rs 500</td>
                <td>CHEN</td>
                <td>
                  <img
                    src="${pageContext.request.contextPath}/assets/img/rating-stars.png"
                    class="rating-stars"
                    alt="rating"
                  />
                </td>
                <td><button class="action-btn">Delete</button></td>
              </tr>
              <tr>
                <td>Kibbles'n Bites</td>
                <td>Rs 650</td>
                <td>GUILFAR</td>
                <td>
                  <img
                    src="${pageContext.request.contextPath}/assets/img/rating-stars.png"
                    class="rating-stars"
                    alt="rating"
                  />
                </td>
                <td><button class="action-btn">Delete</button></td>
              </tr>
            </tbody>
          </table>
        </section>
      </main>
    </div>
  </body>
</html>
