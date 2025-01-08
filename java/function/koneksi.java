package function;

import java.sql.Connection;
import java.sql.DriverManager;

public class koneksi {
    private static Connection conn;
    
    public static Connection getKoneksi() {  //encapsulation
        try {
            if (conn == null || conn.isClosed()) {
                String url = "jdbc:mysql://localhost:3306/suara_mahasiswa";
                String user = "root";
                String password = "";
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                System.out.println("Koneksi berhasil!");
            }
        } catch (Exception e) {
            System.err.println("Error koneksi: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}