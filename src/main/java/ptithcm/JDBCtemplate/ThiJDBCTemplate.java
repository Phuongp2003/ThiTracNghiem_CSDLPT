package ptithcm.JDBCtemplate;

import java.sql.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.ChiTietDapAn;
import ptithcm.bean.temp.KetQuaThi;
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.temp.ThoiGianThi;
import ptithcm.mapper.ChiTietDapAnMapper;
import ptithcm.mapper.DeThiMapper;
import ptithcm.mapper.KetQuaThiMapper;
import ptithcm.mapper.MonThiMapper;
import ptithcm.mapper.ThoiGianThiMapper;

@Service
public class ThiJDBCTemplate {
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<CauHoiDeThi> getDeThi(String masv, String malop, String mamh,
            int lanthi) {
        String SQL = "{call SP_TaoBaiThi(?, ?, ?, ?)}";
        List<CauHoiDeThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv, malop, mamh, lanthi },
                    new DeThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("De Thi - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public List<CauHoiDeThi> reGetDeThi(String masv, String mamh,
            int lanthi) {
        String SQL = "{call SP_DeThi(?, ?, ?)}";
        List<CauHoiDeThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv, mamh, lanthi },
                    new DeThiMapper());
            String maBangDiem = masv.trim() + mamh.trim() + lanthi;
            for (CauHoiDeThi cauHoiDeThi : res) {
                String traloi = jdbcTemplate.queryForObject(
                        "SELECT DAPANSV FROM CTBAITHI WHERE MABANGDIEM = ? AND CAUHOI = ?",
                        new Object[] { maBangDiem, cauHoiDeThi.getCAUHOI() }, String.class);
                cauHoiDeThi.setDAPAN(traloi);
            }
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("REGET - De Thi - select Error: " + e.getMessage());
            res = null;
        }

        return res;
    }

    public String getTrangThaiThi(String masv, String mamh,
            int lanthi) {
        String SQL = "{call SP_KiemTraTrangThaiThi(?, ?, ?)}";
        String res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv, mamh, lanthi }, String.class);
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Trang Thai Thi - select Error: " + e.getMessage());
            res = null;
        }
        return res;
    }

    public List<MonThi> getListMonThi(String masv) {
        String SQL = "{call SP_DanhSachCacMonThi(?)}";
        List<MonThi> res;
        try {
            res = jdbcTemplate.query(SQL, new Object[] { masv }, new MonThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Mon Thi - select Error: " + e.getMessage());
            res = null;
        }
        return res;
    }

    public ThoiGianThi getThoiGianThi(String masv, String maMonThi, int lanThi) {
        String SQL = "{call SP_LayThoiGianThi(?, ?, ?)}";
        ThoiGianThi res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv, maMonThi, lanThi }, new ThoiGianThiMapper());
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Thoi Gian Thi - select Error: " + e.getMessage());
            res = null;
        }
        return res;
    }

    public void updateBaiThi(String masv, String mamh, int lanthi, int cauhoi, String traloi) throws Exception {
        String SQL = "{call SP_CapNhatBaiThi(?, ?, ?, ?, ?)}";
        try {
            jdbcTemplate.update(SQL, masv, mamh, lanthi, cauhoi, traloi);
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Update Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Update Bai Thi - update Error: " + e.getMessage());
        }
    }

    public void chamBaiThi(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{call SP_ChamDiemBaiThi(?, ?, ?)}";
        try {
            jdbcTemplate.update(SQL, masv, mamh, lanthi);
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Cham Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Cham Bai Thi - update Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Cham Bai Thi - update Error: " + e.getMessage());
            throw new Exception("Cham Bai Thi - update Error: " + e.getMessage());
        }
    }

    public KetQuaThi nhanKetQuaThi(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{call SP_ThiSinhXemKetQua(?, ?, ?)}";
        KetQuaThi res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv, mamh, lanthi }, new KetQuaThiMapper());
            return res;
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Error: " + e.getMessage());
            throw new Exception("Nhan Dap An - select Error: " + e.getMessage());
        }
    }

    public KetQuaThi nhanDapAn(String masv, String mamh, int lanthi) throws Exception {
        String SQL = "{call SP_ThiSinhXemKetQua(?, ?, ?)}";
        KetQuaThi res;
        try {
            res = jdbcTemplate.queryForObject(SQL, new Object[] { masv, mamh, lanthi }, new KetQuaThiMapper());
            String SQL2 = "{call SP_XemKetQua(?, ?, ?)}";
            List<ChiTietDapAn> chiTietDapAn = jdbcTemplate.query(SQL2, new Object[] { masv, mamh, lanthi },
                    new ChiTietDapAnMapper());
            res.setChiTietDapAn(chiTietDapAn);
            return res;
        } catch (DataAccessException e) {
            e.printStackTrace();
            System.err.println("Nhan Dap An - select Error: " + e.getMessage());
            throw new Exception("Nhan Dap An - select Error: " + e.getMessage());
        }
    }
}
