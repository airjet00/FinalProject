package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.Country;

public interface CountryService {

	public List<Country> index();

	public Country show(int cid);

	public Country create(Country country);

	public Country update(int cid, Country country);

	public boolean destroy(int cid);
}
