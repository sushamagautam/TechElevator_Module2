package com.techelevator.auctions.controller;

import com.techelevator.auctions.DAO.AuctionDAO;
import com.techelevator.auctions.DAO.MemoryAuctionDAO;
import com.techelevator.auctions.model.Auction;


import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController


@RequestMapping("/auctions")

public class AuctionController {

    private AuctionDAO dao;

    public AuctionController() {
        this.dao = new MemoryAuctionDAO();
    }

    //implement a list() method
    
    @RequestMapping(method = RequestMethod.GET)
    public List<Auction> list(@RequestParam(defaultValue = "") String title_like, 
    					@RequestParam(defaultValue = "0") double currentBid_lte) {
       
    	if((title_like != "") && (currentBid_lte != 0)) {
    		List<Auction> list = dao.searchByTitleAndPrice(title_like, currentBid_lte);
    				return list;
    	}
    	
    	else if(title_like != "") {
    		return dao.searchByTitle(title_like);
    	
    	}
    	else if(currentBid_lte != 0) {
    		return dao.searchByPrice(currentBid_lte);
    	}
    	
    	return dao.list();
    }
    
    //implement the get() method
    
    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public Auction get(@PathVariable int id) {
    	return dao.get(id);
    }
    
    
    //implement the create() method
    
    @RequestMapping(method = RequestMethod.POST)
    public Auction addAuction(@RequestBody Auction newAuction) {
    	return dao.create(newAuction);
    }
    
  
    
   
    
    
    
}
