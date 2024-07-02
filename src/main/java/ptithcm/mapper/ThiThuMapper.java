package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.ChiTietDapAn;

public class ThiThuMapper implements RowMapper<ChiTietDapAn> {
    public ChiTietDapAn mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ChiTietDapAn(rs.getInt("CAUHOI"),
                rs.getString("NOIDUNG"),
                rs.getString("A"),
                rs.getString("B"),
                rs.getString("C"),
                rs.getString("D"),
                null,
                rs.getString("DAPAN"));

    }
}
