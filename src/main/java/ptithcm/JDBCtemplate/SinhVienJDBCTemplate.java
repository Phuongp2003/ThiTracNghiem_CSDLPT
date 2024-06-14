package ptithcm.JDBCtemplate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

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

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    // New SinhVien
    public void create(SinhVien sinhVien) {
        String SQL = "INSERT INTO SinhVien (MASV, HO, TEN, NGAYSINH, DIACHI, MALOP, MATKHAU) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(SQL, sinhVien.getMASV(), sinhVien.getHO(), sinhVien.getTEN(), sinhVien.getNGAYSINH(),
                sinhVien.getDIACHI(), sinhVien.getMALOP(), sinhVien.getMATKHAU());
        System.out.println("Created Record Name = " + sinhVien.getTEN());
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
            System.err.println("Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    // Get all SinhVien
    public List<SinhVien> listSinhVien() {
        String SQL = "SELECT * FROM SinhVien";
        return jdbcTemplate.query(SQL, new SinhVienMapper());
    }

    // Update SinhVien (input: Id, SinhVien)
    public void update(String masv, SinhVien sinhVien) {
        String SQL = "UPDATE SinhVien SET HO = ?, TEN = ?, NGAYSINH = ?, DIACHI = ?, MALOP = ?, MATKHAU = ? WHERE MASV = ?";
        jdbcTemplate.update(SQL, sinhVien.getHO(), sinhVien.getTEN(), sinhVien.getNGAYSINH(), sinhVien.getDIACHI(),
                sinhVien.getMALOP(), sinhVien.getMATKHAU(), masv);
        System.out.println("Updated Record with ID = " + masv);
    }

    // Delete SinhVien (input: Id)
    public void delete(String masv) {
        String SQL = "DELETE FROM SinhVien WHERE MASV = ?";
        jdbcTemplate.update(SQL, masv);
        System.out.println("Deleted Record with ID = " + masv);
    }

    // Find SinhVien by Name
    public List<SinhVien> findSinhVien(String name) {
        String SQL = "SELECT * FROM SinhVien WHERE TEN LIKE ?";
        return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new SinhVienMapper());
    }

    // Login SinhVien by Procedure
    public List<String> login(String masv, String matkhau) {
        String SQL = "{call SP_DangNhapSinhVien(?, ?)}";
        List<List<String>> res;
        try {
            res = mainSiteTemplate.query(SQL, new Object[] { masv, matkhau }, (ResultSet rs, int rowNum) -> {
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
}
