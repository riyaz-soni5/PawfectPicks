package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/profile-image")
public class ProfileImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdParam = request.getParameter("userId");
        if (userIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user ID");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT profile_image FROM Users WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] imageData = rs.getBytes("profile_image");

                if (imageData != null && imageData.length > 0) {
                    response.setContentType("image/jpeg");
                    response.setContentLength(imageData.length);

                    OutputStream out = response.getOutputStream();
                    out.write(imageData);
                    out.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile image not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading image");
        }
    }
}
