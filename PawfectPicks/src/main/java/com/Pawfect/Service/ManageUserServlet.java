package com.Pawfect.Service;

import com.Pawfect.Model.User;
import com.Pawfect.Utility.DBConnection;

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
import java.util.List;
/**
 * Servlet implementation class promoAnnouceController
 */
@WebServlet("/manageusers")
public class ManageUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = new ArrayList<>();
        String roleFilter = request.getParameter("role");
        boolean applyRoleFilter = roleFilter != null && !roleFilter.equalsIgnoreCase("All");

        try (Connection conn = DBConnection.getConnection()) {
            StringBuilder sql = new StringBuilder("SELECT user_id, email, role, created_at FROM users");
            
            if (applyRoleFilter) {
                sql.append(" WHERE role = ?");
            }

            sql.append(" ORDER BY created_at DESC");

            PreparedStatement stmt = conn.prepareStatement(sql.toString());
            if (applyRoleFilter) {
                stmt.setString(1, roleFilter);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }

            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/pages/Admin/ManageUsers.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        String userIdStr = request.getParameter("userId");
        String newRole = request.getParameter("newRole");

        // Role update logic
        if (userIdStr != null && newRole != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE users SET role = ? WHERE user_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, newRole);
                stmt.setInt(2, Integer.parseInt(userIdStr));

                int rows = stmt.executeUpdate();
                response.getWriter().write(rows > 0 ? "success" : "fail");

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("error");
            }
            return;
        }
        
        String deleteUserIdStr = request.getParameter("deleteUserId");
        if (deleteUserIdStr != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String deleteSql = "DELETE FROM users WHERE user_id = ?";
                PreparedStatement stmt = conn.prepareStatement(deleteSql);
                stmt.setInt(1, Integer.parseInt(deleteUserIdStr));
                int rows = stmt.executeUpdate();
                response.getWriter().write(rows > 0 ? "success" : "fail");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("error");
            }
            return;
        }

        // Fallback to GET if no role update params found
        doGet(request, response);
    }

}
