package ptithcm.JDBCtemplate;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import org.springframework.jdbc.core.RowMapper;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.BoDe;
import ptithcm.mapper.BoDeMapper;

@Service
public class BoDeJDBCTemplate {

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public BoDe getBoDe(int cauhoi) throws Exception {
        String SQL = "SELECT * FROM BoDe WHERE CAUHOI = ?";
        // IDFix.fix(makh, 8);
        BoDe res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { cauhoi }, (ResultSet rs, int rowNum) -> {
                BoDe bd = new BoDe();
                bd.setCAUHOI(rs.getInt("CAUHOI"));
                bd.setMAMH(rs.getString("MAMH"));
                bd.setTRINHDO(rs.getString("TRINHDO"));
                bd.setNOIDUNG(rs.getString("NOIDUNG"));
                bd.setA(rs.getString("A"));
                bd.setB(rs.getString("B"));
                bd.setC(rs.getString("C"));
                bd.setD(rs.getString("D"));
                bd.setDAP_AN(rs.getString("DAP_AN"));
                bd.setMAGV(rs.getString("MAGV"));
                return bd;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - select Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }

        return res;
    }

    public List<BoDe> listBoDe(String magv) throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAGV = ?";
            List<BoDe> res = jdbcTemplate.query(SQL, new Object[] { magv }, new BoDeMapper());
            if (res.size() == 0) {
                String newSQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.BoDe WHERE MAGV = ?";
                res = jdbcTemplate.query(newSQL, new Object[] { magv }, new BoDeMapper());
            }
            return res;
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - Select Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - Select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<BoDe> listAllBoDe() throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe";
            return jdbcTemplate.query(SQL, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - Select all Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - Select all Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<BoDe> findBoDeByMonHoc(String mamh) throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAMH = ?";
            return jdbcTemplate.query(SQL, new Object[] { mamh }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find by MaMH Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - find by MaMH Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<BoDe> findBoDeByMonHoc(String mamh, String magv) throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find by MaMH, MaGV Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - find by MaMH, MaGV Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<BoDe> findBoDeByTrinhDo(String name, String mamh, String magv) throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe WHERE TRINHDO = ? AND MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { name, mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find adv Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - find adv Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public List<BoDe> findBoDeByNoiDung(String name, String mamh, String magv) throws Exception {
        try {
            String SQL = "SELECT * FROM BoDe WHERE NOIDUNG LIKE ? AND MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%", mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find adv Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - find adv Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void create(BoDe bode) throws Exception {
        try {
            String SQL = "INSERT INTO BoDe (CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setInt(1, bode.getCAUHOI());
            cs.setString(2, bode.getMAMH());
            cs.setString(3, bode.getTRINHDO());
            cs.setString(4, bode.getNOIDUNG());
            cs.setString(5, bode.getA());
            cs.setString(6, bode.getB());
            cs.setString(7, bode.getC());
            cs.setString(8, bode.getD());
            cs.setString(9, bode.getDAP_AN());
            cs.setString(10, bode.getMAGV());
            cs.execute();
            System.out.println("Created Record Name = " + bode.getCAUHOI());
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: Insert BoDe)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - create Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void update(int cauhoi, BoDe bode) throws Exception {
        try {
            String SQL = "UPDATE BoDe SET TRINHDO = ?, NOIDUNG = ?, A = ?, B = ?"
                    + ", C = ?, D = ?, DAP_AN = ? WHERE CAUHOI = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setString(1, bode.getTRINHDO());
            cs.setString(2, bode.getNOIDUNG());
            cs.setString(3, bode.getA());
            cs.setString(4, bode.getB());
            cs.setString(5, bode.getC());
            cs.setString(6, bode.getD());
            cs.setString(7, bode.getDAP_AN());
            cs.setInt(8, cauhoi);
            cs.execute();
            System.out.println("Updated Record with ID = " + cauhoi);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: Update BoDe)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - update Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public void delete(int cauhoi) throws Exception {
        try {
            String SQL = "DELETE FROM BoDe WHERE CAUHOI = ?";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.setInt(1, cauhoi);
            cs.execute();
            System.out.println("Deleted Record with ID = " + cauhoi);
        } catch (SQLException e) {
            e.printStackTrace();
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            System.err.println("SQL Error - State: " + sqlState + ", Code: " + errorCode);
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: Delete BoDe)");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - delete Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }

    public int getMaxCauHoi() throws Exception {
        String SQL = "SELECT ISNULL(MAX(CAUHOI), 0) AS MAXCAUHOI FROM BoDe";
        int res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] {}, Integer.class);
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - select Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - select Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
        return res;
    }

    public List<BoDe> search(String input) throws Exception {
        try {
            String SQL = "{? = call SP_TimKiemBoDe(?)}";
            CallableStatement cs = jdbcTemplate.getDataSource().getConnection()
                    .prepareCall(SQL);
            cs.registerOutParameter(1, java.sql.Types.INTEGER);
            cs.setString(2, input);
            try (ResultSet rs = cs.executeQuery()) {
                List<BoDe> results = new ArrayList<>();
                RowMapper<BoDe> mapper = new BoDeMapper();
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
            System.err.println("SQL: " + e.getMessage());
            throw new Exception(e.getMessage() + " (DB_ERR: Search BoDe)");
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            throw new Exception("Không tìm thấy câu hỏi, lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - find - Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
