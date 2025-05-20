<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String email = (String) session.getAttribute("email"); String role = (String)session.getAttribute("role"); %>

<header>

  <nav class="navbar">
    <div class="nav-left">
      <img
        src="${pageContext.request.contextPath}/assets/img/Pawfect-Picks.png"
        alt="Pawfect Picks Logo"
        class="logo"
      />
    </div>

    <div class="hamburger" onclick="toggleMenu()">☰</div>

    <ul class="nav-links" id="navLinks">
      <li>
        <img
          src="${pageContext.request.contextPath}/assets/icons/home-icon.png"
          alt="Home Icon"
          class="nav-icon"
        /><a href="${pageContext.request.contextPath}/home">HOME</a>
      </li>
      <li>
        <img
          src="${pageContext.request.contextPath}/assets/icons/store-icon.png"
          alt="Shop Icon"
          class="nav-icon"
        /><a href="${pageContext.request.contextPath}/shop">SHOP</a>
      </li>
      <li>
        <img
          src="${pageContext.request.contextPath}/assets/icons/contact-us-icon.png"
          alt="Contact Icon"
          class="nav-icon"
        /><a href="${pageContext.request.contextPath}/contact">CONTACT</a>
      </li>
      <li>
        <img
          src="${pageContext.request.contextPath}/assets/icons/about-us-icon.png"
          alt="About Icon"
          class="nav-icon"
        /><a href="${pageContext.request.contextPath}/aboutus">ABOUT US</a>
      </li>
      <li>
        <a href="${pageContext.request.contextPath}/cart">
          <img
            src="${pageContext.request.contextPath}/assets/icons/cart-icon.png"
            alt="Cart Icon"
            class="nav-icon"
          />
        </a>
      </li>
      <li class="profile-dropdown">
        <c:choose>
          <c:when test="${not empty sessionScope.email}">
            <div class="dropdown-trigger" id="userDropdown">
              <img src="${pageContext.request.contextPath}/profile-image?userId=${sessionScope.userId}" 
              onerror="this.onerror=null; 
              this.src='${pageContext.request.contextPath}/assets/icons/profile-user-icon.png';" 
              alt="User Icon"
              class="nav-icon"
              style="border-radius: 50%; width: 30px; height: 30px;"/>
              <ul class="dropdown-menu" id="dropdownMenu">
                <li>
                  <a href="${pageContext.request.contextPath}/profile"
                    >Profile</a
                  >
                </li>
                <li>
                  <a href="${pageContext.request.contextPath}/logout"
                    >Logout</a
                  >
                </li>
              </ul>
            </div>
          </c:when>
          <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">
              <img
                src="${pageContext.request.contextPath}/assets/icons/profile-user-icon.png"
                alt="User Icon"
                class="nav-icon"
              />
            </a>
          </c:otherwise>
        </c:choose>
      </li>
    </ul>
  </nav>
</header>

<script>
  function toggleMenu() {
    const nav = document.getElementById("navLinks");
    nav.classList.toggle("active");
  }
  document.addEventListener("DOMContentLoaded", function () {
	    const trigger = document.getElementById("userDropdown");
	    const dropdown = document.getElementById("dropdownMenu");

	    if (trigger && dropdown) {
	      trigger.addEventListener("click", function (e) {
	        e.stopPropagation();
	        dropdown.style.display =
	          dropdown.style.display === "block" ? "none" : "block";
	      });

	      // Hide dropdown when clicking outside
	      document.addEventListener("click", function (e) {
	        if (!trigger.contains(e.target)) {
	          dropdown.style.display = "none";
	        }
	      });
	    }
	  });
</script>
