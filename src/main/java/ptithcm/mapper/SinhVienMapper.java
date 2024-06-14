package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.SinhVien;

public class SinhVienMapper implements RowMapper<SinhVien> {
    public SinhVien mapRow(ResultSet rs, int rowNum) throws SQLException {
        String MASV = rs.getString("MASV");
        String HO = rs.getString("HO");
        String TEN = rs.getString("TEN");
        java.sql.Date NGAYSINH = rs.getDate("NGAYSINH");
        String DIACHI = rs.getString("DIACHI");
        String MALOP = rs.getString("MALOP");
        String MATKHAU = rs.getString("MATKHAU");
        return new SinhVien(MASV, HO, TEN, NGAYSINH, DIACHI, MALOP, MATKHAU);
    }
}
