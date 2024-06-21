package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;

public class LopAction implements Action<Lop>{
    private String type;
    private Lop oldData;
    private Lop data;
    private KhoaLopJDBCTemplate cmd;

    public LopAction() {}
    public LopAction(String type, Lop data) {
        this.type = type;
        this.data = data;
    }

    public LopAction(String type, Lop data, Lop oldData) {
        this.type = type;
        this.data = data;
        this.oldData = oldData;
    }

    public void setCmd(KhoaLopJDBCTemplate cmd) {
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
    public Lop getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(Lop oldData) {
        this.oldData = oldData;
    }

    @Override
    public Lop getData() {
        return data;
    }

    @Override
    public void setData(Lop data) {
        this.data = data;
    }

    @Override
    public Action<Lop> getRevertAction() {
        String revertType;
        LopAction rvAction;
        switch (type) {
            case "add":
                revertType = "delete";
                rvAction = new LopAction(revertType, data);
                break;
            case "delete":
                revertType = "add";
                rvAction = new LopAction(revertType, data);
                break;
            case "edit":
                revertType = "edit";
                rvAction = new LopAction(revertType, oldData, data);
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
                    cmd.createLop(data);
                    break;
                case "delete":
                    cmd.deleteLop(data.getMALOP());
                    break;
                case "edit":
                    cmd.updateLop(data.getMALOP(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("LopAction.java: Thực thi lệnh " + type + " thật bại: " + e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "LopAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}
