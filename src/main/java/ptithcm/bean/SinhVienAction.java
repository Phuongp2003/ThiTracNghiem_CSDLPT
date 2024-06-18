package ptithcm.bean;

import ptithcm.DAO.Action;
import ptithcm.JDBCtemplate.SinhVienJDBCTemplate;

public class SinhVienAction implements Action<SinhVien> {
    private String type;
    private SinhVien oldData;
    private SinhVien data;
    private SinhVienJDBCTemplate cmd;

    public SinhVienAction() {}

    public SinhVienAction(String type,  SinhVien data) {
        this.type = type;
        this.data = data;
    }

    public SinhVienAction(String type, SinhVien data, SinhVien oldData) {
        this.type = type;
        this.data = data;
        this.oldData = oldData;
    }

    public void setCmd(SinhVienJDBCTemplate cmd) {
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
    public SinhVien getOldData() {
        return oldData;
    }

    @Override
    public void setOldData(SinhVien oldData) {
        this.oldData = oldData;
    }

    @Override
    public SinhVien getData() {
        return data;
    }

    @Override
    public void setData(SinhVien data) {
        this.data = data;
    }

    @Override
    public Action<SinhVien> getRevertAction() {
        String revertType;
        switch (type) {
            case "add":
                revertType = "delete";
                return new SinhVienAction(revertType, data);
            case "delete":
                revertType = "add";
                return new SinhVienAction(revertType, data);
            case "edit":
                revertType = "edit";
                return new SinhVienAction(revertType, oldData, data);
            default:
                return null;
        }
    }

    @Override
    public int execute() {
        try {
            switch (type) {
                case "add":
                    cmd.create(data);
                    break;
                case "delete":
                    cmd.delete(data.getMASV());
                    break;
                case "edit":
                    cmd.update(data.getMASV(), data);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        return 0;
    }

    @Override
    public String toString() {
        return "SinhVienAction{" +
                "type='" + type + '\'' +
                ", data=" + data +
                '}';
    }
}
