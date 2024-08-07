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

import ptithcm.JDBCtemplate.BoDeJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.BoDe;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.BoDeAction;
import ptithcm.bean.GiaoVien;
import ptithcm.bean.MonHoc;

@Controller
@RequestMapping("bode")
public class BoDeController {
    @Autowired
    BoDeJDBCTemplate boDeJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @Autowired
    GiaoVienJDBCTemplate giaoVienJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                boDeJDBCTemplate.setDataSource(currentConnection.getSite());
                monHocJDBCTemplate.setDataSource(currentConnection.getSite());
                giaoVienJDBCTemplate.setDataSource(currentConnection.getSite());

                // Initialize HistoryAction in session if not present
                session.setAttribute("historyAction", new HistoryAction());

                // Pass history actions to the template for potential undo/redo display
                model.addAttribute("canUndo", ((HistoryAction) session.getAttribute("historyAction")).canUndo());
                model.addAttribute("canRedo", ((HistoryAction) session.getAttribute("historyAction")).canRedo());

                List<BoDe> bodes;
                List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
                if (currentConnection.getRoleAlias().equals("TRUONG") ||
                        currentConnection.getRoleAlias().equals("COSO")) {
                    bodes = boDeJDBCTemplate.listAllBoDe();

                    Map<String, String> giaovienMap = new HashMap<String, String>();
                    for (GiaoVien i : giaoviens) {
                        giaovienMap.put(i.getMAGV(), i.getFullName());
                    }

                    model.addAttribute("giaovienMap", giaovienMap);
                } else
                    bodes = boDeJDBCTemplate.listBoDe(currentConnection.getEmployeeID());

                List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
                HashMap<String, String> monhocMap = new HashMap<String, String>();
                for (MonHoc i : monhocs) {
                    monhocMap.put(i.getMAMH(), i.getTENMH());
                }

