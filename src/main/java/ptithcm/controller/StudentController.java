package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.FormSubmitEvent.MethodType;

import org.dom4j.rule.Mode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;
import ptithcm.util.IDFix;

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
    public String list(ModelMap model, @RequestParam(value = "malop", required = false, defaultValue = "all") String malop, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<SinhVien> sinhViens;
            if("all".equals(malop)) {
                sinhViens = sinhVienJDBCTemplate.listSinhVien();
            } else{
                sinhViens = sinhVienJDBCTemplate.findSinhVienByLop(malop);
            }
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("sinhViens", sinhViens);
            model.addAttribute("lops", lops);
            model.addAttribute("malop", malop);
        }
        else{
            model.addAttribute("message", "Không có sinh viên nào!");
        }
        return "pages/student";
    }

    @RequestMapping(value = "/get-sv-by-lop", method = RequestMethod.POST)
    public String listByLop(ModelMap model, @RequestParam(value = "malop", required = false, defaultValue = "all") String malop, HttpSession session,
    @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<SinhVien> sinhViens;
            if("all".equals(malop)) {
                sinhViens = sinhVienJDBCTemplate.listSinhVien();
            } else{
                sinhViens = sinhVienJDBCTemplate.findSinhVienByLop(malop);
            }
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("sinhViens", sinhViens);
            model.addAttribute("lops", lops);
            model.addAttribute("malop", malop);
        }
        else{
            model.addAttribute("message", "Không có sinh viên nào!");
        }

        return "elements/student/student_list";
    }

    @RequestMapping(value = "add-student", method = RequestMethod.POST)
    public String addStudent(ModelMap model, @RequestParam("masv") String masv, 
    @RequestParam("ho") String ho, @RequestParam("ten") String ten, 
    @RequestParam("ngaysinh") Date ngaysinh, @RequestParam("diachi") String diachi, 
    @RequestParam("malop") String malop, HttpSession session) {
        SinhVien sv = new SinhVien();
        sv.setMASV(masv);
        sv.setHO(ho);
        sv.setTEN(ten);
        sv.setNGAYSINH(ngaysinh);
        sv.setDIACHI(diachi);
        sv.setMALOP(malop);
        sinhVienJDBCTemplate.create(sv);
        return "redirect:/student.htm";
    }

    @RequestMapping(value = "delete-student/{id}")
    public String deleteStudent(ModelMap model, @PathVariable("id") String masv, HttpSession session){
        sinhVienJDBCTemplate.delete(masv);
        return "redirect:/student.htm";
    }

    @RequestMapping(value = "edit-student/{id}", method = RequestMethod.POST)
    public String updateStudent(ModelMap model, @PathVariable("id") String masv, 
    @RequestParam("ho") String ho, @RequestParam("ten") String ten, 
    @RequestParam("ngaysinh") Date ngaysinh, @RequestParam("diachi") String diachi, 
    @RequestParam("malop") String malop, HttpSession session){
        SinhVien sv = new SinhVien();
        sv = sinhVienJDBCTemplate.getStudent(masv);
        sinhVienJDBCTemplate.update(masv, sv);
        return "redirect:/student.htm";
    }
}
