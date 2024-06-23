package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.MonHocJDBCTemplate;

public class MonHocAction implements Action<MonHoc>{
    private String type;
    private MonHoc oldData;
    private MonHoc data;
    private MonHocJDBCTemplate cmd;

    public MonHocAction(){}
    public MonHocAction(String type, MonHoc data) {
        this.type = type;
        this.data = data;
    }

    public MonHocAction(String type, MonHoc data, MonHoc oldData) {
        this.type = type;
        this.data = data;
        this.oldData = oldData;
    }

    public void setCmd(MonHocJDBCTemplate cmd) {
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
    public MonHoc getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(MonHoc oldData) {
        this.oldData = oldData;
    }

    @Override
    public MonHoc getData() {
        return data;
    }

    @Override
    public void setData(MonHoc data) {
        this.data = data;
    }

    @Override
    public Action<MonHoc> getRevertAction() {
        String revertType;
        MonHocAction rvAction;
        switch (type) {
            case "add":
                revertType = "delete";
                rvAction = new MonHocAction(revertType, data);
                break;
            case "delete":
                revertType = "add";
                rvAction = new MonHocAction(revertType, data);
                break;
            case "edit":
                revertType = "edit";
                rvAction = new MonHocAction(revertType, oldData, data);
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
                    cmd.delete(data.getMAMH());
                    break;
                case "edit":
                    cmd.update(data.getMAMH(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("MonHocAction.java: Thực thi lệnh " + type + " thật bại: " + e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "MonHocAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}
