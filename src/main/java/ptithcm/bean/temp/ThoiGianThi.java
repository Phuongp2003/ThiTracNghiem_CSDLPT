package ptithcm.bean.temp;

import java.util.Date;

public class ThoiGianThi {
    int thoiGian;
    Date thoiDiem;

    public ThoiGianThi() {
    }

    public ThoiGianThi(int thoiGian, Date thoiDiem) {
        this.thoiGian = thoiGian;
        this.thoiDiem = thoiDiem;
    }

    public int getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(int thoiGian) {
        this.thoiGian = thoiGian;
    }

    public Date getThoiDiem() {
        return thoiDiem;
    }

    public void setThoiDiem(Date thoiDiem) {
        this.thoiDiem = thoiDiem;
    }

    @Override
    public String toString() {
        return "ThoiGianThi{" +
                "thoiGian=" + thoiGian +
                ", thoiDiem=" + thoiDiem +
                '}';
    }
}
