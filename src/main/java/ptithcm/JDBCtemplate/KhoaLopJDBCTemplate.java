package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.bean.MonHoc;
import ptithcm.mapper.KhoaMapper;
import ptithcm.mapper.LopMapper;
import ptithcm.mapper.SinhVienMapper;
import ptithcm.util.IDFix;

@Service
public class KhoaLopJDBCTemplate {

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Khoa getKhoa(String makh) {
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
            res = null;
        }

        return res;
    }

    public List<Khoa> listKhoa() {
        try {
            String SQL = "SELECT * FROM Khoa";
            return jdbcTemplate.query(SQL, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<Khoa> findKhoa(String name) {
        try {
            String SQL = "SELECT * FROM Khoa WHERE TENKH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new KhoaMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Khoa - find Error: " + e.getMessage());
            return null;
        }
    }

    public Lop getLop(String malop) {
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
            res = null;
        }

        return res;
    }

    public List<Lop> listLop() {
        try {
            String SQL = "{call SP_DanhSachLop}";
            return jdbcTemplate.query(SQL, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<Lop> findLop(String name) {
        try {
            String SQL = "SELECT * FROM Lop WHERE TENLOP LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new LopMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Lop - find Error: " + e.getMessage());
            return null;
        }
    }

    public List<Lop> findLopByKhoa(String makh) {
        try {
            String SQL = "SELECT * FROM Lop WHERE MAKH = ?";
            return jdbcTemplate.query(SQL, new Object[] { makh }, new LopMapper());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - find by khoa Error: " + e.getMessage());
            return null;
        }
    }

    public void createKhoa(Khoa khoa) {
        try {
            String SQL = "INSERT INTO Khoa (MAKH, TENKH, MACS) VALUES (?, ?, ?)";
            jdbcTemplate.update(SQL, khoa.getMAKH(), khoa.getTENKH(), khoa.getMACS());
            System.out.println("Created Record Name = " + khoa.getTENKH());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - create error: " + e.getMessage());
        }
    }

    public void updateKhoa(String makh, Khoa khoa) {
        try {
            String SQL = "UPDATE Khoa SET TENKH = ? WHERE MAKH = ?";
            jdbcTemplate.update(SQL, khoa.getTENKH(), makh);
            System.out.println("Updated Record with ID = " + makh);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - update Error: " + e.getMessage());
        }
    }

    public void deleteKhoa(String makh) {
        try {
            String SQL = "DELETE FROM Khoa WHERE MAKH = ?";
            jdbcTemplate.update(SQL, makh);
            System.out.println("Deleted Record with ID = " + makh);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Khoa - delete Error: " + e.getMessage());
        }
    }

    public void createLop(Lop lop) {
        try {
            String SQL = "INSERT INTO Lop (MALOP, TENLOP, MAKH) VALUES (?, ?, ?)";
            jdbcTemplate.update(SQL, lop.getMALOP(), lop.getTENLOP(), lop.getMAKH());
            System.out.println("Created Record Name = " + lop.getTENLOP());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - create error: " + e.getMessage());
        }
    }

    public void updateLop(String malop, Lop lop) {
        try {
            String SQL = "UPDATE Lop SET TENLOP = ? WHERE MALOP = ?";
            jdbcTemplate.update(SQL, lop.getTENLOP(), malop);
            System.out.println("Updated Record with ID = " + malop);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - update Error: " + e.getMessage());
        }
    }

    public void deleteLop(String malop) {
        try {
            String SQL = "DELETE FROM Lop WHERE MALOP = ?";
            jdbcTemplate.update(SQL, malop);
            System.out.println("Deleted Record with ID = " + malop);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lop - delete Error: " + e.getMessage());
        }
    }
}
