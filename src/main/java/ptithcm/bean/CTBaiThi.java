package ptithcm.bean;

public class CTBaiThi {
    private String MABANGDIEM;
    private int CAUHOI;
    private String DAPANSV;

    public CTBaiThi() {
    }

    public CTBaiThi(String MABANGDIEM, int CAUHOI, String DAPANSV) {
        this.MABANGDIEM = MABANGDIEM;
        this.CAUHOI = CAUHOI;
        this.DAPANSV = DAPANSV;
    }

    public String getMABANGDIEM() {
        return MABANGDIEM;
    }

    public void setMABANGDIEM(String MABANGDIEM) {
        this.MABANGDIEM = MABANGDIEM;
    }

    public int getCAUHOI() {
        return CAUHOI;
    }

    public void setCAUHOI(int CAUHOI) {
        this.CAUHOI = CAUHOI;
    }

    public String getDAPANSV() {
        return DAPANSV;
    }

    public void setDAPANSV(String DAPANSV) {
        this.DAPANSV = DAPANSV;
    }

    @Override
    public String toString() {
        return "CTBaiThi{" +
                "MABANGDIEM='" + MABANGDIEM + '\'' +
                ", CAUHOI=" + CAUHOI +
                ", DAPANSV='" + DAPANSV + '\'' +
                '}';
    }
}
