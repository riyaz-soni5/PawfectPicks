<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminHeader.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminSideNav.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manageProducts.css">
</head>
<body class="admin-layout">
    <%@ include file="adminHeader.jsp" %>
    <%@ include file="adminSideNav.jsp" %>
    
    <main class="admin-main">
        <h1 class="page-title">Products</h1>
        
        <!-- Add Product Form -->
        <section class="add-product-form">
            <h2 class="form-title">Add Product</h2>
            <form>
                <div class="form-group">
                    <label for="product-name">Product Name</label>
                    <input type="text" id="product-name" placeholder="Enter product name">
                </div>
                <div class="form-group">
                    <label for="product-desc">Product Description</label>
                    <textarea id="product-desc" placeholder="Enter product description"></textarea>
                </div>
                <div class="form-group">
                    <label for="product-category">Product Category</label>
                    <select id="product-category">
                        <option value="">Select category</option>
                        <option value="dog">Dog</option>
                        <option value="cat">Cat</option>
                        <option value="small-pet">Small Pet</option>
                        <option value="fish">Fish</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="product-price">Price</label>
                    <input type="number" id="product-price" placeholder="Enter price">
                </div>
                <button type="submit" class="add-btn">ADD</button>
            </form>
        </section>
        
        <!-- Product List -->
        <section class="product-list">
            <h2 class="list-title">All Product List</h2>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Category</th>
                        <th>Rating</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Kibbles'n Bites</td>
                        <td>Rs 1000</td>
                        <td>KST</td>
                        <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        <td><button class="action-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>Guinea Pig Food</td>
                        <td>Rs 800</td>
                        <td>GUILFAR</td>
                        <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        <td><button class="action-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>Kibbles'n Bites</td>
                        <td>Rs 500</td>
                        <td>KONIGS</td>
                        <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        <td><button class="action-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>Kibbles'n Bites</td>
                        <td>Rs 500</td>
                        <td>CHEN</td>
                        <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        <td><button class="action-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>Kibbles'n Bites</td>
                        <td>Rs 650</td>
                        <td>GUILFAR</td>
                        <td><img src="${pageContext.request.contextPath}/assets/img/rating-stars.png" class="rating-stars" alt="rating"></td>
                        <td><button class="action-btn">Delete</button></td>
                    </tr>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>