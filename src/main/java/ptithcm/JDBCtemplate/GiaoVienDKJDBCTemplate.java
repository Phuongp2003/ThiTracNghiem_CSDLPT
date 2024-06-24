package ptithcm.JDBCtemplate;

import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GiaoVienDangKy;
import ptithcm.mapper.GiaoVienDKMapper;

@Service
public class GiaoVienDKJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void create(GiaoVienDangKy gvdk) {
        try {
            String SQL = "INSERT INTO GiaoVien_DangKy (MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, gvdk.getMAGV(), gvdk.getMAMH(), gvdk.getMALOP(), gvdk.getTRINHDO(), 
                gvdk.getNGAYTHI(), gvdk.getLAN(), gvdk.getSOCAUTHI(), gvdk.getTHOIGIAN());
            System.out.println("Created Record Name = " + gvdk.getMAGV());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("GVDK - create error: " + e.getMessage());
        }
    }

    public List<GiaoVienDangKy> listGiaoVienDK(Date startDate, Date endDate) {
        try {
            String SQL = "{call SP_DanhSachDangKyThi(?, ?)}";
            return jdbcTemplate.query(SQL, new Object[] { startDate, endDate }, new GiaoVienDKMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - list error: " + e.getMessage());
            return null;
        }
    }
}
