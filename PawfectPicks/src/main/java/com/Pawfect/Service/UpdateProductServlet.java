package com.Pawfect.Service;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import jakarta.servlet.annotation.MultipartConfig;


import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

import com.Pawfect.Utility.DBConnection;

import com.Pawfect.Model.*;

import java.util.Base64;



/**
 * Servlet implementation class UpdateProductServlet
 */

@MultipartConfig
@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProductServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("productName");
        String categoryName = request.getParameter("productCategory");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("productDescriptions");

        Part filePart = request.getPart("productImage");
        InputStream imageStream = (filePart != null && filePart.getSize() > 0) ? filePart.getInputStream() : null;

        try (Connection conn = DBConnection.getConnection()) {
            // Fetch category ID from category name
            PreparedStatement catStmt = conn.prepareStatement("SELECT category_id FROM categories WHERE category_name = ?");
            catStmt.setString(1, categoryName);
            ResultSet rs = catStmt.executeQuery();
            int categoryId = rs.next() ? rs.getInt("category_id") : 0;

            String sql;
            PreparedStatement stmt;
            if (imageStream != null) {
                sql = "UPDATE products SET product_name = ?, category_id = ?, price = ?, description = ?, product_image = ? WHERE product_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setInt(2, categoryId);
                stmt.setDouble(3, price);
                stmt.setString(4, description);
                stmt.setBlob(5, imageStream);
                stmt.setInt(6, id);
            } else {
                sql = "UPDATE products SET product_name = ?, category_id = ?, price = ?, description = ? WHERE product_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setInt(2, categoryId);
                stmt.setDouble(3, price);
                stmt.setString(4, description);
                stmt.setInt(5, id);
            }

            int result = stmt.executeUpdate();
            if (result > 0) {
                request.setAttribute("message", "Product edited successfully!");
            } else {
                request.setAttribute("message", "Failed to update product.");
            }

            // ✅ Fetch updated product list and pass to JSP
            List<Product> productList = new ArrayList<>();
            PreparedStatement ps = conn.prepareStatement("SELECT p.product_id, p.product_name, p.price, p.rating, p.product_image, p.description, c.category_name FROM products p JOIN categories c ON p.category_id = c.category_id");
            ResultSet rs2 = ps.executeQuery();
            while (rs2.next()) {
                Product p = new Product();
                p.setId(rs2.getInt("product_id"));
                p.setName(rs2.getString("product_name"));
                p.setPrice((int) rs2.getDouble("price"));
                p.setRating((int) rs2.getDouble("rating"));
                p.setDescription(rs2.getString("description"));
                p.setCategoryName(rs2.getString("category_name"));

                byte[] imageBytes = rs2.getBytes("product_image");
                if (imageBytes != null) {
                    String base64 = Base64.getEncoder().encodeToString(imageBytes);
                    p.setBase64Image(base64);
                } else {
                    p.setBase64Image("");
                }

                productList.add(p);
            }
            request.setAttribute("productList", productList);


        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/Admin/manageProducts.jsp").forward(request, response);
   }
}

