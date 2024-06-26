package ptithcm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.JDBCtemplate.GiaoVienDKJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.JDBCtemplate.ThiJDBCTemplate;
import ptithcm.bean.CauHoiDeThi;
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.MonHoc;
import ptithcm.bean.SinhVien;
import ptithcm.util.IDFix;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("thi")
public class ThiController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    ThiJDBCTemplate thiJDBCTemplate;

    @RequestMapping("")
    public String infoStudent(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            thiJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
            Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("sv", sv);
            model.addAttribute("lop", lop);
            model.addAttribute("monhocs", monhocs);
        }
        return "pages/thi";
    }

    @RequestMapping(value = "start-exam", method = RequestMethod.POST)
    public String startExam(ModelMap model, HttpSession session, @RequestParam("mamh") String mamh,
            @RequestParam("lanthi") int lanthi,
            @RequestParam("ngaythi") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaythi) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
            List<CauHoiDeThi> deThi = thiJDBCTemplate.getDeThi(sv.getMASV(), sv.getMALOP(),
                    new java.sql.Date(ngaythi.getTime()),
                    50, "A", mamh, lanthi);
            session.setAttribute("deThi", deThi);
            session.setAttribute("sv", sv);
        }
        return "redirect:/thi/exam.htm";
    }

    @RequestMapping(value = "exam", method = RequestMethod.GET)
    public String doExam(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = (SinhVien) session.getAttribute("sv");
            Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
            List<CauHoiDeThi> deThi = (List<CauHoiDeThi>) session.getAttribute("deThi");
            model.addAttribute("deThi", deThi);
            model.addAttribute("sv", sv);
            model.addAttribute("lop", lop);
        }
        return "pages/start_exam";
    }
}
