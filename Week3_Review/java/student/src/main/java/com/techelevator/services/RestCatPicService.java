package com.techelevator.services;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.techelevator.model.CatPic;

@Component
public class RestCatPicService implements CatPicService {

	private static final String PIC_API_URL =  "";
	private RestTemplate catAPITemplate = new RestTemplate();
	
	
	
	@Override
	public CatPic getPic() {
		
		CatPic cat = catAPITemplate.getForObject(PIC_API_URL, CatPic.class);
		
		return cat;
	}

}	
