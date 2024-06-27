package ptithcm.JDBCtemplate;

import java.sql.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.temp.ThoiGianThi;
import ptithcm.mapper.DeThiMapper;
import ptithcm.mapper.MonThiMapper;
import ptithcm.mapper.ThoiGianThiMapper;

@Service
public class ThiJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<CauHoiDeThi> getDeThi(String masv, String malop, String mamh,
            int lanthi) {
        String SQL = "{call SP_TaoBaiThi(?, ?, ?, ?)}";
        List<CauHoiDeThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv, malop, mamh, lanthi },
                    new DeThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("De Thi - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public List<MonThi> getListMonThi(String masv) {
        String SQL = "{call SP_DanhSachCacMonThi(?)}";
        List<MonThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv }, new MonThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Thi - select Error: " + e.getMessage());
            res = null;
        }
        return res;
    }

    public ThoiGianThi getThoiGianThi(String masv, String maMonThi, int lanThi) {
        String SQL = "{call SP_LayThoiGianThi(?, ?, ?)}";
        ThoiGianThi res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv, maMonThi, lanThi }, new ThoiGianThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Thoi Gian Thi - select Error: " + e.getMessage());
            res = null;
        }
        return res;
    }

    public void updateBaiThi(String masv, String mamh, int lanthi, int cauhoi, String traloi) throws Exception {
        String SQL = "{call SP_CapNhatBaiThi(?, ?, ?, ?, ?)}";
        try {
            jdbcTemplate.update(SQL, masv, mamh, lanthi, cauhoi, traloi);
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Update Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Update Bai Thi - update Error: " + e.getMessage());
        }
    }
}
