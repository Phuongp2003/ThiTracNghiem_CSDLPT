package ptithcm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.bean.GiaoVien;

@Service
public class GiaoVienService {
    @Autowired
    private GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    public void setDataSource(DriverManagerDataSource site) {
        giaoVienJDBCTemplate.setDataSource(site);
    }

    public void themGiaoVien(GiaoVien giaoVien) {
        giaoVienJDBCTemplate.create(giaoVien);
    }

    public GiaoVien docGiaoVien(String magv) {
        return giaoVienJDBCTemplate.getTeacher(magv);
    }

    public List<GiaoVien> docDanhSachGiaoVien() {
        return giaoVienJDBCTemplate.listGiaoVien();
    }

    public void capNhatGiaoVien(String maGiaoVien, GiaoVien giaoVien) {
        giaoVienJDBCTemplate.update(maGiaoVien, giaoVien);
    }

    public void xoaGiaoVien(String maGiaoVien) {
        giaoVienJDBCTemplate.delete(maGiaoVien);
    }

    public Map<String, String> dangNhap(String username) {
        return giaoVienJDBCTemplate.login(username);
    }

    public List<GiaoVien> docDanhSachGiaoVienTheoKhoa(String makhoa) {
        return giaoVienJDBCTemplate.findTeacherByKhoa(makhoa);
    }
}
