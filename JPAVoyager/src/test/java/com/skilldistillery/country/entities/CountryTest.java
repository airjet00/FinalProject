package com.skilldistillery.country.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;


class CountryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Country country;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("voyagerPU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		country = em.find(Country.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		country = null;
	}

	@Test
	void test_Country_entity_mapping() {
		assertNotNull(country);
		assertEquals(country.getName(), "Singapore");
		assertEquals(country.getDefaultImage(),"singapore.jpg");
	}
	
	@Test
	void test_Country_Advice_relational_mapping() {
		assertNotNull(country.getAdviceTypes());
		assertTrue(country.getAdviceTypes().size()>0);
	}
	
	@Test
	void test_Country_Comment_relational_mapping() {
		assertNotNull(country.getComments());
		assertTrue(country.getComments().size()>0);
	}
	
	@Test
	void test_Country_ItineraryItem_relational_mapping() {
		assertNotNull(country.getItineraryItems());
		assertTrue(country.getItineraryItems().size()>0);
	}
	
	@Test
	void test_Country_Picture_relational_mapping() {
		assertNotNull(country.getPictures());
		assertTrue(country.getPictures().size()>0);
	}

	

}
