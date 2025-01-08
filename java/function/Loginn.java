package function;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Loginn", urlPatterns = {"/login"})
public class Loginn extends HttpServlet {   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try (Connection conn = koneksi.getKoneksi()) {
            // Query matches the user table structure we see in phpMyAdmin
            String sql = "SELECT NIM, namaMahasiswa FROM user WHERE email = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                ps.setString(2, password);
                
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    // Store NIM and namaMahasiswa in session
                    session.setAttribute("NIM", rs.getString("NIM")); // Changed to match case in DB
                    session.setAttribute("namaMahasiswa", rs.getString("namaMahasiswa"));
                    response.sendRedirect("voting.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=Invalid credentials");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Terjadi kesalahan pada server.");
        }
    }
}