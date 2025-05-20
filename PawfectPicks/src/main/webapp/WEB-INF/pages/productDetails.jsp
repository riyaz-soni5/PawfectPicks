<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      href="${pageContext.request.contextPath}/css/header.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/footer.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/productDetails.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>
    <div class="container">
      <button class="back-btn" aria-label="Go back" onclick="goBack()">
        <img
          src="${pageContext.request.contextPath}/assets/icons/back-arrow-icon.png"
          alt="<"
          class="back-arrow-img"
        />
        <span>Back</span>
      </button>

      <div class="product-page">
        <div class="product-image">
          <img
            src="${pageContext.request.contextPath}/ProductImageServlet?productId=${product.id}"
            alt="${product.name}"
          />
        </div>

        <div class="product-details">
          <h1 class="product-title">${product.name}</h1>

          <div class="category-container">
            <div>Product Category:</div>
            <div class="product-category">${product.categoryName}</div>
          </div>

          <div class="rating">
            <c:forEach begin="1" end="${product.rating}">⭐️</c:forEach>
          </div>

          <div class="description">
            <h3 class="description-title">Description</h3>
            <p class="description-text">${product.description}</p>
          </div>

          <div class="price">NPR ${product.price}</div>

          <div class="stock">
            <span>${product.stockStatus}</span>
          </div>

          <div class="quantity-selector">
            <button class="qty-btn" aria-label="Decrease quantity">-</button>
            <input
              type="number"
              class="qty-input"
              value="1"
              min="1"
              aria-label="Quantity"
            />
            <button class="qty-btn" aria-label="Increase quantity">+</button>
          </div>

          <c:choose>
  <c:when test="${product.stockStatus eq 'In Stock'}">
    <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
      <input type="hidden" name="productId" value="${product.id}" />
      <input type="hidden" name="quantity" id="quantityField" value="1" />
      <button type="submit" class="add-to-cart">Add to Cart</button>
    </form>
  </c:when>
  <c:otherwise>
    <button class="add-to-cart" disabled style="background-color: #ccc; cursor: not-allowed;">
      Restocking Soon
    </button>
  </c:otherwise>
</c:choose>

        </div>
      </div>

      <div class="review-container">
      	<div class="review-header-container">
      		<h2>Reviews</h2>
      		<c:if test="${canReview}">
  <button
    class="review-btn"
    onclick="document.getElementById('reviewModal').style.display='flex'"
  >
    Add Review
  </button>

  <div id="reviewModal" class="review-modal">
    <div class="review-modal-content">
      <span
        class="review-close-btn"
        onclick="document.getElementById('reviewModal').style.display='none'"
        >×</span
      >
      <h3>Submit Your Review</h3>
      <form action="${pageContext.request.contextPath}/submit-review" method="post">
  <input type="hidden" name="action" value="submitReview" />
  <input type="hidden" name="productId" value="${product.id}" />
  <div>
    <label>Rating (1–5):</label>
    <input type="number" name="rating" min="1" max="5" required />
  </div>
  <div>
    <label>Your Review:</label><br />
    <textarea name="reviewText" rows="4" cols="40" required></textarea>
  </div>
  <div style="margin-top: 10px">
    <button type="submit" class="review-submit">Submit</button>
    <button
      type="button"
      class="review-cancel"
      onclick="document.getElementById('reviewModal').style.display='none'"
    >
      Cancel
    </button>
  </div>
</form>

    </div>
  </div>
</c:if>
      		
      	
      	</div>
        <c:if test="${empty reviews}">
          <div class="no-review-note">
            No reviews yet – <strong>Buy it</strong> so you can be the first to
            review it on <span class="brand-name">Pawfect Picks</span>!
          </div>
        </c:if>
        <c:forEach var="review" items="${reviews}">
          <div class="review-box">
            <div class="user-info flex">
              <div class="profile-container">
                <c:choose>
                  <c:when test="${not empty review.profileImage}">
                    <img
                      src="${pageContext.request.contextPath}/profile-image?userId=${review.userId}"
                      alt="Profile"
                      class="user-profile"
                    />
                  </c:when>
                  <c:otherwise>
                    <img
                      src="${pageContext.request.contextPath}/assets/img/man-profile-account-picture.png"
                      alt="Default"
                      class="user-profile"
                    />
                  </c:otherwise>
                </c:choose>
              </div>
              <div class="user-name">
                ${review.firstName} ${review.lastName}
              </div>
            </div>

            <div class="user-review flex column">
              <div class="reviews">
                <c:forEach begin="1" end="${review.rating}">⭐</c:forEach>
              </div>
              <div class="review-date">Reviewed on <fmt:formatDate
                    value="${review.createdAt}"
                    pattern="yyyy-MM-dd"
                  /></div>
            </div>

            <div class="description-text">${review.reviewText}</div>
          </div>
        </c:forEach>
      </div>
     
      
      
      
    </div>

    <div><%@ include file="footer.jsp" %></div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const qtyInput = document.querySelector(".qty-input");
        const minusBtn = document.querySelector(".qty-btn:first-child");
        const plusBtn = document.querySelector(".qty-btn:last-child");
        const quantityField = document.getElementById("quantityField");
        
        let stock_text = document.querySelector(".stock");
        
        if(stock_text.innerText === "Out Of Stock"){
        	stock_text.style.color = 'Red'
        }

        minusBtn.addEventListener("click", function () {
          let currentVal = parseInt(qtyInput.value);
          if (currentVal > 1) {
            qtyInput.value = currentVal - 1;
            quantityField.value = qtyInput.value;
          }
        });

        plusBtn.addEventListener("click", function () {
          let currentVal = parseInt(qtyInput.value);
          qtyInput.value = currentVal + 1;
          quantityField.value = qtyInput.value;
        });

        qtyInput.addEventListener("change", function () {
          if (this.value < 1 || isNaN(this.value)) {
            this.value = 1;
          }
          quantityField.value = this.value;
        });
      });

      function goBack() {
        window.history.back();
      }

    </script>
  </body>
</html>
