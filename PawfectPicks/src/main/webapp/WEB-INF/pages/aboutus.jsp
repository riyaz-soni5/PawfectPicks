<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>About us</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about-us.css" />
</head>
<body>

  <%@ include file="header.jsp" %>

  <main class="main">

    <!-- About Section -->
    <section class="main-content">
      <div class="logo-large">
        <img src="${pageContext.request.contextPath}/assets/img/Pawfect-Picks.png" alt="Pawfect Picks Logo" />
      </div>

      <div class="about-text">
        <h2>About Us</h2>
        <p>
            Welcome to PawFect Picks, your one-stop shop for all your pet's
            needs. Founded in 2025, we started as a small local pet store with a
            passion for animals and have grown into a trusted online destination
            for pet lovers nationwide.
          </p>
          <p>
            Our mission is simple: to provide high-quality, affordable products
            that keep your furry friends happy and healthy. We carefully select
            every item in our inventory, from nutritious foods to fun toys and
            stylish accessories. All our products are sourced from reputable
            manufacturers who share our commitment to animal welfare.
          </p>
          <p>
            What sets us apart is our team of pet enthusiasts. Each of our staff
            members is a pet owner themselves, bringing personal experience and
            knowledge to help you make the best choices for your companion.
            We're not just sellers - we're a community of animal lovers here to
            support you through every stage of your pet's life.
          </p>
          <p>
            At PawFect Picks, we believe pets are family. That's why we offer a
            100% satisfaction guarantee on all our products. If you or your pet
            aren't completely happy, we'll make it right. Thank you for trusting
            us with your pet's needs - we're honored to be part of your pet
            parenting journey.
          </p>
      </div>
    </section>

    <!-- Team Section -->
<section class="team-section">
  <h2>Our Team</h2>
  <div class="team-members">
    <c:forEach var="admin" items="${admins}">
      <div class="member">
        <c:choose>
          <c:when test="${not empty admin.image}">
            <img src="data:image/png;base64,${admin.image}" alt="${admin.name}" />
          </c:when>
          <c:otherwise>
            <img src="${pageContext.request.contextPath}/assets/img/man-profile-account-picture.png" alt="${admin.name}" />
          </c:otherwise>
        </c:choose>
        <p>${admin.name}</p>
      </div>
    </c:forEach>
  </div>
</section>


  </main>

  <%@ include file="footer.jsp" %>
</body>
</html>

