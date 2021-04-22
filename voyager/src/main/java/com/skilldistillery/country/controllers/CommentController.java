package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.country.entities.Comment;
import com.skilldistillery.country.services.CommentService;
import com.skilldistillery.country.services.CountryService;

@CrossOrigin({ "*", "http://localhost:4290" })
@RestController
public class CommentController {

	@Autowired
	private CommentService commentServ;
	
	@Autowired
	private CountryService countryServ;
	
	@GetMapping("countries/{countryId}/comments")
	public List<Comment> indexEnabled(HttpServletResponse resp, @PathVariable Integer countryId) {
		List<Comment> comments = null;
		comments = commentServ.indexEnabledCommentsForCountry(countryId);
		if (comments != null)
			resp.setStatus(200);
		else
			resp.setStatus(404);
		return comments;
	}

	@GetMapping("countries/{countryId}/comments/all")
	public List<Comment> index(HttpServletResponse resp, @PathVariable Integer countryId) {
		List<Comment> comments = null;
		comments = commentServ.indexCommentsForCountry(countryId);
		if (comments != null)
			resp.setStatus(200);
		else
			resp.setStatus(404);
		return comments;
	}
	
	@GetMapping("countries/{countryId}/comments/disabled")
	public List<Comment> indexDisabled(HttpServletResponse resp, @PathVariable Integer countryId) {
		List<Comment> comments = null;
		comments = commentServ.indexAllDisabledComments();
		if (comments != null)
			resp.setStatus(200);
		else
			resp.setStatus(404);
		return comments;
	}

	@GetMapping("countries/{countryId}/comments/{cid}")
	public Comment show(Principal principal, @PathVariable Integer cid, HttpServletResponse resp) {
		Comment comment = null;
		if (cid != null) {
			comment = commentServ.show(principal.getName(), cid);
			if (comment != null) {
				resp.setStatus(200);
			} else {
				resp.setStatus(404);
			}
		}
		return comment;
	}

	@PostMapping("api/countries/{countryId}/comments")
	public Comment create(Principal principal, @PathVariable Integer countryId, @RequestBody Comment comment,
			HttpServletResponse resp) {
		try {
			comment.setCountry(countryServ.show(countryId));
			comment = commentServ.create(principal.getName(), comment);
			resp.setStatus(201);
		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
			resp.setStatus(400);
			comment = null;
		}
		return comment;
	}

	@PutMapping("api/countries/{countryId}/comments/{commentId}")
	public Comment update(Principal principal, @PathVariable Integer countryId, @PathVariable Integer commentId, @RequestBody Comment comment,
			HttpServletResponse resp, HttpServletRequest req) {
		try {
			comment = commentServ.update(principal.getName(), commentId, comment);

			StringBuffer url = req.getRequestURL();
			url.append("/").append(comment.getId());
			resp.setHeader("Location", url.toString());

			return comment;
		} catch (Exception e) {
			System.err.println(e);
			e.printStackTrace();
			resp.setStatus(400);
			comment = null;
			return null;
		}
	}

	@DeleteMapping("api/countries/{countryId}/comments/{commentId}")
	public boolean delete(Principal principal, @PathVariable Integer countryId, @PathVariable Integer commentId, HttpServletResponse resp) {
		try {
			if (commentServ.destroy(principal.getName(), commentId)) {
				resp.setStatus(204);
				return true;
			} else {
				resp.setStatus(404);
				return false;
			}
		} catch (Exception e) {
			System.err.println(e);
			resp.setStatus(400);
			return false;
		}
	}
}