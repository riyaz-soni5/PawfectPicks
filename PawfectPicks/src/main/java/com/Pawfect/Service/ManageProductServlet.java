package com.Pawfect.Service;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.Pawfect.Model.Product;
import com.Pawfect.Utility.DBConnection;

/**
 * Servlet implementation class manageproductController
 */
@WebServlet("/manageproduct")
public class ManageProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageProductServlet() {
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
        List<Product> productList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT p.product_id, p.product_name, p.price, p.rating, p.description, p.stock_status, p.product_image, c.category_name " +
                         "FROM products p " +
                         "JOIN categories c ON p.category_id = c.category_id";

            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice((int) rs.getDouble("price"));
                p.setRating((int) rs.getDouble("rating"));
                p.setDescription(rs.getString("description"));
                p.setStockStatus(rs.getString("stock_status"));


                byte[] imageBytes = rs.getBytes("product_image");
                if (imageBytes != null) {
                    String base64 = Base64.getEncoder().encodeToString(imageBytes);
                    p.setBase64Image(base64);
                } else {
                    p.setBase64Image(""); // fallback if image is null
                }

                p.setCategoryName(rs.getString("category_name"));

                productList.add(p);
            }

            request.setAttribute("productList", productList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/pages/Admin/manageProducts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String idParam = request.getParameter("productId");

            if (idParam == null || idParam.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("invalid");
                return;
            }

            int productId = Integer.parseInt(idParam);

            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM products WHERE product_id = ?");
                stmt.setInt(1, productId);
                int affected = stmt.executeUpdate();

                response.setContentType("text/plain");
                if (affected > 0) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("fail");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("error");
            }
        } else {
           
            doGet(request, response);
        }
    }

}
