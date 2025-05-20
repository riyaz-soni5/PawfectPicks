package com.Pawfect.Service;

import jakarta.servlet.ServletException;


import jakarta.servlet.http.HttpSession;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.Pawfect.Utility.DBConnection;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/add-to-cart")
public class AddToCartService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartService() {
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
	    HttpSession session = request.getSession(false); // don't create new if not existing

	    if (session == null || session.getAttribute("userId") == null) {
	        response.sendRedirect(request.getContextPath() + "/login"); // redirect to login
	        return;
	    }

	    int userId = (Integer) session.getAttribute("userId");
	    int productId = Integer.parseInt(request.getParameter("productId"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));

	    try (Connection conn = DBConnection.getConnection()) {
	        String sql = "INSERT INTO cart (user_id, product_id, quantity, is_selected) " +
	                     "VALUES (?, ?, ?, 1) " +
	                     "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, userId);
	        ps.setInt(2, productId);
	        ps.setInt(3, quantity);
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    response.sendRedirect(request.getContextPath() + "/cart");
	}

}