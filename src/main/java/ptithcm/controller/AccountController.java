package ptithcm.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.GiaoVien;
import ptithcm.bean.GiaoVienAction;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.temp.ServerInfo;
import ptithcm.service.GiaoVienService;
import ptithcm.service.SinhVienService;

@Controller
@RequestMapping("/account")
public class AccountController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String form(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
        GiaoVien user = giaoVienJDBCTemplate.getTeacher(currentConnection.getEmployeeID());
        List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
        model.addAttribute("giaoviens", giaoviens);
        model.addAttribute("user", user);
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/account";
    }

    @RequestMapping(value="create", method = RequestMethod.POST)
    public String create(ModelMap model, @RequestParam("loginname") String loginname,
            @RequestParam("pass") String pass, @RequestParam("magv") String magv, 
            @RequestParam("role") String role, HttpSession session) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
            GiaoVien user = giaoVienJDBCTemplate.getTeacher(currentConnection.getEmployeeID());
            List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
            
            int res = utilJDBCTemplate.createLogin(loginname, pass, magv, role);
            System.out.println(res);
            if(res == 0){
                model.addAttribute("message", "Tạo tài khoản thành công!");
            } else if(res == 1 || res == 2) {
                model.addAttribute("message", "Tên login hoặc mã giáo viên đã tồn tại!");
            }
            model.addAttribute("giaoviens", giaoviens);
            model.addAttribute("user", user);
            model.addAttribute("role_al", currentConnection.getRoleAlias());
        } catch (Exception e) {
            model.addAttribute("message", "Tạo tài khoản thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return "pages/account";
    }
}
