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
	void test_ItineraryItem_entity_mapping() {
		assertNotNull(itineraryItem);
		assertEquals(itineraryItem.getNotes(), "I am so excited!!!");
	}
	
	@Test
	void test_ItineraryItem_Trip_relational_mapping() {
		assertNotNull(itineraryItem.getTrip());
		assertEquals(itineraryItem.getTrip().getId(), 1);
	}
	
	@Test
	void test_ItineraryItem_Country_relational_mapping() {
		assertNotNull(itineraryItem.getCountry());
		assertEquals(itineraryItem.getCountry().getId(), 1);
	}


}
