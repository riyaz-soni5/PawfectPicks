<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <% if (session
== null || session.getAttribute("userId") == null ||
!"admin".equals(session.getAttribute("role"))) {
response.sendRedirect(request.getContextPath() + "/login"); return; } %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Users</title>
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
    <link
      rel="stylesheet"
      type="text/css"
      href="${pageContext.request.contextPath}/css/ManageUser.css"
    />
  </head>
  <body>
    <div class="admin-layout">
      <div class="adminHeader"><%@ include file="adminHeader.jsp" %></div>
      <div class="adminSideNav"><%@ include file="adminSideNav.jsp" %></div>
      <main class="admin-dashboard">
        <section class="order-section">
          <div class="order-header">
            <h2>Manage Users</h2>
            <div class="filter-container">
              <button class="filter-btn" type="button">FILTERS</button>
              <div class="filter-dropdown hidden">
                <form
                  method="get"
                  action="${pageContext.request.contextPath}/manageusers"
                >
                  <button type="submit" name="role" value="All">All</button>
                  <button type="submit" name="role" value="user">User</button>
                  <button type="submit" name="role" value="admin">Admin</button>
                </form>
              </div>
            </div>
          </div>

          <div class="order-table">
            <div
              class="table-header"
              style="grid-template-columns: 1fr 3fr 1.5fr 2fr 2fr"
            >
              <div>User ID</div>
              <div>Email</div>
              <div>Role</div>
              <div>Created At</div>
              <div>Actions</div>
            </div>

            <!-- Sample static rows -->
            <c:forEach var="user" items="${users}">
              <div
                class="table-row"
                style="grid-template-columns: 1fr 3fr 1.5fr 2fr 2fr"
              >
                <div>${user.userId}</div>
                <div>${user.email}</div>
                <div><span class="category-label">${user.role}</span></div>
                <div>
                  <fmt:formatDate
                    value="${user.createdAt}"
                    pattern="yyyy-MM-dd"
                  />
                </div>
                <div class="action-buttons">
                  <div class="dropdown-container">
                    <button class="btn update-role-button">
                      <img
                        src="${pageContext.request.contextPath}/assets/icons/change-status-icon.png"
                      />
                    </button>
                    <div class="role-dropdown hidden">
                      <button
                        class="role-option"
                        data-user-id="${user.userId}"
                        data-role="admin"
                      >
                        Change to Admin
                      </button>
                      <button
                        class="role-option"
                        data-user-id="${user.userId}"
                        data-role="user"
                      >
                        Change to User
                      </button>
                    </div>
                  </div>
                  <button
                    class="btn delete-button"
                    data-user-id="${user.userId}"
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
    <!-- Confirm Role Change Modal -->
    <div id="confirmRoleModal" class="delete-modal hidden">
      <div class="delete-modal-content">
        <span class="delete-close-button">&times;</span>
        <h2 style="text-align: center">Confirm Role Change</h2>
        <p
          id="confirmRoleMessage"
          style="text-align: center; margin-top: 10px"
        ></p>
        <div
          style="
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
          "
        >
          <button id="confirmRoleBtn" class="btn danger">Confirm</button>
          <button id="cancelRoleBtn" class="btn secondary">Cancel</button>
        </div>
      </div>
    </div>

    <!-- Status Modal -->
    <div id="roleStatusModal" class="status-modal hidden">
      <div class="status-modal-content">
        <span class="status-close-button">&times;</span>
        <h2 id="roleStatusTitle" style="text-align: center"></h2>
        <p
          id="roleStatusMessage"
          style="text-align: center; margin-top: 10px"
        ></p>
        <div
          style="
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
          "
        >
          <button id="roleStatusOkBtn" class="btn primary">OK</button>
        </div>
      </div>
    </div>

    <!-- Delete User Confirmation Modal -->
    <div id="confirmDeleteUserModal" class="delete-modal hidden">
      <div class="delete-modal-content">
        <span class="delete-close-button">&times;</span>
        <h2 style="text-align: center">Confirm Deletion</h2>
        <p id="deleteUserMessage" style="text-align: center; margin-top: 10px">
          Are you sure you want to delete this user?
        </p>
        <div
          style="
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
          "
        >
          <button id="confirmDeleteUserBtn" class="btn danger">Delete</button>
          <button id="cancelDeleteUserBtn" class="btn secondary">Cancel</button>
        </div>
      </div>
    </div>

    <script>
      const contextPath = "${pageContext.request.contextPath}";
      document.addEventListener("DOMContentLoaded", function () {
        const filterBtn = document.querySelector(".filter-btn");
        const dropdown = document.querySelector(".filter-dropdown");

        filterBtn.addEventListener("click", function (e) {
          e.stopPropagation();
          dropdown.classList.toggle("hidden");
        });

        // Close dropdown if clicked outside
        document.addEventListener("click", function () {
          dropdown.classList.add("hidden");
        });
      });
      let selectedUserId = null;
      let selectedRole = null;

      // Show role dropdown
      document.querySelectorAll(".update-role-button").forEach((button) => {
        button.addEventListener("click", function () {
          const dropdown = this.nextElementSibling;
          dropdown.classList.toggle("hidden");

          document.querySelectorAll(".role-dropdown").forEach((d) => {
            d.classList.add("hidden");
            d.style.display = "none";
          });

          // Toggle current one
          if (dropdown.classList.contains("hidden")) {
            dropdown.classList.remove("hidden");
            dropdown.style.display = "flex"; // This is what you need
          } else {
            dropdown.classList.add("hidden");
            dropdown.style.display = "none";
          }
        });
      });

      // Handle dropdown selection
      document.querySelectorAll(".role-option").forEach((option) => {
        option.addEventListener("click", function () {
          selectedUserId = this.dataset.userId;
          selectedRole = this.dataset.role;

          document.getElementById("confirmRoleMessage").textContent =
            "Are you sure you want to change role to " + selectedRole;

          const modal = document.getElementById("confirmRoleModal");
          modal.classList.remove("hidden");
          modal.style.display = "flex";
        });
      });

      // Confirm role change
      document
        .getElementById("confirmRoleBtn")
        .addEventListener("click", () => {
          if (!selectedUserId || !selectedRole) return;

          fetch(contextPath + "/manageusers", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body:
              "userId=" +
              encodeURIComponent(selectedUserId) +
              "&newRole=" +
              encodeURIComponent(selectedRole),
          })
            .then((res) => res.text())
            .then((result) => {
              document
                .getElementById("confirmRoleModal")
                .classList.add("hidden");
              document.getElementById("confirmRoleModal").style.display =
                "none";

              const statusModal = document.getElementById("roleStatusModal");
              const title = document.getElementById("roleStatusTitle");
              const message = document.getElementById("roleStatusMessage");

              if (result === "success") {
                title.textContent = "Success";
                message.textContent = "User role updated successfully.";
              } else {
                title.textContent = "Error";
                message.textContent = "Failed to update user role.";
              }

              statusModal.classList.remove("hidden");
              statusModal.style.display = "flex";
            });
        });

      document.getElementById("cancelRoleBtn").addEventListener("click", () => {
        document.getElementById("confirmRoleModal").classList.add("hidden");
        document.getElementById("confirmRoleModal").style.display = "none";
      });

      document
        .getElementById("roleStatusOkBtn")
        .addEventListener("click", () => {
          document.getElementById("roleStatusModal").classList.add("hidden");
          document.getElementById("roleStatusModal").style.display = "none";
          location.reload();
        });
      let selectedDeleteUserId = null;

      // Open delete modal when delete button is clicked
      document.querySelectorAll(".delete-button").forEach((button) => {
        button.addEventListener("click", function () {
          selectedDeleteUserId = this.dataset.userId;

          const modal = document.getElementById("confirmDeleteUserModal");
          modal.classList.remove("hidden");
          modal.style.display = "flex";
        });
      });

      // Cancel delete
      document
        .getElementById("cancelDeleteUserBtn")
        .addEventListener("click", () => {
          document
            .getElementById("confirmDeleteUserModal")
            .classList.add("hidden");
          document.getElementById("confirmDeleteUserModal").style.display =
            "none";
          selectedDeleteUserId = null;
        });

      // Close modal on X
      document
        .querySelector(".delete-close-button")
        .addEventListener("click", () => {
          document
            .getElementById("confirmDeleteUserModal")
            .classList.add("hidden");
          document.getElementById("confirmDeleteUserModal").style.display =
            "none";
          selectedDeleteUserId = null;
        });

      // Confirm delete
      document
        .getElementById("confirmDeleteUserBtn")
        .addEventListener("click", () => {
          if (!selectedDeleteUserId) return;

          fetch(contextPath + "/manageusers", {
            method: "POST",
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
            },
            body: "deleteUserId=" + encodeURIComponent(selectedDeleteUserId),
          })
            .then((res) => res.text())
            .then((result) => {
              document
                .getElementById("confirmDeleteUserModal")
                .classList.add("hidden");
              document.getElementById("confirmDeleteUserModal").style.display =
                "none";

              const statusModal = document.getElementById("roleStatusModal");
              const title = document.getElementById("roleStatusTitle");
              const message = document.getElementById("roleStatusMessage");

              if (result === "success") {
                title.textContent = "Deleted";
                message.textContent = "User deleted successfully.";
              } else {
                title.textContent = "Error";
                message.textContent = "Failed to delete user.";
              }

              statusModal.classList.remove("hidden");
              statusModal.style.display = "flex";
            });
        });
    </script>
  </body>
</html>


