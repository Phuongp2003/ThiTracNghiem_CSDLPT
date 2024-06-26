package ptithcm.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.JDBCtemplate.GiaoVienDKJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.MonHoc;
import ptithcm.bean.SinhVien;
import ptithcm.util.IDFix;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("thithu")
public class ThiThuController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienDKJDBCTemplate giaoVienDKJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @RequestMapping("")
    public String thithu(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            giaoVienDKJDBCTemplate.setDataSource(currentConnection.getSite());
            GiaoVienDangKy gvdk = giaoVienDKJDBCTemplate.getGVDK(currentConnection.getCurrentUser().getUserName());
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("gvdk", gvdk);
            model.addAttribute("lops", lops);
            model.addAttribute("monhocs", monhocs);
        }
        return "pages/thithu";
    }
}
