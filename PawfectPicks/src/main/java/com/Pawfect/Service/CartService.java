package com.Pawfect.Service;

import com.Pawfect.Model.CartItem; 

import com.Pawfect.Utility.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.Base64;



/**
 * Servlet implementation class cartController
 */
@WebServlet("/cart")
public class CartService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartService() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	
    	 if (session == null || session.getAttribute("userId") == null) {
    	        response.sendRedirect(request.getContextPath() + "/login");
    	        return;
    	    }
    	int userId = (Integer) request.getSession().getAttribute("userId");
    	
    	String deliveryAddress = null;
    	
    	
        List<CartItem> cartItems = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
        	
        	String addressQuery = "SELECT address FROM users WHERE user_id = ?";
            PreparedStatement addressStmt = conn.prepareStatement(addressQuery);
            addressStmt.setInt(1, userId);
            ResultSet addressRs = addressStmt.executeQuery();
            if (addressRs.next()) {
                deliveryAddress = addressRs.getString("address");
            }
            
            String sql = "SELECT c.cart_id, c.product_id, c.quantity, c.is_selected, " +
                    "p.product_name, p.price, p.product_image " +
                    "FROM cart c " +
                    "JOIN products p ON c.product_id = p.product_id " +
                    "WHERE c.user_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getDouble("price"));
                item.setSelected(rs.getBoolean("is_selected"));
                item.setImageUrl("data:image/jpeg;base64," +
                    Base64.getEncoder().encodeToString(rs.getBytes("product_image")));
                cartItems.add(item);    
                
            }
            double subtotal = 0;
            for (CartItem item : cartItems) {
                if (item.isSelected()) {
                    subtotal += item.getPrice() * item.getQuantity();
                }
            }
            double shippingFee = subtotal > 0 ? 105 : 0;
            double total = subtotal + shippingFee;

            request.setAttribute("subtotal", String.format("%.2f", subtotal));
            request.setAttribute("shippingFee", String.format("%.2f", shippingFee));
            request.setAttribute("total", String.format("%.2f", total));

            request.setAttribute("deliveryAddress", deliveryAddress);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
    }

}
