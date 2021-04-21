package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost:4290"})
public class UserController {

	@Autowired 
	private UserService userSvc;
	
	@GetMapping("ping")
	public String ping() {
		return "pong";
	}
	
	
	@GetMapping("users")
	public List<User> index(HttpServletRequest req, HttpServletResponse res, Principal principal){	
		
		List<User> users = userSvc.index(principal.getName());
		if(users == null) {
			res.setStatus(401);
		} else if(users.size() == 0) {
			res.setStatus(204);
		}
		
		return users;
	}
}
