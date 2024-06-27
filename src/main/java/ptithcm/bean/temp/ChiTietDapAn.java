package ptithcm.bean.temp;

public class ChiTietDapAn {
    int CAUHOI;
    String NOIDUNG;
    String A;
    String B;
    String C;
    String D;
    String DAPANSV;
    String DAPANDUNG;

    public int getCAUHOI() {
        return CAUHOI;
    }

    public void setCAUHOI(int cAUHOI) {
        CAUHOI = cAUHOI;
    }

    public String getNOIDUNG() {
        return NOIDUNG;
    }

    public void setNOIDUNG(String nOIDUNG) {
        NOIDUNG = nOIDUNG;
    }

    public String getA() {
        return A;
    }

    public void setA(String A) {
        this.A = A;
    }

    public String getB() {
        return B;
    }

    public void setB(String B) {
        this.B = B;
    }

    public String getC() {
        return C;
    }

    public void setC(String C) {
        this.C = C;
    }

    public String getD() {
        return D;
    }

    public void setD(String D) {
        this.D = D;
    }

    public String getDAPANSV() {
        return DAPANSV;
    }

    public void setDAPANSV(String dAPANSV) {
        DAPANSV = dAPANSV;
    }

    public String getDAPANDUNG() {
        return DAPANDUNG;
    }

    public void setDAPANDUNG(String dAPANDUNG) {
        DAPANDUNG = dAPANDUNG;
    }

    public ChiTietDapAn(int CAUHOI, String NOIDUNG, String A, String B, String C, String D, String DAPANSV,
            String DAPANDUNG) {
        super();
        this.CAUHOI = CAUHOI;
        this.NOIDUNG = NOIDUNG;
        this.A = A;
        this.B = B;
        this.C = C;
        this.D = D;
        this.DAPANSV = DAPANSV;
        this.DAPANDUNG = DAPANDUNG;
    }

    public ChiTietDapAn() {
        super();
    }

    @Override
    public String toString() {
        return "ChiTietDapAn [CAUHOI=" + CAUHOI + ", NOIDUNG=" + NOIDUNG + ", A=" + A + ", B=" + B + ", C=" + C + ", D="
                + D + ", DAPANSV=" + DAPANSV + ", DAPANDUNG=" + DAPANDUNG + "]";
    }

}
