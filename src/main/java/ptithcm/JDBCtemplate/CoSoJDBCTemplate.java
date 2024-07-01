package ptithcm.JDBCtemplate;

import java.util.List;
import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.CoSo;
import ptithcm.mapper.CoSoMapper;

@Service
public class CoSoJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<CoSo> listCoSo() throws Exception {
        try {
            String SQL = "SELECT * FROM LINK2.TN_CSDLPT.DBO.CoSo";
            return jdbcTemplate.query(SQL, new CoSoMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Co so - list DA Error: " + e.getMessage());
            throw new Exception("Lỗi quyền hạn truy cập dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Co so - list Unhandled Error: " + e.getMessage());
            throw new Exception("Lỗi không xác định!");
        }
    }
}
