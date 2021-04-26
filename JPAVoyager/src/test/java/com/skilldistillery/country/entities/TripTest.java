package com.skilldistillery.country.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class TripTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Trip trip;

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
		trip = em.find(Trip.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		trip = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(trip);
		assertEquals(trip.getName(), "Southeast Asia Fall 2021");
	}


	@Test
	@DisplayName("Trip has ManyToOne mapping with User")
	void test2() {
		assertNotNull(trip);
		assertEquals(trip.getUser().getId(), 1);
	}
	@Test
	@DisplayName("Trip has OneToMany mapping with Itinerary item")
	void test3() {
		assertNotNull(trip);
		assertEquals(trip.getItineraryItems().get(0).getId(), 1);
	}
}
