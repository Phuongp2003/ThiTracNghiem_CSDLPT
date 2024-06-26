package ptithcm.bean;

public class CauHoiDeThi {
	private String NOIDUNG;
	private String A;
	private String B;
	private String C;
	private String D;

	public CauHoiDeThi() {
	}

	public CauHoiDeThi(String NOIDUNG, String A, String B, String C, String D) {
		this.NOIDUNG = NOIDUNG;
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
