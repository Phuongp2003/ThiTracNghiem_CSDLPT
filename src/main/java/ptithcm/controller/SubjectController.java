package ptithcm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;

@Controller
@RequestMapping("subject")
public class SubjectController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("monhocs", monhocs);
        }
        else{
            model.addAttribute("message", "Không có môn học nào!");
        }
        return "pages/subject";
    }
}
