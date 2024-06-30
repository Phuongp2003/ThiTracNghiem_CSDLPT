package ptithcm.JDBCtemplate;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Service;

import ptithcm.bean.temp.ServerInfo;
import ptithcm.mapper.GiaoVienMapper;

@Service
public class UtilJDBCTemplate {
    private JdbcTemplate root_cmd;
    private JdbcTemplate cmd;

    public void setRootDataSource(DataSource dataSource) {
        this.root_cmd = new JdbcTemplate(dataSource);
    }

    public void setDataSource(DataSource dataSource) {
        this.cmd = new JdbcTemplate(dataSource);
    }

    public List<ServerInfo> getDSPhanManh() {
        String SQL = "SELECT * FROM view_DanhSachPhanManh";
        List<ServerInfo> res;
        try {
            res = root_cmd.query(SQL, new ResultSetExtractor<List<ServerInfo>>() {
                @Override
                public List<ServerInfo> extractData(ResultSet rs) throws SQLException, DataAccessException {
                    List<ServerInfo> listRet = new ArrayList<>();
                    while (rs.next()) {
                        String tenServer = rs.getString("TENSERVER");
                        String tenCS = rs.getString("TENCS");
                        String tenCS_s = rs.getString("s_TENCS");
                        if (!tenCS_s.equals("TC")) {
                            listRet.add(new ServerInfo(tenServer, tenCS, tenCS_s));
                        }
                    }
                    return listRet;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("PhanManh - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public int createLogin(String loginname, String pass, String magv, String role) {
        String SQL = "{call SP_TAO_LOGIN(?, ?, ?, ?)}";
        try {
            return root_cmd.queryForObject(SQL, new Object[] {loginname, pass, magv, role}, (ResultSet rs, int rowNum) -> {
                return rs.getInt(1);
            });
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Tao login - select Error: " + e.getMessage());
            return -1;
        }
    }
}
