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

import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.services.CountryService;

@CrossOrigin({ "*", "http://localhost:4290" })
	@RestController
	public class CountryController {

		@Autowired
		private CountryService countryServ;

		@GetMapping("countries")
		public List<Country> index() {
			return countryServ.index();
		}
		
		@GetMapping("countries/search/{keyword}")
		public List<Country> searchByKeyword(@PathVariable String keyword) {
			return countryServ.searchByKeyword(keyword);
		}
		
		@GetMapping("countries/{cid}")
		public Country show(HttpServletResponse res, @PathVariable int cid) { 
			Country country = countryServ.show(cid);
			if(country == null) {
				res.setStatus(404);
			}
			
			return country;
		}
		
		@PostMapping("api/countries")
		public Country create(HttpServletRequest req, HttpServletResponse res, @RequestBody Country country, Principal principal) {
			try {
				country = countryServ.create(principal.getName(), country);
				res.setStatus(201);

				StringBuffer url = req.getRequestURL();
				url.append("/").append(country.getId());
				res.setHeader("Location", url.toString());
				
			} catch (Exception e) {
				System.err.println(e);
				res.setStatus(400);
				country = null;
			}
			
			return country;
		}
		
		@PutMapping("api/countries/{cid}")
		public Country update(HttpServletRequest req, HttpServletResponse res,@PathVariable int cid, @RequestBody Country country, Principal principal) { 
			
			if(countryServ.show(cid) == null) {
				res.setStatus(404);
				country = null;
			}
			else {
				try {
					country = countryServ.update(principal.getName(), cid, country);
					res.setStatus(200);
					StringBuffer url = req.getRequestURL();
					url.append("/").append(country.getId());
					res.setHeader("Location", url.toString());
				} catch (Exception e) {
					System.err.println(e);
					res.setStatus(400);
					country = null;
				}
				
			}
			
			
			return country;
		}
		
		@DeleteMapping("api/countries/{cid}")
		public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int cid, Principal principal) {
			try {
				if(countryServ.destroy(principal.getName(), cid)) {
					res.setStatus(204);
				}
				else {
					res.setStatus(404);
				}
		
			} catch (Exception e) {
					System.err.println(e);
					res.setStatus(400); // shouldn't it be 409?
				}
		}
		
		
}
