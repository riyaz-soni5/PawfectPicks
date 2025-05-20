package com.Pawfect.Controller;

import jakarta.servlet.ServletException;



import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Pawfect.Model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import java.sql.SQLException;

import com.Pawfect.Utility.DBConnection;


/**
 * Servlet implementation class shopController
 */
@WebServlet("/shop")
public class shopController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public shopController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");

        try (Connection conn = DBConnection.getConnection()) {
            String sql;
            PreparedStatement stmt;

            if (category != null) {
                sql = "SELECT * FROM Products WHERE category_id = ? ORDER BY rating DESC, total_sales DESC";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, category);
            } else {
                sql = "SELECT * FROM Products ORDER BY rating DESC, total_sales DESC LIMIT 20";
                stmt = conn.prepareStatement(sql);
            }

            ResultSet rs = stmt.executeQuery();
            List<Product> products = new ArrayList<>();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getInt("price"));
                p.setRating(rs.getInt("rating"));
                products.add(p);
            }

            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/pages/shop.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/pages/shop.jsp").forward(request, response);
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
