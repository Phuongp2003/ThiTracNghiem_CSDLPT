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
import ptithcm.bean.HistoryAction;
import ptithcm.bean.SinhVienAction;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("student")
public class StudentController {
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

            // Initialize HistoryAction in session if not present
            session.setAttribute("historyAction", new HistoryAction());

            // Pass history actions to the template for potential undo/redo display
            model.addAttribute("canUndo", ((HistoryAction) session.getAttribute("historyAction")).canUndo());
            model.addAttribute("canRedo", ((HistoryAction) session.getAttribute("historyAction")).canRedo());

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
        try {
            SinhVien sv = new SinhVien();
            sv.setMASV(masv);
            sv.setHO(ho);
            sv.setTEN(ten);
            sv.setNGAYSINH(ngaysinh);
            sv.setDIACHI(diachi);
            sv.setMALOP(malop);
            sv.setMATKHAU(masv);

            sinhVienJDBCTemplate.create(sv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            historyAction.addAction(new SinhVienAction("create", sv));
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm sinh viên thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm sinh viên thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "delete-student/{id}")
    public String deleteStudent(ModelMap model, @PathVariable("id") String masv, HttpSession session) {
        try {
            SinhVien sv = sinhVienJDBCTemplate.getStudent(masv);
            sinhVienJDBCTemplate.delete(masv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            historyAction.addAction(new SinhVienAction("delete", sv));
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Xóa sinh viên thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Xóa sinh viên thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "edit-student", method = RequestMethod.POST)
    public String updateStudent(ModelMap model, @RequestParam("masv") String masv,
            @RequestParam("ho") String ho, @RequestParam("ten") String ten,
            @RequestParam("ngaysinh") @DateTimeFormat(pattern = "yyyy-MM-dd") Date ngaysinh,
            @RequestParam("diachi") String diachi, HttpSession session) {
        try {
            SinhVien oldSv = sinhVienJDBCTemplate.getStudent(masv);
            SinhVien newSv = new SinhVien();
            newSv.setMASV(masv);
            newSv.setHO(ho);
            newSv.setTEN(ten);
            newSv.setNGAYSINH(ngaysinh);
            newSv.setDIACHI(diachi);

            sinhVienJDBCTemplate.update(masv, newSv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            historyAction.addAction(new SinhVienAction("update", oldSv, newSv));
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Cập nhật sinh viên thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Cập nhật sinh viên thất bại!");
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "undo", method = RequestMethod.POST)
    public String undo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canUndo()) {
                historyAction.undo();
                model.addAttribute("message", "Hoàn tác thành công!");
            } else {
                model.addAttribute("message", "Không có hành động nào để hoàn tác!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Hoàn tác thất bại!");
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "redo", method = RequestMethod.POST)
    public String redo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canRedo()) {
                historyAction.redo();
                model.addAttribute("message", "Làm lại thành công!");
            } else {
                model.addAttribute("message", "Không có hành động nào để làm lại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Làm lại thất bại!");
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }
}
