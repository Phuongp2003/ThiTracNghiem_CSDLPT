package ptithcm.JDBCtemplate;

import java.sql.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.CauHoiDeThi;
import ptithcm.mapper.DeThiMapper;

@Service
public class ThiJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<CauHoiDeThi> getDeThi(String masv, String malop, Date ngaythi, int socau, String trinhdo, String mamh,
            int lanthi) {
        String SQL = "{call SP_TaoBaiThi(?, ?, ?, ?, ?, ?, ?)}";
        List<CauHoiDeThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv, malop, ngaythi, socau, trinhdo, mamh, lanthi },
                    new DeThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("De Thi - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }
}
