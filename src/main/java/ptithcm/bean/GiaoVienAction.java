package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.GiaoVienJDBCTemplate;

public class GiaoVienAction implements Action<GiaoVien> {
    private String type;
    private GiaoVien oldData;
    private GiaoVien data;
    private GiaoVienJDBCTemplate cmd;

    public GiaoVienAction() {
    }

    public GiaoVienAction(String type, GiaoVien data) {
        this.type = type;
        this.data = data;
    }

    public GiaoVienAction(String type, GiaoVien data, GiaoVien oldData) {
        this.type = type;
        this.data = data;
        this.oldData = oldData;
    }

    public void setCmd(GiaoVienJDBCTemplate cmd) {
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
    public GiaoVien getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(GiaoVien oldData) {
        this.oldData = oldData;
    }

    @Override
    public GiaoVien getData() {
        return data;
    }

    @Override
    public void setData(GiaoVien data) {
        this.data = data;
    }

    @Override
    public Action<GiaoVien> getRevertAction() {
        String revertType;
        GiaoVienAction rvAction;
        switch (type) {
            case "add":
                revertType = "delete";
                rvAction = new GiaoVienAction(revertType, data);
                break;
            case "delete":
                revertType = "add";
                rvAction = new GiaoVienAction(revertType, data);
                break;
            case "edit":
                revertType = "edit";
                rvAction = new GiaoVienAction(revertType, oldData, data);
            case "move":
                revertType = "move";
                rvAction = new GiaoVienAction(revertType, oldData, data);
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
                    cmd.delete(data.getMAGV());
                    break;
                case "edit":
                    cmd.update(data.getMAGV(), data);
                case "move":
                    cmd.move(data.getMAKH(), data.getMAGV(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("GiaoVienAction.java: Thực thi lệnh " + type + " thật bại: " + e.getMessage());
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "GiaoVienAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}
