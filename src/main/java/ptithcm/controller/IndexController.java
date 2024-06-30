package ptithcm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.GlobalVariable;
import ptithcm.service.SinhVienService;

@Controller
public class IndexController {
    @Autowired
    SinhVienService sinhVienService;

    @RequestMapping({ "/home", "/" })
    public String home(Model model, HttpSession session) {
        model.addAttribute("title", "Thi trắc nghiệm trực tuyến");
        model.addAttribute("type", "home");
        return "pages/home";
    }

    @RequestMapping(value = "function-filter", method = RequestMethod.POST)
    public String test(Model model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("role", currentConnection.getCurrentUser().getRoleAlias());
        return "elements/nav_functions";
    }

    @RequestMapping("/error")
    public String error(Model model) {
        model.addAttribute("title", "Lỗi");
        return "pages/error";
    }
}
