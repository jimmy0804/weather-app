//
//  WeatherModelTests.swift
//  WeatherAppTests
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherModelTests: XCTestCase {
    let exampleRespondJson = """
{
"coord": {
"lon": -0.13,
"lat": 51.51
},
"weather": [
{
"id": 300,
"main": "Drizzle",
"description": "light intensity drizzle",
"icon": "09d"
}
],
"base": "stations",
"main": {
"temp": 280.32,
"pressure": 1012,
"humidity": 81,
"temp_min": 279.15,
"temp_max": 281.15
},
"visibility": 10000,
"wind": {
"speed": 4.1,
"deg": 80
},
"clouds": {
"all": 90
},
"dt": 1485789600,
"sys": {
"type": 1,
"id": 5091,
"message": 0.0103,
"country": "GB",
"sunrise": 1485762037,
"sunset": 1485794875
},
"id": 2643743,
"name": "London",
"cod": 200
}
"""
    var jsonData: Data!
    
    override func setUp() {
        jsonData = Data(exampleRespondJson.utf8)
    }

    override func tearDown() {
        jsonData = nil
    }

    func testWeatherModelCanBeDecodedCorrectly() {
        let decoder = JSONDecoder()
        
        do {
            let weather = try decoder.decode(Weather.self, from: jsonData)
            XCTAssertEqual(weather.id, 2643743)
            XCTAssertEqual(weather.cityName, "London")
            
            XCTAssertEqual(weather.detail.temperture, 280.32)
            XCTAssertEqual(weather.detail.humidity, 81)
            XCTAssertEqual(weather.detail.minTemperture, 279.15)
            XCTAssertEqual(weather.detail.maxTemperture, 281.15)
            XCTAssertNil(weather.detail.groundLevelAtmosphericPressure)
            XCTAssertNil(weather.detail.seaLevelAtmosphericPressure)
            
            
            XCTAssertEqual(weather.wind.speed, 4.1)
            XCTAssertEqual(weather.wind.degree, 80)
            
            XCTAssertEqual(weather.geoLocation.longitude, -0.13)
            XCTAssertEqual(weather.geoLocation.latitude, 51.51)
            
            XCTAssertEqual(weather.clouds.cloudiness, 90)
            
            XCTAssertNil(weather.rain)
            
            XCTAssertNil(weather.snow)
        } catch {
            XCTFail("Failed to decode JSON to Weather model")
        }
    }
    
    
}
