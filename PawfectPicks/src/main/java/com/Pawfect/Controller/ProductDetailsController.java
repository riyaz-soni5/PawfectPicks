package com.Pawfect.Controller;

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
import java.sql.SQLException;

import com.Pawfect.Utility.DBConnection;

import com.Pawfect.Model.Product;

import com.Pawfect.Model.Review;

import java.util.List;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;






/**
 * Servlet implementation class ProductDetailsServlet
 */
@WebServlet("/product-details")
public class ProductDetailsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDetailsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null) {
            response.sendRedirect("shop");
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT p.*, c.category_name FROM Products p JOIN Categories c ON p.category_id = c.category_id WHERE p.product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setPrice(rs.getInt("price"));
                product.setDescription(rs.getString("description"));
                product.setRating(rs.getInt("rating"));
                product.setStockStatus(rs.getString("stock_status"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));
                request.setAttribute("product", product);
            }

            // Load Reviews
            String reviewSql = "SELECT r.*, u.first_name, u.last_name, u.profile_image " +
                    "FROM Reviews r JOIN Users u ON r.user_id = u.user_id " +
                    "WHERE r.product_id = ? ORDER BY r.created_at DESC";

            PreparedStatement reviewStmt = conn.prepareStatement(reviewSql);
            reviewStmt.setInt(1, productId);
            ResultSet reviewRs = reviewStmt.executeQuery();

            List<Map<String, Object>> reviews = new ArrayList<>();
            while (reviewRs.next()) {
                Map<String, Object> review = new HashMap<>();
                review.put("userId", reviewRs.getInt("user_id"));
                review.put("firstName", reviewRs.getString("first_name"));
                review.put("lastName", reviewRs.getString("last_name"));
                review.put("rating", reviewRs.getInt("rating"));
                review.put("reviewText", reviewRs.getString("review_text"));
                review.put("createdAt", reviewRs.getTimestamp("created_at"));
                review.put("profileImage", reviewRs.getBytes("profile_image"));
                reviews.add(review);
            }
            request.setAttribute("reviews", reviews);

            // Check eligibility for review
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (int) session.getAttribute("userId");
                String eligibilitySql = "SELECT COUNT(*) FROM orders o JOIN order_items oi ON o.order_id = oi.order_id WHERE o.user_id = ? AND oi.product_id = ? AND o.order_status = 'Completed'";
                PreparedStatement eligibilityStmt = conn.prepareStatement(eligibilitySql);
                eligibilityStmt.setInt(1, userId);
                eligibilityStmt.setInt(2, productId);
                ResultSet eligibilityRs = eligibilityStmt.executeQuery();

                if (eligibilityRs.next() && eligibilityRs.getInt(1) > 0) {
                    request.setAttribute("canReview", true);
                }
            }

            request.getRequestDispatcher("/WEB-INF/pages/productDetails.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop");
        }
    }
}


