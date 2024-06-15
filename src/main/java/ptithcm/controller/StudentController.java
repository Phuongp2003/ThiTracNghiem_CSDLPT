package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("student")
public class StudentController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            List<SinhVien> sinhViens = sinhVienJDBCTemplate.listSinhVien();
            model.addAttribute("sinhViens", sinhViens);
            System.out.println(sinhViens);
        }
        else{
            model.addAttribute("message", "Không có sinh viên nào!");
        }
        return "pages/student";
    }
}
