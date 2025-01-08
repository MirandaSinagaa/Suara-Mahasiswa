package function;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;

@WebServlet(name = "VoteData", urlPatterns = {"/vote-data"})
public class VoteData extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (Connection conn = koneksi.getKoneksi();
             PrintWriter out = response.getWriter()) {

            // Query untuk mendapatkan jumlah vote tiap paslon
            String sql = "SELECT nomorPaslon, COUNT(*) AS jumlahVote FROM voting GROUP BY nomorPaslon";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                Map<String, Integer> voteData = new HashMap<>();
                while (rs.next()) {
                    voteData.put("Paslon " + rs.getString("nomorPaslon"), rs.getInt("jumlahVote"));
                }

                // Konversi data menjadi JSON menggunakan Gson
                Gson gson = new Gson();
                String json = gson.toJson(voteData);
                out.print(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Gagal mengambil data voting.");
        }
    }
}
