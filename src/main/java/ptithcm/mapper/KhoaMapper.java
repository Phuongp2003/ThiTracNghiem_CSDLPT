package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.Khoa;

public class KhoaMapper implements RowMapper<Khoa>{
    public Khoa mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MAKH = rs.getString("MAKH");
        String TENKH = rs.getString("TENKH");
        String MACS = rs.getString("MACS");
        return new Khoa(MAKH, TENKH, MACS);
    }
}
