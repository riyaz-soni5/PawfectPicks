<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%
if (session == null || session.getAttribute("userId") == null ||
!"admin".equals(session.getAttribute("role"))) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Order</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/adminHeader.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/adminSideNav.css"
    />
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/manageOrder.css"
    />
  </head>
  <body>
    <div class="admin-layout">
      <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>
      <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
      <main class="admin-dashboard">
        <section class="order-section">
          <div class="order-header" style="position: relative">
            <h2>Order</h2>
            <div class="filter-container">
              <button class="filter-btn">FILTERS</button>
              <div class="filter-dropdown hidden">
                <form
                  method="get"
                  action="${pageContext.request.contextPath}/manageorder"
                >
                  <button type="submit" name="status" value="All">All</button>
                  <button type="submit" name="status" value="Processing">
                    Processing
                  </button>
                  <button type="submit" name="status" value="Pending">
                    Pending
                  </button>
                  <button type="submit" name="status" value="Completed">
                    Completed
                  </button>
                  <button type="submit" name="status" value="Shipped">
                    Shipped
                  </button>
                </form>
              </div>
            </div>
          </div>
          <div class="order-table">
            <div class="table-header">
              <div>Order ID</div>
              <div>Product</div>
              <div>Category</div>
              <div>Order Status</div>
              <div>Payment Status</div>
              <div>Actions</div>
            </div>

            <c:forEach var="item" items="${orderItems}">
              <div class="table-row">
                <div>${item.orderId}</div>
                <div class="product-info">
                  <div class="product-img">
                    <img
                      src="data:image/jpeg;base64,${item.base64Image}"
                      alt="product"
                      alt="${item.productName}"
                    />
                  </div>
                  <div>
                    <p class="product-name">${item.productName}</p>
                    <p class="product-price">Rs ${item.price}</p>
                  </div>
                </div>
                <div><span class="category-label">${item.category}</span></div>
                <div class="status ${item.orderStatus.toLowerCase()}">
                  ${item.orderStatus}
                </div>
                <div class="status ${item.paymentStatus.toLowerCase()}">
                  ${item.paymentStatus}
                </div>
                <div class="action-buttons">
                  <button
                    type="button"
                    class="btn view-button"
                    data-order-id="${item.orderId}"
                    data-order-status="${item.orderStatus}"
                    data-payment-status="${item.paymentStatus}"
                    data-user-name="${item.userName}"
                    data-user-email="${item.userEmail}"
                    data-user-phone="${item.userPhone}"
                    data-address="${item.deliveryAddress}"
                    data-subtotal="${item.subtotal}"
                    data-shipping="${item.shippingFee}"
                    data-total="${item.totalAmount}"
                    data-product-name="${item.productName}"
                    data-product-qty="${item.quantity}"
                    data-product-price="${item.price}"
                  >
                    <img
                      src="${pageContext.request.contextPath}/assets/icons/view-icon.png"
                    />
                  </button>
                  <div class="dropdown-container">
                    <button
                      type="button"
                      class="btn update-button"
                      data-order-id="${item.orderId}"
                    >
                      <img
                        src="${pageContext.request.contextPath}/assets/icons/change-status-icon.png"
                      />
                    </button>
                    <div class="status-dropdown hidden">
                      <button
                        class="status-option"
                        data-type="order"
                        data-value="Processing"
                        data-order-id="${item.orderId}"
                      >
                        Change Order Status to Processing
                      </button>
                      <button
                        class="status-option"
                        data-type="order"
                        data-value="Shipped"
                        data-order-id="${item.orderId}"
                      >
                        Change Order Status to Shipped
                      </button>
                      <button
                        class="status-option"
                        data-type="order"
                        data-value="Completed"
                        data-order-id="${item.orderId}"
                      >
                        Change Order Status to Completed
                      </button>
                      <button
                        class="status-option"
                        data-type="payment"
                        data-value="Paid"
                        data-order-id="${item.orderId}"
                      >
                        Change Payment Status to Paid
                      </button>
                    </div>
                  </div>

                  <button
                    class="btn delete-button"
                    data-order-item-id="${item.orderItemId != null ? item.orderItemId : 0}"
                  >
                    <img
                      src="${pageContext.request.contextPath}/assets/icons/delete-icon.png"
                    />
                  </button>
                </div>
              </div>
            </c:forEach>
          </div>
        </section>
      </main>
    </div>
    <div id="orderModal" class="modal hidden">
      <div class="modal-content">
        <span class="close-button">&times;</span>
        <h2 style="align-self: center">Order Details</h2>
        <div class="modal-grid">
          <div class="modal-section">
            <h3>Customer Info</h3>
            <p><strong>Name:</strong> <span id="modal-user-name"></span></p>
            <p><strong>Email:</strong> <span id="modal-user-email"></span></p>
            <p><strong>Phone:</strong> <span id="modal-user-phone"></span></p>
            <p>
              <strong>Delivery Address:</strong>
              <span id="modal-address"></span>
            </p>
          </div>
          <div class="modal-section">
            <h3>Order Info</h3>
            <p><strong>Order ID:</strong> <span id="modal-order-id"></span></p>
            <p>
              <strong>Status:</strong> <span id="modal-order-status"></span>
            </p>
            <p>
              <strong>Payment Status:</strong>
              <span id="modal-payment-status"></span>
            </p>
            <p>
              <strong>Subtotal:</strong> Rs <span id="modal-subtotal"></span>
            </p>
            <p>
              <strong>Shipping Fee:</strong> Rs
              <span id="modal-shipping"></span>
            </p>
            <p><strong>Total:</strong> Rs <span id="modal-total"></span></p>
          </div>
        </div>
      </div>
    </div>

    <!-- Status Message Modal -->
    <div id="statusModal" class="status-modal hidden">
      <div class="status-modal-content">
        <span class="status-close-button">&times;</span>
        <h2 id="statusModalTitle" style="text-align: center">Status Update</h2>
        <p id="statusModalMessage" style="text-align: center; margin-top: 10px">
          Message goes here
        </p>
        <div
          style="
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
          "
        >
          <button id="statusModalOkBtn" class="btn primary">OK</button>
        </div>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="delete-modal hidden">
      <div class="delete-modal-content">
        <span class="delete-close-button">&times;</span>
        <h2 style="text-align: center">Confirm Deletion</h2>
        <p style="text-align: center; margin-top: 10px">
          Are you sure you want to delete this order item?
        </p>
        <div
          style="
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
          "
        >
          <button id="confirmDeleteBtn" class="btn danger">Delete</button>
          <button id="cancelDeleteBtn" class="btn secondary">Cancel</button>
        </div>
      </div>
    </div>

    <script>
      const contextPath = "${pageContext.request.contextPath}";

      document.addEventListener("DOMContentLoaded", () => {
        const filterBtn = document.querySelector(".filter-btn");
        const dropdown = document.querySelector(".filter-dropdown");

        filterBtn.addEventListener("click", function (e) {
          e.stopPropagation();
          dropdown.classList.toggle("hidden");
        });

        // Hide dropdown if clicked outside
        document.addEventListener("click", function () {
          dropdown.classList.add("hidden");
        });

        const modal = document.getElementById("orderModal");
        const closeButton = document.querySelector(".close-button");

        // Demo click handler (you should replace this with actual data fetch logic)
        document.querySelectorAll(".view-button").forEach((button) => {
          button.addEventListener("click", function (e) {
            e.preventDefault();
            const btn = this;
            document.getElementById("modal-user-name").textContent =
              btn.dataset.userName;
            document.getElementById("modal-user-email").textContent =
              btn.dataset.userEmail;
            document.getElementById("modal-user-phone").textContent =
              btn.dataset.userPhone;
            document.getElementById("modal-address").textContent =
              btn.dataset.address;

            document.getElementById("modal-order-id").textContent =
              btn.dataset.orderId;
            document.getElementById("modal-order-status").textContent =
              btn.dataset.orderStatus;
            document.getElementById("modal-payment-status").textContent =
              btn.dataset.paymentStatus;
            document.getElementById("modal-subtotal").textContent =
              btn.dataset.subtotal;
            document.getElementById("modal-shipping").textContent =
              btn.dataset.shipping;
            document.getElementById("modal-total").textContent =
              btn.dataset.total;

            modal.classList.remove("hidden");
            modal.classList.remove("hidden");
            modal.style.display = "flex";
          });
        });

        closeButton.addEventListener("click", () => {
          modal.classList.add("hidden");
          modal.style.display = "none";
        });

        window.addEventListener("click", (e) => {
          const modalContent = document.querySelector(".modal-content");
          if (
            !modal.classList.contains("hidden") &&
            !modalContent.contains(e.target)
          ) {
            modal.classList.add("hidden");
          }
        });

        // update status
        document.querySelectorAll(".update-button").forEach((btn) => {
          btn.addEventListener("click", function () {
            const dropdown = this.nextElementSibling;
            dropdown.classList.toggle("hidden");
          });
        });

        // Handle dropdown option selection
        document.querySelectorAll(".status-option").forEach((option) => {
          option.addEventListener("click", function () {
            const orderId = this.getAttribute("data-order-id");
            const statusType = this.getAttribute("data-type"); // 'order' or 'payment'
            const newValue = this.getAttribute("data-value");

            if (!orderId || !statusType || !newValue) {
              alert("Missing data attributes for status update.");
              return;
            }

            // AJAX to update status
            fetch(contextPath + "/manageorder", {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
              },
              body:
                "orderId=" +
                encodeURIComponent(orderId) +
                "&type=" +
                encodeURIComponent(statusType) +
                "&value=" +
                encodeURIComponent(newValue),
            })
              .then((res) => res.text())
              .then((result) => {
                const modal = document.getElementById("statusModal");
                const title = document.getElementById("statusModalTitle");
                const message = document.getElementById("statusModalMessage");

                if (result === "success") {
                  title.textContent = "Success";
                  message.textContent = "Status updated successfully.";
                } else {
                  title.textContent = "Failed";
                  message.textContent = "Failed to update status.";
                }

                modal.classList.remove("hidden");
                modal.style.display = "flex";

                document.getElementById("statusModalOkBtn").onclick = () => {
                  modal.classList.add("hidden");
                  modal.style.display = "none";
                  if (result === "success") location.reload();
                };
              })
              .catch((err) => {
                console.error("Error updating status:", err);
                alert("Error occurred.");
              });
          });
        });

        // Delete Order Item
        let selectedOrderItemId = null;

        // Show modal on delete button click
        document.querySelectorAll(".delete-button").forEach((button) => {
          button.addEventListener("click", function () {
            selectedOrderItemId = this.getAttribute("data-order-item-id");
            document
              .getElementById("deleteConfirmModal")
              .classList.remove("hidden");
            deleteConfirmModal.style.display = "flex";
          });
        });

        // Confirm delete
        document
          .getElementById("confirmDeleteBtn")
          .addEventListener("click", () => {
            if (!selectedOrderItemId) return;

            fetch(contextPath + "/manageorder", {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
              },
              body: "orderItemId=" + encodeURIComponent(selectedOrderItemId),
            })
              .then((res) => res.text())
              .then((result) => {
                selectedOrderItemId = null;
                document
                  .getElementById("deleteConfirmModal")
                  .classList.add("hidden");

                if (result === "success") {
                  location.reload();
                } else {
                  alert("Failed to delete order item.");
                }
              })
              .catch((error) => {
                console.error("Delete error:", error);
                alert("An error occurred while deleting.");
              });
          });

        // Cancel delete
        document
          .getElementById("cancelDeleteBtn")
          .addEventListener("click", () => {
            selectedOrderItemId = null;
            document
              .getElementById("deleteConfirmModal")
              .classList.add("hidden");
          });

        // Close modal on X
        document
          .querySelector(".delete-close-button")
          .addEventListener("click", () => {
            selectedOrderItemId = null;
            document
              .getElementById("deleteConfirmModal")
              .classList.add("hidden");
          });
      });
    </script>
  </body>
</html>
