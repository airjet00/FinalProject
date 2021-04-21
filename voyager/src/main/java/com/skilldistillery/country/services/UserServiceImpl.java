package com.skilldistillery.country.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired 
	private UserRepository userRepo;

	@Override
	public List<User> index(String username) {
		List<User> users = null;
		User user = userRepo.findByUsername(username);
		// TODO Change "user" to "admin"
		if (user != null && user.getRole().equalsIgnoreCase("admin")) {
			 users = userRepo.findAll();
		}
		return users;
	}

	@Override
	public User show(String username, int uid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User create(String username, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User update(String username, int uid, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean destroy(String username, int uid) {
		// TODO Auto-generated method stub
		return false;
	}
}
