package com.skilldistillery.country.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Country;

public interface CountryRepository extends JpaRepository<Country, Integer> {

	 List<Country> findByUser_username(String username);
	 Country findByUser_usernameAndId(String username, int cid);
	
}
