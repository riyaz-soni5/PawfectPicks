<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/profile.css" />
  </head>
  <body>
    <%@ include file="header.jsp" %>

    <div class="profile-container">
      <h1 class="page-title">My Profile</h1>

      <c:if test="${not empty sessionScope.successMessage}">
        <div class="success-message">${sessionScope.successMessage}</div>
        <c:remove var="successMessage" scope="session" />
      </c:if>
      <c:if test="${not empty sessionScope.errorMessage}">
        <div class="error-message">${sessionScope.errorMessage}</div>
        <c:remove var="errorMessage" scope="session" />
      </c:if>

      <form action="${pageContext.request.contextPath}/updateProfile" method="post" enctype="multipart/form-data" id="profileForm">
        <div class="profile-content">
          <aside class="profile-sidebar">
            <div class="profile-image">
              <c:choose>
                <c:when test="${not empty sessionScope.profileImage}">
                  <img src="${pageContext.request.contextPath}/profile-image?userId=${sessionScope.userId}" alt="Profile" />
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}/assets/icons/profile-user-icon.png" alt="Profile" />
                </c:otherwise>
              </c:choose>
            </div>
            <label for="profileImageUpload" id="editImageLabel" style="display: none; text-decoration: underline; color: #007bff; cursor: pointer;">Edit Profile Picture</label>
            <input type="file" id="profileImageUpload" name="profileImage" accept="image/*" style="display: none;" />
            
            
            <div class="profile-actions">
              <button type="button" class="btn-action" onclick="toggleEdit()" id="editBtn">EDIT PROFILE</button>
              <button type="submit" class="btn-action" id="saveBtn" style="display:none;">SAVE CHANGES</button>
              <button type="button" class="btn-action" onclick="document.getElementById('passwordSection').style.display='block'">CHANGE PASSWORD</button>
            </div>
          </aside>

          <section class="profile-details">
            <div class="form-row">
              <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" name="firstName" id="firstName" class="form-control" value="${user.firstName}" placeholder="Enter your first name" disabled />
              </div>
              <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" name="lastName" id="lastName" class="form-control" value="${user.lastName}" placeholder="Enter your last name" disabled />
              </div>
            </div>

            <div class="form-row">
              <div class="form-group full-width">
                <label for="email">Email Address</label>
                <input type="email" name="email" id="email" class="form-control" value="${user.email}" readonly />
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="birthday">Birthday</label>
                <input type="date" name="birthday" id="birthday" class="form-control" value="${user.birthday}" disabled />
              </div>
              <div class="form-group">
                <label for="gender">Gender</label>
                <select name="gender" id="gender" class="form-control" disabled>
                  <option value="">Select gender</option>
                  <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                  <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                </select>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group full-width">
                <label for="mobile">Mobile</label>
                <input type="tel" name="mobile" id="mobile" class="form-control" value="${user.mobile}" placeholder="Please add your mobile number" disabled />
              </div>
            </div>

            <div class="form-row">
              <div class="form-group full-width">
                <label for="address">Address</label>
                <input type="text" name="address" id="address" class="form-control" value="${user.address}" placeholder="Please add your address" disabled />
              </div>
            </div>
          </section>
        </div>

        <div id="passwordSection" style="display: none; margin-top: 30px">
          <h3>Change Password</h3>
          <div class="form-row">
            <div class="form-group">
              <label for="newPassword">New Password</label>
              <input type="password" name="newPassword" id="newPassword" class="form-control" />
            </div>
            <div class="form-group">
              <label for="confirmPassword">Confirm Password</label>
              <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" />
            </div>
          </div>
        </div>
      </form>
    </div>

    <%@ include file="footer.jsp" %>
    <script>
  function toggleEdit() {
    const form = document.getElementById("profileForm");
    const inputs = form.querySelectorAll("input, select");
    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");
    const imageLabel = document.getElementById("editImageLabel");
    const imageInput = document.getElementById("profileImageUpload");

    if (editBtn.innerText === "EDIT PROFILE") {
      // Enable form fields except email
      inputs.forEach((input) => {
        if (input.id !== "email") input.disabled = false;
      });

      // Enable image input
      imageInput.disabled = false;

      // Show label to trigger file input
      imageLabel.style.display = "inline-block";

      // Update buttons
      editBtn.innerText = "CANCEL";
      saveBtn.style.display = "inline-block";
    } else {
      // Disable all fields again
      inputs.forEach((input) => {
        if (input.id !== "email") input.disabled = true;
      });

      imageInput.disabled = true;
      imageLabel.style.display = "none";

      // Reset button text
      editBtn.innerText = "EDIT PROFILE";
      saveBtn.style.display = "none";
    }
  }

  // Handle clicking label to open file input
  document.addEventListener("DOMContentLoaded", () => {
    const label = document.getElementById("editImageLabel");
    const input = document.getElementById("imageInput");

    if (label && input) {
      label.addEventListener("click", () => input.click());
    }
  });
</script>
  </body>
</html>

