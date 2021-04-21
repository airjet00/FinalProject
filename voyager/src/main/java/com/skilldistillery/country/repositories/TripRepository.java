package com.skilldistillery.country.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.AdviceType;

public interface TripRepository extends JpaRepository<AdviceType, Integer> {

}
