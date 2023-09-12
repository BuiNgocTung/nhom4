package daos;

import jakarta.servlet.http.HttpSession;
import models.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection connection;
    private HttpSession session;

    public UserDAO(HttpSession session) throws Exception {
        Class.forName("org.mariadb.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/logondb",
                "root", "sapassword");
        this.session = session;
    }

    public boolean logon(String us, String psd) throws Exception {
        String sql = "select *from dbuser where  user_name =? and psd = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, us);
        ps.setString(2, psd);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String role =rs.getString("role");
            if (role.equalsIgnoreCase("admin")){
                Statement stmt = connection.createStatement();
                ResultSet rsU = stmt.executeQuery("select *from dbuser");
                List<User> list = new ArrayList<>();
                while (rsU.next()){
                    User u = new User(rsU.getString(1),rsU.getString(2)
                          , rsU.getString(3),rsU.getString(4)
                           , rsU.getString(5));
                    list.add(u);
                }
                session.setAttribute("ds",list);
            }else {
                User u = new User(rs.getString(1),rs.getString(2)
                        , rs.getString(3),rs.getString(4)
                        , rs.getString(5));
                session.setAttribute("us",u);
            }
            return true;
        }
       return false;
    }
}
