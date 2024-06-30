package ptithcm.bean;

import java.sql.Date;

public class GiaoVienDangKy {
    private String MAGV;
    private String MAMH;
    private String MALOP;
    private String TRINHDO;
    private Date NGAYTHI;
    private int LAN;
    private int SOCAUTHI;
    private int THOIGIAN;

    public GiaoVienDangKy() {
    }

    public GiaoVienDangKy(String MAGV, String MAMH, String MALOP, String TRINHDO, Date NGAYTHI, int LAN, int SOCAUTHI,
            int THOIGIAN) {
        this.MAGV = MAGV;
        this.MAMH = MAMH;
        this.MALOP = MALOP;
        this.TRINHDO = TRINHDO;
        this.NGAYTHI = NGAYTHI;
        this.LAN = LAN;
        this.SOCAUTHI = SOCAUTHI;
        this.THOIGIAN = THOIGIAN;
    }

    public String getMAGV() {
        return MAGV;
    }

    public void setMAGV(String MAGV) {
        this.MAGV = MAGV;
    }

    public String getMAMH() {
        return MAMH;
    }

    public void setMAMH(String MAMH) {
        this.MAMH = MAMH;
    }

    public String getMALOP() {
        return MALOP;
    }

    public void setMALOP(String MALOP) {
        this.MALOP = MALOP;
    }

    public String getTRINHDO() {
        return TRINHDO;
    }

    public void setTRINHDO(String TRINHDO) {
        this.TRINHDO = TRINHDO;
    }

    public Date getNGAYTHI() {
        return NGAYTHI;
    }

    public void setNGAYTHI(Date NGAYTHI) {
        this.NGAYTHI = NGAYTHI;
    }

    public int getLAN() {
        return LAN;
    }

    public void setLAN(int LAN) {
        this.LAN = LAN;
    }

    public int getSOCAUTHI() {
        return SOCAUTHI;
    }

    public void setSOCAUTHI(int SOCAUTHI) {
        this.SOCAUTHI = SOCAUTHI;
    }

    public int getTHOIGIAN() {
        return THOIGIAN;
    }

    public void setTHOIGIAN(int THOIGIAN) {
        this.THOIGIAN = THOIGIAN;
    }

    @Override
    public String toString() {
        return "GiaoVienDangKy{" +
                "MAGV='" + MAGV + '\'' +
                ", MAMH='" + MAMH + '\'' +
                ", MALOP='" + MALOP + '\'' +
                ", TRINHDO='" + TRINHDO + '\'' +
                ", NGAYTHI=" + NGAYTHI +
                ", LAN=" + LAN +
                ", SOCAUTHI=" + SOCAUTHI +
                ", THOIGIAN=" + THOIGIAN +
                '}';
    }
}
