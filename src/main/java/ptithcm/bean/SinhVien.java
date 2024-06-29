package ptithcm.bean;

import java.util.Date;

import ptithcm.util.DateFM;

public class SinhVien {
    private String MASV;
    private String HO;
    private String TEN;
    private Date NGAYSINH;
    private String DIACHI;
    private String MALOP;
    private String MATKHAU;

    public SinhVien() {
    }

    public SinhVien(String MASV, String HO, String TEN, Date NGAYSINH, String DIACHI, String MALOP, String MATKHAU) {
        this.MASV = MASV;
        this.HO = HO;
        this.TEN = TEN;
        this.NGAYSINH = NGAYSINH;
        this.DIACHI = DIACHI;
        this.MALOP = MALOP;
        this.MATKHAU = MATKHAU;
    }

    public String getMASV() {
        return MASV;
    }

    public void setMASV(String MASV) {
        this.MASV = MASV;
    }

    public String getHO() {
        return HO;
    }

    public void setHO(String HO) {
        this.HO = HO;
    }

    public String getTEN() {
        return TEN;
    }

    public void setTEN(String TEN) {
        this.TEN = TEN;
    }

    public Date getNGAYSINH() {
        return NGAYSINH;
    }

    public String getNGAYSINHF() {
        return DateFM.Date(this.NGAYSINH);
    }

    public void setNGAYSINH(Date NGAYSINH) {
        this.NGAYSINH = NGAYSINH;
    }

    public String getDIACHI() {
        return DIACHI;
    }

    public void setDIACHI(String DIACHI) {
        this.DIACHI = DIACHI;
    }

    public String getMALOP() {
        return MALOP;
    }

    public void setMALOP(String MALOP) {
        this.MALOP = MALOP;
    }

    public String getMATKHAU() {
        return MATKHAU;
    }

    public void setMATKHAU(String MATKHAU) {
        this.MATKHAU = MATKHAU;
    }

    @Override
    public String toString() {
        return "SinhVien{" +
                "MASV='" + MASV + '\'' +
                ", HO='" + HO + '\'' +
                ", TEN='" + TEN + '\'' +
                ", NGAYSINH=" + NGAYSINH +
                ", DIACHI='" + DIACHI + '\'' +
                ", MALOP='" + MALOP + '\'' +
                ", MATKHAU='" + MATKHAU + '\'' +
                '}';
    }
}
