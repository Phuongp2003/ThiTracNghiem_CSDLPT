package ptithcm.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import ptithcm.bean.temp.ChiTietDapAn;

public class ChiTietDapAnMapper implements RowMapper<ChiTietDapAn> {
    public ChiTietDapAn mapRow(ResultSet rs, int rowNum) throws SQLException {
        ChiTietDapAn chiTietDapAn = new ChiTietDapAn();
        chiTietDapAn.setCAUHOI(rs.getInt("CAUHOI"));
        chiTietDapAn.setNOIDUNG(rs.getString("NOIDUNG"));
        chiTietDapAn.setA(rs.getString("A"));
        chiTietDapAn.setB(rs.getString("B"));
        chiTietDapAn.setC(rs.getString("C"));
        chiTietDapAn.setD(rs.getString("D"));
        chiTietDapAn.setDAPANSV(rs.getString("DAPANSV"));
        chiTietDapAn.setDAPANDUNG(rs.getString("DAPAN"));
        return chiTietDapAn;
    }
}
