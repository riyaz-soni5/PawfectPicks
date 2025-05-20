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

import com.Pawfect.Model.CartItem;
import com.Pawfect.Utility.DBConnection;

import java.sql.Statement;

import java.util.List;
import java.util.ArrayList;

import com.Pawfect.Model.CartItem;


/**
 * Servlet implementation class OrderControllerServlet
 */
@WebServlet("/OrderControllerServlet")
public class OrderControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        try (Connection conn = DBConnection.getConnection()) {
        	conn.setAutoCommit(false);
        	
        	 String shippingAddress = null;
        	 PreparedStatement addrStmt = conn.prepareStatement("SELECT address FROM users WHERE user_id = ?");
             addrStmt.setInt(1, userId);
             ResultSet addrRs = addrStmt.executeQuery();
             if (addrRs.next()) {
                 shippingAddress = addrRs.getString("address");
             }

             if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                 response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Delivery address missing");
                 return;
             }
             
             double subtotal = Double.parseDouble(request.getParameter("subtotal"));
             double shippingFee = 105;
             double total = subtotal + shippingFee;
             
             
             String orderSql = "INSERT INTO orders (user_id, order_status, payment_status, shipping_address, subtotal, shipping_fee, total_amount, order_date) VALUES (?, 'Pending', 'Unpaid', ?, ?, ?, ?, NOW())";
             PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
             orderStmt.setInt(1, userId);
             orderStmt.setString(2, shippingAddress);
             orderStmt.setDouble(3, subtotal);
             orderStmt.setDouble(4, shippingFee);
             orderStmt.setDouble(5, total);
             orderStmt.executeUpdate();
             
             ResultSet generatedKeys = orderStmt.getGeneratedKeys();
             int orderId = 0;
             if (generatedKeys.next()) {
                 orderId = generatedKeys.getInt(1);
             }

             // 2. Insert order items
             String itemSql = "INSERT INTO order_items (order_id, product_id, category, product_name, quantity, price) VALUES (?, ?, ?, ?, ?, ?)";
             PreparedStatement itemStmt = conn.prepareStatement(itemSql);

             List<CartItem> cartItems = new ArrayList<>();
             String cartSql = "SELECT c.cart_id, c.product_id, c.quantity, p.product_name, p.price " +
                     "FROM cart c JOIN products p ON c.product_id = p.product_id " +
                     "WHERE c.user_id = ? AND c.is_selected = 1";
             PreparedStatement cartStmt = conn.prepareStatement(cartSql);
             cartStmt.setInt(1, userId);
             ResultSet cartRs = cartStmt.executeQuery();
             while (cartRs.next()) {
                 CartItem item = new CartItem();
                 item.setCartId(cartRs.getInt("cart_id"));
                 item.setProductId(cartRs.getInt("product_id"));
                 item.setQuantity(cartRs.getInt("quantity"));
                 item.setProductName(cartRs.getString("product_name"));
                 item.setPrice(cartRs.getDouble("price"));
                 item.setSelected(true);
                 cartItems.add(item);
             }

             for (CartItem item : cartItems) {
            	    if (item.isSelected()) {
            	        // get category_id from product table
            	    	String category = "";
            	    	String catQuery = "SELECT c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.category_id WHERE p.product_id = ?";

            	        PreparedStatement catStmt = conn.prepareStatement(catQuery);
            	        catStmt.setInt(1, item.getProductId());
            	        ResultSet catRs = catStmt.executeQuery();
            	        if (catRs.next()) {
            	            category = catRs.getString("category_name");
            	        }

            	        itemStmt.setInt(1, orderId);
            	        itemStmt.setInt(2, item.getProductId());
            	        itemStmt.setString(3, category); 
            	        itemStmt.setString(4, item.getProductName());
            	        itemStmt.setInt(5, item.getQuantity());
            	        itemStmt.setDouble(6, item.getPrice());
            	        itemStmt.addBatch();
            	    }
            	}
          
             itemStmt.executeBatch();

             // 3. Remove purchased items from cart
             String deleteSql = "DELETE FROM cart WHERE user_id = ? AND is_selected = 1";
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
             deleteStmt.setInt(1, userId);
             deleteStmt.executeUpdate();

             conn.commit();
             session.setAttribute("orderSuccess", true);
             response.sendRedirect(request.getContextPath() + "/cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        	
        }
}

