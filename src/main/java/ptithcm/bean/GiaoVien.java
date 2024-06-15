package ptithcm.bean;

public class GiaoVien {
    private String MAGV;
    private String HO;
    private String TEN;
    private String DIACHI;
    private String MAKH;

    public GiaoVien() {
    }

    public GiaoVien(String MAGV, String HO, String TEN, String DIACHI, String MAKH) {
        this.MAGV = MAGV;
        this.HO = HO;
        this.TEN = TEN;
        this.DIACHI = DIACHI;
        this.MAKH = MAKH;
    }

    public String getMAGV() {
        return MAGV;
    }

    public void setMAGV(String MAGV) {
        this.MAGV = MAGV;
    }

    public String getHO() {
        return HO;
    }

    public void setHO(String HO) {
        this.HO = HO;
    }

    public String getTEN() {
        return TEN;
    }

    public void setTEN(String TEN) {
        this.TEN = TEN;
    }

    public String getDIACHI() {
        return DIACHI;
    }

    public void setDIACHI(String DIACHI) {
        this.DIACHI = DIACHI;
    }

    public String getMAKH() {
        return MAKH;
    }

    public void setMAKH(String MAKH) {
        this.MAKH = MAKH;
    }

    @Override
    public String toString() {
        return "GiaoVien{" +
                "MAGV='" + MAGV + '\'' +
                ", HO='" + HO + '\'' +
                ", TEN='" + TEN + '\'' +
                ", DIACHI='" + DIACHI + '\'' +
                ", MAKH='" + MAKH + '\'' +
                '}';
    }
}
