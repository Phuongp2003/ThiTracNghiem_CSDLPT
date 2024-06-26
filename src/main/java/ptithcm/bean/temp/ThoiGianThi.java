package ptithcm.bean.temp;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class ThoiGianThi {
    int thoiGian;
    Timestamp thoiDiem;
    Date ngayThi;
    Time gioThi;

    public ThoiGianThi() {
    }

    public ThoiGianThi(int thoiGian, Timestamp thoiDiem) {
        this.thoiGian = thoiGian;
        this.thoiDiem = thoiDiem;
        this.ngayThi = new Date(thoiDiem.getTime());
        this.gioThi = new Time(thoiDiem.getTime());
    }

    public int getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(int thoiGian) {
        this.thoiGian = thoiGian;
    }

    public Timestamp getThoiDiem() {
        return thoiDiem;
    }

    public void setThoiDiem(Timestamp thoiDiem) {
        this.thoiDiem = thoiDiem;
        this.ngayThi = new Date(thoiDiem.getTime());
        this.gioThi = new Time(thoiDiem.getTime());
    }

    public Date getNgayThi() {
        return ngayThi;
    }

    public void setNgayThi(Date ngayThi) {
        this.ngayThi = ngayThi;
    }

    public Time getGioThi() {
        return gioThi;
    }

    public void setGioThi(Time gioThi) {
        this.gioThi = gioThi;
    }

    @Override
    public String toString() {
        return "ThoiGianThi{" +
                "thoiGian=" + thoiGian +
                ", thoiDiem=" + thoiDiem +
                '}';
    }
}
