package com.Pawfect.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class registerServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
public class registerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");
	    String email = request.getParameter("email");
	    String password = request.getParameter("password");
	    String confirmPassword = request.getParameter("confirmPassword");

	    if (!password.equals(confirmPassword)) {
	        request.setAttribute("error", "Passwords do not match.");
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    String hashedPassword = com.Pawfect.Utility.PasswordUtil.hashPassword(password);

	    try (java.sql.Connection conn = com.Pawfect.Utility.DBConnection.getConnection()) {
	        String sql = "INSERT INTO Users (first_name, last_name, email, password, role) VALUES (?, ?, ?, ?, 'user')";
	        java.sql.PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, firstName);
	        stmt.setString(2, lastName);
	        stmt.setString(3, email);
	        stmt.setString(4, hashedPassword);

	        int rows = stmt.executeUpdate();

	        if (rows > 0) {
	            request.setAttribute("success", "Account created successfully. Please login.");
	            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
	        } else {
	            request.setAttribute("error", "Failed to create account. Try again.");
	            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
	}
}

