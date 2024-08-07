package ptithcm.controller;

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
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.JDBCtemplate.UtilJDBCTemplate;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.HistoryAction;
import ptithcm.bean.Khoa;
import ptithcm.bean.SinhVienAction;
import ptithcm.util.DateFM;
import ptithcm.bean.Lop;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("student")
public class StudentController {
    @Autowired
    SinhVienJDBCTemplate sinhVienJDBCTemplate;

    @Autowired
    KhoaLopJDBCTemplate khoaLopJDBCTemplate;

    @Autowired
    UtilJDBCTemplate utilJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
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
                List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
                Map<String, String> khoaMap = new HashMap<>();
                for (Khoa i : khoas) {
                    khoaMap.put(i.getMAKH(), i.getTENKH());
                }
                Map<String, String> lopMap = new HashMap<>();
                for (Lop i : lops) {
                    lopMap.put(i.getMALOP(), i.getTENLOP());
                }

                model.addAttribute("currentSite", session.getAttribute("site"));
                utilJDBCTemplate.setRootDataSource(currentConnection.getRootSite());
                model.addAttribute("sites", utilJDBCTemplate.getDSPhanManh());
                model.addAttribute("sinhViens", sinhViens);
                model.addAttribute("lops", lops);
                model.addAttribute("lopMap", lopMap);
                model.addAttribute("khoaMap", khoaMap);
            } else {
                model.addAttribute("in4_message", "Không có sinh viên nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "pages/student";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/get-sv-by-lop", method = RequestMethod.POST)
    public String listByLop(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                sinhVienJDBCTemplate.setDataSource(currentConnection.getSite());
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                List<SinhVien> sinhViens;
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                String malop = map.get("malop");
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                if (malop != null) {
                    if ("all".equals(malop)) {
                        if (diff) {
                            sinhViens = sinhVienJDBCTemplate.listSinhVienDiffSite();
                        } else {
                            sinhViens = sinhVienJDBCTemplate.listSinhVien();
                        }
                    } else {
                        if (diff) {
                            sinhViens = sinhVienJDBCTemplate.findSinhVienByLopDiffSite(malop);
                        } else {
                            sinhViens = sinhVienJDBCTemplate.findSinhVienByLop(malop);
                        }
                    }
                } else {
                    throw new NullPointerException("Mã lớp không được để trống!");
                }
                List<Lop> lops = khoaLopJDBCTemplate.listLop();
                Map<String, String> lopMap = new HashMap<>();
                for (Lop i : lops) {
                    lopMap.put(i.getMALOP(), i.getTENLOP());
                }
                model.addAttribute("sinhViens", sinhViens);
                model.addAttribute("lops", lops);
                model.addAttribute("malop", malop);
                model.addAttribute("lopMap", lopMap);
            } else {
                model.addAttribute("in4_message", "Không có sinh viên nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());
        return "elements/student/student_list";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "load-lop-o", method = RequestMethod.POST)
    public String loadLopTable(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                String current = map.get("current");
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                List<Lop> lops = null;
                if (diff)
                    lops = khoaLopJDBCTemplate.listLopDiffSite();
                else
                    lops = khoaLopJDBCTemplate.listLop();
                model.addAttribute("current", current);
                model.addAttribute("lops", lops);
            } else {
                model.addAttribute("in4_message", "Không có lớp nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }

        return "elements/student/lop_option";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "load-lop-t", method = RequestMethod.POST)
    public String loadKhoaOption(ModelMap model, HttpSession session, @RequestBody String body) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            if (currentConnection != null) {
                khoaLopJDBCTemplate.setDataSource(currentConnection.getSite());
                Gson gson = new Gson();
                Map<String, String> map = new HashMap<String, String>();
                map = gson.fromJson(body, map.getClass());
                String current = map.get("current");
                Boolean diff = Boolean.parseBoolean(map.get("diff"));
                List<Lop> lops = null;
                if (diff)
                    lops = khoaLopJDBCTemplate.listLopDiffSite();
                else
                    lops = khoaLopJDBCTemplate.listLop();

                List<Khoa> khoas = khoaLopJDBCTemplate.listKhoa();
                List<Khoa> khoasDiff = khoaLopJDBCTemplate.listKhoaDiffSite();
                khoasDiff.addAll(khoas);
                Map<String, String> khoaMap = new HashMap<>();
                for (Khoa i : khoasDiff) {
                    khoaMap.put(i.getMAKH(), i.getTENKH());
                }
                model.addAttribute("current", current);
                model.addAttribute("lops", lops);
                model.addAttribute("khoaMap", khoaMap);
            } else {
                model.addAttribute("in4_message", "Không có lớp nào!");
            }
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }

        return "elements/student/lop_list";
    }

    @RequestMapping(value = "add-student", method = RequestMethod.POST)
    public String addStudent(ModelMap model, @RequestParam("masv") String masv,
            @RequestParam("ho") String ho, @RequestParam("ten") String ten,
            @RequestParam("ngaysinh") @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date ngaysinh,
            @RequestParam("diachi") String diachi, @RequestParam("malop") String malop,
            HttpSession session) {
        try {
            SinhVien sv = new SinhVien();
            sv.setMASV(masv);
            sv.setHO(ho);
            sv.setTEN(ten);
            sv.setNGAYSINH(DateFM.UtilToSQL(ngaysinh));
            sv.setDIACHI(diachi);
            sv.setMALOP(malop);
            sv.setMATKHAU(masv);

            sinhVienJDBCTemplate.create(sv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            SinhVienAction svAction = new SinhVienAction("add", sv);
            svAction.setCmd(sinhVienJDBCTemplate);
            historyAction.addAction(svAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Thêm sinh viên thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Thêm sinh viên thất bại! Chi tiết: " + e.getMessage());
        }
        return "elements/message_box";
    }

    @RequestMapping(value = "delete-student/{id}")
    public String deleteStudent(ModelMap model, @PathVariable("id") String masv, HttpSession session) {
        try {
            SinhVien sv = sinhVienJDBCTemplate.getStudent(masv);
            sinhVienJDBCTemplate.delete(masv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            SinhVienAction svAction = new SinhVienAction("delete", sv);
            svAction.setCmd(sinhVienJDBCTemplate);
            historyAction.addAction(svAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Xóa sinh viên thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Xóa sinh viên thất bại! " + e.getMessage());
        }
        return "elements/message_box";
    }

    @RequestMapping(value = "edit-student", method = RequestMethod.POST)
    public String updateStudent(ModelMap model, @RequestParam("masv") String masv,
            @RequestParam("ho") String ho, @RequestParam("ten") String ten,
            @RequestParam("ngaysinh") @DateTimeFormat(pattern = "yyyy-MM-dd") java.util.Date ngaysinh,
            @RequestParam("diachi") String diachi, HttpSession session) {
        try {
            SinhVien oldSv = sinhVienJDBCTemplate.getStudent(masv);
            SinhVien newSv = sinhVienJDBCTemplate.getStudent(masv);
            newSv.setHO(ho);
            newSv.setTEN(ten);
            newSv.setNGAYSINH(DateFM.UtilToSQL(ngaysinh));
            newSv.setDIACHI(diachi);

            sinhVienJDBCTemplate.update(masv, newSv);

            // Save the action in session history
            HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
            SinhVienAction svAction = new SinhVienAction("edit", newSv, oldSv);
            svAction.setCmd(sinhVienJDBCTemplate);
            historyAction.addAction(svAction);
            session.setAttribute("historyAction", historyAction);

            model.addAttribute("ok_message", "Cập nhật sinh viên thành công!");
        } catch (Exception e) {
            model.addAttribute("e_message", "Cập nhật sinh viên thất bại! " + e.getMessage());
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
        return "elements/message_box";
    }

    @RequestMapping(value = "refresh-action-buttons", method = RequestMethod.POST)
    public String refreshActionButtons(ModelMap model, HttpSession session) {
        HistoryAction historyAction = (HistoryAction) session.getAttribute("historyAction");
        model.addAttribute("canUndo", historyAction.canUndo());
        model.addAttribute("canRedo", historyAction.canRedo());
        return "elements/student/button_action_list";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "check-masv", method = RequestMethod.POST)
    public String checkMasvExist(@RequestBody String body, ModelMap model) {
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String masv = map.get("masv");
            Boolean isAvai = sinhVienJDBCTemplate.checkMasv(masv);
            if (!isAvai) {
                return "false";
            }
        } catch (Exception e) {
            model.addAttribute("e_message", "Kiểm tra mã sinh viên thất bại! " + e.getMessage());
            return "elements/message_box";
        }
        return "true";
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "search", method = RequestMethod.POST)
    public String searchStudent(ModelMap model, HttpSession session, @RequestBody String searchInput) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        try {
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(searchInput, map.getClass());
            searchInput = map.get("searchInput");
            List<SinhVien> sinhViens = sinhVienJDBCTemplate.search(searchInput);
            List<Lop> lops = khoaLopJDBCTemplate.listLop();
            Map<String, String> lopMap = new HashMap<>();
            for (Lop i : lops) {
                lopMap.put(i.getMALOP(), i.getTENLOP());
            }
            model.addAttribute("sinhViens", sinhViens);
            model.addAttribute("lops", lops);
            model.addAttribute("lopMap", lopMap);
        } catch (Exception e) {
            model.addAttribute("e_message", e.getMessage());
        }
        model.addAttribute("role_al", currentConnection.getRoleAlias());

        return "elements/student/student_list";
    }
}
