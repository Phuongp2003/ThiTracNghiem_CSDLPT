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

import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.mapper.KhoaMapper;
import ptithcm.mapper.LopMapper;
import ptithcm.util.IDFix;

@Service
public class KhoaLopJDBCTemplate {

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Khoa getKhoa(String makh) throws Exception {
        String SQL = "SELECT * FROM Khoa WHERE MAKH = ?";
        IDFix.fix(makh, 8);
        Khoa res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { makh }, (ResultSet rs, int rowNum) -> {
                Khoa kh = new Khoa();
                kh.setMAKH(rs.getString("MAKH"));
                kh.setTENKH(rs.getString("TENKH"));
                kh.setMACS(rs.getString("MACS"));
                return kh;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - get Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public List<Khoa> listKhoa() throws Exception {
        try {
            String SQL = "SELECT * FROM Khoa";
            return jdbcTemplate.query(SQL, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Khoa> listKhoaDiffSite() throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Khoa";
            return jdbcTemplate.query(SQL, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Khoa> findKhoa(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM Khoa WHERE TENKH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Khoa> findKhoaDiffSite(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Khoa WHERE TENKH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public Lop getLop(String malop) throws Exception {
        String SQL = "SELECT * FROM Lop WHERE MALOP = ?";
        IDFix.fix(malop, 8);
        Lop res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { malop }, (ResultSet rs, int rowNum) -> {
                Lop lp = new Lop();
                lp.setMALOP(rs.getString("MALOP"));
                lp.setTENLOP(rs.getString("TENLOP"));
                lp.setMAKH(rs.getString("MAKH"));
                return lp;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - get Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public Lop getLopDiffSite(String malop) throws Exception {
        String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Lop WHERE MALOP = ?";
        IDFix.fix(malop, 8);
        Lop res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { malop }, (ResultSet rs, int rowNum) -> {
                Lop lp = new Lop();
                lp.setMALOP(rs.getString("MALOP"));
                lp.setTENLOP(rs.getString("TENLOP"));
                lp.setMAKH(rs.getString("MAKH"));
                return lp;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - get Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public List<Lop> listLop() throws Exception {
        try {
            String SQL = "SELECT * FROM Lop";
            return jdbcTemplate.query(SQL, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> listLopDiffSite() throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Lop";
            return jdbcTemplate.query(SQL, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> findLop(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM Lop WHERE TENLOP LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> findLopDiffSite(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Lop WHERE TENLOP LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> findLopByKhoa(String makh) throws Exception {
        try {
            String SQL = "SELECT * FROM Lop WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makh }, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - find by khoa Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - find by khoa Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> findLopByKhoaDiffSite(String makh) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.Lop WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makh }, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - find by khoa Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - find by khoa Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void createKhoa(Khoa khoa) throws Exception {
        try {
            String SQL = "INSERT INTO Khoa (MAKH, TENKH, MACS) VALUES (?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, khoa.getMAKH());
            cs.setString(2, khoa.getTENKH());
            cs.setString(3, khoa.getMACS());
            cs.execute();
            System.out.println("Created Record Name = " + khoa.getTENKH());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: createKhoa)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void updateKhoa(String makh, Khoa khoa) throws Exception {
        try {
            String SQL = "UPDATE Khoa SET TENKH = ? WHERE MAKH = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, khoa.getTENKH());
            cs.setString(2, makh);
            cs.execute();
            System.out.println("Updated Record with ID = " + makh);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: updateKhoa)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void deleteKhoa(String makh) throws Exception {
        try {
            String SQL = "DELETE FROM Khoa WHERE MAKH = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, makh);
            cs.execute();
            System.out.println("Deleted Record with ID = " + makh);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: deleteKhoa)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - delete Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void createLop(Lop lop) throws Exception {
        try {
            String SQL = "INSERT INTO Lop (MALOP, TENLOP, MAKH) VALUES (?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, lop.getMALOP());
            cs.setString(2, lop.getTENLOP());
            cs.setString(3, lop.getMAKH());
            cs.execute();
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: createLop)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void updateLop(String malop, Lop lop) throws Exception {
        try {
            String SQL = "UPDATE Lop SET TENLOP = ? WHERE MALOP = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, lop.getTENLOP());
            cs.setString(2, malop);
            cs.execute();
            System.out.println("Updated Record with ID = " + malop);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: updateLop)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void deleteLop(String malop) throws Exception {
        try {
            String SQL = "DELETE FROM Lop WHERE MALOP = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, malop);
            cs.execute();
            System.out.println("Deleted Record with ID = " + malop);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: deleteLop)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - delete Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<Lop> search(String input) throws Exception {
        try {
            String SQL = "{? = call SP_TimKiemLop(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<Lop> results = new ArrayList<>();
                RowMapper<Lop> mapper = new LopMapper();
                while (rs.next()) {
                    results.add(mapper.mapRow(rs, 0));
                }
                return results;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: search)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - search Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        }
    }

    public boolean checkMalop(String malop) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraLopTonTai(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, malop);
            cs.execute();
            return cs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: checkMalop)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - checkMalop Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        }
    }

    public boolean checkMakh(String makh) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraKhoaTonTai(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, makh);
            cs.execute();
            return cs.getInt(1) == 0;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: checkMakh)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
