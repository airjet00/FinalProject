package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.Country;

public interface CountryService {

	public List<Country> index();

	public Country show(int cid);

	public Country create(String username, Country country);

	public Country update(String username, int cid, Country country);

	public boolean destroy(String username, int cid);

	public List<Country> searchByKeyword(String keyword);
}
