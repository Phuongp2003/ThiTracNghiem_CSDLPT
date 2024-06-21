package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.KhoaLopJDBCTemplate;

public class KhoaAction implements Action<Khoa>{
    private String type;
    private Khoa oldData;
    private Khoa data;
    private KhoaLopJDBCTemplate cmd;

    public KhoaAction() {}
    public KhoaAction(String type, Khoa data) {
        this.type = type;
        this.data = data;
    }

    public KhoaAction(String type, Khoa data, Khoa oldData) {
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
    public Khoa getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(Khoa oldData) {
        this.oldData = oldData;
    }

    @Override
    public Khoa getData() {
        return data;
    }

    @Override
    public void setData(Khoa data) {
        this.data = data;
    }

    @Override
    public Action<Khoa> getRevertAction() {
        String revertType;
        KhoaAction rvAction;
        switch (type) {
            case "add":
                revertType = "delete";
                rvAction = new KhoaAction(revertType, data);
                break;
            case "delete":
                revertType = "add";
                rvAction = new KhoaAction(revertType, data);
                break;
            case "edit":
                revertType = "edit";
                rvAction = new KhoaAction(revertType, oldData, data);
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
                    cmd.createKhoa(data);
                    break;
                case "delete":
                    cmd.deleteKhoa(data.getMAKH());
                    break;
                case "edit":
                    cmd.updateKhoa(data.getMAKH(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("KhoaAction.java: Thực thi lệnh " + type + " thật bại: " + e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "KhoaAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}