package ptithcm.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.service.GiaoVienService;
import ptithcm.service.SinhVienService;

@Controller
@RequestMapping("/auth")
public class UserController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    private JdbcTemplate mainSiteTemplate;

    @Autowired
    private SinhVienService sinhVienService;

    @Autowired
    private GiaoVienService giaoVienService;

    @Autowired
    private DriverManagerDataSource firstSite;

    @Autowired
    private DriverManagerDataSource secondSite;

    @Autowired
    private DriverManagerDataSource reportSite;

    @RequestMapping("/login")
    public String login(Model model, HttpSession session,
            @RequestParam(value = "message", required = false) String message,
            RedirectAttributes redirectAttributes) {
        if (message != null) {
            redirectAttributes.addFlashAttribute("message", message);
            return "redirect:/auth/login.htm";
        }
        model.addAttribute("title", "Đăng nhập");
        model.addAttribute("type", "login");
        session.removeAttribute("currentConnection");
        return "pages/login";
    }

    @RequestMapping(value = "check-login", method = RequestMethod.POST)
    public String checkLogin(Model model,
            @RequestParam("site") int site,
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("usertype") String usertype,
            HttpSession session) {
        String svUsername = username;
        String svPassword = password;
        GlobalVariable currentConnection = new GlobalVariable();
        try {
            // Check site
            switch (site) {
                case 1:
                    currentConnection.setSite(firstSite);
                    break;
                case 2:
                    currentConnection.setSite(secondSite);
                    break;
                case 3:
                    currentConnection.setSite(reportSite);
                    break;
                default:
                    throw new Exception("SITE NOT FOUND");
            }

            // Check role
            if (usertype.equals("SV")) {
                currentConnection.setUsername("SV");
                username = "SV";
                password = "SV";
            }

            // Login to sql
            currentConnection.setUsername(username);
            currentConnection.setPassword(password);

            // Check login - Server
            currentConnection.getSite().getConnection();

            // Check login - DB
            if (usertype.equals("SV")) {
                sinhVienService.setDataSource(currentConnection.getSite());
                List<String> sinhVienInfo = sinhVienService.dangNhap(svUsername, svPassword);
                System.out.println(sinhVienInfo);
                currentConnection.setCurrentUser(username, sinhVienInfo.get(0), "Sinh Viên");
            } else {
                giaoVienService.setDataSource(currentConnection.getSite());
                List<String> giaoVienInfo = giaoVienService.dangNhap(username);
                System.out.println(giaoVienInfo);
                currentConnection.setCurrentUser(username, giaoVienInfo.get(0), "Giáo Viên");
            }

        } catch (SQLException e) {
            System.out.println("LOGIN FAIL" + e);
            model.addAttribute("type", "login");
            model.addAttribute("message", "Thông tin đăng nhập không chính xác!");
            return "redirect:/auth/login.htm";
        } catch (Exception e) {
            System.out.println("LOGIN FAIL" + e);
            model.addAttribute("type", "login");
            model.addAttribute("message", "Không tồn tại cơ sở!");
            return "redirect:/auth/login.htm";
        }
        session.setAttribute("currentConnection", currentConnection);
        model.addAttribute("title", "PTITHCM Book Shop");
        model.addAttribute("type", "home");
        model.addAttribute("currentConnection", currentConnection);
        model.addAttribute("message", "login-success");
        return "redirect:/home.htm";
    }

    @RequestMapping(value = "test", method = RequestMethod.POST)
    public String test(Model model, HttpSession session) {

        return "pages/home";
    }
}
