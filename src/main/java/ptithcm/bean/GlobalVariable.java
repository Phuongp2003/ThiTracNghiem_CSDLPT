package ptithcm.bean;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Component;

@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class GlobalVariable {
    private DriverManagerDataSource rootSite;
    private DriverManagerDataSource site;
    private JdbcTemplate root_cmd;
    private JdbcTemplate cmd;
    private CurrentUser currentUser;

    public class CurrentUser {
        private String loginName;
        private String fullname;
        private String password;
        private String role;
        private String roleAlias;
        private String userName;

        // Employee ID
        private String e_id;

        private String site_al;

        public CurrentUser() {
        }

        public CurrentUser(String loginName, String fullname, String role) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            this.userName = loginName;
        }

        public CurrentUser(String loginName, String fullname, String role, String roleAlias) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            this.roleAlias = roleAlias;
            this.userName = loginName;
        }

        public CurrentUser(String loginName, String fullname, String role, String uid, String roleAlias, boolean is_e) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            this.roleAlias = roleAlias;
            if (is_e) {
                this.e_id = uid;
                this.userName = loginName;
            } else {
                this.userName = uid;
            }
        }

        public void setCurrentUser(String loginName, String fullname, String role) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            this.userName = loginName;
        }

        public void setCurrentUser(String loginName, String fullname, String role, String roleAlias) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            this.roleAlias = roleAlias;
            this.userName = loginName;
        }

        public void setCurrentUser(String loginName, String fullname, String role, String uid, String roleAlias,
                boolean is_e) {
            this.loginName = loginName;
            this.fullname = fullname;
            this.role = role;
            if (is_e) {
                this.e_id = uid;
                this.userName = loginName;
            } else {
                this.userName = uid;
            }
            this.roleAlias = roleAlias;
        }

        public String getLoginName() {
            return loginName;
        }

        public void setLoginName(String loginName) {
            this.loginName = loginName;
        }

        public String getFullname() {
            return fullname;
        }

        public void setFullname(String fullname) {
            this.fullname = fullname;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public String getRoleAlias() {
            return roleAlias;
        }

        public void setRoleAlias(String roleAlias) {
            this.roleAlias = roleAlias;
        }

        public String getUserName() {
            return userName;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }
    }

    public GlobalVariable() {
        this.currentUser = new CurrentUser();
    }

    public GlobalVariable(DriverManagerDataSource site, String loginName, String password) {
        this.site = site;
        this.currentUser.loginName = loginName;
        this.currentUser.password = password;
    }

    public DriverManagerDataSource getSite() {
        return site;
    }

    public void setSite(DriverManagerDataSource site) {
        this.site = site;
    }

    public DriverManagerDataSource getRootSite() {
        return rootSite;
    }

    public void setRootSite(DriverManagerDataSource rootSite) {
        this.rootSite = rootSite;
    }

    public void setRoot_cmd(JdbcTemplate root_cmd) {
        this.root_cmd = root_cmd;
    }

    public JdbcTemplate getRoot_cmd() {
        return root_cmd;
    }

    public JdbcTemplate getCmd() {
        return cmd;
    }

    public void setCmd(JdbcTemplate cmd) {
        this.cmd = cmd;
    }

    public String getLoginName() {
        return currentUser.getLoginName();
    }

    public void setLoginName(String loginName) {
        this.currentUser.setLoginName(loginName);
        site.setUsername(loginName);
    }

    public String getPassword() {
        return currentUser.getPassword();
    }

    public void setPassword(String password) {
        this.currentUser.setPassword(password);
        site.setPassword(password);
    }

    public String getFullname() {
        return currentUser.getFullname();
    }

    public void setFullname(String fullname) {
        this.currentUser.setFullname(fullname);
    }

    public String getRole() {
        return currentUser.getRole();
    }

    public void setRole(String role) {
        this.currentUser.setRole(role);
    }

    public String getRoleAlias() {
        return currentUser.getRoleAlias();
    }

    public void setRoleAlias(String roleAlias) {
        this.currentUser.setRoleAlias(roleAlias);
    }

    public String getUserName() {
        return currentUser.getUserName();
    }

    public void setUserName(String userName) {
        this.currentUser.setUserName(userName);
    }

    public String getEmployeeID() {
        return currentUser.e_id;
    }

    public void setEmployeeID(String e_id) {
        this.currentUser.e_id = e_id;
    }

    public CurrentUser getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(String loginName, String fullname, String role) {
        this.currentUser.setCurrentUser(loginName, fullname, role);
    }

    public void setCurrentUser(String loginName, String fullname, String role, String roleAlias) {
        this.currentUser.setCurrentUser(loginName, fullname, role, roleAlias);
    }

    public void setCurrentUser(String loginName, String fullname, String role, String uid, String roleAlias,
            boolean is_e) {
        this.currentUser.setCurrentUser(loginName, fullname, role, uid, roleAlias, is_e);
    }

    public String getSite_al() {
        return currentUser.site_al;
    }

    public void setSite_al(String site_al) {
        this.currentUser.site_al = site_al;
    }
}
