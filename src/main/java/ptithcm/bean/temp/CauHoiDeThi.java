package ptithcm.bean.temp;

public class CauHoiDeThi {
	private String NOIDUNG;
	private int CAUHOI;
	private String A;
	private String B;
	private String C;
	private String D;
	private String DAPAN;

	public CauHoiDeThi() {
	}

	public CauHoiDeThi(String NOIDUNG, int CAUHOI ,String A, String B, String C, String D) {
		this.NOIDUNG = NOIDUNG;
		this.CAUHOI = CAUHOI;
		this.A = A;
		this.B = B;
		this.C = C;
		this.D = D;
	}

	public String getNOIDUNG() {
		return NOIDUNG;
	}

	public void setNOIDUNG(String NOIDUNG) {
		this.NOIDUNG = NOIDUNG;
	}

	public int getCAUHOI() {
		return CAUHOI;
	}

	public void setCAUHOI(int CAUHOI) {
		this.CAUHOI = CAUHOI;
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

	@Override
	public String toString() {
		return "DeThi{" +
				", NOIDUNG='" + NOIDUNG + '\'' +
				", A='" + A + '\'' +
				", B='" + B + '\'' +
				", C='" + C + '\'' +
				", D='" + D + '\'' +
				'}';
	}
}
