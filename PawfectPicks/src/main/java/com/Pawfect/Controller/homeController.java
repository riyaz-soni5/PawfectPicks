package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 * Servlet implementation class homeController
 */
@WebServlet("/home")
public class homeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public homeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Map<String, Object>> topProducts = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT product_id, product_name, product_image, price, rating FROM Products ORDER BY rating DESC LIMIT 12";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("id", rs.getInt("product_id"));
                product.put("name", rs.getString("product_name"));
                product.put("image", rs.getBytes("product_image"));
                product.put("price", rs.getInt("price"));
                product.put("rating", rs.getDouble("rating"));
                topProducts.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("topProducts", topProducts);
        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
