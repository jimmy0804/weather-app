//
//  WeatherSearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import XCTest
import CoreLocation

@testable import WeatherApp

// MARK: - Mock

class LocationManagerMock: LocationManager {
    private (set) var startUpdatingLocationWasCalled = false
    private (set) var requestWhenInUseAuthorizationWasCalled = false

    var location: CLLocation?
    var delegate: CLLocationManagerDelegate?
    
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyNearestTenMeters
    
    func startUpdatingLocation() {
        startUpdatingLocationWasCalled = true
        
    }
    
    func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationWasCalled = true
    }
}

class WeatherSearchViewModelDelegateMock: WeatherSearchViewModelProtocal {
    private (set) var location: CLLocationCoordinate2D?
    private (set) var didFailGettingCurrentLocationWasCalled = false

    func didRecieveCurrentLocation(_ location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    func didFailGettingCurrentLocation() {
        didFailGettingCurrentLocationWasCalled = true
    }
}

// MARK: - Tests

class WeatherSearchViewModelTests: XCTestCase {
    
    var delegate: WeatherSearchViewModelDelegateMock!
    var locationManager: LocationManagerMock!

    override func setUp() {
        super.setUp()
        delegate = WeatherSearchViewModelDelegateMock()
        locationManager = LocationManagerMock()
    }

    override func tearDown() {
        super.tearDown()
        delegate = nil
        locationManager = nil
    }

    func test_init() {
        let viewModel = WeatherSearchViewModel(delegate: delegate, locationManager: locationManager)
        
        XCTAssertNotNil(viewModel.delegate)
        XCTAssertNotNil(viewModel.locationManager)
    }
    
    func test_hasSearchKeywords_returnsExpectedValue() {
        let viewModel = WeatherSearchViewModel(delegate: delegate, locationManager: locationManager)
        let expectedKeywords = "TEST"
        viewModel.searchKeywords = expectedKeywords
        
        XCTAssertTrue(viewModel.searchKeywords == expectedKeywords)
        XCTAssertTrue(viewModel.hasSearchKeywords)
    }
    
    func test_hasHistory_returnsExpectedValue() {
        let viewModel = WeatherSearchViewModel(delegate: delegate, locationManager: locationManager)
        let expectedSearchHistory = [WeatherSearch]()
        
        viewModel.searchHistory = expectedSearchHistory
        
        XCTAssertTrue(viewModel.searchHistory.count == expectedSearchHistory.count)
        XCTAssertFalse(viewModel.hasSearchHistory)
    }
    
//    func test_getCurrentLocation_success() {
//        let expectedLocation = CLLocation(latitude: 55, longitude: 55)
//        locationManager.location = expectedLocation
//        let viewModel = WeatherSearchViewModel(delegate: delegate, locationManager: locationManager)
//
//        viewModel.getCurrentLocationIfAvailable()
//        XCTAssertNotNil(locationManager.location)
//        XCTAssertNotNil(delegate.location)
//        XCTAssertTrue(delegate.location! == expectedLocation.coordinate)
//    }
}
