package com.skilldistillery.country.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Country;

public interface CountryRepository extends JpaRepository<Country, Integer> {

}
