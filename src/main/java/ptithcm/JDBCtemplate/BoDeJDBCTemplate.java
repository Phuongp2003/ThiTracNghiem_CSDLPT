package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.BoDe;
import ptithcm.mapper.BoDeMapper;
import ptithcm.util.IDFix;

@Service
public class BoDeJDBCTemplate {
    
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public BoDe getBoDe(int cauhoi) {
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
                bd.setDAPAN(rs.getString("DAPAN"));
                bd.setMAGV(rs.getString("MAGV"));
                return bd;
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public List<BoDe> listBoDe(String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAMH = mamh AND MAGV = magv";
            return jdbcTemplate.query(SQL, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByTrinhDo(String name, String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE TRINHDO = name AND MAMH = mamh AND MAGV = magv";
            return jdbcTemplate.query(SQL, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByNoiDung(String name, String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE TRINHDO = ? AND MAMH = mamh AND MAGV = magv";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            return null;
        }
    }

    public void create(BoDe bode) {
        try {
            String SQL = "INSERT INTO BoDe (CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAPAN, MAGV) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, bode.getCAUHOI(), bode.getMAMH(), bode.getTRINHDO(), bode.getNOIDUNG(), 
                bode.getA(), bode.getB(), bode.getC(), bode.getD(), bode.getDAPAN(), bode.getMAGV());
            System.out.println("Created Record Name = " + bode.getCAUHOI());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - create error: " + e.getMessage());
        }
    }

    public void update(int cauhoi, BoDe bode) {
        try {
            String SQL = "UPDATE BoDe SET TRINHDO = ? AND SET NOIDUNG = ? AND SET A = ? AND SET B = ? "
                        + "AND SET C = ? AND SET D = ? AND DAPAN = ? WHERE CAUHOI = ?";
            jdbcTemplate.update(SQL, bode.getCAUHOI(), cauhoi);
            System.out.println("Updated Record with ID = " + cauhoi);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - update Error: " + e.getMessage());
        }
    }

    public void delete(int cauhoi) {
        try {
            String SQL = "DELETE FROM BoDe WHERE CAUHOI = ?";
            jdbcTemplate.update(SQL, cauhoi);
            System.out.println("Deleted Record with ID = " + cauhoi);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - delete Error: " + e.getMessage());
        }
    }
}
