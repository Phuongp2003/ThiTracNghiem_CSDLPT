package ptithcm.bean;

public class Khoa {
	private String MAKH;
	private String TENKH;
	private String MACS;

	public Khoa() {
	}

	public Khoa(String MAKH, String TENKH, String MACS) {
		this.MAKH = MAKH;
		this.TENKH = TENKH;
		this.MACS = MACS;
	}

	public String getMAKH() {
		return MAKH;
	}

	public void setMAKH(String MAKH) {
		this.MAKH = MAKH;
	}

	public String getTENKH() {
		return TENKH;
	}

	public void setTENKH(String TENKH) {
		this.TENKH = TENKH;
	}

	public String getMACS() {
		return MACS;
	}

	public void setMACS(String MACS) {
		this.MACS = MACS;
	}

	@Override
	public String toString() {
		return "Khoa{" +
				"MAKH='" + MAKH + '\'' +
				", TENKH='" + TENKH + '\'' +
				", MACS='" + MACS + '\'' +
				'}';
	}
}
