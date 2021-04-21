package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public List<Picture> index() {
		return picRepo.findAll();
	}

	@Override
	public Picture show(int pid) {
		Picture picture = null;
		Optional<Picture> opt = picRepo.findById(pid);
		if (opt.isPresent())
			picture = opt.get();
		return picture;
	}

	@Override
	public Picture create(String username, Picture picture) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {
			return picRepo.saveAndFlush(picture);
		}
		return null;
	}

	@Override
	public Picture update(String username, Picture picture, int pid) {
		User user = userRepo.findByUsername(username);

		if (user.getRole().equals("admin")) {

			Picture managed = null;
			Optional<Picture> opt = picRepo.findById(pid);
			if (opt.isPresent())
				managed = opt.get();

			if (managed != null) {

				managed.setCountry(picture.getCountry());
				managed.setImageUrl(picture.getImageUrl());
				managed = picRepo.saveAndFlush(managed);
				return managed;

			}
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int pid) {
		User user = userRepo.findByUsername(username);
		boolean deleted = false;

		if (user.getRole() == "admin") {
			Picture managed = show(pid);

			if (managed != null) {
				picRepo.delete(managed);
				deleted = true;
			}

		}
		return deleted;
	}
}