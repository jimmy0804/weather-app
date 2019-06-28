//
//  WeatherSearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import XCTest

@testable import WeatherApp

class WeatherSearchViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

//    func testInit() {
//        let networkRouter = NetworkRouter<WeatherApi>()
//        let viewModel = WeatherSearchViewModel(networkRouter: networkRouter)
//        XCTAssertNotNil(viewModel.networkRouter)
//    }
    
    func testHasSearchKeywordsReturnsCorrectValue() {
        let keywords = "test"
        var viewModel = WeatherSearchViewModel()
        viewModel.searchKeywords = keywords
        
        XCTAssertTrue(viewModel.hasSearchKeywords)
    }
}
