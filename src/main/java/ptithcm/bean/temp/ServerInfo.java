package ptithcm.bean.temp;

public class ServerInfo {
    private String tenServer;
    private String tenCS;

    public ServerInfo(String tenServer, String tenCS) {
        this.tenServer = tenServer;
        this.tenCS = tenCS;
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
}
