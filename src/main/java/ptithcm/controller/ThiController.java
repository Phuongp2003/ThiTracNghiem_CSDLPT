package ptithcm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.gson.Gson;

import ptithcm.JDBCtemplate.GiaoVienDKJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.JDBCtemplate.ThiJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;
import ptithcm.bean.SinhVien;
import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.ThoiGianThi;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("thi")
public class ThiController {

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
            session.setAttribute("mamh", mamh);
            session.setAttribute("lanthi", lanthi);
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

    @RequestMapping(value = "submit-question", method = RequestMethod.POST)
    public String submitQuesttion(ModelMap model, HttpSession session, @RequestBody String body,
            HttpServletResponse response) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            if (currentConnection != null) {
                thiJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = (SinhVien) session.getAttribute("sv");
                String mamh = (String) session.getAttribute("mamh");
                int lanthi = (int) session.getAttribute("lanthi");

                Gson gson = new Gson();
                Map<String, String> map = new HashMap<>();
                map = gson.fromJson(body, map.getClass());
                int cauhoi = Integer.parseInt(map.get("cauhoi"));
                String dapan = map.get("dapan");
                thiJDBCTemplate.updateBaiThi(sv.getMASV(), mamh, lanthi, cauhoi, dapan);
                List<CauHoiDeThi> dethi = (List<CauHoiDeThi>) session.getAttribute("deThi");
                for (CauHoiDeThi cauHoiDeThi : dethi) {
                    if (cauHoiDeThi.getCAUHOI() == cauhoi) {
                        cauHoiDeThi.setDAPAN(dapan);
                        break;
                    }
                }
                session.setAttribute("deThi", dethi);

                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return "elements/message";
    }

    @RequestMapping(value = "time-exam", method = RequestMethod.POST)
    public String timeExam(ModelMap model, HttpSession session,
            HttpServletResponse response) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            if (currentConnection != null) {
                thiJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = (SinhVien) session.getAttribute("sv");
                String mamh = (String) session.getAttribute("mamh");
                int lanthi = (int) session.getAttribute("lanthi");
                ThoiGianThi thoiGianThi = thiJDBCTemplate.getThoiGianThi(sv.getMASV(), mamh, lanthi);
                Cookie cookie = new Cookie("ngaythi", String.valueOf(thoiGianThi.getNgayThi()));
                cookie.setMaxAge(60 * 60);
                cookie.setPath("/");
                response.addCookie(cookie);
                Cookie cookie2 = new Cookie("giothi", String.valueOf(thoiGianThi.getGioThi()));
                cookie2.setMaxAge(60 * 60);
                cookie2.setPath("/");
                response.addCookie(cookie2);
                Cookie cookie3 = new Cookie("thoigian", String.valueOf(thoiGianThi.getThoiGian()));
                cookie3.setMaxAge(60 * 60);
                cookie3.setPath("/");
                response.addCookie(cookie3);

                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Time Exam - select Error: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return "elements/message";
    }
}
