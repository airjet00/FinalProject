package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.CountryRepository;
import com.skilldistillery.country.repositories.UserRepository;

@Service
@Transactional
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
	public Country create(Country country) {
		return countryRepo.saveAndFlush(country);
	}

	@Override
	public Country update(int cid, Country country) {
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
		return null;
	}

	@Override
	public boolean destroy(int cid) {
		boolean deleted = false;

		Country managed = show(cid);

		if (managed != null) {
			countryRepo.delete(managed);
			deleted = true;
		}

		return deleted;
	}
}
