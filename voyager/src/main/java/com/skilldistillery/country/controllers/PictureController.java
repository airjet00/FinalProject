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

import com.skilldistillery.country.entities.Picture;
import com.skilldistillery.country.services.PictureService;

@CrossOrigin({ "*", "http://localhost:4290" })
@RestController
public class PictureController {

	@Autowired
	private PictureService pictureServ;
	
	@GetMapping("countries/{cid}/pictures")
	public List<Picture> index(@PathVariable int cid) {
		return pictureServ.index(cid);
	}
	
	@GetMapping("countries/{cid}/pictures/{pid}")
	public Picture show(HttpServletResponse res, @PathVariable int cid, @PathVariable int pid) { 
		Picture picture = pictureServ.show(cid, pid);
		if(picture == null) {
			res.setStatus(404);
		}
		
		return picture;
	}

	@PostMapping("api/countries/{cid}/pictures")
	public Picture create(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, @RequestBody Picture picture, Principal principal) {
		try {
			picture = pictureServ.create(principal.getName(), cid, picture);
			res.setStatus(201);

			StringBuffer url = req.getRequestURL();
			url.append("/").append(picture.getId());
			res.setHeader("Location", url.toString());
			
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			picture = null;
		}
		
		return picture;
	}
	
	@PutMapping("api/countries/{cid}/pictures/{pid}")
	public Picture update(HttpServletRequest req, HttpServletResponse res,@PathVariable int cid, 
			@PathVariable int pid, @RequestBody Picture picture, Principal principal) { 
		
		if(pictureServ.show(cid, pid) == null) {
			res.setStatus(404);
			picture = null;
		}
		else {
			try {
				picture = pictureServ.update(principal.getName(), cid, picture, pid);
				res.setStatus(200);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(picture.getId());
				res.setHeader("Location", url.toString());
			} catch (Exception e) {
				System.err.println(e);
				res.setStatus(400);
				picture = null;
			}
			
		}
		
		
		return picture;
	}
	
	@DeleteMapping("api/countries/{cid}/pictures/{pid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid,
			@PathVariable int pid, Principal principal) {
		
		try {
			if(pictureServ.destroy(principal.getName(), cid, pid)) {
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
