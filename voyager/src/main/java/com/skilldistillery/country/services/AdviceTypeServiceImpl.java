package com.skilldistillery.country.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.AdviceType;
import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.AdviceTypeRepository;
import com.skilldistillery.country.repositories.UserRepository;

@Service
public class AdviceTypeServiceImpl implements AdviceTypeService {
	
	@Autowired
	AdviceTypeRepository aTRepo;
	
	@Autowired
	UserRepository userRepo;

	@Override
	public List<AdviceType> index(int cid) {
		return aTRepo.findByCountries_id(cid);
	}

	@Override
	public AdviceType show(int cid, int atid) {
		return aTRepo.findByCountries_idAndId(cid, atid);
	}

	@Override
	public AdviceType create(String username, int cid, AdviceType adviceType) {
		User user = userRepo.findByUsername(username);
		
		if(user.getRole().equals("admin")) {
			Country country = new Country();
			country.setId(cid);
			List<Country> countries = adviceType.getCountries();
			if(countries == null) {
				countries = new ArrayList<Country>();
			}
			countries.add(country);
			adviceType.setCountries(countries);
			return aTRepo.saveAndFlush(adviceType);
		}
		
		return null;
	}

	@Override
	public AdviceType update(String username, int cid, AdviceType adviceType, int atid) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {

			AdviceType managed = show(cid, atid);

			if (managed != null) {
				managed.setAdviceUrl(adviceType.getAdviceUrl());
				managed.setDescription(adviceType.getDescription());
				managed.setName(adviceType.getName());
				managed = aTRepo.saveAndFlush(managed);
				return managed;

			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int cid, int atid) {
		User user = userRepo.findByUsername(username);
		boolean deleted = false;

		if (user.getRole().equals("admin")) {
			AdviceType managed = show(cid, atid);

			if (managed != null) {
				aTRepo.delete(managed);
				deleted = true;
			}

		}
		return deleted;
	}

}
