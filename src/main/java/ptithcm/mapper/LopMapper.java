package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.Lop;

public class LopMapper implements RowMapper<Lop>{
    public Lop mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MALOP = rs.getString("MALOP");
        String TENLOP = rs.getString("TENLOP");
        String MAKH = rs.getString("MAKH");
        return new Lop(MALOP, TENLOP, MAKH);
    }
}
