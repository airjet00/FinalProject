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

class ItineraryItemTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ItineraryItem itineraryItem;

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
		itineraryItem = em.find(ItineraryItem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		itineraryItem = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(itineraryItem);
		assertEquals(itineraryItem.getNotes(), "user");
	}
	
	@Test
	void test_User_Country_relational_mapping() {
		assertNotNull(itineraryItem.getCountry());
		assertEquals(itineraryItem.getCountry().getId(), 1);
	}


}
