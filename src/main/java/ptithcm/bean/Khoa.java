package ptithcm.bean;

public class Khoa {
	private String MAKH;
	private String TENKH;
	private String MACS;
	
	public Khoa() {}

	public Khoa(String mAKH, String tENKH, String mACS) {
		MAKH = mAKH;
		TENKH = tENKH;
		MACS = mACS;
	}

	public String getMAKH() {
		return MAKH;
	}

	public void setMAKH(String mAKH) {
		MAKH = mAKH;
	}

	public String getTENKH() {
		return TENKH;
	}

	public void setTENKH(String tENKH) {
		TENKH = tENKH;
	}

	public String getMACS() {
		return MACS;
	}

	public void setMACS(String mACS) {
		MACS = mACS;
	}

	
}
