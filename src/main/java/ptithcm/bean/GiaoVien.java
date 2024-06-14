package ptithcm.bean;

public class GiaoVien {
	private String MAGV;
	private String HO;
	private String TEN;
    private String DIACHI;
    private String MAKH;

    public GiaoVien() {}

    public GiaoVien(String mAGV, String hO, String tEN, String dIACHI, String mAKH) {
        MAGV = mAGV;
        HO = hO;
        TEN = tEN;
        DIACHI = dIACHI;
        MAKH = mAKH;
    }

    public String getMAGV() {
        return MAGV;
    }

    public void setMAGV(String mAGV) {
        MAGV = mAGV;
    }

    public String getHO() {
        return HO;
    }

    public void setHO(String hO) {
        HO = hO;
    }

    public String getTEN() {
        return TEN;
    }

    public void setTEN(String tEN) {
        TEN = tEN;
    }

    public String getDIACHI() {
        return DIACHI;
    }

    public void setDIACHI(String dIACHI) {
        DIACHI = dIACHI;
    }

    public String getMAKH() {
        return MAKH;
    }

    public void setMAKH(String mAKH) {
        MAKH = mAKH;
    }    
}

