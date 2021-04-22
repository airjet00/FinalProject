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

import com.skilldistillery.country.entities.AdviceType;
import com.skilldistillery.country.services.AdviceTypeServiceImpl;

@CrossOrigin({ "*", "http://localhost:4290" })
@RestController
public class AdviceTypeController {

	@Autowired
	private AdviceTypeServiceImpl adviceServ;
	
	@GetMapping("countries/{cid}/adviceTypes")
	public List<AdviceType> index(@PathVariable int cid) {
		return adviceServ.index(cid);
	}
	
	@GetMapping("countries/{cid}/adviceTypes/{atid}")
	public AdviceType show(HttpServletResponse res, @PathVariable int cid, @PathVariable int atid) { 
		AdviceType advice = adviceServ.show(cid, atid);
		if(advice == null) {
			res.setStatus(404);
		}
		
		return advice;
	}

	@PostMapping("api/countries/{cid}/adviceTypes")
	public AdviceType create(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, @RequestBody AdviceType adviceType, Principal principal) {
		try {
			adviceType = adviceServ.create(principal.getName(), cid, adviceType);
			res.setStatus(201);

			StringBuffer url = req.getRequestURL();
			url.append("/").append(adviceType.getId());
			res.setHeader("Location", url.toString());
			
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			adviceType = null;
		}
		
		return adviceType;
	}
	
	@PutMapping("api/countries/{cid}/adviceTypes/{atid}")
	public AdviceType update(HttpServletRequest req, HttpServletResponse res,@PathVariable int cid, 
			@PathVariable int atid, @RequestBody AdviceType adviceType, Principal principal) { 
		
		if(adviceServ.show(cid, atid) == null) {
			res.setStatus(404);
			adviceType = null;
		}
		else {
			try {
				adviceType = adviceServ.update(principal.getName(), cid, adviceType, atid);
				res.setStatus(200);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(adviceType.getId());
				res.setHeader("Location", url.toString());
			} catch (Exception e) {
				System.err.println(e);
				res.setStatus(400);
				adviceType = null;
			}
			
		}
		
		
		return adviceType;
	}
	
	@DeleteMapping("api/countries/{cid}/adviceTypes/{atid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid,
			@PathVariable int atid, Principal principal) {
		
		try {
			if(adviceServ.destroy(principal.getName(), cid, atid)) {
				res.setStatus(204);
			}
			else {
				res.setStatus(404);
			}
	
		} catch (Exception e) {
				System.err.println(e);
				res.setStatus(400); 
			}
	}
	
		
}
