package model;

public class Asiakas {
	private int ID;
	private String etunimi, sukunimi, puhelin, sposti;
	
	public Asiakas() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public Asiakas(int iD, String etunimi, String sukunimi, String puhelin, String sposti) {
		super();
		ID = iD;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.sposti = sposti;
	}


	public int getID() {
		return ID;
	}


	public void setID(int iD) {
		ID = iD;
	}


	public String getEtunimi() {
		return etunimi;
	}


	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}


	public String getSukunimi() {
		return sukunimi;
	}


	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}


	public String getPuhelin() {
		return puhelin;
	}


	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}


	public String getSposti() {
		return sposti;
	}


	public void setSposti(String sposti) {
		this.sposti = sposti;
	}


	@Override
	public String toString() {
		return "Asiakas [ID=" + ID + ", etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin=" + puhelin
				+ ", sposti=" + sposti + "]";
	}
	
	


}
