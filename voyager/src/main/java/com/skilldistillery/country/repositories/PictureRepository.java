package com.skilldistillery.country.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.country.entities.Picture;

public interface PictureRepository extends JpaRepository<Picture, Integer> {

}
