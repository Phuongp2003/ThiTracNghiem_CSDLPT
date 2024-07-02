package ptithcm.JDBCtemplate;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import ptithcm.bean.SinhVien;
import ptithcm.mapper.SinhVienMapper;
import ptithcm.util.IDFix;

import javax.sql.DataSource;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class SinhVienJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public int setDataSource(DataSource dataSource) {
        try {
            this.jdbcTemplate = new JdbcTemplate(dataSource);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - setDataSource Error: " + e.getMessage());
            return 0;
        }
    }

    // New SinhVien
    public void create(SinhVien sinhVien) throws Exception {
        try {
            String SQL = "INSERT INTO SinhVien (MASV, HO, TEN, NGAYSINH, DIACHI, MALOP, MATKHAU) VALUES (?, ?, ?, ?, ?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, sinhVien.getMASV());
            cs.setString(2, sinhVien.getHO());
            cs.setString(3, sinhVien.getTEN());
            cs.setDate(4, sinhVien.getNGAYSINH());
            cs.setString(5, sinhVien.getDIACHI());
            cs.setString(6, sinhVien.getMALOP());
            cs.setString(7, sinhVien.getMATKHAU() != null ? sinhVien.getMATKHAU() : sinhVien.getMASV());
            cs.execute();
            System.out.println("Created Record Name = " + sinhVien.getTEN());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Get SinhVien by ID
    public SinhVien getStudent(String masv) throws Exception {
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
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public SinhVien getStudentDiffSite(String masv) throws Exception {
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
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    // Get all SinhVien
    public List<SinhVien> listSinhVien() throws Exception {
        try {
            String SQL = "SELECT * FROM SinhVien";
            return jdbcTemplate.query(SQL, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<SinhVien> listSinhVienDiffSite() throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.SinhVien";
            return jdbcTemplate.query(SQL, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Update SinhVien (input: Id, SinhVien)
    public void update(String masv, SinhVien sinhVien) throws Exception {
        try {
            String SQL = "UPDATE SinhVien SET HO = ?, TEN = ?, NGAYSINH = ?, DIACHI = ?, MALOP = ?, MATKHAU = ? WHERE MASV = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, sinhVien.getHO());
            cs.setString(2, sinhVien.getTEN());
            cs.setDate(3, sinhVien.getNGAYSINH());
            cs.setString(4, sinhVien.getDIACHI());
            cs.setString(5, sinhVien.getMALOP());
            cs.setString(6, sinhVien.getMATKHAU());
            cs.setString(7, masv);
            cs.execute();
            System.out.println("Updated Record with ID = " + masv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Delete SinhVien (input: Id)
    public void delete(String masv) throws Exception {
        try {
            String SQL = "DELETE FROM SinhVien WHERE MASV = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, masv);
            cs.execute();
            System.out.println("Deleted Record with ID = " + masv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - delete Handled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void move(String malop, String masv, SinhVien sinhVien) throws Exception {
        try {
            String SQL = "{call SP_ChuyenLop(?, ?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, sinhVien.getMALOP().trim());
            cs.setString(2, masv);
            cs.execute();
            System.out.println("Move Record with ID = " + masv);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - delete Unhanled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<SinhVien> findSinhVienByLop(String malop) throws Exception {
        try {
            String SQL = "SELECT * FROM SinhVien WHERE MALOP = ?";
            return jdbcTemplate.query(SQL, new Object[] { malop }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<SinhVien> findSinhVienByLopDiffSite(String malop) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.SinhVien WHERE MALOP = ?";
            return jdbcTemplate.query(SQL, new Object[] { malop }, new SinhVienMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    // Login SinhVien by Procedure
    public List<String> login(String masv, String matkhau) throws Exception {
        String SQL = "{? = call SP_DangNhapSinhVien(?, ?)}";
        List<List<String>> res = new ArrayList<>();
        ;
        try {
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.setString(3, matkhau);
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    List<String> list = new ArrayList<>();
                    list.add(rs.getString("HOTEN"));
                    list.add(rs.getString("TENNHOM"));
                    res.add(list);
                }
            }
        } catch (DataAccessException e) {
            System.err.println("Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: DangNhapSinhVien)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - login Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return res.get(0);
    }

    public boolean checkMasv(String masv) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraSinhVienTonTai(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, masv);
            cs.execute();
            return cs.getInt(1) == 0;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: KiemTraSinhVienTonTai)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<SinhVien> search(String input) throws Exception {
        try {
            String SQL = "{? = call SP_TimKiemSinhVien(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<SinhVien> res = new ArrayList<>();
                while (rs.next()) {
                    RowMapper<SinhVien> mapper = new SinhVienMapper();
                    res.add(mapper.mapRow(rs, 0));
                }
                return res;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: TimKiemSinhVien)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<SinhVien> searchDiffSite(String input) throws Exception {
        try {
            String SQL = "{? = call LINK1.TN_CSDLPT.DBO.SP_TimKiemSinhVien(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<SinhVien> res = new ArrayList<>();
                while (rs.next()) {
                    RowMapper<SinhVien> mapper = new SinhVienMapper();
                    res.add(mapper.mapRow(rs, 0));
                }
                return res;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: TimKiemSinhVien)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Sinh Vien - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
