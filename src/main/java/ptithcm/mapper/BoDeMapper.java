package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.BoDe;

public class BoDeMapper implements RowMapper<BoDe> {
    public BoDe mapRow(ResultSet rs, int rowNum) throws SQLException {
        int CAUHOI = rs.getInt("CAUHOI");
        String MAMH = rs.getString("MAMH");
        String TRINHDO = rs.getString("TRINHDO");
        String NOIDUNG = rs.getString("NOIDUNG");
        String A = rs.getString("A");
        String B = rs.getString("B");
        String C = rs.getString("C");
        String D = rs.getString("D");
        String DAPAN = rs.getString("DAPAN");
        String MAGV = rs.getString("MAGV");
        return new BoDe(CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAPAN, MAGV);
    }
}
