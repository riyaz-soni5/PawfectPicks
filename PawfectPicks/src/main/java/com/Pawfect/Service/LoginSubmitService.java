package com.Pawfect.Service;

import com.Pawfect.Utility.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.Pawfect.Utility.CookieUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;





/**
 * Servlet implementation class loginController
 */
@WebServlet("/submit-login")
public class LoginSubmitService extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginSubmitService() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    
	    

	    try (Connection conn = DBConnection.getConnection()) {
	        String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, email);
	        String hashedPassword = com.Pawfect.Utility.PasswordUtil.hashPassword(password); // Use the same method as registration
	        stmt.setString(2, hashedPassword);

	        

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	        	
	            String role = rs.getString("role");
	            int userId = rs.getInt("user_id");
	            
	            
	            

	            HttpSession session = request.getSession();
	            session.setAttribute("userId", userId);
	            session.setAttribute("email", email);
	            session.setAttribute("role", role);
	            
	            
	            byte[] profileImage = rs.getBytes("profile_image");
	            session.setAttribute("profileImage", profileImage);

	            

	            
	            String remember = request.getParameter("rememberMe");
	            if ("on".equals(remember)) {
	                CookieUtil.addCookie(response, "savedEmail", email, 7 * 24 * 60 * 60);
	            } else {
	                CookieUtil.deleteCookie(response, "savedEmail");
	            }


	            if ("admin".equalsIgnoreCase(role)) {
	                response.sendRedirect("dashboard");
	            } else {
	                response.sendRedirect("home");
	            }
	        } else {

	            request.setAttribute("error", "Invalid email or password");
	            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
	}
}
