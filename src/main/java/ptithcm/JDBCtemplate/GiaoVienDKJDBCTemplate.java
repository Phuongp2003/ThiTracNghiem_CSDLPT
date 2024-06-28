package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GiaoVien;
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.mapper.GiaoVienDKMapper;

@Service
public class GiaoVienDKJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public void create(GiaoVienDangKy gvdk) {
        try {
            String SQL = "INSERT INTO GiaoVien_DangKy (MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, gvdk.getMAGV(), gvdk.getMAMH(), gvdk.getMALOP(), gvdk.getTRINHDO(),
                    gvdk.getNGAYTHI(), gvdk.getLAN(), gvdk.getSOCAUTHI(), gvdk.getTHOIGIAN());
            System.out.println("Created Record Name = " + gvdk.getMAGV());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("GVDK - create error: " + e.getMessage());
        }
    }

    public GiaoVienDangKy getGVDK(String magv) {
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
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public GiaoVienDangKy getAllGVDK() {
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
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public GiaoVienDangKy getAllGVDKDiffSite() {
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
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien DK - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public List<List<String>> listDKThi(Date startDate, Date endDate) {
        try {
            String SQL = "{call SP_DanhSachDangKyThi(?, ?)}";
            return jdbcTemplate.query(SQL, new Object[] { startDate, endDate },
                    (ResultSet rs, int rowNum) -> {
                        List<String> list = new ArrayList<>();
                        list.add(rs.getString("TENLOP"));
                        list.add(rs.getString("TENMH"));
                        list.add(rs.getString("HOTEN"));
                        list.add(rs.getString("SOCAUTHI"));
                        list.add(rs.getString("NGAYTHI"));
                        list.add(rs.getString("DATHI"));
                        return list;
                    });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Error: " + e.getMessage());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<List<String>> listDKThiDiffSite(Date startDate, Date endDate) {
        try {
            String SQL = "{call LINK1.TN_CSDLPT.DBO.SP_DanhSachDangKyThi(?, ?)}";
            return jdbcTemplate.query(SQL, new Object[] { startDate, endDate },
                    (ResultSet rs, int rowNum) -> {
                        List<String> list = new ArrayList<>();
                        list.add(rs.getString("TENLOP"));
                        list.add(rs.getString("TENMH"));
                        list.add(rs.getString("HOTEN"));
                        list.add(rs.getString("SOCAUTHI"));
                        list.add(rs.getString("NGAYTHI"));
                        list.add(rs.getString("DATHI"));
                        return list;
                    });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Error: " + e.getMessage());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Danh sach dk thi - list Error: " + e.getMessage());
            return null;
        }
    }
}
