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

import ptithcm.JDBCtemplate.BoDeJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;
import ptithcm.bean.BoDe;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.Khoa;
import ptithcm.bean.Lop;
import ptithcm.bean.MonHoc;
import ptithcm.bean.SinhVien;

@Controller
@RequestMapping("bode")
public class BoDeController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    BoDeJDBCTemplate boDeJDBCTemplate;

    @Autowired
    MonHocJDBCTemplate monHocJDBCTemplate;

    @RequestMapping("")
    public String list(ModelMap model, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            boDeJDBCTemplate.setDataSource(currentConnection.getSite());
            monHocJDBCTemplate.setDataSource(currentConnection.getSite());
            List<BoDe> bodes = boDeJDBCTemplate.listBoDe("TH123");
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("bodes", bodes);
            model.addAttribute("monhocs", monhocs);
        } else {
            model.addAttribute("message", "Không có bộ đề nào!");
        }
        return "pages/bode";
    }

    @RequestMapping(value = "get-bode-by-monhoc", method = RequestMethod.POST)
    public String listByMonHoc(ModelMap model, HttpSession session, @RequestBody String body){
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            boDeJDBCTemplate.setDataSource(currentConnection.getSite());
            List<BoDe> bodes;
            Gson gson = new Gson();
            Map<String, String> map = new HashMap<String, String>();
            map = gson.fromJson(body, map.getClass());
            String mamh = map.get("mamh");
            if (mamh != null) {
                if ("all".equals(mamh)) {
                    bodes = boDeJDBCTemplate.listBoDe("TH123");
                } else {
                    bodes = boDeJDBCTemplate.findBoDeByMonHoc(mamh, "TH123");
                }
            } else {
                throw new NullPointerException("Mã môn học không được để trống!");
            }
            List<MonHoc> monhocs = monHocJDBCTemplate.listMonHoc();
            model.addAttribute("bodes", bodes);
            model.addAttribute("monhocs", monhocs);
            model.addAttribute("mamh", mamh);
        } else {
            model.addAttribute("message", "Không có môn học nào!");
        }
        return "elements/bode/bode_list";
    }
}
