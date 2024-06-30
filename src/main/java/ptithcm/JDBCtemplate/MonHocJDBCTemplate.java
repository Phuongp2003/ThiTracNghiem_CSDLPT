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

import ptithcm.bean.MonHoc;
import ptithcm.mapper.MonHocMapper;
import ptithcm.util.IDFix;

@Service
public class MonHocJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public MonHoc getMonHoc(String mamh) throws Exception {
        String SQL = "SELECT * FROM MonHoc WHERE MAMH = ?";
        IDFix.fix(mamh, 8);
        MonHoc res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { mamh }, (ResultSet rs, int rowNum) -> {
                MonHoc mh = new MonHoc();
                mh.setMAMH(rs.getString("MAMH"));
                mh.setTENMH(rs.getString("TENMH"));
                return mh;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public MonHoc getMonHocDiffSite(String mamh) throws Exception {
        String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.MonHoc WHERE MAMH = ?";
        IDFix.fix(mamh, 8);
        MonHoc res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { mamh }, (ResultSet rs, int rowNum) -> {
                MonHoc mh = new MonHoc();
                mh.setMAMH(rs.getString("MAMH"));
                mh.setTENMH(rs.getString("TENMH"));
                return mh;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - select Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public List<MonHoc> listMonHoc() throws Exception {
        try {
            String SQL = "SELECT * FROM MonHoc";
            return jdbcTemplate.query(SQL, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - list Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<MonHoc> listMonHocDiffSite() {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.MonHoc";
            return jdbcTemplate.query(SQL, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<MonHoc> findMonHoc(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM MonHoc WHERE TENMH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find - Handless Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<MonHoc> findMonHocDiffSite(String name) throws Exception {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.MonHoc WHERE TENMH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find - Handless Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void create(MonHoc monHoc) throws Exception {
        try {
            String SQL = "INSERT INTO MonHoc (MAMH, TENMH) VALUES (?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, monHoc.getMAMH());
            cs.setString(2, monHoc.getTENMH());
            cs.execute();
            System.out.println("Created Record Name = " + monHoc.getTENMH());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: MonHoc)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void update(String mamh, MonHoc monHoc) throws Exception {
        try {
            String SQL = "UPDATE MonHoc SET TENMH = ? WHERE MAMH = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, monHoc.getTENMH());
            cs.setString(2, mamh);
            cs.execute();
            System.out.println("Updated Record with ID = " + mamh);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: MonHoc)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void delete(String mamh) throws Exception {
        try {
            String SQL = "DELETE FROM MonHoc WHERE MAMH = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, mamh);
            cs.execute();
            System.out.println("Deleted Record with ID = " + mamh);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: MonHoc)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - delete Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<MonHoc> search(String input) throws Exception {
        try {
            String SQL = "{? = call SP_TimKiemMonHoc(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<MonHoc> res = new ArrayList<>();
                while (rs.next()) {
                    MonHoc mh = new MonHoc();
                    mh.setMAMH(rs.getString("MAMH"));
                    mh.setTENMH(rs.getString("TENMH"));
                    res.add(mh);
                }
                return res;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: MonHoc)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon hoc - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon hoc - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public boolean checkMamh(String mamh) throws Exception {
        try {
            String SQL = "{? = call SP_KiemTraMonHocTonTai(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, mamh);
            cs.execute();
            return cs.getInt(1) == 0;
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("Database: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: MonHoc)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
