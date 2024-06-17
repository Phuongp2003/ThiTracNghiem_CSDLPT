package ptithcm.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ptithcm.bean.GlobalVariable;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private JdbcTemplate mainSiteTemplate;

    @Autowired
    private DriverManagerDataSource mainSite;

    @Resource(name = "dodgedPatterns")
    private List<String> dodgedPatterns;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        GlobalVariable currentConnection = (GlobalVariable) session.getAttribute("currentConnection");

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        for (String pattern : dodgedPatterns) {
            if (requestURI.startsWith(contextPath + pattern)) {
                return true;
            }
        }

        if (currentConnection == null) {
            currentConnection = new GlobalVariable();
            currentConnection.setSite(mainSite);
            currentConnection.setCmd(mainSiteTemplate);
            session.setAttribute("currentConnection", currentConnection);
        }

        if (currentConnection.getUsername() == null) {
            response.sendRedirect(contextPath + "/auth/login.htm");
            return false;
        }
        return true;
    }
}
