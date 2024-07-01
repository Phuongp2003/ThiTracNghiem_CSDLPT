package ptithcm.bean.temp;

import java.sql.Timestamp;
import java.util.List;

import ptithcm.util.DateFM;

public class KetQuaThi {
    String HOTEN;
    String LOP;
    String MAMH;
    String TENMH;
    Timestamp NGAYTHI;
    int LAN;
    float DIEM;
    List<ChiTietDapAn> chiTietDapAn;

    public String getHOTEN() {
        return HOTEN;
    }

    public void setHOTEN(String HOTEN) {
        this.HOTEN = HOTEN;
    }

    public String getLOP() {
        return LOP;
    }

    public void setLOP(String LOP) {
        this.LOP = LOP;
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

    public Timestamp getNGAYTHI() {
        return NGAYTHI;
    }

    public void setNGAYTHI(Timestamp NGAYTHI) {
        this.NGAYTHI = NGAYTHI;
    }

    public int getLAN() {
        return LAN;
    }

    public void setLAN(int LAN) {
        this.LAN = LAN;
    }

    public float getDIEM() {
        return DIEM;
    }

    public void setDIEM(float DIEM) {
        this.DIEM = Math.round(DIEM * 10.0f) / 10.0f;
    }

    public List<ChiTietDapAn> getChiTietDapAn() {
        return chiTietDapAn;
    }

    public void setChiTietDapAn(List<ChiTietDapAn> chiTietDapAn) {
        this.chiTietDapAn = chiTietDapAn;
    }

    public String getNgayThiF() {
        if (NGAYTHI == null) {
            return "";
        }

        return DateFM.Datetime(NGAYTHI);
    }

    public KetQuaThi(String HOTEN, String LOP, String MAMH, String TENMH, Timestamp NGAYTHI, int LAN, float DIEM,
            List<ChiTietDapAn> chiTietDapAn) {
        super();
        this.HOTEN = HOTEN;
        this.LOP = LOP;
        this.MAMH = MAMH;
        this.TENMH = TENMH;
        this.NGAYTHI = NGAYTHI;
        this.LAN = LAN;
        this.DIEM = DIEM;
        this.chiTietDapAn = chiTietDapAn;
    }

    public KetQuaThi() {
        super();
    }
}
