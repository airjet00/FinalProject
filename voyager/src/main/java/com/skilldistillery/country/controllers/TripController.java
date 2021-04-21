package com.skilldistillery.country.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
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
	
}
