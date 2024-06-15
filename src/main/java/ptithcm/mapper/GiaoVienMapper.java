package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.GiaoVien;

public class GiaoVienMapper implements RowMapper<GiaoVien> {
    public GiaoVien mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MAGV = rs.getString("MAGV");
        String HO = rs.getString("HO");
        String TEN = rs.getString("TEN");
        String DIACHI = rs.getString("DIACHI");
        String MAKH = rs.getString("MAKH");
        return new GiaoVien(MAGV, HO, TEN, DIACHI, MAKH);
    }
}
