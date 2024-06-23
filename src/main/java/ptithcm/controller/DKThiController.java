package ptithcm.controller;

import java.util.Date;
import java.util.List;
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
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("dkthi")
public class DKThiController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienDKJDBCTemplate giaoVienDKJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            giaoVienDKJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("lops", lops);
            model.addAttribute("monhocs", monhocs);
        }
        return "pages/dkthi";
    }

    @RequestMapping(value = "add-dkthi", method = RequestMethod.POST)
    public String addDKThi(ModelMap model, @RequestParam("malop") String malop, 
            @RequestParam("mamh") String mamh, @RequestParam("trinhdo") String trinhdo, 
            @RequestParam("lanthi") int lanthi, @RequestParam("socauthi") int socauthi, 
            @RequestParam("ngaythi") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaythi, 
            @RequestParam("thoigianthi") int thoigianthi, HttpSession session) {
        try {
            GiaoVienDangKy gvdk = new GiaoVienDangKy();
            gvdk.setMAGV("TH123");
            gvdk.setMAMH(mamh);
            gvdk.setMALOP(malop);
            gvdk.setTRINHDO(trinhdo);
            gvdk.setNGAYTHI(ngaythi);
            gvdk.setLAN(lanthi);
            gvdk.setSOCAUTHI(socauthi);
            gvdk.setTHOIGIAN(thoigianthi);
            giaoVienDKJDBCTemplate.create(gvdk);

            model.addAttribute("message", "Đăng ký thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Đăng ký thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return "elements/message";
    }
}
