package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.GiaoVien;
import ptithcm.mapper.GiaoVienMapper;

@Service
public class GiaoVienJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    // New GiaoVien
    public void create(GiaoVien giaoVien) throws Exception {
        try {
            String SQL = "INSERT INTO GiaoVien (MAGV, HO, TEN, DIACHI, MAKH) VALUES (?, ?, ?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, giaoVien.getMAGV());
            cs.setString(2, giaoVien.getHO());
            cs.setString(3, giaoVien.getTEN());
            cs.setString(4, giaoVien.getDIACHI());
            cs.setString(5, giaoVien.getMAKH());
            cs.execute();
            System.out.println("Created Record (GV) Name = " + giaoVien.getTEN());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ThemGiaoVien)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Get GiaoVien by ID
    public GiaoVien getTeacher(String magv) throws Exception {
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
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - select DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    // Get all GiaoVien
    public List<GiaoVien> listGiaoVien() throws Exception {
        try {
            String SQL = "SELECT * FROM GiaoVien";
            return jdbcTemplate.query(SQL, new GiaoVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<GiaoVien> listGiaoVienDiffSite() throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.GiaoVien";
            return jdbcTemplate.query(SQL, new GiaoVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Update GiaoVien (input: Id, GiaoVien)
    public void update(String magv, GiaoVien giaoVien) throws Exception {
        try {
            String SQL = "UPDATE GiaoVien SET HO = ?, TEN = ?, DIACHI = ? WHERE MAGV = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, giaoVien.getHO());
            cs.setString(2, giaoVien.getTEN());
            cs.setString(3, giaoVien.getDIACHI());
            cs.setString(4, giaoVien.getMAKH());
            cs.setString(5, magv);
            cs.execute();
            System.out.println("Updated Record with ID = " + magv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: SuaGiaoVien)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Delete GiaoVien (input: Id)
    public void delete(String magv) throws Exception {
        try {
            String SQL = "DELETE FROM GiaoVien WHERE MAGV = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, magv);
            cs.execute();
            System.out.println("Deleted Record with ID = " + magv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: XoaGiaoVien)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - delete Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void move(String makh, String magv, GiaoVien giaoVien) throws Exception {
        try {
            String SQL = "{? = call SP_ChuyenKhoa(?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, magv);
            cs.setString(3, giaoVien.getMAKH());
            cs.execute();
            System.out.println("Move Record with ID = " + magv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: ChuyenKhoa)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - move Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Find GiaoVien by Khoa
    public List<GiaoVien> findTeacherByKhoa(String makhoa) throws Exception {
        try {
            String SQL = "SELECT * FROM GiaoVien WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makhoa }, new GiaoVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<GiaoVien> findTeacherByKhoaDiffSite(String makhoa) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.GiaoVien WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makhoa }, new GiaoVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find by khoa Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Login GiaoVien by Procedure
    public Map<String, String> login(String magv) throws Exception {
        String SQL = "{? = call SP_DangNhapGiangVien(?)}";
        List<Map<String, String>> res;
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, magv);
            try (ResultSet rs = cs.executeQuery()) {
                res = new ArrayList<>();
                while (rs.next()) {
                    Map<String, String> list = new HashMap<String, String>();
                    list.put("MANV", rs.getString("MANV"));
                    list.put("HOTEN", rs.getString("HOTEN"));
                    list.put("TENNHOM", rs.getString("TENNHOM"));
                    res.add(list);
                }
            }
            return res.get(0);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: DangNhapGiangVien)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - login Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<GiaoVien> getGVByKhoa(String makhoa) throws Exception {
        try {
            String SQL = "SELECT * FROM GiaoVien WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makhoa }, new GiaoVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - getGVByKhoa DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - getGVByKhoa Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<GiaoVien> search(String input) throws Exception {
        try {
            String SQL = "{? = call SP_TimKiemGiaoVien(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<GiaoVien> results = new ArrayList<>();
                while (rs.next()) {
                    GiaoVien gv = new GiaoVien();
                    gv.setMAGV(rs.getString("MAGV"));
                    gv.setHO(rs.getString("HO"));
                    gv.setTEN(rs.getString("TEN"));
                    gv.setDIACHI(rs.getString("DIACHI"));
                    gv.setMAKH(rs.getString("MAKH"));
                    results.add(gv);
                }
                return results;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: TimKiemGiaoVien)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - search Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - search Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public String checkMagv(String magv) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraGiaoVienTonTai(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, magv);
            cs.execute();
            return cs.getString(1);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: KiemTraGiaoVienTonTai)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Giao Vien - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
