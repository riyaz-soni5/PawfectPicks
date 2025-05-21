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
  <style>
    .order-section {
      background: #fff;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .order-table {
      width: 100%;
      display: grid;
      gap: 1rem;
    }
    .table-header, .table-row {
      display: grid;
      grid-template-columns: 3fr 1fr 1fr 1fr;
      align-items: center;
      padding: 1rem;
      background: #fff;
      border-bottom: 1px solid #ddd;
    }
    .table-header {
      font-weight: bold;
      background: #f3f3f3;
    }
    .summary {
      margin-top: 2rem;
      background: #f9f9f9;
      padding: 1.5rem;
      border-radius: 8px;
    }
    .summary p {
      margin: 0.5rem 0;
    }
    .modal-actions {
      margin-top: 1.5rem;
    }
    .btn-confirm {
      background-color: #28a745;
      color: white;
      border: none;
      padding: 10px 20px;
      margin-right: 10px;
      border-radius: 5px;
      cursor: pointer;
    }
    .btn-cancel {
      background-color: #dc3545;
      color: white;
      padding: 10px 20px;
      border-radius: 5px;
      text-decoration: none;}
      .modal-overlay {
  position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: rgba(0,0,0,0.5); display: none; align-items: center; justify-content: center;
}
.modal-content {
  background: white; padding: 2rem; border-radius: 8px; text-align: center;
}
.modal-content h2 { color: green; }
  </style>
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
