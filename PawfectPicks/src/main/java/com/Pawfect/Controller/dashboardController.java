package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;
import com.Pawfect.Model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;



/**
 * Servlet implementation class dashboardController
 */
@WebServlet("/dashboard")
public class dashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public dashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
    	
        try (Connection conn = DBConnection.getConnection()) {
        	
        	// Fetch admin details for header display
        	HttpSession session = request.getSession();
        	int userId = (int) session.getAttribute("userId");

        	String adminSql = "SELECT first_name FROM users WHERE user_id = ?";
        	PreparedStatement adminStmt = conn.prepareStatement(adminSql);
        	adminStmt.setInt(1, userId);
        	ResultSet adminRs = adminStmt.executeQuery();

        	if (adminRs.next()) {
        	    String firstName = adminRs.getString("first_name");
        	    session.setAttribute("firstName", firstName);
        	}

            // Total users (excluding admin)
            String userQuery = "SELECT COUNT(*) FROM users WHERE role != 'admin'";
            PreparedStatement userStmt = conn.prepareStatement(userQuery);
            ResultSet userRs = userStmt.executeQuery();
            int totalUsers = userRs.next() ? userRs.getInt(1) : 0;

            // Completed orders
            String completedQuery = "SELECT COUNT(*) FROM orders WHERE order_status = 'Completed'";
            PreparedStatement completedStmt = conn.prepareStatement(completedQuery);
            ResultSet completedRs = completedStmt.executeQuery();
            int completedOrders = completedRs.next() ? completedRs.getInt(1) : 0;

            // Processing orders
            String processingQuery = "SELECT COUNT(*) FROM orders WHERE order_status = 'Processing'";
            PreparedStatement processingStmt = conn.prepareStatement(processingQuery);
            ResultSet processingRs = processingStmt.executeQuery();
            int processingOrders = processingRs.next() ? processingRs.getInt(1) : 0;

            // Total orders
            String totalOrdersQuery = "SELECT COUNT(*) FROM orders";
            PreparedStatement totalStmt = conn.prepareStatement(totalOrdersQuery);
            ResultSet totalRs = totalStmt.executeQuery();
            int totalOrders = totalRs.next() ? totalRs.getInt(1) : 0;

            // Set stat attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("processingOrders", processingOrders);
            request.setAttribute("totalOrders", totalOrders);
            



            // Top Products (by sales + rating)
            String sql = "SELECT p.product_id, p.product_name, p.product_image, p.price, p.total_sales, " +
                    "p.rating, c.category_name " +
                    "FROM products p " +
                    "JOIN categories c ON p.category_id = c.category_id " +
                    "ORDER BY p.total_sales DESC, p.rating DESC " +
                    "LIMIT 10";

            // Recent Orders (latest first, showing status only)
            String recentOrdersSql = "SELECT o.order_id, oi.product_name, oi.price, p.product_image, o.order_status " +
                                     "FROM orders o " +
                                     "JOIN order_items oi ON o.order_id = oi.order_id " +
                                     "JOIN products p ON oi.product_id = p.product_id " +
                                     "ORDER BY o.order_date DESC " +
                                     "LIMIT 6";

            PreparedStatement orderStmt = conn.prepareStatement(recentOrdersSql);
            ResultSet orderRs = orderStmt.executeQuery();

            List<Map<String, Object>> recentOrders = new ArrayList<>();

            while (orderRs.next()) {
                Map<String, Object> order = new LinkedHashMap<>();
                order.put("orderId", orderRs.getInt("order_id"));
                order.put("productName", orderRs.getString("product_name"));
                order.put("price", orderRs.getInt("price"));
                order.put("orderStatus", orderRs.getString("order_status"));

                byte[] imgBytes = orderRs.getBytes("product_image");
                String base64Img = imgBytes != null ? Base64.getEncoder().encodeToString(imgBytes) : "";
                order.put("productImage", base64Img);

                recentOrders.add(order);
            }

            request.setAttribute("recentOrders", recentOrders);

            

            List<Product> topProducts = new ArrayList<>();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));

                // Convert product image to Base64
                byte[] imageBytes = rs.getBytes("product_image");
                if (imageBytes != null && imageBytes.length > 0) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    product.setBase64Image(base64Image);
                } else {
                    product.setBase64Image(""); // Or provide a default fallback
                }

                product.setPrice(rs.getInt("price"));
                product.setTotalSales(rs.getInt("total_sales"));
                product.setRating(rs.getInt("rating"));
                product.setCategoryName(rs.getString("category_name"));

                topProducts.add(product);
            }

            request.setAttribute("topProducts", topProducts);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/pages/Admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            if (!response.isCommitted()) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

