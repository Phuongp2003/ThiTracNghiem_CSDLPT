package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.CauHoiDeThi;

public class DeThiMapper implements RowMapper<CauHoiDeThi> {
    public CauHoiDeThi mapRow(ResultSet rs, int rowNum) throws SQLException {
        String NOIDUNG = rs.getString("NOIDUNG");
        String A = rs.getString("A");
        String B = rs.getString("B");
        String C = rs.getString("C");
        String D = rs.getString("D");
        return new CauHoiDeThi(NOIDUNG, A, B, C, D);
    }
}
