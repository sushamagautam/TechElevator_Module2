package com.techelevator.dao;

import com.techelevator.model.Park;

import java.util.List;

public interface ParkDAO {

    List<Park> getAllParks();
    public List<Park> getParkInfo (long choice);
    public List<Park> getAllCampgroundsByParkId();
	List<Park> getParkInfo(int parkId);
}
