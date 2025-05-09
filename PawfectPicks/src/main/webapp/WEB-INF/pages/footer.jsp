<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>
<footer class="footer">
      <div class="footer-section">
        <h4>FOLLOW US:</h4>
        <div class="social-icons">
          <img src="./assets /icons/facebook-icon.png" alt="Facebook" />
          <img src="./assets /icons/x-icon.png" alt="Twitter" />
          <img src="./assets /icons/instagram-icon.png" alt="Instagram" />
        </div>
      </div>

      <div class="footer-section">
        <h4>SHOP NOW</h4>
        <ul>
          <li>For Dogs</li>
          <li>For Cats</li>
          <li>For Small Pets</li>
        </ul>
      </div>

      <div class="footer-nav">
        <ul>
          <li><a href="#">Home</a></li>
          <li><a href="#">Shop</a></li>
          <li><a href="#">Contact Us</a></li>
          <li><a href="#">About Us</a></li>
          
        </ul>
      </div>

      <div class="footer-section copyright">
        <p>@Copyright</p>
      </div>
      <p>Context path: ${pageContext.request.contextPath}</p>
      
    </footer>
</body>
</html>