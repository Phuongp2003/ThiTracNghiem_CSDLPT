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

import ptithcm.bean.temp.ServerInfo;

@Service
public class UtilJDBCTemplate {
    private JdbcTemplate root_cmd;
    @SuppressWarnings("unused")
    private JdbcTemplate cmd;

    public void setRootDataSource(DataSource dataSource) {
        this.root_cmd = new JdbcTemplate(dataSource);
    }

    public void setDataSource(DataSource dataSource) {
        this.cmd = new JdbcTemplate(dataSource);
    }

    public List<ServerInfo> getDSPhanManh() throws Exception {
        String SQL = "SELECT * FROM view_DanhSachPhanManh";
        List<ServerInfo> res = new ArrayList<>();
        try {
            CallableStatement cs = root_cmd.getDataSource().getConnection()
                    .prepareCall(SQL);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    String tenServer = rs.getString("TENSERVER");
                    String tenCS = rs.getString("TENCS");
                    String tenCS_s = rs.getString("s_TENCS");
                    if (!tenCS_s.equals("TC")) {
                        res.add(new ServerInfo(tenServer, tenCS, tenCS_s));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: getDSPhanManh)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("PhanManh - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("PhanManh - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public int createLogin(String loginname, String pass, String magv, String role) throws Exception {
        String SQL = "{? = call SP_TAO_LOGIN(?, ?, ?, ?)}";
        try {
            CallableStatement cs = root_cmd.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, loginname);
            cs.setString(3, pass);
            cs.setString(4, magv);
            cs.setString(5, role);
            cs.execute();
            return cs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: createLogin)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Tao login - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Tao login - select Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
