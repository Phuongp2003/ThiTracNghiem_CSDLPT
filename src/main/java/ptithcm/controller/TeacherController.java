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

import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.Khoa;
import ptithcm.util.IDFix;
import ptithcm.bean.GiaoVien;
import ptithcm.bean.GiaoVienAction;

@Controller
@RequestMapping("teacher")
public class TeacherController {
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
            session.setAttribute("historyAction", new HistoryAction());
            model.addAttribute("idFix", new IDFix());
            model.addAttribute("giaoViens", giaoViens);
            model.addAttribute("khoa", khoaMap);
            model.addAttribute("khoas", khoas);
        } else {
            model.addAttribute("message", "Không có giáo viên nào!");
        }
        return "pages/teacher";
    }

    @RequestMapping(value = "get-gv-by-khoa", method = RequestMethod.POST)
    public String getGVByKhoa(ModelMap model, HttpSession session,
            @RequestBody String body) {
        List<GiaoVien> giaoViens;
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<String, String>();
        map = gson.fromJson(body, map.getClass());
        String makhoa = map.get("makhoa");
        if (makhoa != null) {
            if (makhoa.equals("all")) {
                giaoViens = giaoVienJDBCTemplate.listGiaoVien();
            } else {
                giaoViens = giaoVienJDBCTemplate.getGVByKhoa(makhoa);
            }
        } else {
            throw new NullPointerException("Mã khoa không được để trống!");
        }

        List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
        Map<String, String> khoaMap = new HashMap();
        for (Khoa i : khoas) {
            khoaMap.put(i.getMAKH(), i.getTENKH());
        }
        model.addAttribute("idFix", new IDFix());
        model.addAttribute("giaoViens", giaoViens);
        model.addAttribute("khoa", khoaMap);
        model.addAttribute("khoas", khoas);
        return "elements/teacher/list";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String add(ModelMap model, HttpSession session,
            @RequestParam("manv") String manv,
            @RequestParam("ho") String ho,
            @RequestParam("ten") String ten,
            @RequestParam("diachi") String diachi,
            @RequestParam("makhoa") String makhoa) {
        try {
            GiaoVien giaoVien = new GiaoVien(manv, ho, ten, diachi, makhoa);

            giaoVienJDBCTemplate.create(giaoVien);

            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            GiaoVienAction gvAction = new GiaoVienAction("add", giaoVien);
            gvAction.setCmd(giaoVienJDBCTemplate);
            historyAction.addAction(gvAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm giáo viên thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm giáo viên thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String update(ModelMap model, HttpSession session,
            @RequestParam("manv") String manv,
            @RequestParam("ho") String ho,
            @RequestParam("ten") String ten,
            @RequestParam("diachi") String diachi) {
        try {
            GiaoVien oldGV = giaoVienJDBCTemplate.getTeacher(manv);
            GiaoVien giaoVien = giaoVienJDBCTemplate.getTeacher(manv);
            giaoVien.setHO(ho);
            giaoVien.setTEN(ten);
            giaoVien.setDIACHI(diachi);

            giaoVienJDBCTemplate.update(manv, giaoVien);

            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            GiaoVienAction gvAction = new GiaoVienAction("edit", giaoVien, oldGV);
            gvAction.setCmd(giaoVienJDBCTemplate);
            historyAction.addAction(gvAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Cập nhật giáo viên thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Cập nhật giáo viên thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "delete/{id}", method = RequestMethod.POST)
    public String delete(ModelMap model, HttpSession session,
            @PathVariable("id") String manv) {
        try {
            GiaoVien giaoVien = giaoVienJDBCTemplate.getTeacher(manv);

            giaoVienJDBCTemplate.delete(manv);

            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            GiaoVienAction gvAction = new GiaoVienAction("delete", giaoVien);
            gvAction.setCmd(giaoVienJDBCTemplate);
            historyAction.addAction(gvAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Xóa giáo viên thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Xóa giáo viên thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "undo", method = RequestMethod.POST)
    public String undo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canUndo()) {
                if (!historyAction.undo()) {
                    throw new Exception("HistoryAction báo: Hoàn tác thất bại!");
                }
                model.addAttribute("message", "Hoàn tác thành công!");
            } else
                model.addAttribute("message", "Không có hành động nào để hoàn tác!");
        } catch (Exception e) {
            model.addAttribute("message", "Hoàn tác thất bại!");
            e.printStackTrace();
            System.out.println("TeacherController.java: Hoàn tác thất bại:  " + e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "redo", method = RequestMethod.POST)
    public String redo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canRedo()) {
                if (!historyAction.redo()) {
                    throw new Exception("HistoryAction báo: Làm lại thất bại!");
                }
                model.addAttribute("message", "Làm lại thành công!");
            } else
                model.addAttribute("message", "Không có hành động nào để làm lại!");
        } catch (Exception e) {
            model.addAttribute("message", "Làm lại thất bại!");
            e.printStackTrace();
            System.out.println("TeacherController.java: Làm lại thất bại:  " + e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "refresh-action-buttons", method = RequestMethod.POST)
    public String refreshActionButtons(ModelMap model, HttpSession session) {
        HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
        model.addAttribute("canUndo", historyAction.canUndo());
        model.addAttribute("canRedo", historyAction.canRedo());
        return "elements/teacher/button_action_list";
    }
}
