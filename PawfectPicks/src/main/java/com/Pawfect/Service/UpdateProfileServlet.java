package com.Pawfect.Service;

import com.Pawfect.Utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/updateProfile")
@MultipartConfig(maxFileSize = 16177215) // Limit ~16MB
public class UpdateProfileServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve userId from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Fetch form fields
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String birthday = request.getParameter("birthday");
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");

        // Image
        Part imagePart = request.getPart("profileImage");
        InputStream imageInputStream = (imagePart != null && imagePart.getSize() > 0) ? imagePart.getInputStream() : null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql;
            PreparedStatement stmt;

            if (imageInputStream != null) {
                sql = "UPDATE Users SET first_name = ?, last_name = ?, email = ?, birthday = ?, gender = ?, mobile = ?, address = ?, profile_image = ? WHERE user_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, email);
                stmt.setString(4, birthday);
                stmt.setString(5, gender);
                stmt.setString(6, mobile);
                stmt.setString(7, address);
                stmt.setBlob(8, imageInputStream);
                stmt.setInt(9, userId);
            } else {
                sql = "UPDATE Users SET first_name = ?, last_name = ?, email = ?, birthday = ?, gender = ?, mobile = ?, address = ? WHERE user_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, email);
                stmt.setString(4, birthday);
                stmt.setString(5, gender);
                stmt.setString(6, mobile);
                stmt.setString(7, address);
                stmt.setInt(8, userId);
            }

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
            	session.setAttribute("successMessage", "Profile updated successfully!");

            } else {
            	session.setAttribute("errorMessage", "Something went wrong. Please try again.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while updating the profile.");

        }


        response.sendRedirect("profile");
        
    }
}
