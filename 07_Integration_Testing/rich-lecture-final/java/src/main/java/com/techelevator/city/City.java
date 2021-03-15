package com.techelevator.city;

public class City {
	private Long id;
	private String name;
	private String countryCode;
	private String district;
	private int population;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public int getPopulation() {
		return population;
	}

	public void setPopulation(int population) {
		this.population = population;
	}
	
	@Override
	public String toString() {
		return this.id +":"+ this.name +":"+ this.district +":"+ this.countryCode +":"+ this.population;
	}
	
	@Override
	public boolean equals(Object objectToCompare) {
		boolean result = false;
		City comparisonCity = (City)objectToCompare;
		if(
				comparisonCity.id.equals(this.id) &&
				comparisonCity.countryCode.equals(this.countryCode) &&
				comparisonCity.district.equals(this.district) &&
				comparisonCity.name.equals(this.name) &&
				comparisonCity.population == this.population				
				) {result = true;}
		
		return result;
			
	}
	
}
