package ptithcm.bean;

public class MonHoc {
    private String MAMH;
    private String TENMH;

    public MonHoc(){}
    
    public MonHoc(String mAMH, String tENMH) {
        MAMH = mAMH;
        TENMH = tENMH;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String mAMH) {
        MAMH = mAMH;
    }

    public String getTENMH() {
        return TENMH;
    }

    public void setTENMH(String tENMH) {
        TENMH = tENMH;
    }
}
