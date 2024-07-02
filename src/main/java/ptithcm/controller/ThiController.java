package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.JDBCtemplate.ThiJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.SinhVien;
import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.KetQuaThi;
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
        try {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            thiJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
            Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
            List<MonThi> monthi = thiJDBCTemplate.getListMonChuaThi(sv.getMASV());
            Map<String, String> trangthai = new HashMap<>();
            for (MonThi item : monthi) {
                trangthai.put(item.getMaMon().trim() + String.valueOf(item.getLanThi()),
                        thiJDBCTemplate.getTrangThaiThi(sv.getMASV(), item.getMaMon(), item.getLanThi()));
            }
            model.addAttribute("sv", sv);
            model.addAttribute("lop", lop);
            model.addAttribute("monthi", monthi);
            model.addAttribute("trangthai", trangthai);
            model.addAttribute("jdbc", monHocJDBCTemplate);
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/thi";
    }

    @RequestMapping(value = "start-exam", method = RequestMethod.POST)
    public String startExam(ModelMap model, HttpSession session, @RequestParam("mamh") String mamh,
            @RequestParam("lanthi") int lanthi,
            RedirectAttributes redirectAttributes) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            if (currentConnection != null) {
                sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
                List<CauHoiDeThi> deThi = null;
                session.setAttribute("sv", sv);
                session.setAttribute("mamh", mamh);
                session.setAttribute("lanthi", lanthi);
                String trangthai = thiJDBCTemplate.getTrangThaiThi(sv.getMASV(), mamh, lanthi);

                switch (trangthai) {
                    case "CHUATHI":
                        deThi = thiJDBCTemplate.getDeThi(sv.getMASV(), sv.getMALOP(), mamh, lanthi);
                        break;
                    case "DATHI":
                        break;
                    case "DANGTHI":
                        deThi = thiJDBCTemplate.reGetDeThi(sv.getMASV(), mamh, lanthi);
                        break;
                }
                session.setAttribute("trangthaithi", trangthai);
                session.setAttribute("deThi", deThi);
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("e_message", e.getMessage());
            return "redirect:/thi.htm";
        }
        return "redirect:/thi/exam.htm";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "exam", method = RequestMethod.GET)
    public String doExam(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = (SinhVien) session.getAttribute("sv");
            Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
            List<CauHoiDeThi> deThi = (List<CauHoiDeThi>) session.getAttribute("deThi");
            model.addAttribute("deThi", deThi);
            model.addAttribute("sv", sv);
            model.addAttribute("lop", lop);
            model.addAttribute("trangthaithi", (String) session.getAttribute("trangthaithi"));
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        return "pages/start_exam";
    }

    @RequestMapping(value = "get-point", method = RequestMethod.POST)
    public String getPoint(ModelMap model, HttpSession session, HttpServletResponse response) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            if (currentConnection != null) {
                thiJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = (SinhVien) session.getAttribute("sv");
                String mamh = (String) session.getAttribute("mamh");
                int lanthi = (int) session.getAttribute("lanthi");
                KetQuaThi kq = thiJDBCTemplate.nhanKetQuaThi(sv.getMASV(), mamh, lanthi);
                model.addAttribute("kq", kq);
                model.addAttribute("annoucement", "Đã nộp bài thi");
                session.setAttribute("trangthaithi", "DATHI");

                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
            return "elements/message";
        }
        return "elements/thi/ketqua";
    }

    @RequestMapping(value = "submit-exam", method = RequestMethod.POST)
    public String submitExam(ModelMap model, HttpSession session, HttpServletResponse response,
            @RequestBody String body) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            if (currentConnection != null) {
                thiJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = (SinhVien) session.getAttribute("sv");
                String mamh = (String) session.getAttribute("mamh");
                int lanthi = (int) session.getAttribute("lanthi");
                thiJDBCTemplate.chamBaiThi(sv.getMASV(), mamh, lanthi);
                KetQuaThi kq = thiJDBCTemplate.nhanKetQuaThi(sv.getMASV(), mamh, lanthi);
                model.addAttribute("kq", kq);
                model.addAttribute("annoucement", "Đã nộp bài thi");
                session.setAttribute("trangthaithi", "DATHI");

                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
            return "elements/message";
        }
        return "elements/thi/ketqua";
    }

    @SuppressWarnings("unchecked")
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
            model.addAttribute("message", e.getMessage());
            return "elements/message";
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
            model.addAttribute("message", e.getMessage());
            return "elements/message";
        }
        return "elements/message";
    }
}
