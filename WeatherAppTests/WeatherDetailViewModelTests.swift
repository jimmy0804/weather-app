//
//  WeatherDetailViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import XCTest

@testable import WeatherApp

class WeatherDetailViewModelDelegateMock: WeatherDetailViewModelProtocal {
    private (set) var startsSearchingWasCalled = false
    private (set) var didFinishSearchingWasCalled = false
    private (set) var didFailedSearchingWasCalled = false
    
    private (set) var weatherResult: Weather?

    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, startsSearching search: WeatherSearch) {
        startsSearchingWasCalled = true
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFinishSearching search: WeatherSearch, withResult result: Weather) {
        weatherResult = result
        didFinishSearchingWasCalled = true
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFailedSearching search: WeatherSearch, withReason reason: String) {
        didFailedSearchingWasCalled = true
    }
}

class WeatherDetailViewModelTests: XCTestCase {
    
    var delegate: WeatherDetailViewModelDelegateMock!
    var networkRouter: NetworkRouter<WeatherApi>!
    var session: MockURLSession!

    override func setUp() {
        super.setUp()

        delegate = WeatherDetailViewModelDelegateMock()
        session = MockURLSession()
        networkRouter = NetworkRouter<WeatherApi>(session: session)
    }

    override func tearDown() {
        super.tearDown()

        delegate = nil
        networkRouter = nil
        session = nil
    }

    func test_init() {
        let weatherSearch = WeatherSearch(searchType: .cityName(name: "test"))
        let viewModel = WeatherDetailViewModel(weatherSearch: weatherSearch, delegate: delegate, networkRouter: networkRouter)

        XCTAssertNotNil(viewModel.weatherSearch)
        XCTAssertNotNil(viewModel.delegate)
        XCTAssertNotNil(viewModel.networkRouter)
    }
    
    func test_getWeatherDetail_byCityName() {
        let weatherSearch = WeatherSearch(searchType: .cityName(name: "test"))
        let viewModel = WeatherDetailViewModel(weatherSearch: weatherSearch, delegate: delegate, networkRouter: networkRouter)
        
        viewModel.getWeatherDetail()
    }
    
    func test_getWeatherDetail_byZipCode() {
        
    }
    
    func test_getWeatherDetail_byLocation() {
        
    }
}
