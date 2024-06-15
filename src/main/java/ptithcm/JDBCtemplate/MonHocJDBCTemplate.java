package ptithcm.JDBCtemplate;

import java.sql.ResultSet;
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

    public MonHoc getMonHoc(String mamh) {
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
            res = null;
        }

        return res;
    }

    public List<MonHoc> listMonHoc() {
        try {
            String SQL = "SELECT * FROM MonHoc";
            return jdbcTemplate.query(SQL, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - list Error: " + e.getMessage());
            return null;
        }
    }

    public List<MonHoc> findMonHoc(String name) {
        try {
            String SQL = "SELECT * FROM MonHoc WHERE TENMH LIKE ?";
            return jdbcTemplate.query(SQL, new Object[] { "%" + name + "%" }, new MonHocMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - find Error: " + e.getMessage());
            return null;
        }
    }

    public void create(MonHoc monHoc) {
        try {
            String SQL = "INSERT INTO MonHoc (MAMH, TENMH) VALUES (?, ?)";
            jdbcTemplate.update(SQL, monHoc.getMAMH(), monHoc.getTENMH());
            System.out.println("Created Record Name = " + monHoc.getTENMH());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - create error: " + e.getMessage());
        }
    }

    public void update(String mamh, MonHoc monHoc) {
        try {
            String SQL = "UPDATE MonHoc SET TENMH = ? WHERE MAMH = ?";
            jdbcTemplate.update(SQL, monHoc.getTENMH(), mamh);
            System.out.println("Updated Record with ID = " + mamh);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - update Error: " + e.getMessage());
        }
    }

    public void delete(String mamh) {
        try {
            String SQL = "DELETE FROM MonHoc WHERE MAMH = ?";
            jdbcTemplate.update(SQL, mamh);
            System.out.println("Deleted Record with ID = " + mamh);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Mon Hoc - delete Error: " + e.getMessage());
        }
    }
}
