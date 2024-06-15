package ptithcm.bean;

import java.util.Date;

public class BangDiem {
    private String MASV;
    private String MAMH;
    private int LAN;
    private Date NGAYTHI;
    private float DIEM;
    private String MABANGDIEM;

    public BangDiem() {
    }

    public BangDiem(String MASV, String MAMH, int LAN, Date NGAYTHI, float DIEM, String MABANGDIEM) {
        this.MASV = MASV;
        this.MAMH = MAMH;
        this.LAN = LAN;
        this.NGAYTHI = NGAYTHI;
        this.DIEM = DIEM;
        this.MABANGDIEM = MABANGDIEM;
    }

    public String getMASV() {
        return MASV;
    }

    public void setMASV(String MASV) {
        this.MASV = MASV;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String MAMH) {
        this.MAMH = MAMH;
    }

    public int getLAN() {
        return LAN;
    }

    public void setLAN(int LAN) {
        this.LAN = LAN;
    }

    public Date getNGAYTHI() {
        return NGAYTHI;
    }

    public void setNGAYTHI(Date NGAYTHI) {
        this.NGAYTHI = NGAYTHI;
    }

    public float getDIEM() {
        return DIEM;
    }

    public void setDIEM(float DIEM) {
        this.DIEM = DIEM;
    }

    public String getMABANGDIEM() {
        return MABANGDIEM;
    }

    public void setMABANGDIEM(String MABANGDIEM) {
        this.MABANGDIEM = MABANGDIEM;
    }

    @Override
    public String toString() {
        return "BangDiem{" +
                "MASV='" + MASV + '\'' +
                ", MAMH='" + MAMH + '\'' +
                ", LAN=" + LAN +
                ", NGAYTHI=" + NGAYTHI +
                ", DIEM=" + DIEM +
                ", MABANGDIEM='" + MABANGDIEM + '\'' +
                '}';
    }
}
