package ptithcm.bean;

public class MonHoc {
    private String MAMH;
    private String TENMH;

    public MonHoc() {
    }

    public MonHoc(String MAMH, String TENMH) {
        this.MAMH = MAMH;
        this.TENMH = TENMH;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String MAMH) {
        this.MAMH = MAMH;
    }

    public String getTENMH() {
        return TENMH;
    }

    public void setTENMH(String TENMH) {
        this.TENMH = TENMH;
    }

    @Override
    public String toString() {
        return "MonHoc{" +
                "MAMH='" + MAMH + '\'' +
                ", TENMH='" + TENMH + '\'' +
                '}';
    }
}
