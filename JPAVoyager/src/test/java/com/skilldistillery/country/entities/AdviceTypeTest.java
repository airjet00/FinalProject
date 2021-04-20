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

class AdviceTypeTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private AdviceType adviceType;

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
		adviceType = em.find(AdviceType.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		adviceType = null;
	}


	@Test
	@DisplayName("Test AdviceType Entity Mappings")
	void test0() {
		assertNotNull(adviceType);
		assertEquals("Covid-Related", adviceType.getName());
		assertEquals("Precautions for Covid-19 pandemic", adviceType.getDescription());
		assertEquals("www.cdc.gov", adviceType.getAdviceUrl());
	}

}
