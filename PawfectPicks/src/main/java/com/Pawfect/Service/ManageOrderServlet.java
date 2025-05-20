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
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.Pawfect.Model.OrderItem;
import com.Pawfect.Utility.DBConnection;

@WebServlet("/manageorder")
public class ManageOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ManageOrderServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<OrderItem> orderItems = new ArrayList<>();
        String statusFilter = request.getParameter("status");

        boolean applyFilter = statusFilter != null && !statusFilter.equalsIgnoreCase("All");

        try (Connection conn = DBConnection.getConnection()) {
            StringBuilder sql = new StringBuilder(
                "SELECT oi.order_item_id, oi.order_id, oi.product_name, oi.category, oi.price, oi.quantity, " +
                "o.order_status, o.payment_status, o.shipping_address, o.subtotal, o.shipping_fee, o.total_amount, " +
                "u.first_name, u.last_name, u.email, u.mobile, p.product_image " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "JOIN users u ON o.user_id = u.user_id " +
                "JOIN products p ON oi.product_id = p.product_id "
            );

            if (applyFilter) {
                sql.append("WHERE o.order_status = ? ");
            }

            sql.append("ORDER BY oi.order_id DESC");

            PreparedStatement stmt = conn.prepareStatement(sql.toString());

            if (applyFilter) {
                stmt.setString(1, statusFilter);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderId(rs.getInt("order_id"));
                item.setProductName(rs.getString("product_name"));
                item.setCategory(rs.getString("category"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setOrderStatus(rs.getString("order_status"));
                item.setPaymentStatus(rs.getString("payment_status"));
                item.setDeliveryAddress(rs.getString("shipping_address"));
                item.setSubtotal(rs.getDouble("subtotal"));
                item.setShippingFee(rs.getDouble("shipping_fee"));
                item.setTotalAmount(rs.getDouble("total_amount"));
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setUserName(rs.getString("first_name") + " " + rs.getString("last_name"));
                item.setUserEmail(rs.getString("email"));
                item.setUserPhone(rs.getString("mobile"));

                byte[] imageBytes = rs.getBytes("product_image");
                if (imageBytes != null) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    item.setBase64Image(base64Image);
                } else {
                    item.setBase64Image("");
                }

                orderItems.add(item);
            }

            request.setAttribute("orderItems", orderItems);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/pages/Admin/manageOrder.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        String orderItemIdStr = request.getParameter("orderItemId");
        if (orderItemIdStr != null) {
            try (Connection conn = DBConnection.getConnection()) {
                int orderItemId = Integer.parseInt(orderItemIdStr);

                // Find the order ID for this order item
                String getOrderIdSql = "SELECT order_id FROM order_items WHERE order_item_id = ?";
                PreparedStatement getOrderStmt = conn.prepareStatement(getOrderIdSql);
                getOrderStmt.setInt(1, orderItemId);
                ResultSet orderRs = getOrderStmt.executeQuery();

                if (!orderRs.next()) {
                    response.getWriter().write("not-found");
                    return;
                }

                int orderId = orderRs.getInt("order_id");

                // Delete the order item
                String deleteSql = "DELETE FROM order_items WHERE order_item_id = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
                deleteStmt.setInt(1, orderItemId);
                int rowsDeleted = deleteStmt.executeUpdate();

                if (rowsDeleted == 0) {
                    response.getWriter().write("fail");
                    return;
                }

                // Check if any items remain in this order
                String countSql = "SELECT COUNT(*) FROM order_items WHERE order_id = ?";
                PreparedStatement countStmt = conn.prepareStatement(countSql);
                countStmt.setInt(1, orderId);
                ResultSet countRs = countStmt.executeQuery();

                if (countRs.next() && countRs.getInt(1) == 0) {
                    // No more items, delete the order
                    String deleteOrderSql = "DELETE FROM orders WHERE order_id = ?";
                    PreparedStatement deleteOrderStmt = conn.prepareStatement(deleteOrderSql);
                    deleteOrderStmt.setInt(1, orderId);
                    deleteOrderStmt.executeUpdate();
                } else {
                    // Items still exist - recalculate subtotal and total
                    String recalcSql = "SELECT SUM(price * quantity) AS subtotal FROM order_items WHERE order_id = ?";
                    PreparedStatement recalcStmt = conn.prepareStatement(recalcSql);
                    recalcStmt.setInt(1, orderId);
                    ResultSet subtotalRs = recalcStmt.executeQuery();

                    if (subtotalRs.next()) {
                        double newSubtotal = subtotalRs.getDouble("subtotal");
                        double newShippingFee = 100.0; // Or calculate if dynamic
                        double newTotal = newSubtotal + newShippingFee;

                        String updateOrderSql = "UPDATE orders SET subtotal = ?, shipping_fee = ?, total_amount = ? WHERE order_id = ?";
                        PreparedStatement updateOrderStmt = conn.prepareStatement(updateOrderSql);
                        updateOrderStmt.setDouble(1, newSubtotal);
                        updateOrderStmt.setDouble(2, newShippingFee);
                        updateOrderStmt.setDouble(3, newTotal);
                        updateOrderStmt.setInt(4, orderId);
                        updateOrderStmt.executeUpdate();
                    }
                }

                response.getWriter().write("success");

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("error");
            }
            return;
        }
        
     // ==== STATUS UPDATE LOGIC (ORDER / PAYMENT) ====
        String orderIdStr = request.getParameter("orderId");
        String type = request.getParameter("type");
        String value = request.getParameter("value");

        if (orderIdStr == null || orderIdStr.isEmpty() || type == null || value == null) {
            response.getWriter().write("missing-params");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            int orderId = Integer.parseInt(orderIdStr);
            String sql;

            if ("order".equals(type)) {
                sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
            } else if ("payment".equals(type)) {
                sql = "UPDATE orders SET payment_status = ? WHERE order_id = ?";
            } else {
                response.getWriter().write("invalid-type");
                return;
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, value);
            stmt.setInt(2, orderId);

            int updated = stmt.executeUpdate();
            response.getWriter().write(updated > 0 ? "success" : "fail");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }

    }
}
