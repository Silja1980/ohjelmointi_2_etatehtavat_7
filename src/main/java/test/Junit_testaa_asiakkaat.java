package test;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.Assert.assertEquals;
import java.util.ArrayList;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import model.Asiakas;
import model.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
class Junit_testaa_asiakkaat {

	@Test
	@Order(1) 
	public void testPoistaKaikkiAutot() {
		//Poistetaan kaikki autot
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("nimda");
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}
	
	@Test
	@Order(2) 
	public void testLisaaAsiakas() {		
		//Tehd‰‰n muutama uusi testiauto
		Dao dao = new Dao();
	
		Asiakas asiakas_1 = new Asiakas(22,"Mikko", "Mallikas", "0700159258", "mallikas@mikko.fi");
		Asiakas asiakas_2 = new Asiakas(23,"Minna", "Mallikas", "0800159258", "mallikas@Minna.fi");
		Asiakas asiakas_3 = new Asiakas(24,"Maija", "Mallikas", "0500159258", "mallikas@maija.fi");
		Asiakas asiakas_4 = new Asiakas(25,"Minttu", "Mallikas", "0400159258", "mallikas@minttu.fi");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
	}
	
	@Test
	@Order(3) 
	public void testMuutaAuto() {
		//Muutetaan yht‰ autoa
		Dao dao = new Dao();
		Asiakas muutettava = dao.etsiAsiakas("8");
		muutettava.setEtunimi("Minttu");
		muutettava.setSukunimi("Meik‰l‰inen");
		muutettava.setPuhelin("05015895");
		muutettava.setSposti("Testi@testi.fi");
		dao.muutaAsiakas(muutettava, "8");	
		assertEquals("A-1", dao.etsiAsiakas("A-1").getEtunimi());
		assertEquals("Ford", dao.etsiAsiakas("A-1").getSukunimi());
		assertEquals("Focus", dao.etsiAsiakas("A-1").getPuhelin());
		assertEquals(2016, dao.etsiAsiakas("A-1").getSposti());
	}
	
	@Test
	@Order(4) 
	public void testPoistaAuto() {
		Dao dao = new Dao();
		dao.poistaAsiakas(22);
		assertEquals(null, dao.etsiAsiakas("22"));
	}

}
