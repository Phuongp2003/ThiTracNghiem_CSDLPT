package ptithcm.controller;

import java.util.ArrayList;
import java.sql.Date;
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
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.GiaoVienDangKy;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;
import ptithcm.bean.Lop;

@Controller
@RequestMapping("dkthi")
public class DKThiController {
    @Autowired
    GiaoVienDKJDBCTemplate giaoVienDKJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                giaoVienDKJDBCTemplate.setDataSource(currentConnection.getSite());
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                monHocJDBCTemplate.setDataSource(currentConnection.getSite());
                List<Lop> lops = khoaLopJDBCTemplate.listLop();
                List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();

                model.addAttribute("currentSite", session.getAttribute("site"));
                utilJDBCTemplate.setRootDataSource(currentConnection.getRootSite());
                model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());
                model.addAttribute("lops", lops);
                model.addAttribute("monhocs", monhocs);
            } else {
                throw new Exception("Không có kết nối nào!");
            }
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/dkthi";
    }

    @RequestMapping(value = "add-dkthi", method = RequestMethod.POST)
    public String addDKThi(ModelMap model, @RequestParam("malop") String malop,
            @RequestParam("mamh") String mamh, @RequestParam("trinhdo") String trinhdo,
            @RequestParam("lanthi") int lanthi, @RequestParam("socauthi") int socauthi,
            @RequestParam("ngaythi") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaythi,
            @RequestParam("thoigianthi") int thoigianthi, HttpSession session) {
        try {
            GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
            GiaoVienDangKy gvdk = new GiaoVienDangKy();
            gvdk.setMAGV(currentConnection.getEmployeeID());
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
            model.addAttribute("message", "Đăng ký thất bại! " + e.getMessage());
        }

        return "pages/dkthi";
    }

    @RequestMapping(value = "dsdkthi", method = RequestMethod.POST)
    public String listDKThi(ModelMap model,
            @RequestParam("startdate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date startdate,
            @RequestParam("enddate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date enddate,
            HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            List<List<String>> dsdk = giaoVienDKJDBCTemplate.listDKThi(startdate, enddate);
            model.addAttribute("site_al", currentConnection.getSite_al());
            model.addAttribute("currentSite", session.getAttribute("site"));
            model.addAttribute("dsdk1", listDKThiTheoCS(dsdk, "CS1"));
            model.addAttribute("dsdk2", listDKThiTheoCS(dsdk, "CS2"));
            model.addAttribute("total1", listDKThiTheoCS(dsdk, "CS1").size());
            model.addAttribute("total2", listDKThiTheoCS(dsdk, "CS2").size());
            model.addAttribute("startdate", startdate);
            model.addAttribute("enddate", enddate);
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
        }
        return "pages/dsdkthi";
    }

    public List<List<String>> listDKThiTheoCS(List<List<String>> base, String tenCsRutGon) {
        List<List<String>> res = new ArrayList<>();
        for (List<String> list : base) {
            if (list.get(6).equals(tenCsRutGon)) {
                res.add(list);
            }
        }
        return res;
    }
}
