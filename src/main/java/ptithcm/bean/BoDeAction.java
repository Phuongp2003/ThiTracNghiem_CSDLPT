package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.BoDeJDBCTemplate;
public class BoDeAction implements Action<BoDe>{
    private String type;
    private BoDe oldData;
    private BoDe data;
    private BoDeJDBCTemplate cmd;

    public BoDeAction() {}
    public BoDeAction(String type, BoDe data) {
        this.type = type;
        this.data = data;
    }

    public BoDeAction(String type, BoDe data, BoDe oldData) {
        this.type = type;
        this.data = data;
        this.oldData = oldData;
    }

    public void setCmd(BoDeJDBCTemplate cmd) {
        this.cmd = cmd;
    }

    @Override
    public String getType() {
        return type;
    }

    @Override
    public void setType(String type) {
        this.type = type;
    }

    @Override
    public BoDe getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(BoDe oldData) {
        this.oldData = oldData;
    }

    @Override
    public BoDe getData() {
        return data;
    }

    @Override
    public void setData(BoDe data) {
        this.data = data;
    }

    @Override
    public Action<BoDe> getRevertAction() {
        String revertType;
        BoDeAction rvAction;
        switch (type) {
            case "add":
                revertType = "delete";
                rvAction = new BoDeAction(revertType, data);
                break;
            case "delete":
                revertType = "add";
                rvAction = new BoDeAction(revertType, data);
                break;
            case "edit":
                revertType = "edit";
                rvAction = new BoDeAction(revertType, oldData, data);
                break;
            default:
                return null;
        }
        rvAction.setCmd(cmd);
        return rvAction;
    }

    @Override
    public Boolean execute() {
        try {
            switch (type) {
                case "add":
                    cmd.create(data);
                    break;
                case "delete":
                    cmd.delete(data.getCAUHOI());
                    break;
                case "edit":
                    cmd.update(data.getCAUHOI(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("BoDeAction.java: Thực thi lệnh " + type + " thật bại: " + e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "BoDeAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}
