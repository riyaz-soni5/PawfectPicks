package com.Pawfect.Service;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.Pawfect.Model.Product;
import com.Pawfect.Utility.DBConnection;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProductService() {
        super();
    }
    
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String name = request.getParameter("productName");
        String categoryName = request.getParameter("productCategory");
        String priceStr = request.getParameter("price");
        String description = request.getParameter("productDescriptions");
        
        // Convert price string to double 

        double price = Double.parseDouble(priceStr);
        
        
        // Handle uploaded image

        InputStream imageStream = null;
        Part filePart = request.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            imageStream = filePart.getInputStream();
        }

        try (Connection conn = DBConnection.getConnection()) {
        	
            // Gets category_id from category_name
            int categoryId = -1;
            String categoryQuery = "SELECT category_id FROM categories WHERE category_name = ?";
            try (PreparedStatement catStmt = conn.prepareStatement(categoryQuery)) {
                catStmt.setString(1, categoryName);
                ResultSet rs = catStmt.executeQuery();
                if (rs.next()) {
                    categoryId = rs.getInt("category_id");
                } else {
                    request.setAttribute("message", "Invalid category name provided.");
                    request.getRequestDispatcher("/WEB-INF/pages/Admin/manageProducts.jsp").forward(request, response);
                    return;
                }
            }

            // Insert product to the product table 
            String sql = "INSERT INTO Products (product_name, product_image, category_id, price, description, stock_status, rating, total_sales, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, 'In Stock', 0, 0, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setBlob(2, imageStream);
            stmt.setInt(3, categoryId);
            stmt.setDouble(4, price);
            stmt.setString(5, description);
            
            // runs insert query

            int result = stmt.executeUpdate();
            if (result > 0) {
                request.setAttribute("message", "Product added successfully!");
                List<Product> productList = new ArrayList<>();
                String fetchSql = "SELECT p.product_id, p.product_name, p.price, p.rating, p.product_image, p.description, c.category_name " +
                                  "FROM products p JOIN categories c ON p.category_id = c.category_id";
                PreparedStatement fetchStmt = conn.prepareStatement(fetchSql);
                ResultSet resultSet = fetchStmt.executeQuery();
                while (resultSet.next()) {
                    Product p = new Product();
                    p.setId(resultSet.getInt("product_id"));
                    p.setName(resultSet.getString("product_name"));
                    p.setPrice((int) resultSet.getDouble("price"));
                    p.setRating((int) resultSet.getDouble("rating"));
                    p.setDescription(resultSet.getString("description"));
                    p.setCategoryName(resultSet.getString("category_name"));

                    byte[] imageBytes = resultSet.getBytes("product_image");
                    if (imageBytes != null) {
                        String base64 = Base64.getEncoder().encodeToString(imageBytes);
                        p.setBase64Image(base64);
                    } else {
                        p.setBase64Image("");
                    }

                    productList.add(p);
                }
                request.setAttribute("productList", productList);
            } else {
                request.setAttribute("message", "Failed to add product.");
            }

            request.getRequestDispatcher("/WEB-INF/pages/Admin/manageProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Admin/manageProducts.jsp").forward(request, response);
        }
    }
}

