package ptithcm.bean;

public class Lop {
	private String MALOP;
	private String TENLOP;
	private String MAKH;

	public Lop() {
	}

	public Lop(String MALOP, String TENLOP, String MAKH) {
		this.MALOP = MALOP;
		this.TENLOP = TENLOP;
		this.MAKH = MAKH;
	}

	public String getMALOP() {
		return MALOP;
	}

	public void setMALOP(String MALOP) {
		this.MALOP = MALOP;
	}

	public String getTENLOP() {
		return TENLOP;
	}

	public void setTENLOP(String TENLOP) {
		this.TENLOP = TENLOP;
	}

	public String getMAKH() {
		return MAKH;
	}

	public void setMAKH(String MAKH) {
		this.MAKH = MAKH;
	}

	@Override
	public String toString() {
		return "Lop{" +
				"MALOP='" + MALOP + '\'' +
				", TENLOP='" + TENLOP + '\'' +
				", MAKH='" + MAKH + '\'' +
				'}';
	}
}
