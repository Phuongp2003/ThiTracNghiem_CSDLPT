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
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.SinhVien;
import ptithcm.bean.temp.CauHoiDeThi;
import ptithcm.bean.temp.ChiTietDapAn;
import ptithcm.bean.temp.KetQuaThi;
import ptithcm.bean.temp.ThoiGianThi;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("kqthi")
public class KetQuaThiController {
    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    ThiJDBCTemplate thiJDBCTemplate;

    @RequestMapping("")
    public String index(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            thiJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
            Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
            List<MonThi> monthi = thiJDBCTemplate.getListMonThi(sv.getMASV());
            Map<String, String> trangthai = new HashMap<>();
            for (MonThi item : monthi) {
                trangthai.put(item.getMaMon().trim(),
                        thiJDBCTemplate.getTrangThaiThi(sv.getMASV(), item.getMaMon(), item.getLanThi()));
            }
            model.addAttribute("sv", sv);
            model.addAttribute("lop", lop);
            model.addAttribute("monthi", monthi);
            model.addAttribute("trangthai", trangthai);
            model.addAttribute("jdbc", monHocJDBCTemplate);
        }
        return "pages/xemkq";
    }

    @RequestMapping(value = "get", method = RequestMethod.POST)
    public String startExam(ModelMap model, HttpSession session, @RequestParam("mamh") String mamh,
            @RequestParam("lanthi") int lanthi) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
            String trangthai = thiJDBCTemplate.getTrangThaiThi(sv.getMASV(), mamh, lanthi);
            session.setAttribute("sv", sv);
            session.setAttribute("mamh", mamh);
            session.setAttribute("lanthi", lanthi);
            session.setAttribute("trangthaithi", trangthai);
        }
        return "redirect:/kqthi/show.htm";
    }

    @RequestMapping(value = "show", method = RequestMethod.GET)
    public String showExam(ModelMap model, HttpSession session) {
        try {
            SinhVien sv = (SinhVien) session.getAttribute("sv");
            String mamh = (String) session.getAttribute("mamh");
            int lanthi = (int) session.getAttribute("lanthi");
            if (sv != null && mamh != null && lanthi != 0) {
                KetQuaThi kq = thiJDBCTemplate.nhanDapAn(sv.getMASV(), mamh, lanthi);
                model.addAttribute("kq", kq);
                return "pages/ketquathi";
            }
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            e.printStackTrace();
        }
        return "redirect:/login.htm";
    }
}
