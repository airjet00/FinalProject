package com.skilldistillery.country.controllers;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.services.CountryService;

@CrossOrigin({ "*", "http://localhost:4290" })
	@RequestMapping("api")
	@RestController
	public class CountryController {

		@Autowired
		private CountryService countryServ;

		@GetMapping("countries")
		public List<Country> index() {
			return countryServ.index();
		}
		
	
}
