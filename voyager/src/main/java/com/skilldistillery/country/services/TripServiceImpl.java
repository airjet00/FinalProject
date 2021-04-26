package com.skilldistillery.country.services;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.country.entities.ItineraryItem;
import com.skilldistillery.country.entities.Trip;
import com.skilldistillery.country.entities.User;
import com.skilldistillery.country.repositories.TripRepository;
import com.skilldistillery.country.repositories.UserRepository;

@Service
@Transactional
public class TripServiceImpl implements TripService {
	
	@Autowired
	TripRepository tripRepo;
	
	@Autowired
	UserRepository userRepo;

	@Override
	public List<Trip> index(String username) {
		return tripRepo.findByUser_username(username);
	}

	@Override
	public Trip show(int tid) {
		Trip trip = null;
		Optional<Trip> opt = tripRepo.findById(tid);
		if(opt.isPresent()) {
			trip = opt.get();
			return trip;
		}
		
		return trip;
	}

	@Override
	public Trip create(String username, Trip trip) {
		User user = userRepo.findByUsername(username);

		if(user != null) {
			trip.setUser(user);
			trip = tripRepo.save(trip);
		} else {
			trip = null;
		}
		
		return trip;
	}

	@Override
	public Trip update(String username, int tid, Trip trip) {
		Trip managed = tripRepo.findByUser_usernameAndId(username, tid);
		
		if(managed != null) {
			managed.setName(trip.getName());
			managed.setDescription(trip.getDescription());
			managed.setCompleted(trip.getCompleted());
			managed.setStartDate(trip.getStartDate());
			managed.setEndDate(trip.getEndDate());
			managed.setEnabled(trip.getEnabled());
			
			// Handle changes to itineraryItem
			// Add in new iItems
			for (ItineraryItem iItem : trip.getItineraryItems()) {
				if (managed.getItineraryItems() == null || !managed.getItineraryItems().contains(iItem)) {
					managed.addItineraryItems(iItem);
				}
			}
			// Remove desired iItems
			if (managed.getItineraryItems() != null) {
				for (ItineraryItem iItem : managed.getItineraryItems()) {
					// If no iItems, remove all
					if (trip.getItineraryItems() == null) {
						managed.removeItineraryItems(iItem);
					} // If trip doesn't have an iItem managed does, remove iItem from managed
					else if (!trip.getItineraryItems().contains(iItem)) {
						managed.removeItineraryItems(iItem);
					}
				}	
			}
			
			managed = tripRepo.save(managed);
		}
		else {
			managed = null;
		}
		
		return managed;
	}

	@Override
	public boolean destroy(String username, int tid) {
		Trip managed = show(tid);
		boolean deleted = false;
		
		if(managed != null) {
			managed.setEnabled(false);
			tripRepo.save(managed);
			deleted = true;
		}
		
		
		return deleted;
	}

}
