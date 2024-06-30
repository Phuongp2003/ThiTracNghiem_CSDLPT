package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import org.springframework.jdbc.core.RowMapper;
import ptithcm.bean.GiaoVienDangKy;

public class GiaoVienDKMapper implements RowMapper<GiaoVienDangKy> {
    public GiaoVienDangKy mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MAGV = rs.getString("MAGV");
        String MAMH = rs.getString("MAMH");
        String MALOP = rs.getString("MALOP");
        String TRINHDO = rs.getString("TRINHDO");
        Date NGAYTHI = rs.getDate("NGAYTHI");
        int LAN = rs.getInt("LAN");
        int SOCAUTHI = rs.getInt("SOCAUTHI");
        int THOIGIAN = rs.getInt("THOIGIAN");
        return new GiaoVienDangKy(MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN);
    }
}
