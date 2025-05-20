<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Home</title>
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
      href="${pageContext.request.contextPath}/css/home.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>

    <div class="homepage-container">
      <!-- Banner Section -->
      <div class="banner-section">
        <div class="slides">
          <img
            src="./assets/img/New Arrivals.png"
            class="slide active"
            alt="Banner 1"
          />
          <img
            src="./assets/img/Aquatic_Banner.png"
            class="slide"
            alt="Banner 2"
          />
          <img
            src="./assets/img/Dogs_Cats_Banner.png"
            class="slide"
            alt="Banner 3"
          />
        </div>
        <button class="nav-button prev" onclick="prevSlide()">❮</button>
        <button class="nav-button next" onclick="nextSlide()">❯</button>
      </div>

      <!-- Top Recommendations Section -->
      <section class="section-block top-recommendations">
        <h2 class="section-title">Top Recommendation</h2>
        <div class="product-grid">
           <c:forEach var="product" items="${topProducts}">
            <a href="${pageContext.request.contextPath}/product-details?productId=${product.id}" class="product-card">
              <div class="product-thumbnail">
                <img
                  src="${pageContext.request.contextPath}/ProductImageServlet?productId=${product.id}"
                  alt="${product.name}"
                />
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
      let currentSlide = 0;
      const slides = document.querySelectorAll(".slide");
      const totalSlides = slides.length;
      let slideInterval = setInterval(nextSlide, 5000); // auto every 5s

      function showSlide(index) {
        slides.forEach((slide, i) => {
          slide.classList.remove("active");
          if (i === index) {
            slide.classList.add("active");
          }
        });
      }

      function nextSlide() {
        currentSlide = (currentSlide + 1) % totalSlides;
        showSlide(currentSlide);
      }

      function prevSlide() {
        currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
        showSlide(currentSlide);
      }

      // Reset timer on manual action
      document.querySelector(".next").addEventListener("click", () => {
        clearInterval(slideInterval);
        nextSlide();
        slideInterval = setInterval(nextSlide, 5000);
      });

      document.querySelector(".prev").addEventListener("click", () => {
        clearInterval(slideInterval);
        prevSlide();
        slideInterval = setInterval(nextSlide, 5000);
      });
    </script>
  </body>
</html>
