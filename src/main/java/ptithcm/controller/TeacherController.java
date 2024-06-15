package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.GiaoVien;

@Controller
@RequestMapping("teacher")
public class TeacherController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
            List<GiaoVien> giaoViens = giaoVienJDBCTemplate.listGiaoVien();
            model.addAttribute("giaoViens", giaoViens);
        }
        else{
            model.addAttribute("message", "Không có giáo viên nào!");
        }
        return "pages/teacher";
    }
}
