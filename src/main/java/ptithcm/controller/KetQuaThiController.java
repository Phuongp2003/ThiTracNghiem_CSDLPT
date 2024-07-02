package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.JDBCtemplate.ThiJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.temp.MonThi;
import ptithcm.bean.SinhVien;
import ptithcm.bean.temp.KetQuaThi;
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
        try {
            if (currentConnection != null) {
                sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                monHocJDBCTemplate.setDataSource(currentConnection.getSite());
                thiJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
                Lop lop = khoaLopJDBCTemplate.getLop(sv.getMALOP());
                List<MonThi> monthi = thiJDBCTemplate.getListMonDaThi(sv.getMASV());
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
            } else {
                throw new Exception("Không có kết nối nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/xemkq";
    }

    @RequestMapping(value = "get", method = RequestMethod.POST)
    public String startExam(ModelMap model, HttpSession session, @RequestParam("mamh") String mamh,
            @RequestParam("lanthi") int lanthi, RedirectAttributes redirectAttributes) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
                SinhVien sv = sinhVienJDBCTemplate.getStudent(currentConnection.getUserName());
                String trangthai = thiJDBCTemplate.getTrangThaiThi(sv.getMASV(), mamh, lanthi);
                session.setAttribute("sv", sv);
                session.setAttribute("mamh", mamh);
                session.setAttribute("lanthi", lanthi);
                session.setAttribute("trangthaithi", trangthai);
            } else {
                model.addAttribute("e_message", "Không có kết nối nào!");
            }
        } catch (Exception e) {
            redirectAttributes.addAttribute("e_message", e.getMessage());
        }
        return "redirect:/kqthi/show.htm";
    }

    @RequestMapping(value = "show", method = RequestMethod.GET)
    public String showExam(ModelMap model, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            SinhVien sv = (SinhVien) session.getAttribute("sv");
            String mamh = (String) session.getAttribute("mamh");
            int lanthi = (int) session.getAttribute("lanthi");
            if (sv != null && mamh != null && lanthi != 0) {
                KetQuaThi kq = thiJDBCTemplate.nhanDapAn(sv.getMASV(), mamh, lanthi);
                model.addAttribute("kq", kq);
                return "pages/ketquathi";
            } else {
                throw new Exception("Thông tin dự thi không hợp lệ!");
            }
        } catch (Exception e) {
            redirectAttributes.addAttribute("message", e.getMessage());
            return "redirect:/auth/login.htm";
        }
    }
}
