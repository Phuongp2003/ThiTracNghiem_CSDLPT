package ptithcm.controller;

import java.util.List; 
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.AccountJDBCTemplate;
import ptithcm.bean.GiaoVien;
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
            RedirectAttributes redirectAttributes) {
        try {
            GlobalVariable currentConnection;
            currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
            GiaoVien user = giaoVienJDBCTemplate.getTeacher(currentConnection.getEmployeeID());
            List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
            model.addAttribute("giaoviens", giaoviens);
            model.addAttribute("user", user);
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
            @RequestParam("role") String role, HttpSession session) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            accountJDBCTemplate.setDataSource(currentConnection.getSite());
            giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
            GiaoVien user = giaoVienJDBCTemplate.getTeacher(currentConnection.getEmployeeID());
            List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
            
            int res = accountJDBCTemplate.createLogin(loginname, pass, magv, role);
            if(res == 0){
                model.addAttribute("message", "Tạo tài khoản thành công!");
            } else if (res == 1 || res == 2) {
                model.addAttribute("message", "Tên login hoặc mã giáo viên đã tồn tại!");
            }
            model.addAttribute("giaoviens", giaoviens);
            model.addAttribute("user", user);
            model.addAttribute("role_al", currentConnection.getRoleAlias());
        } catch (Exception e) {
            model.addAttribute("message", "Tạo tài khoản thất bại!");
            model.addAttribute("e_message", e.getMessage());
        }

        return "pages/account";
    }
}
