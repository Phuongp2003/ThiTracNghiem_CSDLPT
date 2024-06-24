package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.BangDiem;
public class BangDiemMapper implements RowMapper<BangDiem> {
    public BangDiem mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MASV = rs.getString("MASV");
        String MAMH = rs.getString("MAMH");
        int LAN = rs.getInt("LAN");
        Date NGAYTHI = rs.getDate("NGAYTHI");
        Float DIEM = rs.getFloat("DIEM");
        String MABANGDIEM = rs.getString("MABANGDIEM");
        return new BangDiem(MASV, MAMH, LAN, NGAYTHI, DIEM, MABANGDIEM);
    }
}
