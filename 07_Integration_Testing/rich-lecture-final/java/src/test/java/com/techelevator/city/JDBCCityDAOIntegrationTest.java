package com.techelevator.city;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.SQLException;
import java.util.List;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.FixMethodOrder;
import org.junit.runners.MethodSorters;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.SingleConnectionDataSource;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class JDBCCityDAOIntegrationTest {

	private static final String TEST_COUNTRY = "ZZZ";
	private static final String TEST_DISTRICT = "Tech Elevator";

	/* Using this particular implementation of DataSource so that
	 * every database interaction is part of the same database
	 * session and hence the same database transaction */
	private static SingleConnectionDataSource dataSource;
	private JDBCCityDAO dao;

	/* Before any tests are run, this method initializes the datasource for testing. */
	@BeforeClass
	public static void setupDataSource() {
		dataSource = new SingleConnectionDataSource();
		dataSource.setUrl("jdbc:postgresql://localhost:5432/world");
		dataSource.setUsername("postgres");
		dataSource.setPassword("postgres1");
		/* The following line disables autocommit for connections
		 * returned by this DataSource. This allows us to rollback
		 * any changes after each test */
		dataSource.setAutoCommit(false);
	}

	/* After all tests have finished running, this method will close the DataSource */
	@AfterClass
	public static void closeDataSource() throws SQLException {
		dataSource.destroy();
	}

	@Before
	public void setup() {
		String sqlInsertCountry = "INSERT INTO country (code, name, continent, region, surfacearea, indepyear, population, lifeexpectancy," + 
									" gnp, gnpold, localname, governmentform, headofstate, capital, code2)" + 
									" VALUES (?, 'Afghanistan', 'Asia', 'Southern and Central Asia', 652090, 1919, 22720000, 45.9000015," + 
									" 5976.00, NULL, 'Afganistan/Afqanestan', 'Islamic Emirate', 'Mohammad Omar', 1, 'AF')";
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		jdbcTemplate.update(sqlInsertCountry, TEST_COUNTRY);
		dao = new JDBCCityDAO(dataSource);
	}

	/* After each test, we rollback any changes that were made to the database so that
	 * everything is clean for the next test */
	@After
	public void rollback() throws SQLException {
		dataSource.getConnection().rollback();
	}

	@Test
	public void save_new_city_and_read_it_back() throws SQLException {
		City insertCity = getCity("SQL Station", "South Dakota", "USA", 65535);

		dao.save(insertCity);
		
		// IF I WANT TO VALIDATE THE SAVE, I HAVE TO BE ABLE TO SELECT THAT CITY BACK AND CHECK IT AGAINST THE CITY DATA I INSERTED
		City retrieveSavedCity = dao.findCityById(insertCity.getId());

		assertNotEquals(null, insertCity.getId());
		
		// CUSTOM METHOD TO EVALUATE CITY EQUALITY *WHEN* CITY OBJECT DOES NOT HAVE AN EQUALS OVEDRRIDE
		assertCitiesAreEqual(insertCity, retrieveSavedCity);
		
		// STANDARD assertEquals WHEN THE CITY OBJECT DOES HAVE AN EQUALS OVERRIDE
		assertEquals(insertCity, retrieveSavedCity);
	}

	@Test
	public void returns_cities_by_country_code() {
		City testCity = getCity("SQL Station", "South Dakota", TEST_COUNTRY, 65535);
		City testCity2 = getCity("SQL Junction", "South Dakota", TEST_COUNTRY, 65535);

		dao.save(testCity);
		dao.save(testCity2);
		
		List<City> cityList = dao.findCityByCountryCode(TEST_COUNTRY);

		assertNotNull(cityList);
		
		assertEquals(2, cityList.size());
		
		City savedCity = cityList.get(0);
		
		// CUSTOM METHOD TO EVALUATE CITY EQUALITY *WHEN* CITY OBJECT DOES NOT HAVE AN EQUALS OVEDRRIDE
		assertCitiesAreEqual(testCity, savedCity);
		// STANDARD assertEquals WHEN THE CITY OBJECT DOES HAVE AN EQUALS OVERRIDE
		assertEquals(savedCity, testCity);
		
		savedCity = cityList.get(1);
		// CUSTOM METHOD TO EVALUATE CITY EQUALITY *WHEN* CITY OBJECT DOES NOT HAVE AN EQUALS OVEDRRIDE
		assertCitiesAreEqual(savedCity, testCity2);
		// STANDARD assertEquals WHEN THE CITY OBJECT DOES HAVE AN EQUALS OVERRIDE
		assertEquals(savedCity, testCity2);
	}

	// THIS TEST IS SUSPECT AND PROBABLY HAS SOME BAD ASSUMPTIONS, WHY OR WHY NOT?
	@Test
	public void returns_multiple_cities_by_country_code() {

		dao.save(getCity("SQL Station", "South Dakota", TEST_COUNTRY, 65535));
		dao.save(getCity("Postgres Point", "North Dakota", TEST_COUNTRY, 65535));

		List<City> results = dao.findCityByCountryCode(TEST_COUNTRY);

		assertNotNull(results);
		assertEquals(2, results.size());
	}

	@Test
	public void returns_cities_by_district() {
		//SHOULD BE A CONSTANT, SO WE MADE IT ONE
		//String testDistrict = "Tech Elevator";
		
		City testCity = getCity("SQL Station", TEST_DISTRICT, TEST_COUNTRY, 65535);
		dao.save(testCity);

		List<City> cityList = dao.findCityByDistrict(TEST_DISTRICT);

		assertNotNull(cityList);
		assertEquals(1, cityList.size());
		City returnedCity = cityList.get(0);
		
		assertCitiesAreEqual(testCity, returnedCity);
	}
	
	@Test
	public void update_city_SQL_STATION_TO_SQL_JUNCTION() {
		
		City testCity = getCity("SQL Station", TEST_DISTRICT, TEST_COUNTRY, 65535);
		dao.save(testCity);
		
		
		City newCityData = getCity("SQL Junction", TEST_DISTRICT, TEST_COUNTRY, 65535);
		newCityData.setId(testCity.getId());
		
		dao.update(newCityData);
		
		City updatedCity = dao.findCityById(testCity.getId());
		
		assertEquals(newCityData.getName(), updatedCity.getName());
		
	}

	private City getCity(String name, String district, String countryCode, int population) {
		City theCity = new City();
		theCity.setName(name);
		theCity.setDistrict(district);
		theCity.setCountryCode(countryCode);
		theCity.setPopulation(population);
		return theCity;
	}

	private void assertCitiesAreEqual(City expected, City actual) {
		assertEquals(expected.getId(), actual.getId());
		assertEquals(expected.getName(), actual.getName());
		assertEquals(expected.getDistrict(), actual.getDistrict());
		assertEquals(expected.getCountryCode(), actual.getCountryCode());
		assertEquals(expected.getPopulation(), actual.getPopulation());
	}
}
