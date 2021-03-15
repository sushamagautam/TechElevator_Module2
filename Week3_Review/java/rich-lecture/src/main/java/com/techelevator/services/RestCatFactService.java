package com.techelevator.services;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.techelevator.model.CatFact;

@Component
public class RestCatFactService implements CatFactService {

	private static final String FACT_API_URL = "https://cat-fact.herokuapp.com/facts/random";
	private RestTemplate catFactTemplate = new RestTemplate();
	
	
	
	@Override
	public CatFact getFact() {
		
	
		CatFact fact = catFactTemplate.getForObject(FACT_API_URL, CatFact.class);
		
		return fact;
	}

}
