package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.CoSo;

public class CoSoMapper implements RowMapper<CoSo> {
    public CoSo mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MACS = rs.getString("MACS");
        String TENCS = rs.getString("TENCS");
        String DIACHI = rs.getString("DIACHI");
        return new CoSo(MACS, TENCS, DIACHI);
    }
}
