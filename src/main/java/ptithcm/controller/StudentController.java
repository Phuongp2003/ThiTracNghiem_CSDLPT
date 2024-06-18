package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

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
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("student")
public class StudentController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<SinhVien> sinhViens = sinhVienJDBCTemplate.listSinhVien();
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("sinhViens", sinhViens);
            model.addAttribute("lops", lops);
        } else {
            model.addAttribute("message", "Không có sinh viên nào!");
        }
        return "pages/student";
    }

    @RequestMapping(value = "/get-sv-by-lop", method = RequestMethod.POST)
    public String listByLop(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<SinhVien> sinhViens;
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String malop = map.get("malop");
            if (malop != null) {
                if ("all".equals(malop)) {
                    sinhViens = sinhVienJDBCTemplate.listSinhVien();
                } else {
                    sinhViens = sinhVienJDBCTemplate.findSinhVienByLop(malop);
                }
            } else {
                throw new NullPointerException("Mã lớp không được để trống!");
            }
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("sinhViens", sinhViens);
            model.addAttribute("lops", lops);
            model.addAttribute("malop", malop);
        } else {
            model.addAttribute("message", "Không có sinh viên nào!");
        }

        return "elements/student/student_list";
    }

    @RequestMapping(value = "add-student", method = RequestMethod.POST)
    public String addStudent(ModelMap model, @RequestParam("masv") String masv,
            @RequestParam("ho") String ho, @RequestParam("ten") String ten,
            @RequestParam("ngaysinh") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaysinh,
            @RequestParam("diachi") String diachi, @RequestParam("malop") String malop, 
            HttpSession session) {
        SinhVien sv = new SinhVien();
        sv.setMASV(masv);
        sv.setHO(ho);
        sv.setTEN(ten);
        sv.setNGAYSINH(ngaysinh);
        sv.setDIACHI(diachi);
        sv.setMALOP(malop);
        sv.setMATKHAU(masv);
        sinhVienJDBCTemplate.create(sv);
        return "redirect:/student.htm";
    }

    @RequestMapping(value = "delete-student/{id}")
    public String deleteStudent(ModelMap model, @PathVariable("id") String masv, HttpSession session) {
        sinhVienJDBCTemplate.delete(masv);
        return "redirect:/student.htm";
    }

    @RequestMapping(value = "edit-student", method = RequestMethod.POST)
    public String updateStudent(ModelMap model, @RequestParam("masv") String masv,
            @RequestParam("ho") String ho, @RequestParam("ten") String ten,
            @RequestParam("ngaysinh") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaysinh, 
            @RequestParam("diachi") String diachi, HttpSession session) {
        SinhVien sv = sinhVienJDBCTemplate.getStudent(masv);
        sv.setHO(ho);
        sv.setTEN(ten);
        sv.setNGAYSINH(ngaysinh); 
        sv.setDIACHI(diachi);
        sinhVienJDBCTemplate.update(masv, sv);
        return "redirect:/student.htm";
    }
}
