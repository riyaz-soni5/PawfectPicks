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

import com.Pawfect.Utility.DBConnection;

@WebServlet("/UpdateStockStatusServlet")
public class UpdateStockStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateStockStatusServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("productId");
        System.out.println("Received productId: " + idParam);

        if (idParam == null || idParam.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid product ID");
            return;
        }

        int productId = Integer.parseInt(idParam);

        try (Connection conn = DBConnection.getConnection()) {

            String currentStatus = "";
            PreparedStatement checkStmt = conn.prepareStatement("SELECT stock_status FROM products WHERE product_id = ?");
            checkStmt.setInt(1, productId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                currentStatus = rs.getString("stock_status");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Product not found");
                return;
            }

            String updatedStatus = "In Stock".equalsIgnoreCase(currentStatus) ? "Out Of Stock" : "In Stock";


            PreparedStatement stmt = conn.prepareStatement("UPDATE products SET stock_status = ? WHERE product_id = ?");
            stmt.setString(1, updatedStatus);
            stmt.setInt(2, productId);
            stmt.executeUpdate();


            response.setContentType("text/plain");
            response.getWriter().write(updatedStatus);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }
}
