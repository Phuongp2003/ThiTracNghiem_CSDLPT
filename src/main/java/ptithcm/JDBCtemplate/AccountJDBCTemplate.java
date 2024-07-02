package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class AccountJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void createLogin(String loginname, String pass, String magv, String role) throws Exception {
        try (CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                .prepareCall("{? = call SP_TAO_LOGIN(?,?,?,?)}");) {
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, loginname);
            cs.setString(3, pass);
            cs.setString(4, magv);
            cs.setString(5, role);
            cs.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL Exception occurred: " + e.getMessage());
            throw new Exception(e.getMessage() + "(DB: SP_TAO_LOGIN)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Unhandled Exception occurred: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<List<String>> listNoAccount() throws Exception {
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall("{? = call SP_GiaoVienChuaTaoTK()}");
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            try (ResultSet rs = cs.executeQuery()) {
                List<List<String>> results = new ArrayList<>();
                while (rs.next()) {
                    List<String> list = new ArrayList<>();
                    list.add(rs.getString("MAGV"));
                    list.add(rs.getString("TEN"));
                    results.add(list);
                }
                return results;
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("call SP_GiaoVienChuaTaoTK error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: SP_GiaoVienChuaTaoTK)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Account - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
