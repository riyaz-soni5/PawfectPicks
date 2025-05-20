<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
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
      href="${pageContext.request.contextPath}/css/shop.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>

    <div class="recommendations-container">
      <!-- Category Tabs -->
      <nav class="category-tabs">
  		<a href="${pageContext.request.contextPath}/shop?category=1" class="tab">Dogs</a>
  		<a href="${pageContext.request.contextPath}/shop?category=2" class="tab">Cats</a>
  		<a href="${pageContext.request.contextPath}/shop?category=3" class="tab">Small Pets</a>
  		<a href="${pageContext.request.contextPath}/shop?category=4" class="tab">Aquatic</a>
  		<a href="${pageContext.request.contextPath}/shop" class="tab ${empty param.category ? 'active' : ''}">Recommendation</a>
	 </nav>


      <!-- Recommendations Section -->
      <section class="section-block">
        <h2 class="section-title">Recommendation For Your Pet</h2>

        <div class="product-grid">
  			<c:forEach var="product" items="${products}">
    			<a href="${pageContext.request.contextPath}/product-details?productId=${product.id}" class="product-card">
      				<div class="product-thumbnail">
        				<img src="${pageContext.request.contextPath}/ProductImageServlet?productId=${product.id}"/>

      				</div>
      				<div class="rating-stars">
        				<c:forEach begin="1" end="${product.rating}"> ⭐ </c:forEach>
      				</div>
      				<h3 class="product-title">${product.name}</h3>
      				<p class="product-price">NPR ${product.price}</p>
    			</a>
  			</c:forEach>
		</div>

      </section>
    </div>

    <div><%@ include file="footer.jsp" %></div>
    <script>
  document.addEventListener("DOMContentLoaded", () => {
    const tabs = document.querySelectorAll(".category-tabs .tab");

    tabs.forEach(tab => {
      tab.addEventListener("click", function (e) {

        // Remove active class from all tabs
        tabs.forEach(t => t.classList.remove("active"));

        // Add active class to clicked tab
        this.classList.add("active");

        // Optionally, you can load category-specific content here
        // Example: fetch or filter products via AJAX
      });
    });
  });
</script>
    
    
  </body>
  
</html>
