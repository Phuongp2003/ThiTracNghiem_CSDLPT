package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
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
            String SQL = "{call SP_InBangDiem(?, ?, ?)}";
            return jdbcTemplate.query(SQL, new Object[] { malop, mamh, lan },
                    (ResultSet rs, int rowNum) -> {
                        List<String> list = new ArrayList<>();
                        list.add(rs.getString("MASV"));
                        list.add(rs.getString("HOTEN"));
                        list.add(rs.getString("DIEM"));
                        list.add(rs.getString("DIEMCHU"));
                        return list;
                    });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bang Diem - list Error: " + e.getMessage());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bang Diem - list Error: " + e.getMessage());
            return null;
        }
    }
}
