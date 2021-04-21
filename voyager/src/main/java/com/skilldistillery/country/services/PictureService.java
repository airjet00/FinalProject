package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.Picture;

public interface PictureService {

	List<Picture> index();
	
	Picture show(int pid);
	
	Picture create(String username, Picture picture);
	
	Picture update(String username, Picture newPicture, int pid);
	
	boolean destroy(String username, int pid);
	
	
	
}
