package com.techelevator.reservations.controllers;

import com.techelevator.reservations.dao.HotelDAO;
import com.techelevator.reservations.dao.MemoryHotelDAO;
import com.techelevator.reservations.dao.MemoryReservationDAO;
import com.techelevator.reservations.dao.ReservationDAO;
import com.techelevator.reservations.models.Hotel;
import com.techelevator.reservations.models.Reservation;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

public class HotelController {

    private HotelDAO hotelDAO;
    private ReservationDAO reservationDAO;

    public HotelController() {
        this.hotelDAO = new MemoryHotelDAO();
        this.reservationDAO = new MemoryReservationDAO(hotelDAO);
    }

    /**
     * Return All Hotels
     *
     * @return a list of all hotels in the system
     */
    @RequestMapping(path = "/hotels/{id}", method = RequestMethod.GET)
    public List<Hotel> list() {
        return hotelDAO.list();
    }

    /**
     * Return hotel information
     *
     * @param id the id of the hotel
     * @return all info for a given hotel
     */
    @RequestMapping(path = "/hotels/{id}", method = RequestMethod.GET)
    public Hotel get(@PathVariable int id) {
        return hotelDAO.get(id);
    }
    
    /**
     * Get a reservation by it's id
     *
     * @param id 
     * @return a single reservation
     */
    @RequestMapping(path = "/reservations/{id}", method = RequestMethod.GET)
    public Reservation getReservation(@PathVariable int id) {
    	//simply return the DAO get method
    	return reservationDAO.get(id);
    }
    
    /**
     * List of reservations by hotel
     *
     * @param hotelID
     * @return all reservations for a given hotel
     */
    
    @RequestMapping(path="/hotels/{hotelID}/reservations", method = RequestMethod.GET)
    public List<Reservation> getReservationsByHotel(@PathVariable int hotelID){
    	
    	return reservationDAO.findByHotel(hotelID);
    }
    
    /**
     * Create a new reservation for a given hotel
     *
     * @param reservation 
     * @return hotelID
     */
    
    @RequestMapping(path = "/hotels/{hotelID}/reservations", method = RequestMethod.POST)
    public Reservation addReservation(@RequestBody Reservation newReservation, @PathVariable int hotelID) {
    	
    	return reservationDAO.create(newReservation, hotelID);
    }
    
    
    /**
     *hotels/filter?state=oh&city=cleveland
     *
     * @param state the state to filter by
     * @param city the city to filter by
     * @return a list of hotels that match the city and state
     */
    
    @RequestMapping(path = "/hotels/filter", method = RequestMethod.GET)
    public List<Hotel> filterHotelsByStateCity(@RequestParam String state, @RequestParam String city){
    
    	List<Hotel> hotels = new ArrayList<>();
    	
    	List<Hotel> filteredHotels = new ArrayList<>();
    	
    	hotels.addAll(listHotels());
    	
    	for(Hotel h : hotels) {
    		if(city != null) {
    			if(h.getAddress().getCity().toLowerCase().equals(state.toLowerCase())) {
    				filteredHotels.add(h);
    			}
    			
    		}
    		else {
    			if(h.getAddress().getState().toLowerCase().equals(state).toLowerCase()) {
    				filterdHotels.add(h);
    			}
    		}
    		
    	}
    	
    }
    
}













