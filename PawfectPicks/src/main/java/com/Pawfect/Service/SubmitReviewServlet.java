package com.Pawfect.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Pawfect.Model.Product;
import com.Pawfect.Utility.DBConnection;

/**
 * Servlet implementation class SubmitReviewServlet
 */
@WebServlet("/submit-review")
public class SubmitReviewServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            int userId = (int) session.getAttribute("userId");
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");

            String sql = "INSERT INTO Reviews (user_id, product_id, rating, review_text, created_at) VALUES (?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, rating);
            stmt.setString(4, reviewText);
            stmt.executeUpdate();

            response.sendRedirect("product-details?productId=" + productId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-details?productId=" + request.getParameter("productId"));
        }
    }
}