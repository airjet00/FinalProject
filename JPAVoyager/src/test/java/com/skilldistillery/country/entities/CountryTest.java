package com.skilldistillery.country.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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
		assertEquals(country.getName(), "user");
		assertEquals(country.getDefaultImage(),"");
	}
	
//	@Test
//	void test_Country_Advice_relational_mapping() {
//		assertNotNull(country.getCountryAdviceTypes());
//		assertTrue(country.getCountryAdviceTypes()>0);
//	}

	

}
