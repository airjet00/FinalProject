package com.skilldistillery.country.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired 
	private UserRepository userRepo;
}
