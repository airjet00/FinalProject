package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.User;

public interface UserService {

	public List<User> index(String username);

	public User show(String username, int uid);

	public User create(String username, User user);

	public User update(String username, int uid, User user);

	public boolean destroy(String username, int uid);

}
