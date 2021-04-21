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
	public Trip show(@PathVariable int id, HttpServletResponse res) {
		Trip trip = tripServ.show(id);
		if(trip == null) {
			res.setStatus(404);
		}
		
		return trip;
	}
	@PostMapping("trips")
	public Trip create(HttpServletRequest req, HttpServletResponse res,
			@RequestBody Trip trip, Principal principal) {
		
		trip = tripServ.create(principal.getName(), trip);
		if(trip != null) {
			res.setStatus(201);
			res.setHeader("Location", req.getRequestURL().append("/").append(trip.getId()).toString());
		}
		
		return trip;
	}
	
	@PutMapping("trips/{id}")
	public Trip updated(HttpServletRequest req, HttpServletResponse res,
			@RequestBody Trip trip, @PathVariable int id, Principal principal) {
		trip = tripServ.update(principal.getName(), id, trip);
		if(trip == null) {
			res.setStatus(400);
		}
		
		return trip;
	}
	
	@DeleteMapping("trips/{id}")
	public void destroy(@PathVariable int id, Principal principal, 
			HttpServletRequest req, HttpServletResponse res) {
		
		try {
			if(tripServ.destroy(principal.getName(), id)) {
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
