<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cart</title>
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
      href="${pageContext.request.contextPath}/css/cart.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>
    <main class="container">
      <div class="cart-section" style="display:flex; flex-direction:column;">
      <div style="display:flex; gap: 5px;">
      	<h3>MY CART</h3>
      	<img alt="cart-icon" src="${pageContext.request.contextPath}/assets/icons/cart-icon.png" class="nav-icon">
      </div>
        <c:forEach var="item" items="${cartItems}">
          <div class="item" data-unitprice="${item.price}" data-qty="${item.quantity}">
            <img src="${item.imageUrl}" />
            <div class="item-info">
              <h4>${item.productName}</h4>
              <p>Rs ${item.price}</p>
            </div>
            <form
              action="${pageContext.request.contextPath}/remove-from-cart"
              method="post"
            >
              <input type="hidden" name="cartId" value="${item.cartId}" />
              <button
                type="submit"
                class="remove"
                style="border: none; background: none; cursor: pointer"
              >
                ✖
              </button>
            </form>
          </div>
        </c:forEach>
      </div>

      <div class="summary">
        <i class="fa-solid fa-location-dot"></i>
        <p id="delivery-address">
  			Deliver to: 
  			<c:choose>
    			<c:when test="${not empty deliveryAddress}">
      				${deliveryAddress}
    			</c:when>
    			<c:otherwise>
      				<span style="color:red;">Go to profile to edit your address</span>
    			</c:otherwise>
  			</c:choose>
		</p>

        <h4>Order Summary</h4>
        <p>Total <span id="subtotal">Rs ${subtotal}</span></p>

        <c:choose>
  			<c:when test="${not empty deliveryAddress}">
  				<form method="get" action="${pageContext.request.contextPath}/checkout-summary">
    				<button type="submit" class="checkout">PROCEED TO CHECKOUT</button>
  				</form>
			</c:when>
  		<c:otherwise>
  			<button type="submit" class="checkout">PROCEED TO CHECKOUT</button>
    		<p style="color: red; font-size: 14px; margin-top: 5px;">
      			⚠ Please add a delivery address to proceed with checkout.
    		</p>
  		</c:otherwise>
	</c:choose>
      </div>
    </main>
    <div><%@ include file="footer.jsp" %></div>
    
    <c:if test="${not empty sessionScope.orderSuccess}">
  <div class="modal-overlay" style="display:flex;">
    <div class="modal-content" style="display:flex; flex-direction: column; text-align: center;'">
      <h2>🎉 Order Confirmed!</h2>
      <p>Your order has been placed successfully and will arrive within 2–3 business days.</p>
      <a href="${pageContext.request.contextPath}/shop" class="btn-confirm" style="text-decoration: none">Continue Shopping</a>
    </div>
  </div>
  <c:remove var="orderSuccess" scope="session" />
</c:if>
    
     
  </body>
</html>

