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
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;
import ptithcm.bean.SinhVienAction;
import ptithcm.util.IDFix;
import ptithcm.bean.GiaoVien;
import ptithcm.bean.GiaoVienAction;

@Controller
@RequestMapping("teacher")
public class TeacherController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        model.addAttribute("currentSite", session.getAttribute("site"));
        utilJDBCTemplate.setRootDataSource(currentConnection.getRootSite());
        model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());

        giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());
        khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
        List<GiaoVien> giaoViens = giaoVienJDBCTemplate.listGiaoVien();
        List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
        List<Khoa> khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
        khoasDiff.addAll(khoas);
        Map<String, String> khoaMap = new HashMap();
        for (Khoa i : khoasDiff) {
            khoaMap.put(i.getMAKH(), i.getTENKH());
        }
        session.setAttribute("historyAction", new HistoryAction());
        model.addAttribute("idFix", new IDFix());
        model.addAttribute("giaoViens", giaoViens);
        model.addAttribute("khoa", khoaMap);
        model.addAttribute("khoas", khoas);
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/teacher";
    }

    @RequestMapping(value = "get-gv-by-khoa", method = RequestMethod.POST)
    public String getGVByKhoa(ModelMap model, HttpSession session,
            @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        List<GiaoVien> giaoViens;
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<String, String>();
        map = gson.fromJson(body, map.getClass());
        Boolean diff = Boolean.parseBoolean(map.get("diff"));
        String makhoa = map.get("makhoa");
        if (makhoa != null) {
            if (makhoa.equals("all")) {
                if (diff)
                    giaoViens = giaoVienJDBCTemplate.listGiaoVienDiffSite();
                else
                    giaoViens = giaoVienJDBCTemplate.listGiaoVien();
            } else {
                if (diff)
                    giaoViens = giaoVienJDBCTemplate.findTeacherByKhoaDiffSite(makhoa);
                else
                    giaoViens = giaoVienJDBCTemplate.findTeacherByKhoa(makhoa);
            }
        } else {
            throw new NullPointerException("Mã khoa không được để trống!");
        }

        String current = map.get("current");
        List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
        Map<String, String> khoaMap = new HashMap();
        List<Khoa> khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
        khoasDiff.addAll(khoas);
        for (Khoa i : khoasDiff) {
            khoaMap.put(i.getMAKH(), i.getTENKH());
        }
        model.addAttribute("idFix", new IDFix());
        model.addAttribute("current", current);
        model.addAttribute("giaoViens", giaoViens);
        model.addAttribute("khoa", khoaMap);
        model.addAttribute("khoas", khoas);
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "elements/teacher/list";
    }

    @RequestMapping(value = "load-khoa-o", method = RequestMethod.POST)
    public String loadKhoaTable(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String current = map.get("current");
            Boolean diff = Boolean.parseBoolean(map.get("diff"));
            List<Khoa> khoas = null;
            if (diff)
                khoas = khoaLopJDBCTemplate.listKhoaDiffSite();
            else
                khoas = khoaLopJDBCTemplate.listKhoa();
            model.addAttribute("current", current);
            model.addAttribute("khoas", khoas);
        } else {
            model.addAttribute("message", "Không có khoa nào!");
        }

        return "elements/teacher/khoa_option";
    }

    @RequestMapping(value = "load-khoa-t", method = RequestMethod.POST)
    public String loadKhoaOption(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String current = map.get("current");
            Boolean diff = Boolean.parseBoolean(map.get("diff"));
            List<Khoa> khoas = null;
            if (diff)
                khoas = khoaLopJDBCTemplate.listKhoaDiffSite();
            else
                khoas = khoaLopJDBCTemplate.listKhoa();
            model.addAttribute("current", current);
            model.addAttribute("khoas", khoas);
        } else {
            model.addAttribute("message", "Không có khoa nào!");
        }

        return "elements/teacher/khoa_table";
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

    @RequestMapping(value = "move-teacher", method = RequestMethod.POST)
    public String moveStudent(ModelMap model, @RequestParam("magv") String magv,
            @RequestParam("makh") String makh, HttpSession session) {
        try {
            GiaoVien oldGV = giaoVienJDBCTemplate.getTeacher(magv);
            GiaoVien giaoVien = giaoVienJDBCTemplate.getTeacher(magv);
            giaoVien.setMAGV(magv);
            giaoVien.setMAKH(makh);

            giaoVienJDBCTemplate.move(makh, magv, giaoVien);

            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            GiaoVienAction gvAction = new GiaoVienAction("move", giaoVien, oldGV);
            gvAction.setCmd(giaoVienJDBCTemplate);
            historyAction.addAction(gvAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Chuyển khoa thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Chuyển khoa thất bại!");
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

    @RequestMapping(value = "search", method = RequestMethod.POST)
    public String searchTeacher(ModelMap model, HttpSession session, @RequestBody String searchInput) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<String, String>();
        map = gson.fromJson(searchInput, map.getClass());
        searchInput = map.get("searchInput");
        List<GiaoVien> giaoViens = giaoVienJDBCTemplate.search(searchInput);
        List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
        Map<String, String> khoaMap = new HashMap();
        List<Khoa> khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
        khoasDiff.addAll(khoas);
        for (Khoa i : khoasDiff) {
            khoaMap.put(i.getMAKH(), i.getTENKH());
        }
        session.setAttribute("historyAction", new HistoryAction());
        model.addAttribute("idFix", new IDFix());
        model.addAttribute("giaoViens", giaoViens);
        model.addAttribute("khoa", khoaMap);
        model.addAttribute("khoas", khoas);
        model.addAttribute("role_al", currentConnection.getRoleAlias());

        return "elements/teacher/list";
    }
}
