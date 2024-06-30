package ptithcm.JDBCtemplate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GlobalVariable;
import ptithcm.bean.SinhVien;
import ptithcm.mapper.SinhVienMapper;
import ptithcm.util.IDFix;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Service
public class SinhVienJDBCTemplate {
    @Autowired
    private JdbcTemplate mainSiteTemplate;

    @Autowired
    private GlobalVariable currentConnection;

    private JdbcTemplate jdbcTemplate;

    public int setDataSource(DataSource dataSource) {
        try {
            this.jdbcTemplate = new JdbcTemplate(dataSource);
            this.currentConnection.setCmd(jdbcTemplate);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - setDataSource Error: " + e.getMessage());
            return 0;
        }
    }

    public int tryGetSources() {
        if (this.jdbcTemplate == null) {
            this.jdbcTemplate = this.mainSiteTemplate;
            this.currentConnection.setCmd(jdbcTemplate);
            return 1;
        }
        return 0;
    }

    // New SinhVien
    public void create(SinhVien sinhVien) {
        try {
            String SQL = "INSERT INTO SinhVien (MASV, HO, TEN, NGAYSINH, DIACHI, MALOP, MATKHAU) VALUES (?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, sinhVien.getMASV(), sinhVien.getHO(), sinhVien.getTEN(), sinhVien.getNGAYSINH(),
                    sinhVien.getDIACHI(), sinhVien.getMALOP(),
                    sinhVien.getMATKHAU() != null ? sinhVien.getMATKHAU() : sinhVien.getMASV());
            System.out.println("Created Record Name = " + sinhVien.getTEN());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - create error: " + e.getMessage());
        }
    }

    // Get SinhVien by ID
    public SinhVien getStudent(String masv) {
        String SQL = "SELECT * FROM SinhVien WHERE MASV = ?";
        IDFix.fix(masv, 8);
        SinhVien res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv }, (ResultSet rs, int rowNum) -> {
                SinhVien sv = new SinhVien();
                sv.setMASV(rs.getString("MASV"));
                sv.setHO(rs.getString("HO"));
                sv.setTEN(rs.getString("TEN"));
                sv.setNGAYSINH(rs.getDate("NGAYSINH"));
                sv.setDIACHI(rs.getString("DIACHI"));
                sv.setMALOP(rs.getString("MALOP"));
                sv.setMATKHAU(rs.getString("MATKHAU"));
                return sv;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public SinhVien getStudentDiffSite(String masv) {
        String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.SinhVien WHERE MASV = ?";
        IDFix.fix(masv, 8);
        SinhVien res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv }, (ResultSet rs, int rowNum) -> {
                SinhVien sv = new SinhVien();
                sv.setMASV(rs.getString("MASV"));
                sv.setHO(rs.getString("HO"));
                sv.setTEN(rs.getString("TEN"));
                sv.setNGAYSINH(rs.getDate("NGAYSINH"));
                sv.setDIACHI(rs.getString("DIACHI"));
                sv.setMALOP(rs.getString("MALOP"));
                sv.setMATKHAU(rs.getString("MATKHAU"));
                return sv;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    // Get all SinhVien
    public List<SinhVien> listSinhVien() {
        tryGetSources();
        try {
            String SQL = "SELECT * FROM SinhVien";
            return jdbcTemplate.query(SQL, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Error: " + e.getMessage());
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<SinhVien> listSinhVienDiffSite() {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.SinhVien";
            return jdbcTemplate.query(SQL, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Error: " + e.getMessage());
            return null;
        }
    }

    // Update SinhVien (input: Id, SinhVien)
    public void update(String masv, SinhVien sinhVien) {
        try {
            String SQL = "UPDATE SinhVien SET HO = ?, TEN = ?, NGAYSINH = ?, DIACHI = ?, MALOP = ?, MATKHAU = ? WHERE MASV = ?";
            jdbcTemplate.update(SQL, sinhVien.getHO(), sinhVien.getTEN(), sinhVien.getNGAYSINH(), sinhVien.getDIACHI(),
                sinhVien.getMATKHAU(), masv);
            System.out.println("Updated Record with ID = " + masv);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - update Error: " + e.getMessage());
        }
    }

    // Delete SinhVien (input: Id)
    public void delete(String masv) {
        try {
            String SQL = "DELETE FROM SinhVien WHERE MASV = ?";
            jdbcTemplate.update(SQL, masv);
            System.out.println("Deleted Record with ID = " + masv);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - delete Error: " + e.getMessage());
        }
    }

    public void move(String malop, String masv, SinhVien sinhVien) {
        try {
            String SQL = "{call SP_ChuyenLop(?, ?)}";
            jdbcTemplate.update(SQL, new Object[] { sinhVien.getMALOP().trim(), masv });
            System.out.println("Move Record with ID = " + masv);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - delete Error: " + e.getMessage());
        }
    }

    public List<SinhVien> findSinhVienByLop(String malop) {
        try {
            String SQL = "SELECT * FROM SinhVien WHERE MALOP = ?";
            return jdbcTemplate.query(SQL, new Object[] { malop }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<SinhVien> findSinhVienByLopDiffSite(String malop) {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.SinhVien WHERE MALOP = ?";
            return jdbcTemplate.query(SQL, new Object[] { malop }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            return null;
        }
    }

    // Login SinhVien by Procedure
    public List<String> login(String masv, String matkhau) {
        String SQL = "{call SP_DangNhapSinhVien(?, ?)}";
        List<List<String>> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv, matkhau }, (ResultSet rs, int rowNum) -> {
                // return USERNAME and TENNHOM
                List<String> list = new ArrayList<String>();
                list.add(rs.getString("HOTEN"));
                list.add(rs.getString("TENNHOM"));
                return list;
            });
        } catch (DataAccessException e) {
            System.err.println("Error: " + e.getMessage());
            res = null;
        }
        return res.get(0);
    }

    public boolean checkMasv(String masv) {
        try {
            String SQL = "{call SP_KiemTraSinhVienTonTai(?)}";
            return jdbcTemplate.queryForObject(SQL, new Object[] { masv }, (ResultSet rs, int rowNum) -> {
                if (rs == null) {
                    return false;
                }
                return rs.getInt(1) > 0;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            return false;
        }
    }

    public List<SinhVien> search(String input) {
        try {
            String SQL = "{call SP_TimKiemSinhVien(?)}";
            return jdbcTemplate.query(SQL, new Object[] { input }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<SinhVien> searchDiffSite(String input) {
        try {
            String SQL = "{call LINK1.TN_CSDLPT.DBO.SP_TimKiemSinhVien(?)}";
            return jdbcTemplate.query(SQL, new Object[] { input }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            return null;
        }
    }
}
