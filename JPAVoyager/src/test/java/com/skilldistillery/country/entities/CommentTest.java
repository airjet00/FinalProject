package com.skilldistillery.country.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	
	@Test
	void test_Comment_entity_mapping() {
		assertNotNull(comment);
		assertEquals("Singapore. Not for the fainthearted. The customs agent chewed all my gum.", comment.getContent());
		
/*		mysql> select * from comment where id=1;
		+----+---------------------------------------------------------------------------+-------------+-------------+---------+------------+---------+----------------+
		| id | content                                                                   | create_date | update_date | enabled | country_id | user_id | in_reply_to_id |
		+----+---------------------------------------------------------------------------+-------------+-------------+---------+------------+---------+----------------+
		|  1 | Singapore. Not for the fainthearted. The customs agent chewed all my gum. | NULL        | NULL        |       1 |          1 |       1 |           NULL |
		+----+---------------------------------------------------------------------------+-------------+-------------+---------+------------+---------+----------------+
*/
	}
	
	@Test
	void test_Comment_self_join_to_responses_mapping() {
		assertNull(comment.getOriginalComment());
		assertTrue(comment.getResponses().size() == 0);
	}

	@Test
	void test_Comment_to_Country_mapping() {
		assertNotNull(comment);
		assertEquals("Singapore", comment.getCountry().getName());
		/*
mysql> select name from country join comment on comment.country_id = country.id where comment.id = 1;
+-----------+
| name      |
+-----------+
| Singapore |
+-----------+
		 */
	}

	@Test
	void test_Comment_to_User_mapping() {
		assertNotNull(comment);
		assertEquals("user@user.com", comment.getUser());
		/*
		 * mysql> select username, email from user join comment on comment.user_id = user.id where comment.id = 1;
+----------+---------------+
| username | email         |
+----------+---------------+
| user     | user@user.com |
+----------+---------------+
1 row in set (0.00 sec)
		 */
	}

	// TODO: write this test
//	@ManyToOne
//	@JoinColumn(name = "in_reply_to_id")
//	private Comment originalComment;

	
}
