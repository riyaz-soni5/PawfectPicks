package com.Pawfect.Service;

import jakarta.servlet.ServletException;

import com.Pawfect.Utility.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class SubmitContactMessageServlet
 */
@WebServlet("/SubmitContactMessage")
public class SubmitContactMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitContactMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(true); // ensures session exists
		Integer userId = (session.getAttribute("userId") != null) ? (Integer) session.getAttribute("userId") : null;


        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        String fullName = firstName + " " + lastName;

        try (Connection conn = DBConnection.getConnection()) {
        	String sql = "INSERT INTO Contact_Messages (user_id, name, email, message, submitted_at) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            if (userId != null) {
                ps.setInt(1, userId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            ps.setString(2, fullName);
            ps.setString(3, email);
            ps.setString(4, message);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("success", true);
        try {
            request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        }


    }

}
