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

    public GlobalVariable() {
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
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
