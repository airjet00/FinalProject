package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.AdviceType;

public interface AdviceTypeService {

	List<AdviceType> index(int cid);
	
	AdviceType show(int cid, int atid);
	
	AdviceType create(String username, int cid, AdviceType adviceType);
	
	AdviceType update(String username, int cid, AdviceType adviceType, int atid);
	
	boolean destroy(String username, int cid, int atid);
	
}
