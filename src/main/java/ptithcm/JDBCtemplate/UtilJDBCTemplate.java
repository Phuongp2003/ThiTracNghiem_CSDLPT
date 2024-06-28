package ptithcm.JDBCtemplate;

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
                        if (!tenServer.equals("NPHUONG\\MSSQLSERVER_TN3")) {
                            listRet.add(new ServerInfo(tenServer, tenCS));
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
}