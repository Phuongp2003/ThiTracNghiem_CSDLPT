package ptithcm.bean;

import java.util.Date;

public class BangDiem {
    private String MASV;
    private String MAMH;
    private int LAN;
    private Date NGAYTHI;
    private float DIEM;
    private String MABANGDIEM;

    public BangDiem() {}

    public BangDiem(String mASV, String mAMH, int lAN, Date nGAYTHI, float dIEM, String mABANGDIEM) {
        MASV = mASV;
        MAMH = mAMH;
        LAN = lAN;
        NGAYTHI = nGAYTHI;
        DIEM = dIEM;
        MABANGDIEM = mABANGDIEM;
    }

    public String getMASV() {
        return MASV;
    }

    public void setMASV(String mASV) {
        MASV = mASV;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String mAMH) {
        MAMH = mAMH;
    }

    public int getLAN() {
        return LAN;
    }

    public void setLAN(int lAN) {
        LAN = lAN;
    }

    public Date getNGAYTHI() {
        return NGAYTHI;
    }

    public void setNGAYTHI(Date nGAYTHI) {
        NGAYTHI = nGAYTHI;
    }

    public float getDIEM() {
        return DIEM;
    }

    public void setDIEM(float dIEM) {
        DIEM = dIEM;
    }

    public String getMABANGDIEM() {
        return MABANGDIEM;
    }

    public void setMABANGDIEM(String mABANGDIEM) {
        MABANGDIEM = mABANGDIEM;
    }
}
