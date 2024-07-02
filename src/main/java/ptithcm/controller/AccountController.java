package ptithcm.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.AccountJDBCTemplate;
import ptithcm.bean.GlobalVariable;

@Controller
@RequestMapping("/account")
public class AccountController {
    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @Autowired
    AccountJDBCTemplate accountJDBCTemplate;

    @RequestMapping("")
    public String form(ModelMap model, HttpSession session,
            @RequestParam(value = "e_message", required = false) String message,
            RedirectAttributes redirectAttributes) {
        // clean url
        if (message != null) {
            redirectAttributes.addFlashAttribute("e_message", message);
            return "redirect:/account.htm";
        }
        try {
            GlobalVariable currentConnection;
            currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            accountJDBCTemplate.setDataSource(currentConnection.getSite());
            List<List<String>> gvNoAccount = accountJDBCTemplate.listNoAccount();
            model.addAttribute("gvNoAccount", gvNoAccount);
            model.addAttribute("role_al", currentConnection.getRoleAlias());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            session.removeAttribute("currentConnection");
            return "redirect:/auth/login.htm";
        }
        return "pages/account";
    }

    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String create(ModelMap model, @RequestParam("loginname") String loginname,
            @RequestParam("pass") String pass, @RequestParam("magv") String magv,
            @RequestParam("role") String role, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            accountJDBCTemplate.setDataSource(currentConnection.getSite());

            accountJDBCTemplate.createLogin(loginname, pass, magv, role);
            model.addAttribute("ok_message", "Tạo tài khoản thành công!");
            model.addAttribute("role_al", currentConnection.getRoleAlias());
        } catch (Exception e) {
            redirectAttributes.addAttribute("e_message", "Tạo tài khoản thất bại! " + e.getMessage());
            return "redirect:/account.htm";
        }

        return "pages/account";
    }
}
