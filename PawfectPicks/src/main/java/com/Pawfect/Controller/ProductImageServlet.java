package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ProductImageServlet
 */
@WebServlet("/ProductImageServlet")
public class ProductImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT product_image FROM Products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] imageData = rs.getBytes("product_image");
                if (imageData != null) {
                    response.setContentType("image/jpeg");
                    response.setContentLength(imageData.length);
                    OutputStream out = response.getOutputStream();
                    out.write(imageData);
                    out.flush();
                    
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
