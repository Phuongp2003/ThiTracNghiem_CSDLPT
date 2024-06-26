package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.ThoiGianThi;

public class ThoiGianThiMapper implements RowMapper<ThoiGianThi> {
    public ThoiGianThi mapRow(ResultSet rs, int rowNum) throws SQLException {
        ThoiGianThi thoiGianThi = new ThoiGianThi();
        thoiGianThi.setThoiGian(rs.getInt("THOIGIAN"));
        thoiGianThi.setThoiDiem(rs.getDate("THOIDIEM"));
        return thoiGianThi;
    }
}
