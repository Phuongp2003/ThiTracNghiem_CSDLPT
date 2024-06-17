package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.util.IDFix;
import ptithcm.bean.GiaoVien;

@Controller
@RequestMapping("teacher")
public class TeacherController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<GiaoVien> giaoViens = giaoVienJDBCTemplate.listGiaoVien();
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            Map<String, String> khoaMap = new HashMap();
            for (Khoa i : khoas) {
                khoaMap.put(i.getMAKH(), i.getTENKH());
            }
            model.addAttribute("idFix", new IDFix());
            model.addAttribute("giaoViens", giaoViens);
            model.addAttribute("khoa", khoaMap);
        }
        else{
            model.addAttribute("message", "Không có giáo viên nào!");
        }
        return "pages/teacher";
    }
}
