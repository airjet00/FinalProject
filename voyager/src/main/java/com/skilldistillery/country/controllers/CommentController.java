package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
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
	public List<Comment> index(Principal principal) {
		return commentServ.index(principal.getName());
	}

	@GetMapping("comment/{cid}")
	public Comment show(Principal principal, int cid) {
		return commentServ.show(principal.getName(), cid);
	}
	
}