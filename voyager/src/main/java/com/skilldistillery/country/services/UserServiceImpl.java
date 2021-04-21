package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

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
		User adminUser = userRepo.findByUsername(username);
		User user = null;
		if(!adminUser.getRole().equalsIgnoreCase("admin")) {
			user = new User();
			user.setId(-10);
			return user;
		}
		
		Optional<User> oUser = userRepo.findById(uid);
		// check optional
		if (oUser.isPresent()) {
			user = oUser.get();
		}
		return user;
	}
// Handled in the AuthSvc (in order to properly set password in DB
	@Override
	public User create(String username, User user) {
		
		return null;
	}

	@Override
	public User update(String username, int uid, User user) {
		User requestingUser = userRepo.findByUsername(username);
		User dbUser = null;
		
		if(requestingUser != null && (requestingUser.getRole().equalsIgnoreCase("admin") || requestingUser.getId() == uid)) {
			Optional<User> oDbUser = userRepo.findById(uid);			
			if(oDbUser.isPresent()) {
				dbUser = oDbUser.get();
			} else {
				return null;
			}
			// Will not change any field to null if not provided.
			if(user.getEmail() != null) {
				dbUser.setEmail(user.getEmail());				
			}
			if(user.getFirstName() != null) {
				dbUser.setFirstName(user.getFirstName());
			}
			if(user.getMiddleName() != null) {
				dbUser.setMiddleName(user.getMiddleName());
			}
			if(user.getLastName() != null) {
				dbUser.setLastName(user.getLastName());
			}
			if(user.getSuffix() != null) {
				dbUser.setSuffix(user.getSuffix());
			}
			if(user.getDob() != null) {
				dbUser.setDob(user.getDob());
			}
			if(user.getEnabled() != null) {
				dbUser.setEnabled(user.getEnabled());
			}
			// Only Admin users can alter a user's role
			if(requestingUser.getRole().equalsIgnoreCase("admin")) {
				if(user.getRole() != null) {
					dbUser.setRole(user.getRole());	
				}
			}
			
			userRepo.saveAndFlush(dbUser);
			
		} else {
			User noAuthUser = new User();
			noAuthUser.setId(-10);
			return noAuthUser;
		}
		
		return dbUser;
	}

	@Override
	public int deactivate(String username, int uid) {
		User requestingUser = userRepo.findByUsername(username);
		User dbUser = null;	
		if(requestingUser != null && (requestingUser.getRole().equalsIgnoreCase("admin") || requestingUser.getId() == uid)){
			Optional<User> oDbUser = userRepo.findById(uid);	
			
			if(oDbUser.isPresent()) {
				dbUser = oDbUser.get();
				dbUser.setEnabled(false);
				userRepo.saveAndFlush(dbUser);
				return 204;
			} else {
				return 404;
			}
		} else {
			return 401;
		}
	}
}
