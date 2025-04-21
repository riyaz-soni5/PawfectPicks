<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pawfect Picks</title>
    <link rel="stylesheet" href="styles.css">
    <script defer src="script.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
    <main>
        <section class="hero">
            <div class="image-container"> 
                <img src="placeholder.png" alt="Hero Image">
            </div>
        </section>
        <section class="recommendations">
            <h2>Top Recommendations</h2>
            <div class="product-grid">
                <div class="product"><img src="placeholder.png" alt="Product 1"></div>
                <div class="product"><img src="placeholder.png" alt="Product 2"></div>
                <div class="product"><img src="placeholder.png" alt="Product 3"></div>
                <div class="product"><img src="placeholder.png" alt="Product 4"></div>
            </div>
        </section>
    </main>
    <footer>
        <div class="social-links">Follow us: <span>🔗</span></div>
        <div class="shop-now">Shop Now</div>
        <div class="copyright">&copy; 2025 Pawfect Picks</div>
    </footer>
</body>
</html>
