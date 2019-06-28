//
//  NetworkRouterTests.swift
//  WeatherAppTests
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import XCTest

@testable import WeatherApp

// MARK: - Test

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        cancelWasCalled = true
    }
}

// MARK: - Test

class NetworkRouterTests: XCTestCase {
    
    var networkRouter: NetworkRouter<WeatherApi>!
    var session: MockURLSession!

    override func setUp() {
        super.setUp()

        session = MockURLSession()
        networkRouter = NetworkRouter<WeatherApi>(session: session)
    }

    override func tearDown() {
        super.tearDown()

        networkRouter = nil
        session = nil
    }
    
    func testGetResumeCalled() {
        let cityName = "Hong Kong"
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: cityName)) { response in
            switch response {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }

        XCTAssertTrue(dataTask.resumeWasCalled)
    }
    
    func testGetCancelCalled() {
        let cityName = "Hong Kong"
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: cityName)) { response in
            switch response {
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
        
        networkRouter.cancel()
        
        XCTAssertTrue(dataTask.cancelWasCalled)
    }

    func testGetShouldReturnNoDataError() {
        let cityName = "Hong Kong"
        
        var actualData: Weather?
        var actualError = NetworkError.unknown
        
        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: cityName)) { response in
            switch response {
            case .success(let weather):
                actualData = weather
            case .failure(let error):
                actualError = error
            }
        }

        XCTAssertNil(actualData)
        XCTAssertTrue(actualError == .noData)
    }
    
    func testGetShouldReturnUnableToDecode() {
        let cityName = "Hong Kong"
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData
        
        var actualData: Weather?
        var actualError = NetworkError.unknown
        
        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: cityName)) { response in
            switch response {
            case .success(let weather):
                actualData = weather
            case .failure(let error):
                actualError = error
            }
        }
        
        XCTAssertNil(actualData)
        XCTAssertTrue(actualError == .unableToDecode)
    }
}
