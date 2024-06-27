package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.KetQuaThi;

public class KetQuaThiMapper implements RowMapper<KetQuaThi> {
    public KetQuaThi mapRow(ResultSet rs, int rowNum) throws SQLException {
        KetQuaThi ketQuaThi = new KetQuaThi();
        ketQuaThi.setHOTEN(rs.getString("HO_TEN"));
        ketQuaThi.setTENMH(rs.getString("TENMH"));
        ketQuaThi.setMAMH(rs.getString("MAMH"));
        ketQuaThi.setLOP(rs.getString("TENLOP"));
        ketQuaThi.setNGAYTHI(rs.getTimestamp("NGAYTHI"));
        ketQuaThi.setLAN(rs.getInt("LAN"));
        ketQuaThi.setDIEM(rs.getFloat("DIEM"));
        return ketQuaThi;
    }
}
