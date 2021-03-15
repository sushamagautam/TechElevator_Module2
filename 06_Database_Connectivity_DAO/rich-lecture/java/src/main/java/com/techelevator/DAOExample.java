package com.techelevator;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.dbcp2.BasicDataSource;

import com.techelevator.city.City;
import com.techelevator.city.CityDAO;
import com.techelevator.city.JDBCCityDAO;

public class DAOExample {

	public static void main(String[] args) {
	
		BasicDataSource worldDataSource = new BasicDataSource();
		worldDataSource.setUrl("jdbc:postgresql://localhost:5432/world");
		worldDataSource.setUsername("postgres");
		worldDataSource.setPassword("postgres1");
		
		CityDAO cityDAO = new JDBCCityDAO(worldDataSource);
		
		City smallville = new City();
		smallville.setCountryCode("USA");
		smallville.setDistrict("KS");
		smallville.setName("Smallville");
		smallville.setPopulation(42080);
		
		cityDAO.save(smallville);
		
		City theCity = cityDAO.findCityById(smallville.getId());
		
		System.out.println(theCity.toString());
		
		List<City> cities = cityDAO.findCityByCountryCode("USA");
		
		for(City c : cities) {
			System.out.println(c.toString());
		}
		
		City phoenixVille = new City();
		phoenixVille.setCountryCode("USA");
		phoenixVille.setDistrict("PA");
		phoenixVille.setName("Phoenixville");
		phoenixVille.setPopulation(8200);
		
		cityDAO.save(phoenixVille);
		
	}

}
