package com.skilldistillery.country.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Country {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	
	private String description;
	
	@Column(name="default_image")
	private String defaultImage;
	
	@JsonIgnoreProperties(value="country")
	@OneToMany(mappedBy = "country", cascade = {CascadeType.PERSIST,CascadeType.REMOVE})
	private List<ItineraryItem> itineraryItems;
	
	@JsonIgnoreProperties(value="country")
	@OneToMany(mappedBy = "country", cascade = {CascadeType.PERSIST,CascadeType.REMOVE})
	private List<Comment> comments;
	
	@JsonIgnoreProperties(value="country")
	@OneToMany(mappedBy = "country", cascade = {CascadeType.PERSIST,CascadeType.REMOVE})
	private List<Picture> pictures;
	
	@JsonIgnoreProperties(value="countries")
	@ManyToMany(mappedBy = "countries", cascade = {CascadeType.PERSIST,CascadeType.REMOVE})
	private List<AdviceType> adviceTypes;
	
	@Column(name="country_code")
	private String countryCode;
	
//////// methods
	public Country() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}


	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDefaultImage() {
		return defaultImage;
	}

	public void setDefaultImage(String defaultImage) {
		this.defaultImage = defaultImage;
	}

	public List<ItineraryItem> getItineraryItems() {
		return itineraryItems;
	}

	public void setItineraryItems(List<ItineraryItem> itineraryItems) {
		this.itineraryItems = itineraryItems;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Picture> getPictures() {
		return pictures;
	}

	public void setPictures(List<Picture> pictures) {
		this.pictures = pictures;
	}

	public List<AdviceType> getAdviceTypes() {
		return adviceTypes;
	}

	public void setAdviceTypes(List<AdviceType> adviceTypes) {
		this.adviceTypes = adviceTypes;
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
		Country other = (Country) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Country [id=" + id + ", name=" + name + ", description=" + description + ", defaultImage="
				+ defaultImage + "]";
	}


}
