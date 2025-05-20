<!-- adminHeader.jsp -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="admin-header">
    <div class="logo-container">
        <img src="${pageContext.request.contextPath}/assets/img/Pawfect-Picks.png" alt="Pawfect Picks Logo" class="logo">
    </div>
    <div class="header-right" style="display: flex; align-items: center; gap: 18px;">
        <span class="admin-name" style="font-weight: bold;">
            <c:out value="${sessionScope.firstName}" />
        </span>
        <img 
            src="${pageContext.request.contextPath}/profile-image?userId=${sessionScope.userId}" 
            onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/icons/profile-user-icon.png';" 
            alt="User Icon" 
            class="user-icon"
            style="border-radius: 50%; width: 32px; height: 32px;"
        />
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Log out</a>
    </div>
</div>
