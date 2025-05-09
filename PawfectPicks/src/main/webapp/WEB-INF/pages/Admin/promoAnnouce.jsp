<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminHeader.jsp" %>
<%@ include file="adminSideNav.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Promotions and Announcements - Pawfect Picks</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminHeader.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adminSideNav.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/promoAnnouce.css">
</head>
<body>
	<div class="adminHeader">
        <%@ include file="adminHeader.jsp" %>
    </div>
    
    <div class="adminSideNav">
        <%@ include file="adminSideNav.jsp" %>
    </div>
    
  <main class="main-content">
    <h2>Promotion and Announcements</h2>
    
    <div class="form-grid">
      <div class="promo-form box">
        <h3>Add Promotion Offers</h3>
        <form>
          <label>Promotion Offer Title</label>
          <input type="text" />

          <label>Discount %</label>
          <input type="number" />

          <label>Duration</label>
          <input type="text" />

          <button type="submit" class="btn pink">Add Promotion</button>
        </form>
      </div>

      <div class="announcement-form box">
        <h3>Add Announcement</h3>
        <form>
          <label>Announcement Description</label>
          <textarea rows="6"></textarea>
          <button type="submit" class="btn pink">Add Announcement</button>
        </form>
      </div>
    </div>

    <div class="promo-table">
      <h4>Promotion Offer Active/Inactive Status</h4>
      <div class="table-header">
        <div>Title</div>
        <div>Discount</div>
        <div>Status</div>
        <div>Actions</div>
      </div>

      <!-- Row 1 -->
      <div class="table-row">
        <div>New Year Sale | Use Code: NEWPEW</div>
        <div>25%</div>
        <div class="status active">Active</div>
        <div class="actions">
          <button class="btn view">&#128065;</button>
          <button class="btn toggle">&#8635;</button>
          <button class="btn delete">&#10006;</button>
        </div>
      </div>

      <!-- Additional rows... -->
      <div class="table-row">
        <div>Summer Sale | Use Code: PETSUMMER</div>
        <div>30%</div>
        <div class="status active">Active</div>
        <div class="actions">
          <button class="btn view">&#128065;</button>
          <button class="btn toggle">&#8635;</button>
          <button class="btn delete">&#10006;</button>
        </div>
      </div>

      <div class="table-row">
        <div>Winter Sale | Use Code: PETWINTER</div>
        <div>25%</div>
        <div class="status inactive">Inactive</div>
        <div class="actions">
          <button class="btn view">&#128065;</button>
          <button class="btn toggle">&#8635;</button>
          <button class="btn delete">&#10006;</button>
        </div>
      </div>

      <div class="table-row">
        <div>CHRISTMAS SALE | Use Code: XMASPET</div>
        <div>15%</div>
        <div class="status inactive">Inactive</div>
        <div class="actions">
          <button class="btn view">&#128065;</button>
          <button class="btn toggle">&#8635;</button>
          <button class="btn delete">&#10006;</button>
        </div>
      </div>
    </div>
  </main>
</body>
</html>
