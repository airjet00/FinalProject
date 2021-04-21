package com.skilldistillery.country.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "itinerary_item")
public class ItineraryItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="sequence_num")
	private Integer sequenceNum;
	
	private String notes;

	@ManyToOne
	@JoinColumn(name="trip_id")
	private Trip trip;
	
	@ManyToOne
	@JsonIgnoreProperties(value={"itineraryItems","comments"})
	@JoinColumn(name="country_id")
	private Country country;


//////// methods
	public ItineraryItem() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getSequenceNumber() {
		return sequenceNum;
	}

	public void setSequenceNumber(Integer sequenceNum) {
		this.sequenceNum = sequenceNum;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public Trip getTrip() {
		return trip;
	}

	public void setTrip(Trip trip) {
		this.trip = trip;
	}

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ItineraryItem other = (ItineraryItem) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ItineraryItem [id=" + id + ", sequenceNum=" + sequenceNum + ", notes=" + notes + "]";
	}


}
