package com.Pawfect.Controller;

import com.Pawfect.Utility.DBConnection;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * Servlet implementation class profileController
 */
@WebServlet("/profile")
public class profileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public profileController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Users WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                java.util.Map<String, Object> user = new java.util.HashMap<>();
                user.put("firstName", rs.getString("first_name"));
                user.put("lastName", rs.getString("last_name"));
                user.put("email", rs.getString("email"));
                user.put("birthday", rs.getString("birthday"));
                user.put("gender", rs.getString("gender"));
                user.put("mobile", rs.getString("mobile"));
                user.put("address", rs.getString("address"));

                // Set user object to request
                request.setAttribute("user", user);

                // Set profile image in session if available
                byte[] imageBytes = rs.getBytes("profile_image");
                if (imageBytes != null) {
                    session.setAttribute("profileImage", imageBytes);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load profile data.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
