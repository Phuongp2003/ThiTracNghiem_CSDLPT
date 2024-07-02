package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.ChiTietDapAn;
import ptithcm.bean.temp.KetQuaThi;
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.temp.ThoiGianThi;
import ptithcm.mapper.ChiTietDapAnMapper;
import ptithcm.mapper.DeThiMapper;
import ptithcm.mapper.KetQuaThiMapper;
import ptithcm.mapper.MonThiMapper;
import ptithcm.mapper.ThoiGianThiMapper;

@Service
public class ThiJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<CauHoiDeThi> getDeThi(String masv, String malop, String mamh,
            int lanthi) throws Exception {
        List<CauHoiDeThi> res = new ArrayList<>();
        try {
            String SQL = "{? = call SP_TaoBaiThi(?, ?, ?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, malop);
            cs.setString(4, mamh);
            cs.setInt(5, lanthi);
            try (ResultSet rs = cs.executeQuery()) {
                RowMapper<CauHoiDeThi> mapper = new DeThiMapper();
                while (rs.next()) {
                    res.add(mapper.mapRow(rs, 0));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL Error - Message: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: TaoBaiThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("De Thi - select Error: " + e.getMessage());
            throw new Exception("De Thi - select Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("De Thi - select Unhandle Error: " + e.getMessage());
            throw new Exception("De Thi - select Unhandle Error: " + e.getMessage());
        }

        return res;
    }

    public List<CauHoiDeThi> reGetDeThi(String masv, String mamh,
            int lanthi) throws Exception {
        String SQL = "{? = call SP_DeThi(?, ?, ?)}";
        List<CauHoiDeThi> res;
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            ResultSet rs = cs.executeQuery();
            res = new ArrayList<>();
            RowMapper<CauHoiDeThi> mapper = new DeThiMapper();
            while (rs.next()) {
                res.add(mapper.mapRow(rs, 0));
            }

            String maBangDiem = masv.trim() + mamh.trim() + lanthi;
            for (CauHoiDeThi cauHoiDeThi : res) {
                String traloi = jdbcTemplate.queryForObject(
                        "SELECT DAPANSV FROM CTBAITHI WHERE MABANGDIEM = ? AND CAUHOI = ?",
                        new Object[] { maBangDiem, cauHoiDeThi.getCAUHOI() }, String.class);
                cauHoiDeThi.setDAPAN(traloi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: DeThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("REGET - De Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("REGET - De Thi - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public String getTrangThaiThi(String masv, String mamh,
            int lanthi) throws Exception {
        String SQL = "{? = call SP_KiemTraTrangThaiThi(?, ?, ?, ?)}";
        String res;
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.VARCHAR);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.registerOutParameter(5, java.sql.Types.NVARCHAR);
            cs.execute();
            res = cs.getString(5);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: KiemTraTrangThaiThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Trang Thai Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Trang Thai Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return res;
    }

    public List<MonThi> getListMonThi(String masv) throws Exception {
        String SQL = "{? = call SP_DanhSachCacMonThi(?)}";
        List<MonThi> res = new ArrayList<>();
        ;
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            ResultSet rs = cs.executeQuery();
            RowMapper<MonThi> mapper = new MonThiMapper();
            while (rs.next()) {
                res.add(mapper.mapRow(rs, 0));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: DanhSachCacMonThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return res;
    }

    public ThoiGianThi getThoiGianThi(String masv, String maMonThi, int lanThi) throws Exception {
        String SQL = "{? = call SP_LayThoiGianThi(?, ?, ?)}";
        ThoiGianThi res = new ThoiGianThi();
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, maMonThi);
            cs.setInt(4, lanThi);
            ResultSet rs = cs.executeQuery();
            res = new ThoiGianThi();
            RowMapper<ThoiGianThi> mapper = new ThoiGianThiMapper();
            while (rs.next()) {
                res = mapper.mapRow(rs, 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: LayThoiGianThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Thoi Gian Thi - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Thoi Gian Thi - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return res;
    }

    public void updateBaiThi(String masv, String mamh, int lanthi, int cauhoi, String traloi) throws Exception {
        String SQL = "{? = call SP_CapNhatBaiThi(?, ?, ?, ?, ?)}";
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.setInt(5, cauhoi);
            cs.setString(6, traloi);
            cs.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: CapNhatBaiThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Update Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Update Bai Thi - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void chamBaiThi(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{? = call SP_ChamDiemBaiThi(?, ?, ?)}";
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ChamDiemBaiThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Cham Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Cham Bai Thi - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public KetQuaThi nhanKetQuaThi(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{? = call SP_ThiSinhXemKetQua(?, ?, ?)}";
        KetQuaThi res = new KetQuaThi();
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.execute();
            KetQuaThiMapper mapper = new KetQuaThiMapper();
            while (cs.getResultSet().next()) {
                res = (KetQuaThi) mapper.mapRow(cs.getResultSet(), 0);
            }
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ThiSinhXemKetQua)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public KetQuaThi nhanDapAn(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{? = call SP_ThiSinhXemKetQua(?, ?, ?)}";
        KetQuaThi res = new KetQuaThi();
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.execute();
            KetQuaThiMapper mapper = new KetQuaThiMapper();
            while (cs.getResultSet().next()) {
                res = (KetQuaThi) mapper.mapRow(cs.getResultSet(), 0);
            }
            String SQL2 = "{? = call SP_XemKetQua(?, ?, ?)}";
            cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL2);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, mamh);
            cs.setInt(4, lanthi);
            cs.execute();
            ChiTietDapAnMapper mapper2 = new ChiTietDapAnMapper();
            List<ChiTietDapAn> chiTietDapAn = new ArrayList<>();
            while (cs.getResultSet().next()) {
                chiTietDapAn.add((ChiTietDapAn) mapper2.mapRow(cs.getResultSet(), 0));
            }
            res.setChiTietDapAn(chiTietDapAn);
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ThiSinhXemKetQua)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
