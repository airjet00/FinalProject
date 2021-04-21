package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.country.entities.Comment;
import com.skilldistillery.country.services.CommentService;

@CrossOrigin({ "*", "http://localhost:4290" })
@RequestMapping("api")
@RestController
public class CommentController {

	@Autowired
	private CommentService commentServ;

	@GetMapping("comments")
	public List<Comment> index(Principal principal, HttpServletResponse resp) {
		List<Comment> comments = null;
		comments = commentServ.index(principal.getName());
		if (comments != null)
			resp.setStatus(200);
		else
			resp.setStatus(404);
		return comments;
	}

	@GetMapping("comments/{cid}")
	public Comment show(Principal principal, @PathVariable Integer cid, HttpServletResponse resp) {
		Comment comment = null;
		if (cid != null)
			comment = commentServ.show(principal.getName(), cid);
		else
			resp.setStatus(404);
		return comment;
	}

	/*
	 * 
	 * 
	 * @GetMapping("articles/{id}") public JournalArticle findById(@PathVariable
	 * Integer id, HttpServletResponse resp) { JournalArticle ja =
	 * jaServ.findById(id); if (ja == null) { resp.setStatus(404); } return ja; }
	 * 
	 * @GetMapping("articles/search/{searchTerm}") public List<JournalArticle>
	 * search(@PathVariable String searchTerm) { return jaServ.search(searchTerm); }
	 * 
	 * 
	 * @GetMapping("articles/aggregates/count") public long count() { return
	 * jaServ.count(); }
	 * 
	 * @PostMapping("articles") public JournalArticle create(@RequestBody
	 * PayloadUtility pcu, HttpServletRequest req, HttpServletResponse resp) {
	 * JournalArticle ja = null; Author author = null;
	 * 
	 * try { ja = pcu.getJa(); author = pcu.getAuthor();
	 * System.out.println("author: " + author); System.out.println("ja: " + ja);
	 * 
	 * author = authorServ.create(author); ja = jaServ.create(ja);
	 * 
	 * System.out.println("author: " + author); System.out.println("ja: " + ja);
	 * 
	 * if (ja != null && author != null) { jaServ.addAuthor(ja.getId(),
	 * author.getId()); resp.setStatus(201); }
	 * 
	 * if (ja == null || author == null) { resp.setStatus(400); }
	 * 
	 * StringBuffer url = req.getRequestURL(); url.append("/").append(ja.getId());
	 * resp.setHeader("Location", url.toString()); } catch (Exception e) {
	 * System.err.println(e); e.printStackTrace(); resp.setStatus(400); ja = null; }
	 * return ja; }
	 * 
	 * @PutMapping("articles/{id}") public JournalArticle update(@PathVariable
	 * Integer id, @RequestBody JournalArticle ja, HttpServletResponse resp) { try {
	 * ja = jaServ.update(id, ja); if (ja == null) { resp.setStatus(404); } } catch
	 * (Exception e) { System.err.println(e); resp.setStatus(400); ja = null; }
	 * return ja; }
	 * 
	 * @PutMapping("articles/{jaId}/authors/{authorId}") public JournalArticle
	 * addAuthor(@PathVariable Integer jaId, @PathVariable Integer authorId,
	 * HttpServletResponse resp) { JournalArticle ja = null;
	 * 
	 * try { ja = jaServ.findById(jaId);
	 * 
	 * jaServ.addAuthor(jaId, authorId);
	 * 
	 * if (ja == null) { resp.setStatus(404); } } catch (Exception e) {
	 * System.err.println(e); resp.setStatus(400); ja = null; } return ja; }
	 * 
	 * // @PostMapping("articles/authors") // public JournalArticle
	 * createArticleWithAuthor(@RequestBody JournalArticle ja, @RequestBody Author
	 * author, // HttpServletResponse resp) { // try { // author =
	 * authorServ.create(author); // ja = jaServ.create(ja); // if (ja != null &&
	 * author != null) jaServ.addAuthor(ja.getId(), author.getId()); // // if (ja ==
	 * null || author == null) { // resp.setStatus(400); // } // // } catch
	 * (Exception e) { // System.err.println(e); // resp.setStatus(400); // ja =
	 * null; // } // // return ja; // }
	 * 
	 * @DeleteMapping("articles/{id}") public boolean delete(@PathVariable Integer
	 * id, HttpServletResponse resp) { boolean victory = false; try { if
	 * (jaServ.delete(id)) { resp.setStatus(204); victory = true; } else
	 * resp.setStatus(404); } catch (Exception e) { System.err.println(e);
	 * resp.setStatus(400); } return victory; }
	 * 
	 * 
	 * 
	 */
}