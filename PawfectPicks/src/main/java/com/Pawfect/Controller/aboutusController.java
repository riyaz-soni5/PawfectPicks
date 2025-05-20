package com.Pawfect.Controller;

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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Pawfect.Utility.DBConnection;

/**
 * Servlet implementation class aboutusController
 */
@WebServlet("/aboutus")
public class aboutusController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public aboutusController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	// list to store admin team member data
    	
        List<Map<String, String>> adminList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
        	
        	// SQL query to get first name and profile img
        	
            String sql = "SELECT first_name, profile_image FROM users WHERE role = 'admin'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            
            
            // Loop through each admin record

            while (rs.next()) {
                Map<String, String> admin = new HashMap<>();
                admin.put("name", rs.getString("first_name"));
                
                
                // converts image bytes to Bas64 string

                byte[] imgBytes = rs.getBytes("profile_image");
                String base64Img = (imgBytes != null && imgBytes.length > 0)
                        ? Base64.getEncoder().encodeToString(imgBytes)
                        : "";
                admin.put("image", base64Img);
                
                
                // Add admin details to the list
                adminList.add(admin);
            }
            
            // Set the list as request attributes and forward to JSP

            request.setAttribute("admins", adminList);
            request.getRequestDispatcher("/WEB-INF/pages/aboutus.jsp").forward(request, response);
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
