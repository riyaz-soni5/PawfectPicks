<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Summary</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cart.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/OrderConfirmation.css" />
</head>
<body>
  <div><%@ include file="header.jsp" %></div>

  <main class="container order-con-container">
    <section class="order-section">
      <h2>Order Summary</h2>
      <div class="order-table">
        <div class="table-header">
          <div>Product</div>
          <div>Qty</div>
          <div>Unit Price</div>
          <div>Total</div>
        </div>

        <c:forEach var="item" items="${orderItems}">
          <div class="table-row">
            <div>${item.productName}</div>
            <div>${item.quantity}</div>
            <div>Rs ${item.price}</div>
            <div>Rs ${item.price * item.quantity}</div>
          </div>
        </c:forEach>
      </div>

      <div class="summary">
        <p><strong>Delivery Address:</strong> ${deliveryAddress}</p>
        <p><strong>Subtotal:</strong> Rs ${subtotal}</p>
        <p><strong>Shipping Fee:</strong> Rs ${shippingFee}</p>
        <p class="total"><strong>Total:</strong> Rs ${total}</p>

        <form action="${pageContext.request.contextPath}/OrderControllerServlet" method="post">
          <input type="hidden" name="subtotal" value="${subtotal}" />
          <div class="modal-actions">
            <button type="submit" class="btn-confirm">Confirm Order</button>
            <a href="${pageContext.request.contextPath}/cart" class="btn-cancel">Cancel</a>
          </div>
        </form>
      </div>
    </section>
  </main>

  <div><%@ include file="footer.jsp" %></div>
  
</body>
</html>
