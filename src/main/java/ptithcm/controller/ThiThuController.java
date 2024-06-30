package ptithcm.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import ptithcm.JDBCtemplate.GiaoVienDKJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("thithu")
public class ThiThuController {

    @Autowired
    GiaoVienDKJDBCTemplate giaoVienDKJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @RequestMapping("")
    public String thithu(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            giaoVienDKJDBCTemplate.setDataSource(currentConnection.getSite());
            GiaoVienDangKy gvdk = giaoVienDKJDBCTemplate.getGVDK(currentConnection.getCurrentUser().getUserName());
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("gvdk", gvdk);
            model.addAttribute("lops", lops);
            model.addAttribute("monhocs", monhocs);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/thithu";
    }
}
