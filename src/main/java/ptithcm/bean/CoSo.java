package ptithcm.bean;

public class CoSo {
	private String MACS;
	private String TENCS;
	private String DIACHI;

	public CoSo() {
	}

	public CoSo(String MACS, String TENCS, String DIACHI) {
		this.MACS = MACS;
		this.TENCS = TENCS;
		this.DIACHI = DIACHI;
	}

	public String getMACS() {
		return MACS;
	}

	public void setMACS(String MACS) {
		this.MACS = MACS;
	}

	public String getTENCS() {
		return TENCS;
	}

	public void setTENCS(String TENCS) {
		this.TENCS = TENCS;
	}

	public String getDIACHI() {
		return DIACHI;
	}

	public void setDIACHI(String DIACHI) {
		this.DIACHI = DIACHI;
	}

	@Override
	public String toString() {
		return "CoSo{" +
				"MACS='" + MACS + '\'' +
				", TENCS='" + TENCS + '\'' +
				", DIACHI='" + DIACHI + '\'' +
				'}';
	}
}
