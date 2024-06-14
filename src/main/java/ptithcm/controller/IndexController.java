package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.SinhVien;

@Controller
public class IndexController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @RequestMapping("/home")
    public String home(Model model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("title", "PTITHCM Book Shop");
        model.addAttribute("type", "home");
        return "pages/home";
    }

    @RequestMapping("/test")
    public String test(Model model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("title", "PTITHCM Book Shop");
        model.addAttribute("type", "home");
        if (currentConnection != null) {
            // Ví dụ
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            SinhVien sinhVien = sinhVienJDBCTemplate.getStudent("003");
            if (sinhVien != null)
                System.out.println(sinhVien);
            else
                System.out.println("Không tìm thấy sinh viên");
        }
        List<String> res = sinhVienJDBCTemplate.login("001", "001");
        if (res != null)
            System.out.println(res);
        else
            System.out.println("Không tìm thấy sinh viên");
        return "pages/home";
    }

    @RequestMapping("/error")
    public String error(Model model) {
        model.addAttribute("title", "Lỗi");
        return "pages/error";
    }
}
