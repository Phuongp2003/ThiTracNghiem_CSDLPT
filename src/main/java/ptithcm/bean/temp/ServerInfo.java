package ptithcm.bean.temp;

public class ServerInfo {
    private String tenServer;
    private String tenCS;
    private String tenCS_s;

    public ServerInfo(String tenServer, String tenCS) {
        this.tenServer = tenServer;
        this.tenCS = tenCS;
    }

    public ServerInfo(String tenServer, String tenCS, String tenCS_s) {
        this.tenServer = tenServer;
        this.tenCS = tenCS;
        this.tenCS_s = tenCS_s;
    }

    public String getTenServer() {
        return tenServer;
    }

    public void setTenServer(String tenServer) {
        this.tenServer = tenServer;
    }

    public String getTenCS() {
        return tenCS;
    }

    public void setTenCS(String tenCS) {
        this.tenCS = tenCS;
    }

    public String getTenCS_s() {
        return tenCS_s;
    }

    public void setTenCS_s(String tenCS_s) {
        this.tenCS_s = tenCS_s;
    }
}
