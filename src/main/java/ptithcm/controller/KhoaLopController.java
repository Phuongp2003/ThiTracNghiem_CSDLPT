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
import ptithcm.JDBCtemplate.CoSoJDBCTemplate;
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.CoSo;
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
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    CoSoJDBCTemplate coSoJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                coSoJDBCTemplate.setDataSource(currentConnection.getSite());
                // Initialize HistoryAction in session if not present
                session.setAttribute("historyAction", new HistoryAction());

                // Pass history actions to the template for potential undo/redo display
                model.addAttribute("canUndo", ((HistoryAction) session.getAttribute("historyAction")).canUndo());
                model.addAttribute("canRedo", ((HistoryAction) session.getAttribute("historyAction")).canRedo());

                List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
                List<Khoa> khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
                khoasDiff.addAll(khoas);
                Map<String, String> khoaMap = new HashMap<>();
                for (Khoa i : khoasDiff) {
                    khoaMap.put(i.getMAKH(), i.getTENKH());
                }
                List<Lop> lops = khoaLopJDBCTemplate.listLop();
                List<CoSo> cosos = coSoJDBCTemplate.listCoSo();
                Map<String, String> cosoMap = new HashMap<>();
                for (CoSo i : cosos) {
                    cosoMap.put(i.getMACS(), i.getTENCS());
                }

                model.addAttribute("currentSite", session.getAttribute("site"));
                utilJDBCTemplate.setRootDataSource(currentConnection.getRootSite());
                model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());
                model.addAttribute("khoas", khoas);
                model.addAttribute("lops", lops);
                model.addAttribute("khoaMap", khoaMap);
                model.addAttribute("cosoMap", cosoMap);
            } else {
                model.addAttribute("message", "Không có khoa nào!");
            }
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/khoalop";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/get-lop-by-khoa", method = RequestMethod.POST)
    public String listByKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                List<Lop> lops;
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                String makh = map.get("makh");
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                if (makh != null) {
                    if ("all".equals(makh)) {
                        if (diff)
                            lops = khoaLopJDBCTemplate.listLopDiffSite();
                        else
                            lops = khoaLopJDBCTemplate.listLop();
                    } else {
                        if (diff)
                            lops = khoaLopJDBCTemplate.findLopByKhoaDiffSite(makh);
                        else
                            lops = khoaLopJDBCTemplate.findLopByKhoa(makh);
                    }
                } else {
                    throw new NullPointerException("Mã khoa không được để trống!");
                }
                List<Khoa> khoas = null;
                List<Khoa> khoasDiff = null;
                if (diff) {
                    khoas = khoaLopJDBCTemplate.listKhoaDiffSite();
                    khoasDiff = khoaLopJDBCTemplate.listKhoa();
                } else {
                    khoas = khoaLopJDBCTemplate.listKhoa();
                    khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
                }
                khoasDiff.addAll(khoas);
                Map<String, String> khoaMap = new HashMap<>();
                for (Khoa i : khoasDiff) {
                    khoaMap.put(i.getMAKH(), i.getTENKH());
                }

                model.addAttribute("lops", lops);
                model.addAttribute("khoas", khoas);
                model.addAttribute("makh", makh);
                model.addAttribute("khoaMap", khoaMap);
                model.addAttribute("role_al", currentConnection.getRoleAlias());
            } else {
                model.addAttribute("message", "Không có khoa nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }

        return "elements/khoalop/lop_list";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "load-khoa", method = RequestMethod.POST)
    public String loadKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                coSoJDBCTemplate.setDataSource(currentConnection.getSite());
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                List<Khoa> khoas = null;
                if (diff)
                    khoas = khoaLopJDBCTemplate.listKhoaDiffSite();
                else
                    khoas = khoaLopJDBCTemplate.listKhoa();
                
                List<CoSo> cosos = coSoJDBCTemplate.listCoSo();
                Map<String, String> cosoMap = new HashMap<>();
                for (CoSo i : cosos) {
                    cosoMap.put(i.getMACS(), i.getTENCS());
                }
                model.addAttribute("khoas", khoas);
                model.addAttribute("cosoMap", cosoMap);
                model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());
                model.addAttribute("role_al", currentConnection.getRoleAlias());
            } else {
                model.addAttribute("message", "Không có khoa nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }

        return "elements/khoalop/khoa_list";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "load-rf-khoa", method = RequestMethod.POST)
    public String loadRfKhoa(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                List<Khoa> khoas = null;
                if (diff)
                    khoas = khoaLopJDBCTemplate.listKhoaDiffSite();
                else
                    khoas = khoaLopJDBCTemplate.listKhoa();

                List<CoSo> cosos = coSoJDBCTemplate.listCoSo();
                Map<String, String> cosoMap = new HashMap<>();
                for (CoSo i : cosos) {
                    cosoMap.put(i.getMACS(), i.getTENCS());
                }
                model.addAttribute("khoas", khoas);
                model.addAttribute("cosoMap", cosoMap);
            } else {
                model.addAttribute("message", "Không có khoa nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
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
            model.addAttribute("message", "Thêm lớp thất bại! " + e.getMessage());

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
            model.addAttribute("message", "Xóa lớp thất bại!" + e.getMessage());
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
            model.addAttribute("message", "Cập nhật lớp thất bại! " + e.getMessage());
        }
        return "elements/message";
    }

    @RequestMapping(value = "add-department", method = RequestMethod.POST)
    public String addDepartment(ModelMap model, @RequestParam("makh") String makh,
            @RequestParam("tenkh") String tenkh,
            HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            Khoa khoa = new Khoa();
            khoa.setMAKH(makh);
            khoa.setTENKH(tenkh);
            khoa.setMACS(currentConnection.getSite_al());
            khoaLopJDBCTemplate.createKhoa(khoa);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            KhoaAction khoaAction = new KhoaAction("add", khoa);
            khoaAction.setCmd(khoaLopJDBCTemplate);
            historyAction.addAction(khoaAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("message", "Thêm khoa thành công!");
        } catch (Exception e) {
            model.addAttribute("message", "Thêm khoa thất bại! " + e.getMessage());
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
            model.addAttribute("message", "Xóa khoa thất bại! " + e.getMessage());
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
            model.addAttribute("message", "Cập nhật khoa thất bại! " + e.getMessage());
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
            model.addAttribute("message", "Hoàn tác thất bại! " + e.getMessage());
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
            model.addAttribute("message", "Làm lại thất bại! " + e.getMessage());
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

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "check-malop", method = RequestMethod.POST)
    public String checkMalop(@RequestBody String body, ModelMap modal) {
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String malop = map.get("malop");
            if (malop == null || malop.isEmpty()) {
                return "false";
            }
            Boolean isAvai = khoaLopJDBCTemplate.checkMalop(malop);
            if (!isAvai) {
                return "false";
            }
        } catch (Exception e) {
            // Need parse to new view
            modal.addAttribute("message", e.getMessage());
            return "elements/message";
        }
        return "true";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "check-makh", method = RequestMethod.POST)
    public String checkmakh(@RequestBody String body, ModelMap modal) {
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String makh = map.get("makh");
            if (makh == null || makh.isEmpty()) {
                return "false";
            }
            Boolean isAvai = khoaLopJDBCTemplate.checkMakh(makh);
            if (!isAvai) {
                return "false";
            }
        } catch (Exception e) {
            modal.addAttribute("message", e.getMessage());
            return "elements/message";
        }
        return "true";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "search", method = RequestMethod.POST)
    public String searchLop(ModelMap model, HttpSession session, @RequestBody String searchInput) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(searchInput, map.getClass());
            searchInput = map.get("searchInput");
            List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
            List<Lop> lops = khoaLopJDBCTemplate.search(searchInput);
            Map<String, String> khoaMap = new HashMap<>();
            for (Khoa i : khoas) {
                khoaMap.put(i.getMAKH(), i.getTENKH());
            }
            model.addAttribute("khoas", khoas);
            model.addAttribute("lops", lops);
            model.addAttribute("khoaMap", khoaMap);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());

        return "elements/khoalop/lop_list";
    }
}
