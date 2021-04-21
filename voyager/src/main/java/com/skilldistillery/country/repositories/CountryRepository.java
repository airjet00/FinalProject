package com.skilldistillery.country.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Country;

public interface CountryRepository extends JpaRepository<Country, Integer> {
	List<Country> findByNameLikeOrDescriptionLike(String keyword1, String keyword2);
}
