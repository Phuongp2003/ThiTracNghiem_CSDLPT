package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.Lop;
import ptithcm.bean.MonHoc;
import ptithcm.bean.MonHocAction;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("subject")
public class SubjectController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());

            // Initialize HistoryAction in session if not present
            session.setAttribute("historyAction", new HistoryAction());

            // Pass history actions to the template for potential undo/redo display
            model.addAttribute("canUndo", ((HistoryAction) session.getAttribute("historyAction")).canUndo());
            model.addAttribute("canRedo", ((HistoryAction) session.getAttribute("historyAction")).canRedo());

            List<MonHoc> monHocs = monHocJDBCTemplate.listMonHoc();
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("monHocs", monHocs);
            model.addAttribute("lops", lops);
        }
        else{
            model.addAttribute("message", "Không có môn học nào!");
        }
        return "pages/subject";
    }

    @RequestMapping(value = "load-subject", method = RequestMethod.POST)
    public String loadSubject(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            List<MonHoc> monHocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("monHocs", monHocs);
        } else {
            model.addAttribute("message", "Không có môn học nào!");
        }

        return "elements/subject/subject_list";
    }

    @RequestMapping(value = "add-subject", method = RequestMethod.POST)
    public String addSubject(ModelMap model, @RequestParam("mamh") String mamh, 
            @RequestParam("tenmh") String tenmh, HttpSession session) {
        try {
            MonHoc monHoc = new MonHoc();
            monHoc.setMAMH(mamh);
            monHoc.setTENMH(tenmh);
            monHocJDBCTemplate.create(monHoc);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            MonHocAction monhocAction = new MonHocAction("add", monHoc);
            monhocAction.setCmd(monHocJDBCTemplate);
            historyAction.addAction(monhocAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm môn học thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm môn học thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return "elements/message";
    }

    @RequestMapping(value = "delete-subject/{id}")
    public String deleteSubject(ModelMap model, @PathVariable("id") String mamh, HttpSession session) {
        try{
            MonHoc monHoc = monHocJDBCTemplate.getMonHoc(mamh);
            monHocJDBCTemplate.delete(mamh);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            MonHocAction monhocAction = new MonHocAction("delete", monHoc);
            monhocAction.setCmd(monHocJDBCTemplate);
            historyAction.addAction(monhocAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Xóa môn học thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Xóa môn học thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        
        return "elements/message";
    }

    @RequestMapping(value = "edit-subject", method = RequestMethod.POST)
    public String updateSubject(ModelMap model, @RequestParam("mamh") String mamh, 
            @RequestParam("tenmh") String tenmh, HttpSession session) {
        try{
            MonHoc oldMonHoc = monHocJDBCTemplate.getMonHoc(mamh);
            MonHoc newMonHoc = monHocJDBCTemplate.getMonHoc(mamh);
            newMonHoc.setTENMH(tenmh);
            monHocJDBCTemplate.update(mamh, newMonHoc);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            MonHocAction monhocAction = new MonHocAction("edit", newMonHoc, oldMonHoc);
            monhocAction.setCmd(monHocJDBCTemplate);
            historyAction.addAction(monhocAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Cập nhật môn học thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Cập nhật môn học thất bại!");
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
                    throw new Exception("HistoryAction.java báo: Hoàn tác thất bại!");
                }
                model.addAttribute("message", "Hoàn tác thành công!");
            } else {
                model.addAttribute("message", "Không có hành động nào để hoàn tác!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "Hoàn tác thất bại!");
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

    @RequestMapping(value = "refresh-action-buttons", method = RequestMethod.POST)
    public String refreshActionButtons(ModelMap model, HttpSession session) {
        HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
        model.addAttribute("canUndo", historyAction.canUndo());
        model.addAttribute("canRedo", historyAction.canRedo());
        return "elements/subject/button_action_list";
    }

    @RequestMapping(value = "search", method = RequestMethod.POST)
    public String searchSubjects(ModelMap model, HttpSession session, @RequestBody String searchInput) {
        Gson gson = new Gson();
        Map<String, String> map = new HashMap<String, String>();
        map = gson.fromJson(searchInput, map.getClass());
        searchInput = map.get("searchInput");
        List<MonHoc> monHocs = monHocJDBCTemplate.search(searchInput);
        List<Lop> lops = khoaLopJDBCTemplate.listLop();
        model.addAttribute("monHocs", monHocs);
        model.addAttribute("lops", lops);

        return "elements/subject/subject_list";
    }

    @RequestMapping(value = "score-subject", method = RequestMethod.POST)
    public String scoreSubject(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("monhocs", monhocs);
            model.addAttribute("lops", lops);
        }
        else{
            model.addAttribute("message", "Không có môn học nào!");
        }
        return "pages/subject";
    }
}
