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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;

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
        }
        else{
            model.addAttribute("message", "Không có khoa nào!");
        }
        return "pages/khoalop";
    }

    @RequestMapping(value = "/get-lop-by-khoa", method = RequestMethod.POST)
    public String listByKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<Lop> lops;
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String makh = map.get("makh");
            if (makh != null) {
                if ("all".equals(makh)) {
                    lops = khoaLopJDBCTemplate.listLop();
                } else {
                    lops = khoaLopJDBCTemplate.findLopByKhoa(makh);
                }
            } else {
                throw new NullPointerException("Mã khoa không được để trống!");
            }
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            model.addAttribute("lops", lops);
            model.addAttribute("khoas", khoas);
            model.addAttribute("makh", makh);
        } else {
            model.addAttribute("message", "Không có khoa nào!");
        }

        return "elements/khoalop/lop_list";
    }

    @RequestMapping(value = "add-class", method = RequestMethod.POST)
    public String addClass(ModelMap model, @RequestParam("malop") String malop, 
            @RequestParam("tenlop") String tenlop, @RequestParam("makh") String makh, 
            HttpSession session) {
        Lop lop = new Lop();
        lop.setMALOP(malop);
        lop.setTENLOP(tenlop);
        lop.setMAKH(makh);
        khoaLopJDBCTemplate.createLop(lop);
        return "redirect:/department-class.htm";
    }

    @RequestMapping(value = "delete-class/{id}")
    public String deleteClass(ModelMap model, @PathVariable("id") String malop, HttpSession session) {
        khoaLopJDBCTemplate.deleteLop(malop);
        return "redirect:/department-class.htm";
    }

    @RequestMapping(value = "edit-class", method = RequestMethod.POST)
    public String updateClass(ModelMap model, @RequestParam("malop") String malop, 
            @RequestParam("tenlop") String tenlop, HttpSession session) {
        Lop lop = khoaLopJDBCTemplate.getLop(malop);
        lop.setTENLOP(tenlop);
        khoaLopJDBCTemplate.updateLop(malop, lop);
        return "redirect:/department-class.htm";
    }

    @RequestMapping(value = "add-department", method = RequestMethod.POST)
    public String addDepartment(ModelMap model, @RequestParam("makh") String makh, 
            @RequestParam("tenkh") String tenkh, 
            HttpSession session) {
        Khoa khoa = new Khoa();
        khoa.setMAKH(makh);
        khoa.setTENKH(tenkh);
        khoa.setMACS("CS1");
        khoaLopJDBCTemplate.createKhoa(khoa);
        return "redirect:/department-class.htm";
    }

    @RequestMapping(value = "delete-department/{id}")
    public String deleteDepartment(ModelMap model, @PathVariable("id") String makh, HttpSession session) {
        khoaLopJDBCTemplate.deleteKhoa(makh);
        return "redirect:/department-class.htm";
    }

    @RequestMapping(value = "edit-department", method = RequestMethod.POST)
    public String updateDepartment(ModelMap model, @RequestParam("makh") String makh, 
            @RequestParam("tenkh") String tenkh, HttpSession session) {
        Khoa khoa = khoaLopJDBCTemplate.getKhoa(makh);
        khoa.setTENKH(tenkh);
        khoaLopJDBCTemplate.updateKhoa(makh, khoa);
        return "redirect:/department-class.htm";
    }
}
