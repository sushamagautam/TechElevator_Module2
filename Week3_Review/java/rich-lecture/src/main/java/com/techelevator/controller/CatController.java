package com.techelevator.controller;

import com.techelevator.model.CatCard;
import com.techelevator.model.CatCardDAO;
import com.techelevator.model.CatFact;
import com.techelevator.model.CatPic;
import com.techelevator.services.CatFactService;
import com.techelevator.services.CatPicService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/cards")
public class CatController {

    private CatCardDAO catCardDao;
    private CatFactService catFactService;
    private CatPicService catPicService;

    public CatController(CatCardDAO catCardDao, CatFactService catFactService, CatPicService catPicService) {
        this.catCardDao = catCardDao;
        this.catFactService = catFactService;
        this.catPicService = catPicService;
    }

    
    // *** API CALLS ***
    
    //Generate a new randomized cat card
    @RequestMapping(path="/random", method = RequestMethod.GET)
    public CatCard makeNewCard() {
    	
    	CatPic pic = catPicService.getPic();
    	CatFact fact = catFactService.getFact();
    	
    	CatCard card = new CatCard();
    	
    	card.setImgUrl(pic.getFile());
    	card.setCatFact(fact.getText());
    	
    	return card;
    }
    
    // *** JDBC CALLS
    
    
    //Get ALL saved cards for base API URL
    @RequestMapping(path="", method = RequestMethod.GET)
    public List<CatCard> getAllSavedCards(){
    	return catCardDao.list();
    }
    
    //Save the currently displayed card as a new card
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "", method = RequestMethod.POST)
    public void saveNewCard(@Valid @RequestBody CatCard incomingCard) {
    	
    	catCardDao.save(incomingCard);
    	
    }
    
    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public CatCard getSavedCardByID(@PathVariable long id) {
    	
    	return catCardDao.get(id);
    }
    
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @RequestMapping(path = "/{id}", method = RequestMethod.DELETE)
    public void deleteExistingCard(@PathVariable long id) {
    	if(catCardDao.get(id) != null) {
    		catCardDao.delete(id);
    	}
    }
    
    
}
