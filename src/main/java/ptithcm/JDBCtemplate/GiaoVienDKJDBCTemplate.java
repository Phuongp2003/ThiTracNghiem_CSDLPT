package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GiaoVienDangKy;
import ptithcm.util.DateFM;

@Service
public class GiaoVienDKJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void create(GiaoVienDangKy gvdk) throws Exception {
        try {
            String SQL = "INSERT INTO GiaoVien_DangKy (MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, gvdk.getMAGV());
            cs.setString(2, gvdk.getMAMH());
            cs.setString(3, gvdk.getMALOP());
            cs.setString(4, gvdk.getTRINHDO());
            cs.setDate(5, gvdk.getNGAYTHI());
            cs.setInt(6, gvdk.getLAN());
            cs.setInt(7, gvdk.getSOCAUTHI());
            cs.setInt(8, gvdk.getTHOIGIAN());
            cs.execute();
            System.out.println("Created Record Name = " + gvdk.getMAGV());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public GiaoVienDangKy getGVDK(String magv) throws Exception {
        String SQL = "SELECT * FROM GiaoVien_DangKy WHERE MAGV = ?";
        GiaoVienDangKy res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { magv }, (rs, rowNum) -> {
                GiaoVienDangKy gvdk = new GiaoVienDangKy();
                gvdk.setMAGV(rs.getString("MAGV"));
                gvdk.setMAMH(rs.getString("MAMH"));
                gvdk.setMALOP(rs.getString("MALOP"));
                gvdk.setTRINHDO(rs.getString("TRINHDO"));
                gvdk.setNGAYTHI(rs.getDate("NGAYTHI"));
                gvdk.setLAN(rs.getInt("LAN"));
                gvdk.setSOCAUTHI(rs.getInt("SOCAUTHI"));
                gvdk.setTHOIGIAN(rs.getInt("THOIGIAN"));
                return gvdk;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public GiaoVienDangKy getAllGVDK() throws Exception {
        String SQL = "SELECT * FROM GiaoVien_DangKy";
        GiaoVienDangKy res;
        try {
            res = jdbcTemplate.queryForObject(SQL, (rs, rowNum) -> {
                GiaoVienDangKy gvdk = new GiaoVienDangKy();
                gvdk.setMAGV(rs.getString("MAGV"));
                gvdk.setMAMH(rs.getString("MAMH"));
                gvdk.setMALOP(rs.getString("MALOP"));
                gvdk.setTRINHDO(rs.getString("TRINHDO"));
                gvdk.setNGAYTHI(rs.getDate("NGAYTHI"));
                gvdk.setLAN(rs.getInt("LAN"));
                gvdk.setSOCAUTHI(rs.getInt("SOCAUTHI"));
                gvdk.setTHOIGIAN(rs.getInt("THOIGIAN"));
                return gvdk;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select all Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select all Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public GiaoVienDangKy getAllGVDKDiffSite() throws Exception {
        String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.GiaoVien_DangKy";
        GiaoVienDangKy res;
        try {
            res = jdbcTemplate.queryForObject(SQL, (rs, rowNum) -> {
                GiaoVienDangKy gvdk = new GiaoVienDangKy();
                gvdk.setMAGV(rs.getString("MAGV"));
                gvdk.setMAMH(rs.getString("MAMH"));
                gvdk.setMALOP(rs.getString("MALOP"));
                gvdk.setTRINHDO(rs.getString("TRINHDO"));
                gvdk.setNGAYTHI(rs.getDate("NGAYTHI"));
                gvdk.setLAN(rs.getInt("LAN"));
                gvdk.setSOCAUTHI(rs.getInt("SOCAUTHI"));
                gvdk.setTHOIGIAN(rs.getInt("THOIGIAN"));
                return gvdk;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select all Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select all Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public List<List<String>> listDKThi(Date startDate, Date endDate) throws Exception {
        try {
            String SQL = "{? = call SP_DanhSachDangKyThiJob(?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setDate(2, startDate);
            cs.setDate(3, endDate);
            try (ResultSet rs = cs.executeQuery()) {
                List<List<String>> results = new ArrayList<>();
                while (rs.next()) {
                    List<String> list = new ArrayList<>();
                    list.add(rs.getString("TENLOP"));
                    list.add(rs.getString("TENMH"));
                    list.add(rs.getString("GVDK"));
                    list.add(rs.getString("SOCAUTHI"));
                    list.add(DateFM.Date(rs.getDate("NGAYTHI")));
                    list.add(rs.getString("DATHI"));
                    list.add(rs.getString("MACS"));
                    results.add(list);
                }
                return results;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: DanhSachDangKyThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public boolean checkDKThi(String mamh, String malop, int lan) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraDangKyThi(?, ?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, mamh);
            cs.setString(3, malop);
            cs.setInt(4, lan);
            try (ResultSet rs = cs.executeQuery()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: KiemTraDangKyThi)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("DK Thi - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("DK Thi - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
