
package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Pawfect.Model.Product;


/**
 * Servlet implementation class reportController
 */
@WebServlet("/report")
public class reportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public reportController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {

            // Total users excluding admin
            String userCountQuery = "SELECT COUNT(*) FROM users WHERE role != 'admin'";
            PreparedStatement userStmt = conn.prepareStatement(userCountQuery);
            ResultSet userRs = userStmt.executeQuery();
            int totalUsers = userRs.next() ? userRs.getInt(1) : 0;

            // Total completed orders
            String completedQuery = "SELECT COUNT(*) FROM orders WHERE order_status = 'Completed'";
            PreparedStatement completedStmt = conn.prepareStatement(completedQuery);
            ResultSet completedRs = completedStmt.executeQuery();
            int completedOrders = completedRs.next() ? completedRs.getInt(1) : 0;

            // Total processing orders
            String processingQuery = "SELECT COUNT(*) FROM orders WHERE order_status = 'Processing'";
            PreparedStatement processingStmt = conn.prepareStatement(processingQuery);
            ResultSet processingRs = processingStmt.executeQuery();
            int processingOrders = processingRs.next() ? processingRs.getInt(1) : 0;

            // Total orders
            String totalOrdersQuery = "SELECT COUNT(*) FROM orders";
            PreparedStatement totalStmt = conn.prepareStatement(totalOrdersQuery);
            ResultSet totalRs = totalStmt.executeQuery();
            int totalOrders = totalRs.next() ? totalRs.getInt(1) : 0;

           
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("completedOrders", completedOrders);
            request.setAttribute("processingOrders", processingOrders);
            request.setAttribute("totalOrders", totalOrders);
            
            List<Product> topProducts = new ArrayList<>();

            String categoryId = request.getParameter("categoryId");

            StringBuilder sql = new StringBuilder(
                "SELECT p.product_id, p.product_name, p.product_image, p.price, p.total_sales, " +
                "p.rating, c.category_name " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.category_id "
            );

            if (categoryId != null && !categoryId.equalsIgnoreCase("All")) {
                sql.append("WHERE p.category_id = ? ");
            }

            sql.append("ORDER BY p.total_sales DESC, p.rating DESC LIMIT 10");

            PreparedStatement stmt = conn.prepareStatement(sql.toString());

            if (categoryId != null && !categoryId.equalsIgnoreCase("All")) {
                stmt.setInt(1, Integer.parseInt(categoryId));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                
                byte[] imageData = rs.getBytes("product_image");
                String base64 = Base64.getEncoder().encodeToString(imageData);
                p.setBase64Image(base64);

                
                p.setPrice(rs.getInt("price"));
                p.setTotalSales(rs.getInt("total_sales"));
                p.setRating(rs.getInt("rating")); 
                p.setCategoryName(rs.getString("category_name"));
                topProducts.add(p);
            }
            
            List<Map<String, String>> contactMessages = new ArrayList<>();
            String msgSql = "SELECT user_id, email, message FROM Contact_Messages ORDER BY submitted_at DESC";

            PreparedStatement msgStmt = conn.prepareStatement(msgSql);
            ResultSet msgRs = msgStmt.executeQuery();

            while (msgRs.next()) {
                Map<String, String> msg = new HashMap<>();
                msg.put("userId", msgRs.getString("user_id"));
                msg.put("email", msgRs.getString("email"));
                msg.put("message", msgRs.getString("message"));
                contactMessages.add(msg);
            }
            request.setAttribute("contactMessages", contactMessages);



            request.setAttribute("topProducts", topProducts);

            // Finally forward
            request.getRequestDispatcher("/WEB-INF/pages/Admin/report.jsp").forward(request, response);

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
