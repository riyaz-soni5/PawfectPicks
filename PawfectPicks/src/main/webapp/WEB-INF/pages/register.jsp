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
      href="${pageContext.request.contextPath}/css/register.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>

    <main>
      <div class="register-container">
        <h4 class="section-title">New User</h4>
        <div class="tabs">
          <button class="tab" onclick="navigateTo('login')">
            Login
          </button>
          <button class="tab active" onclick="navigateTo('register')">Register</button>
        </div>
        <form action="${pageContext.request.contextPath}/register" method="post">
          <label>First Name</label>
          <input type="text" name="firstName" placeholder="Enter First Name" required />

          <label>Last Name</label>
          <input type="text" name="lastName" placeholder="Enter Last Name" required />

          <label>Email Address</label>
          <input type="email" name="email" placeholder="Enter Your Email" required />

          <label>Password</label>
          <div class="password-field">
            <input
              type="password"
              name="password"
              id="password"
              placeholder="Create Password"
              required
            />
            <img
              src="${pageContext.request.contextPath}/assets/icons/hide-icon.png"
              alt="Toggle visibility"
              class="toggle-password"
              onclick="togglePassword('password', this)"
            />
          </div>

          <label>Confirm Password</label>
          <div class="password-field">
            <input
              type="password"
              name="confirmPassword"
              id="confirm-password"
              placeholder="Confirm Password"
              required
            />
            <img
              src="${pageContext.request.contextPath}/assets/icons/hide-icon.png"
              alt="Toggle visibility"
              class="toggle-password"
              onclick="togglePassword('confirm-password', this)"
            />
          </div>

          <button type="submit" class="register-btn">Register</button>
        </form>
      </div>
    </main>
    >

    <div><%@ include file="footer.jsp" %></div>

    <script>
      function togglePassword(inputId, icon) {
        const input = document.getElementById(inputId);
        if (!input) return;

        const isHidden = input.type === "password";
        input.type = isHidden ? "text" : "password";

        icon.src = isHidden
          ? "${pageContext.request.contextPath}/assets/icons/show-icon.png"
          : "${pageContext.request.contextPath}/assets/icons/hide-icon.png";
      }
      function navigateTo(path) {
  	    const base = "<%= request.getContextPath() %>";
  	    window.location.href = base + "/" + path;
  	  }
    </script>
  </body>
</html>
