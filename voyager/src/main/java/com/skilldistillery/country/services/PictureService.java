package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.Picture;

public interface PictureService {

	List<Picture> index(int cid);
	
	Picture show(int cid, int pid);
	
	Picture create(String username, int cid, Picture picture);
	
	Picture update(String username, int cid, Picture newPicture, int pid);
	
	boolean destroy(String username, int cid, int pid);
	
}
