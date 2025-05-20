<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% if (session == null || session.getAttribute("userId") == null ||
!"admin".equals(session.getAttribute("role"))) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>

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
          <h2 class="form-title" style="padding:10px;">Add Product</h2>
          <c:if test="${not empty message}">
            <p style="color: green; font-weight: bold">${message}</p>
          </c:if>
          <form
            action="${pageContext.request.contextPath}/AddProductServlet"
            method="post"
            enctype="multipart/form-data"
          >
            <div class="form-flex">
              <!-- Image Upload -->
              <div class="image-upload-container">
                <div class="image-upload">
                  <label for="productImage" style="cursor: pointer">
                    <img
                      id="previewImage"
                      src="${pageContext.request.contextPath}/assets/icons/add_img_icon.png"
                      alt="upload-img"
                    />
                  </label>

                  <input
                    type="file"
                    id="productImage"
                    name="productImage"
                    accept="image/*"
                    style="display: none"
                  />
                </div>
              </div>

              <!-- Form Fields -->
              <div class="fields-container">
                <div class="fields-left">
                  <label for="productName" class="productNameLabel"
                    >Product Name</label
                  >
                  <input
                    type="text"
                    id="productName"
                    name="productName"
                    class="prouct-name"
                    required
                  />

                  <label for="productCategory" class="productCategoryLabel"
                    >Category</label
                  >
                  <input
                    type="text"
                    id="productCategory"
                    name="productCategory"
                    class=".product-category"
                    required
                  />

                  <label for="price" class="priceLabel">Price</label>
                  <input
                    type="number"
                    id="price"
                    name="price"
                    step="0.01"
                    required
                  />
                  <input type="hidden" id="productId" name="productId" />

                  <button
                    type="submit"
                    id="formSubmitButton"
                    class="submit-button"
                  >
                    ADD
                  </button>
                  <button
                    type="button"
                    id="cancelEditButton"
                    class="submit-button"
                    style="background-color: gray; display: none"
                  >
                    CANCEL
                  </button>
                </div>

                <div class="fields-right">
                  <label for="productDescriptions">Product Descriptions</label>
                  <textarea
                    id="productDescriptions"
                    name="productDescriptions"
                    required
                  ></textarea>
                </div>
              </div>
            </div>
          </form>
        </section>

        <!-- Product List Table -->
        <section class="product-list">
          <div class="table-top-content">
            <h2 class="list-title">All Product List</h2>
          </div>

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
            <tbody id="productTableBody">
              <c:forEach var="product" items="${productList}">
                <tr class="product-row-container item">
                  <td class="product-details-container">
                    <img
                      src="data:image/jpeg;base64,${product.base64Image}"
                      alt="${product.name}"
                    />
                    <p>${product.name}</p>
                  </td>
                  <td class="price">Rs ${product.price}</td>
                  <td><p class="categoryName">${product.categoryName}</p></td>
                  <td><span>⭐️ ${product.rating}</span></td>
                  <td>
                    <div class="action-btn-container">
                      <button
                        class="action-btn edit-button"
                        type="button"
                        data-id="${product.id}"
                        data-name="${product.name}"
                        data-category="${product.categoryName}"
                        data-description="${fn:escapeXml(product.description)}"
                        data-price="${product.price}"
                        data-image="${product.base64Image}"
                      >
                        <img
                          src="${pageContext.request.contextPath}/assets/icons/edit-icon.png"
                        />
                      </button>
                      <button
                        class="action-btn stock-toggle-button"
                        type="button"
                        data-id="${product.id}"
                        data-stock="${product.stockStatus}"
                      >
                        <img
                          src="${pageContext.request.contextPath}/assets/icons/out-of-stock-icon.png"
                        />
                      </button>

                      <button class="action-btn delete-button" type="button" data-id="${product.id}">
                        <img
                          src="${pageContext.request.contextPath}/assets/icons/delete-icon.png"
                        />
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <c:if test="${fn:length(productList) > 10}">
            <div class="carousel-controls">
              <button onclick="prevPage()">&#10094;</button>
              <button onclick="nextPage()">&#10095;</button>
            </div>
          </c:if>
        </section>
      </main>
    </div>
    <script>
      const contextPath = "${pageContext.request.contextPath}";
      document
        .getElementById("productImage")
        .addEventListener("change", function (event) {
          const file = event.target.files[0];
          if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
              document.getElementById("previewImage").src = e.target.result;
            };
            reader.readAsDataURL(file);
          }
        });
      let currentPage = 0;
      const rowsPerPage = 10;

      function paginateTable() {
        const rows = document.querySelectorAll("#productTableBody tr");
        rows.forEach((row, index) => {
          row.style.display =
            index >= currentPage * rowsPerPage &&
            index < (currentPage + 1) * rowsPerPage
              ? ""
              : "none";
        });
      }

      function nextPage() {
        const rows = document.querySelectorAll("#productTableBody tr");
        if ((currentPage + 1) * rowsPerPage < rows.length) {
          currentPage++;
          paginateTable();
        }
      }

      function prevPage() {
        if (currentPage > 0) {
          currentPage--;
          paginateTable();
        }
      }
      document.addEventListener("DOMContentLoaded", function () {
    	    // Paginate table
    	    paginateTable();

    	    // Handle image preview
    	    document.getElementById("productImage").addEventListener("change", function (event) {
    	        const file = event.target.files[0];
    	        if (file) {
    	            const reader = new FileReader();
    	            reader.onload = function (e) {
    	                document.getElementById("previewImage").src = e.target.result;
    	            };
    	            reader.readAsDataURL(file);
    	        }
    	    });

    	    // Decode HTML entities
    	    function decodeHtmlEntities(text) {
    	        const textarea = document.createElement("textarea");
    	        textarea.innerHTML = text;
    	        return textarea.value;
    	    }

    	    // Handle Edit Button
    	    document.querySelectorAll(".edit-button").forEach((button) => {
    	        button.addEventListener("click", function () {
    	            document.getElementById("productId").value = this.dataset.id;
    	            document.getElementById("productName").value = this.dataset.name;
    	            document.getElementById("productCategory").value = this.dataset.category;
    	            document.getElementById("price").value = this.dataset.price;
    	            
    	            const fullDescription = decodeHtmlEntities(this.dataset.description || "");
    	            document.getElementById("productDescriptions").value = fullDescription;

    	            document.getElementById("previewImage").src = "data:image/jpeg;base64," + this.dataset.image;

    	            // Change to EDIT mode
    	            document.querySelector(".form-title").textContent = "Edit Product";
    	            const submitBtn = document.getElementById("formSubmitButton");
    	            submitBtn.textContent = "SAVE";
    	            document.querySelector("form").action = contextPath + "/UpdateProductServlet";

    	            document.getElementById("cancelEditButton").style.display = "inline-block";
    	            window.scrollTo({ top: 0, behavior: "smooth" });
    	        });
    	    });

    	    // Cancel Edit
    	    document.getElementById("cancelEditButton").addEventListener("click", function () {
    	        document.querySelector(".form-title").textContent = "Add Product";
    	        document.getElementById("formSubmitButton").textContent = "ADD";
    	        document.querySelector("form").action = contextPath + "/AddProductServlet";

    	        // Clear fields
    	        document.getElementById("productId").value = "";
    	        document.getElementById("productName").value = "";
    	        document.getElementById("productCategory").value = "";
    	        document.getElementById("price").value = "";
    	        document.getElementById("productDescriptions").value = "";
    	        document.getElementById("previewImage").src = "${pageContext.request.contextPath}/assets/icons/add_img_icon.png";
    	        this.style.display = "none";
    	    });

    	    // Stock toggle button logic
    	    document.querySelectorAll(".stock-toggle-button").forEach((button) => {
    	        const stock = button.dataset.stock;
    	        if (stock === "Out Of Stock") {
    	            button.style.backgroundColor = "#99CC9A";
    	        } else {
    	            button.style.backgroundColor = "#F99FB2"; 
    	        }

    	        button.addEventListener("click", function () {
    	            const productId = this.dataset.id;
    	            const self = this;

    	            console.log("Sending productId:", productId);

    	            fetch(contextPath + "/UpdateStockStatusServlet", {
    	                method: "POST",
    	                headers: {
    	                    "Content-Type": "application/x-www-form-urlencoded",
    	                },
    	                body: "productId=" + encodeURIComponent(productId)
    	            })
    	                .then((res) => res.text())
    	                .then((newStatus) => {
    	                    self.dataset.stock = newStatus;

    	                    if (newStatus === "Out Of Stock") {
    	                        self.style.backgroundColor = "#99CC9A";
    	                    } else if (newStatus === "In Stock") {
    	                        self.style.backgroundColor = "#F99FB2";
    	                    }
    	                })
    	                .catch((error) => {
    	                    console.error("Error toggling stock:", error);
    	                    alert("Failed to toggle stock status.");
    	                });
    	        });
    	    });
    	    document.querySelectorAll(".delete-button").forEach((button) => {
    	    	  button.addEventListener("click", function () {
    	    	    const productId = this.dataset.id;
    	    	    if (!productId) return;


    	    	    fetch(contextPath + "/manageproduct", {
    	    	      method: "POST",
    	    	      headers: {
    	    	        "Content-Type": "application/x-www-form-urlencoded",
    	    	      },
    	    	      body: "action=delete&productId=" + encodeURIComponent(productId),
    	    	    })
    	    	      .then((res) => res.text())
    	    	      .then((result) => {
    	    	        if (result === "success") {
    	    	          location.reload();
    	    	        } else {
    	    	          alert("Failed to delete product.");
    	    	        }
    	    	      })
    	    	      .catch((error) => {
    	    	        alert("Error deleting product.");
    	    	      });
    	    	  });
    	    	});

    	});
    </script>
  </body>
</html>
