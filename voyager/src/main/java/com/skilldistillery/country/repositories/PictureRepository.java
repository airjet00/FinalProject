package com.skilldistillery.country.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Picture;

public interface PictureRepository extends JpaRepository<Picture, Integer> {
	List<Picture> findByCountry_id(int cid);
	Picture findByCountry_idAndId(int cid, int pid);
}
