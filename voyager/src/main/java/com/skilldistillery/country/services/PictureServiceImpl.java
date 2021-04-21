package com.skilldistillery.country.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.Country;
import com.skilldistillery.country.entities.Picture;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.PictureRepository;
import com.skilldistillery.country.repositories.UserRepository;

@Service
@Transactional
public class PictureServiceImpl implements PictureService {

	@Autowired
	PictureRepository picRepo;

	@Autowired
	UserRepository userRepo;

	@Override
	public List<Picture> index(int cid) {
		return picRepo.findByCountry_id(cid);
	}

	@Override
	public Picture show(int cid, int pid) {
		return picRepo.findByCountry_idAndId(cid, pid);
	}

	@Override
	public Picture create(String username, int cid, Picture picture) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {
			Country country = new Country();
			country.setId(cid);
			picture.setCountry(country);
			return picRepo.saveAndFlush(picture);
		}
		return null;
	}

	@Override
	public Picture update(String username, int cid, Picture picture, int pid) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {

			Picture managed = show(cid, pid);

			if (managed != null) {

//				managed.setCountry(picture.getCountry());
				managed.setImageUrl(picture.getImageUrl());
				managed = picRepo.saveAndFlush(managed);
				return managed;

			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int cid, int pid) {
		User user = userRepo.findByUsername(username);
		boolean deleted = false;

		if (user.getRole().equals("admin")) {
			Picture managed = show(cid, pid);

			if (managed != null) {
				picRepo.delete(managed);
				deleted = true;
			}

		}
		return deleted;
	}
}