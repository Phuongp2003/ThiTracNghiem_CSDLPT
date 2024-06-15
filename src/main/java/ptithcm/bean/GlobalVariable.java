package ptithcm.bean;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Component;

@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class GlobalVariable {
    private DriverManagerDataSource site;
    private String username;
    private String password;
    private CurrentUser currentUser;

    public class CurrentUser {
        private String username;
        private String fullname;
        private String role;

        public CurrentUser() {
        }

        public CurrentUser(String username, String fullname, String role) {
            this.username = username;
            this.fullname = fullname;
            this.role = role;
        }

        public void setCurrentUser(String username, String fullname, String role) {
            this.username = username;
            this.fullname = fullname;
            this.role = role;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getFullname() {
            return fullname;
        }

        public void setFullname(String fullname) {
            this.fullname = fullname;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }
    }

    public GlobalVariable() {
        this.currentUser = new CurrentUser();
    }

    public GlobalVariable(DriverManagerDataSource site, String username, String password) {
        this.site = site;
        this.username = username;
        this.password = password;
    }

    public DriverManagerDataSource getSite() {
        return site;
    }

    public void setSite(DriverManagerDataSource site) {
        this.site = site;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
        site.setUsername(username);
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
        site.setPassword(password);
    }

    public CurrentUser getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(String username, String fullname, String role) {
        this.currentUser.setCurrentUser(username, fullname, role);
    }
}
