package com.techelevator.dao.jdbc;

import com.techelevator.dao.ParkDAO;
import com.techelevator.model.Campground;
import com.techelevator.model.Park;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

public class JDBCParkDAO implements ParkDAO {

    private JdbcTemplate jdbcTemplate;

    public JDBCParkDAO(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }
    
   @Override
   
   public List<Park> getAllParks(){
		List<Park> parkList = new ArrayList<>();
		String query = "SELECT * FROM park ORDER BY location asc";
		
		SqlRowSet rowSet = jdbcTemplate.queryForRowSet(query);
		while(rowSet.next()) {
			parkList.add(mapRowToPark(rowSet));
		}
		return parkList;
	}
   
   

    private Park mapRowToPark(SqlRowSet results) {
        Park park = new Park();
        park.setParkId(results.getInt("park_id"));
        park.setName(results.getString("name"));
        park.setLocation(results.getString("location"));
        park.setEstablishDate(results.getDate("establish_date").toLocalDate());
        park.setArea(results.getInt("area"));
        park.setVisitors(results.getInt("visitors"));
        park.setDescription(results.getString("description"));
        return park;
    }

	@Override
	public List<Park> getParkInfo(long choice){
		List<Park> parkList = new ArrayList<>();
				String query = ("SELECT * FROM park WHERE park_id=?");
				jdbcTemplate.update(query,choice);
				SqlRowSet rowSet= jdbcTemplate.queryForRowSet(query);
				while(rowSet.next()){
					parkList.add(mapRowToPark(rowSet));
				}
		return parkList;
	}

	@Override
	public List<Park> getAllCampgroundsByParkId() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Park> getParkInfo(int parkId) {
		// TODO Auto-generated method stub
		return null;
	}



	

   

}
