package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.entities.Trip;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.CountryRepository;
import com.skilldistillery.country.repositories.UserRepository;

public class CountryServiceImpl implements CountryService {

	@Autowired
	CountryRepository countryRepo;

	@Autowired
	UserRepository userRepo;

	@Override
	public List<Country> index() {
		return countryRepo.findAll();
	}

	@Override
	public Country show(int cid) {
		Country country = null;
		Optional<Country> opt = countryRepo.findById(cid);
		if (opt.isPresent())
			country = opt.get();
		return country;
	}

	@Override
	public Country create(String username, Country country) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {
			return countryRepo.saveAndFlush(country);
		}
		return null;
	}

	@Override
	public Country update(String username, int cid, Country country) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {

			Country managed = null;
			Optional<Country> opt = countryRepo.findById(cid);
			if (opt.isPresent())
				managed = opt.get();

			if (managed != null) {

				managed.setAdviceTypes(country.getAdviceTypes());
				managed.setComments(country.getComments());
				managed.setDefaultImage(country.getDefaultImage());
				managed.setDescription(country.getDescription());
				managed.setItineraryItems(country.getItineraryItems());
				managed.setName(country.getName());
				managed.setPictures(country.getPictures());

				managed = countryRepo.saveAndFlush(managed);
				return managed;

			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int cid) {
		User user = userRepo.findByUsername(username);
		boolean deleted = false;

		if (user.getRole() == "admin") {
			Country managed = show(cid);

			if (managed != null) {
				countryRepo.delete(managed);
				deleted = true;
			}

		}
		return deleted;
	}
}
