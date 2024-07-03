package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.temp.ChiTietDapAn;
import ptithcm.bean.temp.MonThi;
import ptithcm.mapper.MonThiMapper;
import ptithcm.mapper.ThiThuMapper;

@Service
public class ThiThuJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<MonThi> listMonThi() throws Exception {
        try {
            String sql = "SELECT * FROM view_DanhSachCacMonThi";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection().prepareCall(sql);
            ResultSet rs = cs.executeQuery();
            List<MonThi> list = new ArrayList<MonThi>();
            MonThiMapper mapper = new MonThiMapper();
            while (rs.next()) {
                list.add(mapper.mapRow(rs, 0));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL Error - Message: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ThiThu)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("List Thi Thu - select Error: " + e.getMessage());
            throw new Exception("List Thi Thu - select Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("List Thi Thu - select Unhandle Error: " + e.getMessage());
            throw new Exception("List Thi Thu- select Unhandle Error: " + e.getMessage());
        }
    }

    public List<ChiTietDapAn> listCauHoiDeThi(String malop, String mamh, int lan) throws Exception {
        try {
            String sql = "{call SP_ThiThu(?, ?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection().prepareCall(sql);
            cs.setString(1, malop);
            cs.setString(2, mamh);
            cs.setInt(3, lan);
            ResultSet rs = cs.executeQuery();
            List<ChiTietDapAn> list = new ArrayList<ChiTietDapAn>();
            ThiThuMapper mapper = new ThiThuMapper();
            while (rs.next()) {
                list.add(mapper.mapRow(rs, 0));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println(e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ThiThu)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("List Cau Hoi De Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("List Cau Hoi De Thi - select Unhandle Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định! Vui lòng thử lại sau!");
        }
    }

    public int soCauDung(List<ChiTietDapAn> list) {
        int count = 0;
        for (ChiTietDapAn chiTietDapAn : list) {
            if (chiTietDapAn.getDAPANSV().equals(chiTietDapAn.getDAPANDUNG())) {
                count++;
            }
        }
        return count;
    }

    public int tongSoCau(List<ChiTietDapAn> list) {
        return list.size();
    }
}
