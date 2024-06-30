package ptithcm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

import com.microsoft.sqlserver.jdbc.SQLServerException;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.bean.GiaoVien;

@Service
public class GiaoVienService {
    @Autowired
    private GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    public void setDataSource(DriverManagerDataSource site) {
        giaoVienJDBCTemplate.setDataSource(site);
    }

    public void themGiaoVien(GiaoVien giaoVien) throws Exception {
        giaoVienJDBCTemplate.create(giaoVien);
    }

    public GiaoVien docGiaoVien(String magv) throws Exception {
        return giaoVienJDBCTemplate.getTeacher(magv);
    }

    public List<GiaoVien> docDanhSachGiaoVien() throws Exception {
        return giaoVienJDBCTemplate.listGiaoVien();
    }

    public void capNhatGiaoVien(String maGiaoVien, GiaoVien giaoVien) throws Exception {
        giaoVienJDBCTemplate.update(maGiaoVien, giaoVien);

    }

    public void xoaGiaoVien(String maGiaoVien) throws Exception {
        giaoVienJDBCTemplate.delete(maGiaoVien);
    }

    public Map<String, String> dangNhap(String username) throws Exception {
        return giaoVienJDBCTemplate.login(username);
    }

    public List<GiaoVien> docDanhSachGiaoVienTheoKhoa(String makhoa) throws Exception {
        return giaoVienJDBCTemplate.findTeacherByKhoa(makhoa);
    }
}
