package ptithcm.controller;

import org.omg.CORBA.Current;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.SinhVien;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import java.util.Scanner;

@Controller
@RequestMapping("/setup")
public class SetupController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    private DriverManagerDataSource mainSite;

    @Autowired
    private DriverManagerDataSource firstSite;

    @Autowired
    private DriverManagerDataSource secondSite;

    @Autowired
    private DriverManagerDataSource reportSite;

    @RequestMapping("/init")
    public String init(HttpSession session) {
        String username = "sa";
        String password = "sa";
        currentConnection = new GlobalVariable();
        currentConnection.setSite(firstSite);
        firstSite.setUsername(username);
        firstSite.setPassword(password);
        currentConnection.setUsername(firstSite.getUsername());
        currentConnection.setPassword(firstSite.getPassword());
        session.setAttribute("currentConnection", currentConnection);
        return "redirect:/home.htm";
    }
}
