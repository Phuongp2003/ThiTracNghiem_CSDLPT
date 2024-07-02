package ptithcm.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.ThiThuJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.temp.ChiTietDapAn;
import ptithcm.bean.temp.MonThi;

@Controller
@RequestMapping("thithu")
public class ThiThuController {

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    ThiThuJDBCTemplate thiThuJDBCTemplate;

    @RequestMapping("")
    public String thithu(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            thiThuJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<MonThi> monhocs = thiThuJDBCTemplate.listMonThi();
            model.addAttribute("jdbc", monHocJDBCTemplate);
            model.addAttribute("jdbc2", khoaLopJDBCTemplate);
            model.addAttribute("monthi", monhocs);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/thithu";
    }

    @RequestMapping(value = "start", method = RequestMethod.POST)
    public String start(ModelMap model, HttpSession session,
            @RequestParam("lop") String malop,
            @RequestParam("mamh") String monthi,
            @RequestParam("lanthi") int lanthi) {
        try {
            List<ChiTietDapAn> list = thiThuJDBCTemplate.listCauHoiDeThi(malop, monthi, lanthi);
            session.setAttribute("list", list);
            session.setAttribute("monthi", monthi);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        return "redirect:/thithu/test.htm";
    }

    @RequestMapping("test")
    public String test(ModelMap model, HttpSession session) {
        List<ChiTietDapAn> list = (List<ChiTietDapAn>) session.getAttribute("list");
        String monthi = (String) session.getAttribute("monthi");
        model.addAttribute("monthi", monthi);
        model.addAttribute("jdbc", monHocJDBCTemplate);
        model.addAttribute("deThi", list);
        return "pages/test_thithu";
    }
}
