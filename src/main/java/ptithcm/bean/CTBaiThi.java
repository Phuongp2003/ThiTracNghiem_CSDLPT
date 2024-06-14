package ptithcm.bean;

public class CTBaiThi {
    private String MABANGDIEM;
    private int CAUHOI;
    private String DAPANSV;

    public CTBaiThi(){}

    public CTBaiThi(String mABANGDIEM, int cAUHOI, String dAPANSV) {
        MABANGDIEM = mABANGDIEM;
        CAUHOI = cAUHOI;
        DAPANSV = dAPANSV;
    }

    public String getMABANGDIEM() {
        return MABANGDIEM;
    }

    public void setMABANGDIEM(String mABANGDIEM) {
        MABANGDIEM = mABANGDIEM;
    }

    public int getCAUHOI() {
        return CAUHOI;
    }

    public void setCAUHOI(int cAUHOI) {
        CAUHOI = cAUHOI;
    }

    public String getDAPANSV() {
        return DAPANSV;
    }

    public void setDAPANSV(String dAPANSV) {
        DAPANSV = dAPANSV;
    }

    
}
