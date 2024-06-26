package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.CauHoiDeThi;

public class DeThiMapper implements RowMapper<CauHoiDeThi> {
    public CauHoiDeThi mapRow(ResultSet rs, int rowNum) throws SQLException {
        String NOIDUNG = rs.getString("NOIDUNG");
        int CAUHOI = rs.getInt("CAUHOI");
        String A = rs.getString("A");
        String B = rs.getString("B");
        String C = rs.getString("C");
        String D = rs.getString("D");
        return new CauHoiDeThi(NOIDUNG, CAUHOI, A, B, C, D);
    }
}
