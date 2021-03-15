package com.techelevator.services;

import com.techelevator.models.City;
import com.techelevator.models.Hotel;
import com.techelevator.models.Review;
import org.springframework.web.client.RestTemplate;

public class HotelService {

    private final String GET_BASE_URL = null;
	private final String API_BASE_URL;
    private RestTemplate restTemplate = new RestTemplate();

    public HotelService(String apiURL) {
        API_BASE_URL = apiURL;
    }

    public Hotel[] listHotels() {
        return restTemplate.getForObject(API_BASE_URL + "/hotels", Hotel[].class);
    }

    public Review[] listReviews() {
        return restTemplate.getForObject(GET_BASE_URL + "/reviews", Review[].class);
    }

    public Hotel getHotelById(int id) {
      
		return restTemplate.getForObject(API_BASE_URL + "/hotels/" + id , Hotel.class)
    }

    public Review[] getReviewsByHotelId(int hotelID) {

    	return restTemplate.getForObject(API_BASE_URL + "/hotels/" + hotelID + "/reviews", Review[].class);
    }

    public Hotel[] getHotelsByStarRating(int stars) {
        
    	return restTemplate.getForObject(API_BASE_URL + "/hotels?stars=" + stars, Hotel[].class)
    }

    public City getWithCustomQuery(){
        return null;
    }

}
