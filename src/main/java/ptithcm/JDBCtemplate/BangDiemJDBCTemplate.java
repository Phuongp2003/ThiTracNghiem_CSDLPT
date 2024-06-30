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

import ptithcm.bean.BangDiem;
import ptithcm.mapper.BangDiemMapper;

@Service
public class BangDiemJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<List<String>> listBangDiem(String malop, String mamh, int lan) {
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall("{call SP_InBangDiem(?, ?, ?)}");
            cs.setString(1, malop);
            cs.setString(2, mamh);
            cs.setInt(3, lan);

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
            System.err.println("Bang Diem - list Error: " + e.getMessage());
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bang Diem - list Error: " + e.getMessage());
            return null;
        }
    }
}
