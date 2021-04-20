package com.skilldistillery.country.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name="advice_type")
public class AdviceType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@Column(name = "advice_url")
	private String adviceUrl;

	@ManyToMany
	@JoinTable(name="country_advice_type",
			joinColumns = @JoinColumn(name="advice_type_id"),
			inverseJoinColumns = @JoinColumn(name="country_id"))
	@JsonIgnoreProperties(value="adviceTypes")
	private List<Country> countries;
	
// Methods
	
	// Constructors 

	public AdviceType() {
		super();
	}

	// Get / Set
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getAdviceUrl() {
		return adviceUrl;
	}

	public void setAdviceUrl(String adviceUrl) {
		this.adviceUrl = adviceUrl;
	}

	// Hash / Equals
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
		AdviceType other = (AdviceType) obj;
		if (id != other.id)
			return false;
		return true;
	}

	// toString
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AdviceType [id=").append(id).append(", name=").append(name).append(", description=")
				.append(description).append(", adviceUrl=").append(adviceUrl).append("]");
		return builder.toString();
	}
	
	
	
}
