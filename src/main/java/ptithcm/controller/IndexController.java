package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ptithcm.bean.GlobalVariable;
import ptithcm.bean.SinhVien;
import ptithcm.service.SinhVienService;

@Controller
public class IndexController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    SinhVienService sinhVienService;

    @RequestMapping("/home")
    public String home(Model model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("title", "PTITHCM Book Shop");
        model.addAttribute("type", "home");
        return "pages/home";
    }

    @RequestMapping(value = "/test")
    @ResponseBody
    public String test(Model model, HttpSession session) {
        List<SinhVien> sinhVienList = sinhVienService.docDanhSachSinhVien();
        model.addAttribute("students", sinhVienList);
        return "pages/test_e";
    }

    @RequestMapping("/test2")
    public String test2(Model model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("title", "PTITHCM Book Shop");
        model.addAttribute("type", "home");
        List<SinhVien> sinhVienList = sinhVienService.docDanhSachSinhVien();
        sinhVienList = sinhVienList.subList(0, 3);
        model.addAttribute("students", sinhVienList);
        return "pages/test";
    }

    @RequestMapping("/error")
    public String error(Model model) {
        model.addAttribute("title", "Lỗi");
        return "pages/error";
    }
}
