package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.BoDe;
import ptithcm.bean.SinhVien;
import ptithcm.mapper.BoDeMapper;
import ptithcm.mapper.SinhVienMapper;

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
                bd.setDAP_AN(rs.getString("DAP_AN"));
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

    public List<BoDe> listBoDe(String magv) {
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
            System.err.println("Bo De - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> listAllBoDe() {
        try {
            String SQL = "SELECT * FROM BoDe";
            return jdbcTemplate.query(SQL, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> listAllBoDeDiffSite() {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.BoDe";
            return jdbcTemplate.query(SQL, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByMonHoc(String mamh) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAMH = ?";
            return jdbcTemplate.query(SQL, new Object[] { mamh }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByMonHoc(String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByMonHocDiffSite(String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM LINK1.TN_CSDLPT.DBO.BoDe WHERE MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByTrinhDo(String name, String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE TRINHDO = ? AND MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { name, mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<BoDe> findBoDeByNoiDung(String name, String mamh, String magv) {
        try {
            String SQL = "SELECT * FROM BoDe WHERE NOIDUNG LIKE ? AND MAMH = ? AND MAGV = ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%", mamh, magv }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }

    public void create(BoDe bode) {
        try {
            String SQL = "INSERT INTO BoDe (CAUHOI, MAMH, TRINHDO, NOIDUNG, A, B, C, D, DAP_AN, MAGV) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(SQL, bode.getCAUHOI(), bode.getMAMH(), bode.getTRINHDO(), bode.getNOIDUNG(),
                    bode.getA(), bode.getB(), bode.getC(), bode.getD(), bode.getDAP_AN(), bode.getMAGV());
            System.out.println("Created Record Name = " + bode.getCAUHOI());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - create error: " + e.getMessage());
        }
    }

    public void update(int cauhoi, BoDe bode) {
        try {
            String SQL = "UPDATE BoDe SET TRINHDO = ? AND SET NOIDUNG = ? AND SET A = ? AND SET B = ? "
                    + "AND SET C = ? AND SET D = ? AND DAP_AN = ? WHERE CAUHOI = ?";
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

    public int getMaxCauHoi() {
        try {
            String SQL = "SELECT ISNULL(MAX(CAUHOI), 0) AS MAXCAUHOI FROM BoDe";
            return jdbcTemplate.query(SQL, new Object[] {}, (ResultSet rs) -> {
                if (rs.next()) {
                    return rs.getInt("MAXCAUHOI");
                } else {
                    return 0;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Bo De - Max cau hoi Error: " + e.getMessage());
            return 0;
        }
    }

    public List<BoDe> search(String input){
        try {
            String SQL = "{call SP_TimKiemBoDe(?)}";
            return jdbcTemplate.query(SQL, new Object[] { input }, new BoDeMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Bo De - find Error: " + e.getMessage());
            return null;
        }
    }
}
