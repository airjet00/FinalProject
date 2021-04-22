package com.skilldistillery.country.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.AdviceType;

public interface AdviceTypeRepository extends JpaRepository<AdviceType, Integer> {
	List<AdviceType> findByCountries_id(int cid);
	AdviceType findByCountries_idAndId(int cid, int id);
}
