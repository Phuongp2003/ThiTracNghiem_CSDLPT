package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("department-class")
public class KhoaLopController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("khoas", khoas);
            model.addAttribute("lops", lops);
            System.out.println(khoas);
            System.out.println(lops);
        }
        else{
            model.addAttribute("message", "Không có khoa nào!");
        }
        return "pages/khoalop";
    }
}
