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

import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.Khoa;
import ptithcm.bean.KhoaAction;
import ptithcm.bean.Lop;
import ptithcm.bean.LopAction;

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

            // Initialize HistoryAction in session if not present
            session.setAttribute("historyAction", new HistoryAction());

            // Pass history actions to the template for potential undo/redo display
            model.addAttribute("canUndo", ((HistoryAction) session.getAttribute("historyAction")).canUndo());
            model.addAttribute("canRedo", ((HistoryAction) session.getAttribute("historyAction")).canRedo());

            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            model.addAttribute("khoas", khoas);
            model.addAttribute("lops", lops);
        } else {
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

    @RequestMapping(value = "load-khoa", method = RequestMethod.POST)
    public String loadKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            model.addAttribute("khoas", khoas);
        } else {
            model.addAttribute("message", "Không có khoa nào!");
        }

        return "elements/khoalop/khoa_list";
    }

    @RequestMapping(value = "load-rf-khoa", method = RequestMethod.POST)
    public String loadRfKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            model.addAttribute("khoas", khoas);
        } else {
            model.addAttribute("message", "Không có khoa nào!");
        }

        return "elements/khoalop/khoa_rf_list";
    }

    @RequestMapping(value = "add-class", method = RequestMethod.POST)
    public String addClass(ModelMap model, @RequestParam("malop") String malop,
            @RequestParam("tenlop") String tenlop, @RequestParam("makh") String makh,
            HttpSession session) {
        try {
            Lop lop = new Lop();
            lop.setMALOP(malop);
            lop.setTENLOP(tenlop);
            lop.setMAKH(makh);
            khoaLopJDBCTemplate.createLop(lop);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            LopAction lopAction = new LopAction("add", lop);
            lopAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(lopAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm lớp thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm lớp thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return "elements/message";
    }

    @RequestMapping(value = "delete-class/{id}")
    public String deleteClass(ModelMap model, @PathVariable("id") String malop, HttpSession session) {
        try {
            Lop lop = khoaLopJDBCTemplate.getLop(malop);
            khoaLopJDBCTemplate.deleteLop(malop);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            LopAction lopAction = new LopAction("delete", lop);
            lopAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(lopAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Xóa lớp thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Xóa lớp thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

        return "elements/message";
    }

    @RequestMapping(value = "edit-class", method = RequestMethod.POST)
    public String updateClass(ModelMap model, @RequestParam("malop") String malop,
            @RequestParam("tenlop") String tenlop, HttpSession session) {
        try {
            Lop oldLop = khoaLopJDBCTemplate.getLop(malop);
            Lop newLop = khoaLopJDBCTemplate.getLop(malop);
            newLop.setTENLOP(tenlop);
            khoaLopJDBCTemplate.updateLop(malop, newLop);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            LopAction lopAction = new LopAction("edit", newLop, oldLop);
            lopAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(lopAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Cập nhật lớp thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Cập nhật lớp thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "add-department", method = RequestMethod.POST)
    public String addDepartment(ModelMap model, @RequestParam("makh") String makh,
            @RequestParam("tenkh") String tenkh,
            HttpSession session) {
        try {
            Khoa khoa = new Khoa();
            khoa.setMAKH(makh);
            khoa.setTENKH(tenkh);
            khoa.setMACS("CS1");
            khoaLopJDBCTemplate.createKhoa(khoa);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            KhoaAction khoaAction = new KhoaAction("add", khoa);
            khoaAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(khoaAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm khoa thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm khoa thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "delete-department/{id}")
    public String deleteDepartment(ModelMap model, @PathVariable("id") String makh, HttpSession session) {
        try {
            Khoa khoa = khoaLopJDBCTemplate.getKhoa(makh);
            khoaLopJDBCTemplate.deleteKhoa(makh);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            KhoaAction khoaAction = new KhoaAction("delete", khoa);
            khoaAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(khoaAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Xóa khoa thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Xóa khoa thất bại!");
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "edit-department", method = RequestMethod.POST)
    public String updateDepartment(ModelMap model, @RequestParam("makh") String makh,
            @RequestParam("tenkh") String tenkh, HttpSession session) {
        try {
            Khoa oldKhoa = khoaLopJDBCTemplate.getKhoa(makh);
            Khoa newKhoa = new Khoa();
            Khoa khoa = khoaLopJDBCTemplate.getKhoa(makh);
            khoa.setTENKH(tenkh);
            khoaLopJDBCTemplate.updateKhoa(makh, khoa);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            KhoaAction khoaAction = new KhoaAction("edit", newKhoa, oldKhoa);
            khoaAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(khoaAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Cập nhật khoa thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Cập nhật khoa thất bại!");
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
        return "elements/khoalop/button_action_list";
    }
}
