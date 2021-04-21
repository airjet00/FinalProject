package com.skilldistillery.country.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername (String username);
}
