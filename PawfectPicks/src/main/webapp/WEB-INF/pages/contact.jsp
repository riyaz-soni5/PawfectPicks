<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Contact Our Team</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/header.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/footer.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/contact.css"
    />
  </head>
  <body>
    <div><%@ include file="header.jsp" %></div>

    <main class="main-content">
      <h1 class="page-title">Contact Our Team</h1>
      <p class="subtitle">
        Got any questions about the product or anything else related to the
        platform? We're here to help
      </p>

      <div class="contact-container">
        <!-- Contact Form -->
        <form
          class="contact-form"
          method="post"
          action="${pageContext.request.contextPath}/SubmitContactMessage"
        >
          <!-- Add name attribute to fields -->
          <div class="form-row">
            <div class="form-group">
              <label for="firstName">First name</label>
              <input
                type="text"
                name="firstName"
                id="firstName"
                class="form-control"
                required
              />
            </div>
            <div class="form-group">
              <label for="lastName">Last name</label>
              <input
                type="text"
                name="lastName"
                id="lastName"
                class="form-control"
                required
              />
            </div>
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input
              type="email"
              name="email"
              id="email"
              class="form-control"
              required
            />
          </div>

          <div class="form-group">
            <label for="message">Message</label>
            <textarea
              name="message"
              id="message"
              class="form-control"
              rows="20"
              required
            ></textarea>
          </div>

          <button type="submit" class="btn btn-send">Send message</button>
        </form>

        <!-- Contact Info -->
        <div class="contact-info">
          <h2>Chat with us</h2>
          <div class="contact-item social-icons">
            <a href="#"
              ><img
                src="${pageContext.request.contextPath}/assets/icons/facebook-icon.png"
                alt="Facebook"
                class="icon"
            /></a>
            <a href="#"
              ><img
                src="${pageContext.request.contextPath}/assets/icons/x-icon.png"
                alt="X"
                class="icon"
            /></a>
            <a href="#"
              ><img
                src="${pageContext.request.contextPath}/assets/icons/instagram-icon.png"
                alt="Instagram"
                class="icon"
            /></a>
          </div>

          <div class="contact-item phone">
            <h2>Call us</h2>
            <div>
              <img
                src="${pageContext.request.contextPath}/assets/icons/contact-us-icon.png"
                alt="Phone"
                class="icon"
              />
              <p>+977 9349280394</p>
            </div>
          </div>

          <div class="contact-item address">
            <h2>Visit us</h2>
            <div>
              <img
                src="${pageContext.request.contextPath}/assets/icons/location-icon.png"
                alt="Location"
                class="icon"
              />
              <p>Kamal Pokhari, Near Islington College</p>
            </div>
          </div>

          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.212112472224!2d85.32268482539233!3d27.710736475342106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb1908c874a40b%3A0x87a26cbf3b75037c!2sKamal%20Pokhari!5e0!3m2!1sen!2snp!4v1746993703659!5m2!1sen!2snp"
            width="400"
            height="300"
            style="border: 0"
          ></iframe>
        </div>
      </div>
    </main>

    <div><%@ include file="footer.jsp" %></div>

    <c:if test="${success eq 'true'}">
      <div class="modal-overlay" style="display: flex">
        <div class="modal-content">
          <h2>✅ Message Sent!</h2>
          <p>Thank you for contacting us. We’ll get back to you shortly.</p>
          <a
            href="${pageContext.request.contextPath}/contact"
            class="btn-confirm"
            >Close</a
          >
        </div>
      </div>
    </c:if>
    <script>
  window.addEventListener("DOMContentLoaded", () => {
    const modal = document.querySelector(".modal-overlay");
    if (modal) {
      setTimeout(() => {
        modal.style.display = "none";
      }, 5000);
    }
  });
</script>
  </body>
</html>
