package ptithcm.bean;

public class CoSo {
	private String MACS;
	private String TENCS;
	private String DIACHI;

	public CoSo(){}

	public CoSo(String mACS, String tENCS, String dIACHI) {
		MACS = mACS;
		TENCS = tENCS;
		DIACHI = dIACHI;
	}

	public String getMACS() {
		return MACS;
	}

	public void setMACS(String mACS) {
		MACS = mACS;
	}

	public String getTENCS() {
		return TENCS;
	}

	public void setTENCS(String tENCS) {
		TENCS = tENCS;
	}

	public String getDIACHI() {
		return DIACHI;
	}

	public void setDIACHI(String dIACHI) {
		DIACHI = dIACHI;
	}
	
}
