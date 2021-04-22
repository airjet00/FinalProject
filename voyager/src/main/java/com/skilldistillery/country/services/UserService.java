package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.User;

public interface UserService {

	public List<User> index(String username);

	public User show(String username, int uid);
	
	public User showByUserName(String username);

	public User create(String username, User user);

	public User update(String username, int uid, User user);

	public int deactivate(String username, int uid);

}
