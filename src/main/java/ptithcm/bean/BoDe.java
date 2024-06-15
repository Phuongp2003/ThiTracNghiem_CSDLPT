package ptithcm.bean;

public class BoDe {
	private int CAUHOI;
	private String MAMH;
	private String TRINHDO;
	private String NOIDUNG;
	private String A;
	private String B;
	private String C;
	private String D;
	private String DAPAN;
	private String MAGV;

	public BoDe() {
	}

	public BoDe(int CAUHOI, String MAMH, String TRINHDO, String NOIDUNG, String A, String B, String C, String D,
			String DAPAN, String MAGV) {
		this.CAUHOI = CAUHOI;
		this.MAMH = MAMH;
		this.TRINHDO = TRINHDO;
		this.NOIDUNG = NOIDUNG;
		this.A = A;
		this.B = B;
		this.C = C;
		this.D = D;
		this.DAPAN = DAPAN;
		this.MAGV = MAGV;
	}

	public int getCAUHOI() {
		return CAUHOI;
	}

	public void setCAUHOI(int CAUHOI) {
		this.CAUHOI = CAUHOI;
	}

	public String getMAMH() {
		return MAMH;
	}

	public void setMAMH(String MAMH) {
		this.MAMH = MAMH;
	}

	public String getTRINHDO() {
		return TRINHDO;
	}

	public void setTRINHDO(String TRINHDO) {
		this.TRINHDO = TRINHDO;
	}

	public String getNOIDUNG() {
		return NOIDUNG;
	}

	public void setNOIDUNG(String NOIDUNG) {
		this.NOIDUNG = NOIDUNG;
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

	public String getDAPAN() {
		return DAPAN;
	}

	public void setDAPAN(String DAPAN) {
		this.DAPAN = DAPAN;
	}

	public String getMAGV() {
		return MAGV;
	}

	public void setMAGV(String MAGV) {
		this.MAGV = MAGV;
	}

	@Override
	public String toString() {
		return "BoDe{" +
				"CAUHOI=" + CAUHOI +
				", MAMH='" + MAMH + '\'' +
				", TRINHDO='" + TRINHDO + '\'' +
				", NOIDUNG='" + NOIDUNG + '\'' +
				", A='" + A + '\'' +
				", B='" + B + '\'' +
				", C='" + C + '\'' +
				", D='" + D + '\'' +
				", DAPAN='" + DAPAN + '\'' +
				", MAGV='" + MAGV + '\'' +
				'}';
	}
}
