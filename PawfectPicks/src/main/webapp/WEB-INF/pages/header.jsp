<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header class="top-banner">Summer sale | use code: PETSUMMER</header>

    <nav class="navbar">
      <div class="nav-left">
        <img src="/assets /icons/Pawfect Picks.png" alt="Pawfect Picks Logo" class="logo" />
      </div>

      <div class="hamburger" onclick="toggleMenu()">☰</div>

      <ul class="nav-links" id="navLinks">
        <li>
          <img src="/assets /icons/home-icon.png" alt="Home Icon" class="nav-icon" /><a href="#"
            >HOME</a
          >
        </li>
        <li>
          <img src="/assets /icons/store-icon.png" alt="Shop Icon" class="nav-icon" /><a href="#"
            >SHOP</a
          >
        </li>
        <li>
          <input type="text" placeholder="Search..." class="search-box" />
        </li>
        <li>
          <img src="/assets /icons/contact-us-icon.png" alt="Contact Icon" class="nav-icon" /><a
            href="#"
            >CONTACT</a
          >
        </li>
        <li>
          <img src="/assets /icons/about-us-icon.png" alt="About Icon" class="nav-icon" /><a href="#"
            >ABOUT US</a
          >
        </li>
        <li><img src="./assets /icons/cart-icon.png" alt="Cart Icon" class="nav-icon" /></li>
        <li><img src="./assets /icons/profile-user-icon.png" alt="User Icon" class="nav-icon" /></li>
      </ul>
    </nav>

    <script>
      function toggleMenu() {
        const nav = document.getElementById("navLinks");
        nav.classList.toggle("active");
      }
    </script>
</body>
</html>