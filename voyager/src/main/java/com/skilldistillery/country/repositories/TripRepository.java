package com.skilldistillery.country.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Trip;

public interface TripRepository extends JpaRepository<Trip, Integer> {
	List<Trip> findByUser_username(String username);
	Trip findByUser_usernameAndId(String username, int id);
}
