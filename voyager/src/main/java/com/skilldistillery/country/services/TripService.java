package com.skilldistillery.country.services;

import java.util.List;

import com.skilldistillery.country.entities.Trip;

public interface TripService {
    public List<Trip> index(String username);

    public Trip show(int tid);

    public Trip create(String username, Trip trip);

    public Trip update(String username, int tid, Trip trip);

    public boolean destroy(String username, int tid);
}
