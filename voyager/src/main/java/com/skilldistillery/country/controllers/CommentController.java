package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

	@PostMapping("comments")
	public Comment create(Principal principal, @RequestBody Comment comment, HttpServletResponse resp) {
		try {
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
	 
	
	
}