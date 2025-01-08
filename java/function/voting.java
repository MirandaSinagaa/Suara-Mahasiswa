package function;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "voting", urlPatterns = {"/voting"})
public class voting extends HttpServlet { 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String NIM = (String) session.getAttribute("NIM");
        String nomorPaslon = request.getParameter("nomorPaslon");

        // Check if user is logged in
        if (NIM == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = koneksi.getKoneksi()) {
            // Check if user has already voted
            String checkSql = "SELECT * FROM voting WHERE NIM = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, NIM);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        // User already voted
                        request.setAttribute("errorMessage", "Anda sudah melakukan voting sebelumnya!");
                        request.getRequestDispatcher("voting.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Proceed with voting
            String sql = "INSERT INTO voting (NIM, nomorPaslon, vote_time) VALUES (?, ?, NOW())";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, NIM);
                stmt.setInt(2, Integer.parseInt(nomorPaslon));
                stmt.executeUpdate();
            }
            response.sendRedirect("penutup.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Nomor pasangan calon harus berupa angka.");
            request.getRequestDispatcher("voting.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Gagal menyimpan voting. Coba lagi nanti.");
            request.getRequestDispatcher("voting.jsp").forward(request, response);
        }
    }
}
