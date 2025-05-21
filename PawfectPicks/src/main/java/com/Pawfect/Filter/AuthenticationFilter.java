package com.Pawfect.Filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = session != null && session.getAttribute("userId") != null;
        boolean isAdmin = isLoggedIn && "admin".equals(session.getAttribute("role"));

        // Allow access to login, logout, assets, CSS/JS
        if (path.contains("/login") ||
            path.contains("/logout") ||
            path.contains("/assets") ||
            path.contains("/css") ||
            path.contains("/js")) {
            chain.doFilter(request, response);
            return;
        }

        // Restrict access to admin-only pages
        if (path.contains("/dashboard") ||
            path.contains("/manageproduct") ||
            path.contains("/manageorder") ||
            path.contains("/promoannouncement") ||
            path.contains("/report")) {

            if (!isAdmin) {
                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}


