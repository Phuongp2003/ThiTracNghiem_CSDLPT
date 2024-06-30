package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.SQLException;

import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class AccountJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public int createLogin(String loginname, String pass, String magv, String role) throws Exception {
        int result = -1;
        try (CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                .prepareCall("{? = call SP_TAO_LOGIN(?,?,?,?)}");) {
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, loginname);
            cs.setString(3, pass);
            cs.setString(4, magv);
            cs.setString(5, role);
            cs.execute();
            result = cs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Exception occurred: " + e.getMessage());
            throw new Exception(e.getMessage() + "(DB: SP_TAO_LOGIN)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Unhandled Exception occurred: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return result;
    }
}
