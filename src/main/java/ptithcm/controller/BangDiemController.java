package ptithcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import ptithcm.JDBCtemplate.BangDiemJDBCTemplate;
import ptithcm.JDBCtemplate.BoDeJDBCTemplate;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;
import ptithcm.bean.BangDiem;
import ptithcm.bean.BoDe;
import ptithcm.bean.GlobalVariable;
import ptithcm.bean.MonHoc;

@Controller
@RequestMapping("score-list")
public class BangDiemController {
    @Autowired
    private GlobalVariable currentConnection;

    @Autowired
    BangDiemJDBCTemplate bangDiemJDBCTemplate;

    @RequestMapping(value = "", method = RequestMethod.POST)
    public String list(ModelMap model, @RequestParam("malop") String malop,
            @RequestParam("mamh") String mamh, @RequestParam("lanthi") int lanthi, HttpSession session) {
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");
        if (currentConnection != null) {
            bangDiemJDBCTemplate.setDataSource(currentConnection.getSite());
            List<List<String>> bangdiems = bangDiemJDBCTemplate.listBangDiem(malop, mamh, lanthi);
            model.addAttribute("bangdiems", bangdiems);
        } else {
            model.addAttribute("message", "Không có bảng điểm nào!");
        }
        return "pages/score_subject";
    }
}
