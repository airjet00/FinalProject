package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.country.entities.Trip;
import com.skilldistillery.country.services.TripService;


@CrossOrigin({ "*", "http://localhost:4290" })
@RequestMapping("api")
@RestController
public class TripController {
	
	@Autowired
	TripService tripServ;
	

	@GetMapping("trips")
	public List<Trip> index(Principal principal) {
		return tripServ.index(principal.getName());
	}	
	
	@GetMapping("trips/{id}")
	public Trip show(@PathVariable int id, Principal principal, 
			HttpServletRequest req, HttpServletResponse res) {
		Trip trip = tripServ.show(principal.getName(), id);
		if(trip == null) {
			res.setStatus(404);
		}
		
		return trip;
	}
	
}
