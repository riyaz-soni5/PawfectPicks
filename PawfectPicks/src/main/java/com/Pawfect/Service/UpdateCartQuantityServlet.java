package com.Pawfect.Service;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.Pawfect.Utility.DBConnection;

/**
 * Servlet implementation class UpdateCartQuantityServlet
 */
@WebServlet("/update-cart-quantity")
public class UpdateCartQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartQuantityServlet() {
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
        String cartIdStr = request.getParameter("cartId");
        String quantityStr = request.getParameter("quantity");

        try {
            int cartId = Integer.parseInt(cartIdStr);
            int quantity = Integer.parseInt(quantityStr);

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, quantity);
                ps.setInt(2, cartId);
                ps.executeUpdate();
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

}
