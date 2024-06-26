package ptithcm.bean.temp;

import java.util.Date;

public class MonThi {
    String maMon;
    String trinhDo;
    Date ngayThi;
    int lanThi;
    int soCau;
    int thoiGian;

    public MonThi() {
    }

    public MonThi(String maMon, String trinhDo, Date ngayThi, int lanThi, int soCau, int thoiGian) {
        this.maMon = maMon;
        this.trinhDo = trinhDo;
        this.ngayThi = ngayThi;
        this.lanThi = lanThi;
        this.soCau = soCau;
        this.thoiGian = thoiGian;
    }

    public String getMaMon() {
        return maMon;
    }

    public void setMaMon(String maMon) {
        this.maMon = maMon;
    }

    public String getTrinhDo() {
        return trinhDo;
    }

    public void setTrinhDo(String trinhDo) {
        this.trinhDo = trinhDo;
    }

    public Date getNgayThi() {
        return ngayThi;
    }

    public void setNgayThi(Date ngayThi) {
        this.ngayThi = ngayThi;
    }

    public int getLanThi() {
        return lanThi;
    }

    public void setLanThi(int lanThi) {
        this.lanThi = lanThi;
    }

    public int getSoCau() {
        return soCau;
    }

    public void setSoCau(int soCau) {
        this.soCau = soCau;
    }

    public int getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(int thoiGian) {
        this.thoiGian = thoiGian;
    }

    @Override
    public String toString() {
        return "MonThi{" +
                "maMon='" + maMon + '\'' +
                ", trinhDo='" + trinhDo + '\'' +
                ", ngayThi=" + ngayThi +
                ", lanThi=" + lanThi +
                ", soCau=" + soCau +
                ", thoiGian=" + thoiGian +
                '}';
    }

}
