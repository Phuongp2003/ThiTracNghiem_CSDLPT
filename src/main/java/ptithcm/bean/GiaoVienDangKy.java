package ptithcm.bean;

import java.util.Date;

public class GiaoVienDangKy {
    private String MAGV;
    private String MAMH;
    private String MALOP;
    private String TRINHDO;
    private Date NGAYTHI;
    private int LAN;
    private int SOCAUTHI;
    private int THOIGIAN;
    public GiaoVienDangKy() {}

    public GiaoVienDangKy(String mAGV, String mAMH, String mALOP, String tRINHDO, Date nGAYTHI, int lAN, int sOCAUTHI,
            int tHOIGIAN) {
        MAGV = mAGV;
        MAMH = mAMH;
        MALOP = mALOP;
        TRINHDO = tRINHDO;
        NGAYTHI = nGAYTHI;
        LAN = lAN;
        SOCAUTHI = sOCAUTHI;
        THOIGIAN = tHOIGIAN;
    }

    public String getMAGV() {
        return MAGV;
    }

    public void setMAGV(String mAGV) {
        MAGV = mAGV;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String mAMH) {
        MAMH = mAMH;
    }

    public String getMALOP() {
        return MALOP;
    }

    public void setMALOP(String mALOP) {
        MALOP = mALOP;
    }

    public String getTRINHDO() {
        return TRINHDO;
    }

    public void setTRINHDO(String tRINHDO) {
        TRINHDO = tRINHDO;
    }

    public Date getNGAYTHI() {
        return NGAYTHI;
    }

    public void setNGAYTHI(Date nGAYTHI) {
        NGAYTHI = nGAYTHI;
    }

    public int getLAN() {
        return LAN;
    }

    public void setLAN(int lAN) {
        LAN = lAN;
    }

    public int getSOCAUTHI() {
        return SOCAUTHI;
    }

    public void setSOCAUTHI(int sOCAUTHI) {
        SOCAUTHI = sOCAUTHI;
    }

    public int getTHOIGIAN() {
        return THOIGIAN;
    }

    public void setTHOIGIAN(int tHOIGIAN) {
        THOIGIAN = tHOIGIAN;
    }

    
    
}