                model.addAttribute("currentSite", session.getAttribute("site"));
                utilJDBCTemplate.setRootDataSource(currentConnection.getRootSite());
                model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());
                model.addAttribute("bodes", bodes);
                model.addAttribute("monhocs", monhocs);
                model.addAttribute("giaoviens", giaoviens);
                model.addAttribute("monhocMap", monhocMap);
            } else {
                throw new Exception("Không có kết nối nào!");
            }
            model.addAttribute("role_al", currentConnection.getRoleAlias());
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        return "pages/bode";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "get-bode-by-monhoc", method = RequestMethod.POST)
    public String listByMonHoc(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                boDeJDBCTemplate.setDataSource(currentConnection.getSite());
                List<BoDe> bodes;
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                String mamh = map.get("mamh");
                if (mamh != null) {
                    if ("all".equals(mamh)) {
                        if (currentConnection.getRoleAlias().equals("TRUONG") ||
                                currentConnection.getRoleAlias().equals("COSO")) {
                            bodes = boDeJDBCTemplate.listAllBoDe();
                        } else
                            bodes = boDeJDBCTemplate.listBoDe(currentConnection.getEmployeeID());
                    } else {
                        if (currentConnection.getRoleAlias().equals("TRUONG") ||
                                currentConnection.getRoleAlias().equals("COSO"))
                            bodes = boDeJDBCTemplate.findBoDeByMonHoc(mamh);
                        else
                            bodes = boDeJDBCTemplate.findBoDeByMonHoc(mamh, currentConnection.getEmployeeID());
                    }
                } else {
                    bodes = boDeJDBCTemplate.findBoDeByMonHoc(mamh, currentConnection.getEmployeeID());
                }
                model.addAttribute("mamh", mamh);
                model.addAttribute("bodes", bodes);
            } else {
                throw new NullPointerException("Mã môn học không được để trống!");
            }
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("monhocs", monhocs);
            Map<String, String> monhocMap = new HashMap<>();
            for (MonHoc i : monhocs) {
                monhocMap.put(i.getMAMH(), i.getTENMH());
            }
            List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();
            Map<String, String> giaovienMap = new HashMap<>();
            for (GiaoVien i : giaoviens) {
                giaovienMap.put(i.getMAGV(), i.getFullName());
            }

            model.addAttribute("giaovienMap", giaovienMap);
            model.addAttribute("monhocMap", monhocMap);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());

        return "elements/bode/bode_list";
    }

    @RequestMapping(value = "add-bode", method = RequestMethod.POST)
    public String addBode(ModelMap model, @RequestParam("mamh") String mamh,
            @RequestParam("trinhdo") String trinhdo, @RequestParam("noidung") String noidung,
            @RequestParam("A") String A, @RequestParam("B") String B,
            @RequestParam("C") String C, @RequestParam("D") String D,
            @RequestParam("dapan") String dapan, @RequestParam("magv") String magv,
            HttpSession session) {
        try {
            int maxcauhoi = boDeJDBCTemplate.getMaxCauHoi();
            BoDe bode = new BoDe(maxcauhoi + 1, mamh, trinhdo, noidung, A, B, C, D, dapan, magv);
            boDeJDBCTemplate.create(bode);
            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            BoDeAction bodeAction = new BoDeAction("add", bode);
            bodeAction.setCmd(boDeJDBCTemplate);
            historyAction.addAction(bodeAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Thêm bộ đề thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Thêm bộ đề thất bại! " + e.getMessage());
        }

        return "elements/message_box";
    }

    @RequestMapping(value = "delete-bode/{id}")
    public String deleteBode(ModelMap model, @PathVariable("id") int cauhoi, HttpSession session) {
        try {
            BoDe bode = boDeJDBCTemplate.getBoDe(cauhoi);
            boDeJDBCTemplate.delete(cauhoi);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            BoDeAction bodeAction = new BoDeAction("delete", bode);
            bodeAction.setCmd(boDeJDBCTemplate);
            historyAction.addAction(bodeAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Xóa bộ đề thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Xóa bộ đề thất bại! " + e.getMessage());
        }

        return "elements/message_box";
    }

    @RequestMapping(value = "edit-bode", method = RequestMethod.POST)
    public String updateBode(ModelMap model, @RequestParam("cauhoi") int cauhoi,
            @RequestParam("trinhdo") String trinhdo,
            @RequestParam("noidung") String noidung,
            @RequestParam("A") String A, @RequestParam("B") String B,
            @RequestParam("C") String C, @RequestParam("D") String D,
            @RequestParam("dapan") String dapan, HttpSession session) {
        try {
            BoDe oldBode = boDeJDBCTemplate.getBoDe(cauhoi);
            BoDe newBode = boDeJDBCTemplate.getBoDe(cauhoi);
            newBode.setTRINHDO(trinhdo);
            newBode.setNOIDUNG(noidung);
            newBode.setA(A);
            newBode.setB(B);
            newBode.setC(C);
            newBode.setD(D);
            newBode.setDAP_AN(dapan);
            boDeJDBCTemplate.update(cauhoi, newBode);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            BoDeAction bodeAction = new BoDeAction("edit", newBode, oldBode);
            bodeAction.setCmd(boDeJDBCTemplate);
            historyAction.addAction(bodeAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Cập nhật bộ đề thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Cập nhật bộ đề thất bại!" + e.getMessage());
        }
        return "elements/message_box";
    }

    @RequestMapping(value = "undo", method = RequestMethod.POST)
    public String undo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canUndo()) {
                if (!historyAction.undo()) {
                    throw new Exception("HistoryAction.java báo: Hoàn tác thất bại!");
                }
                model.addAttribute("ok_message", "Hoàn tác thành công!");
            } else {
                model.addAttribute("e_message", "Không có hành động nào để hoàn tác!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", "Hoàn tác thất bại! " + e.getMessage());
        }
        return "elements/message_box";
    }

    @RequestMapping(value = "redo", method = RequestMethod.POST)
    public String redo(ModelMap model, HttpSession session) {
        try {
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            if (historyAction != null && historyAction.canRedo()) {
                historyAction.redo();
                model.addAttribute("ok_message", "Làm lại thành công!");
            } else {
                model.addAttribute("e_message", "Không có hành động nào để làm lại!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", "Làm lại thất bại! " + e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "refresh-action-buttons", method = RequestMethod.POST)
    public String refreshActionButtons(ModelMap model, HttpSession session) {
        HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
        model.addAttribute("canUndo", historyAction.canUndo());
        model.addAttribute("canRedo", historyAction.canRedo());
        return "elements/bode/button_action_list";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "search", method = RequestMethod.POST)
    public String searchBoDe(ModelMap model, HttpSession session, @RequestBody String searchInput) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(searchInput, map.getClass());
            searchInput = map.get("searchInput");
            List<BoDe> bodes = boDeJDBCTemplate.search(searchInput);
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            List<GiaoVien> giaoviens = giaoVienJDBCTemplate.listGiaoVien();

            Map<String, String> monhocMap = new HashMap<>();
            for (MonHoc i : monhocs) {
                monhocMap.put(i.getMAMH(), i.getTENMH());
            }
            Map<String, String> giaovienMap = new HashMap<>();
            for (GiaoVien i : giaoviens) {
                giaovienMap.put(i.getMAGV(), i.getFullName());
            }

            model.addAttribute("bodes", bodes);
            model.addAttribute("monhocs", monhocs);
            model.addAttribute("monhocMap", monhocMap);
            model.addAttribute("giaovienMap", giaovienMap);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());

        return "elements/bode/bode_list";
    }
}
