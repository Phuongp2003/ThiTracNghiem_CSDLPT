package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.MonHoc;

public class MonHocMapper implements RowMapper<MonHoc> {
    public MonHoc mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MAMH = rs.getString("MAMH");
        String TENMH = rs.getString("TENMH");
        return new MonHoc(MAMH, TENMH);
    }
}
