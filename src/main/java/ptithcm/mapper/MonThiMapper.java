package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.MonThi;

public class MonThiMapper implements RowMapper<MonThi> {
    public MonThi mapRow(ResultSet rs, int rowNum) throws SQLException {
        MonThi monThi = new MonThi();
        monThi.setMaMon(rs.getString("MAMH"));
        monThi.setTrinhDo(rs.getString("TRINHDO"));
        monThi.setNgayThi(rs.getDate("NGAYTHI"));
        monThi.setLanThi(rs.getInt("LAN"));
        monThi.setSoCau(rs.getInt("SOCAUTHI"));
        monThi.setThoiGian(rs.getInt("THOIGIAN"));
        try {
            if (rs.getString("MALOP") != null)
                monThi.setLop(rs.getString("MALOP"));
        } catch (SQLException e) {
            monThi.setLop(null);
        }
        return monThi;
    }
}
