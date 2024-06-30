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
public class BangDiemJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<List<String>> listBangDiem(String malop, String mamh, int lan) throws Exception {
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall("{? = call SP_InBangDiem(?, ?, ?)}");
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, malop);
            cs.setString(3, mamh);
            cs.setInt(4, lan);

            try (ResultSet rs = cs.executeQuery()) {
                List<List<String>> results = new ArrayList<>();
                while (rs.next()) {
                    List<String> list = new ArrayList<>();
                    list.add(rs.getString("MASV"));
                    list.add(rs.getString("HOTEN"));
                    list.add(rs.getString("DIEM"));
                    list.add(rs.getString("DIEMCHU"));
                    results.add(list);
                }
                return results;
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("call SP_InBangDiem error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: InBangDiem)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bang Diem - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
