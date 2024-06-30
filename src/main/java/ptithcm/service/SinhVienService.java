package ptithcm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.SinhVien;

@Service
public class SinhVienService {
    @Autowired
    private SinhVienJDBCTemplate sinhVienJDBCTemplate;

    public void setDataSource(DriverManagerDataSource site) {
        sinhVienJDBCTemplate.setDataSource(site);
    }

    public void themSinhVien(SinhVien sinhVien) throws Exception {
        sinhVienJDBCTemplate.create(sinhVien);
    }

    public SinhVien docSinhVien(String masv) throws Exception {
        return sinhVienJDBCTemplate.getStudent(masv);
    }

    public List<SinhVien> docDanhSachSinhVien() throws Exception {
        return sinhVienJDBCTemplate.listSinhVien();
    }

    public void capNhatSinhVien(String maSinhVien, SinhVien sinhVien) throws Exception {
        sinhVienJDBCTemplate.update(maSinhVien, sinhVien);
    }

    public void xoaSinhVien(String maSinhVien) throws Exception {
        sinhVienJDBCTemplate.delete(maSinhVien);
    }

    public List<String> dangNhap(String username, String password) throws Exception {
        return sinhVienJDBCTemplate.login(username, password);
    }
}
