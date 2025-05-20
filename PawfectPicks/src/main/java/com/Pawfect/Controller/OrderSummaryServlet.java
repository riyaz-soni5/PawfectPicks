package com.Pawfect.Controller;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Pawfect.Model.CartItem;
import com.Pawfect.Utility.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 * Servlet implementation class OrderSummaryServlet
 */
@WebServlet("/checkout-summary")
public class OrderSummaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderSummaryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        List<CartItem> orderItems = new ArrayList<>();
        String deliveryAddress = null;
        double subtotal = 0;

        try (Connection conn = DBConnection.getConnection()) {
            // Get address
            PreparedStatement addrStmt = conn.prepareStatement("SELECT address FROM users WHERE user_id = ?");
            addrStmt.setInt(1, userId);
            ResultSet addrRs = addrStmt.executeQuery();
            if (addrRs.next()) {
                deliveryAddress = addrRs.getString("address");
            }

            // Get selected cart items
            String sql = "SELECT c.cart_id, c.quantity, p.product_name, p.price FROM cart c JOIN products p ON c.product_id = p.product_id WHERE c.user_id = ? AND c.is_selected = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartId(rs.getInt("cart_id"));
                item.setProductName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                orderItems.add(item);
                subtotal += item.getPrice() * item.getQuantity();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        double shippingFee = subtotal > 0 ? 105 : 0;
        double total = subtotal + shippingFee;

        request.setAttribute("orderItems", orderItems);
        request.setAttribute("deliveryAddress", deliveryAddress);
        request.setAttribute("subtotal", String.format("%.2f", subtotal));
        request.setAttribute("shippingFee", String.format("%.2f", shippingFee));
        request.setAttribute("total", String.format("%.2f", total));

        request.getRequestDispatcher("/WEB-INF/pages/orderconfirmation.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
