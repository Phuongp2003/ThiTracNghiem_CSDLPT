package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GiaoVien;
import ptithcm.bean.GlobalVariable;
import ptithcm.mapper.GiaoVienMapper;

@Service
public class GiaoVienJDBCTemplate {
    @Autowired
    private JdbcTemplate mainSiteTemplate;

    @Autowired
    private GlobalVariable currentConnection;

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.currentConnection.setCmd(jdbcTemplate);
    }

    // New GiaoVien
    public void create(GiaoVien giaoVien) {
        try {
            String SQL = "INSERT INTO GiaoVien (MAGV, HO, TEN, DIACHI, MAKH) VALUES (?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, giaoVien.getMAGV(), giaoVien.getHO(), giaoVien.getTEN(), giaoVien.getDIACHI(),
                    giaoVien.getMAKH());
            System.out.println("Created Record Name = " + giaoVien.getTEN());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - create error: " + e.getMessage());
        }
    }

    // Get GiaoVien by ID
    public GiaoVien getTeacher(String magv) {
        String SQL = "SELECT * FROM GiaoVien WHERE MAGV = ?";
        GiaoVien res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { magv }, (rs, rowNum) -> {
                GiaoVien gv = new GiaoVien();
                gv.setMAGV(rs.getString("MAGV"));
                gv.setHO(rs.getString("HO"));
                gv.setTEN(rs.getString("TEN"));
                gv.setDIACHI(rs.getString("DIACHI"));
                gv.setMAKH(rs.getString("MAKH"));
                return gv;
            });
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    // Get all GiaoVien
    public List<GiaoVien> listGiaoVien() {
        try {
            String SQL = "SELECT * FROM GiaoVien";
            return jdbcTemplate.query(SQL, new GiaoVienMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list error: " + e.getMessage());
            return null;
        }
    }

    public List<GiaoVien> listGiaoVienDiffSite() {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.GiaoVien";
            return jdbcTemplate.query(SQL, new GiaoVienMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list error: " + e.getMessage());
            return null;
        }
    }

    // Update GiaoVien (input: Id, GiaoVien)
    public void update(String magv, GiaoVien giaoVien) {
        try {
            String SQL = "UPDATE GiaoVien SET HO = ?, TEN = ?, DIACHI = ?, MAKH = ? WHERE MAGV = ?";
            jdbcTemplate.update(SQL, giaoVien.getHO(), giaoVien.getTEN(), giaoVien.getDIACHI(), giaoVien.getMAKH(),
                    magv);
            System.out.println("Updated Record with ID = " + magv);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - update Error: " + e.getMessage());
        }
    }

    // Delete GiaoVien (input: Id)
    public void delete(String magv) {
        try {
            String SQL = "DELETE FROM GiaoVien WHERE MAGV = ?";
            jdbcTemplate.update(SQL, magv);
            System.out.println("Deleted Record with ID = " + magv);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - delete Error: " + e.getMessage());
        }
    }

    // Find GiaoVien by Name
    public List<GiaoVien> findTeacherByName(String name) {
        try {
            String SQL = "SELECT * FROM GiaoVien WHERE TEN LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new GiaoVienMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by name Error: " + e.getMessage());
            return null;
        }
    }

    // Find GiaoVien by Khoa
    public List<GiaoVien> findTeacherByKhoa(String makhoa) {
        try {
            String SQL = "SELECT * FROM GiaoVien WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makhoa }, new GiaoVienMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa Error: " + e.getMessage());
            return null;
        }
    }

    public List<GiaoVien> findTeacherByKhoaDiffSite(String makhoa) {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.GiaoVien WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makhoa }, new GiaoVienMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa Error: " + e.getMessage());
            return null;
        }
    }

    // Login GiaoVien by Procedure
    public Map<String, String> login(String magv) {
        String SQL = "{call SP_DangNhapGiangVien(?)}";
        List<Map<String, String>> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { magv }, (ResultSet rs, int rowNum) -> {
                Map<String, String> list = new HashMap<String, String>();
                list.put("USERNAME", rs.getString("USERNAME"));
                list.put("HOTEN", rs.getString("HOTEN"));
                list.put("TENNHOM", rs.getString("TENNHOM"));
                return list;
            });
            return res.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - login Error: " + e.getMessage());
            return null;
        }
    }
}
