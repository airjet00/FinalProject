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
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(user);
		assertEquals(user.getUsername(), "user");
	}
	@Test
	@DisplayName("Test user relationship")
	void test1() {
		assertNotNull(user);
		// TODO test rel mapping
		assertEquals("Singapore. Not for the fainthearted. The customs agent chewed all my gum.", user.getComments().get(0).getContent());
	}

	@Test
	@DisplayName("Test user mapping with trips")
	void test2() {
		assertNotNull(user);
		// TODO test rel mapping
		assertEquals(user.getTrips().get(0).getName(), "Southeast Asia Fall 2021");
	}
	
	@Test
	@DisplayName("Test user mapping with trips")
	void test3() {
		assertNotNull(user);
		// TODO test rel mapping
		assertEquals(user.getComments().get(0).getContent(), "Singapore. Not for the fainthearted. The customs agent chewed all my gum.");
	}
	
}
