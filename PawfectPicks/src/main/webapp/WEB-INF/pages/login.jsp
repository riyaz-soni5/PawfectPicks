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
      href="${pageContext.request.contextPath}/css/login.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>

    <main>
      <div class="login-container">
        <h4 style="text-align: left">Existing User</h4>
        <div class="tabs">
          <button class="tab active" onclick="navigateTo('login')">
            Login
          </button>
          <button class="tab" onclick="navigateTo('register')">Register</button>
        </div>
        <form action="${pageContext.request.contextPath}/submit-login" method="post">
        	<c:if test="${not empty success}">
  				<div class="success-message">${success}</div>
			</c:if>
			<c:if test="${not empty error}">
  				<div class="error-message">${error}</div>
			</c:if>
        	
           
          <label>Email Address</label>
          <input
            type="email"
            name="email"
            value="${cookie.savedEmail.value != null ? cookie.savedEmail.value : ''}"
            placeholder="Enter Your Email"
            required
          />
          <label>Password</label>
          
          <div class="password-field">
            <input
              type="password"
              name="password"
              id="password"
              placeholder="Enter Password"
              required
            />
            <img
              src="${pageContext.request.contextPath}/assets/icons/hide-icon.png"
              alt="Toggle visibility"
              class="toggle-password"
              onclick="togglePassword('password', this)"
            />
          </div>
          <label>
            <input type="checkbox" name="rememberMe" />
            Keep me logged in
          </label>
          <button type="submit" class="login-btn">Log in</button>
          <a href="#" class="forgot">Forgot password?</a>
        </form>
      </div>
    </main>

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
