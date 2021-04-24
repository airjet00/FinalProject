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

class PictureTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Picture picture;

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
		picture = em.find(Picture.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		picture = null;
	}

	@Test
	void test_Picture_entity_mapping() {
		assertNotNull(picture);
		assertEquals(picture.getImageUrl(), "http://cdn.cnn.com/cnnnext/dam/assets/191212182124-04-singapore-buildings.jpg");
	}
	
	@Test
	void test_Picture_Country_relational_mapping() {
		assertNotNull(picture.getCountry());
		assertEquals(picture.getCountry().getId(), 1);
	}


}
