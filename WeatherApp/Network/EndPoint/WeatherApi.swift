//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/27/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

public enum WeatherApi {
    case getWeatherByCityName(cityName: String)
    case getWeatherByZipCode(zipCode: String)
    case getWeatherByCoordinates
}

/// API Format Documentations
/// https://openweathermap.org/current#format

extension WeatherApi: ServiceType {
    var APIKey: String {
        return "95d190a434083879a6398aafd54d9e73"
    }

    public var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5") else {
            fatalError("BaseURL is invalid.")
        }
        return url
    }
    
    public var path: String {
        switch self {
        case .getWeatherByCityName(cityName: _):
            fallthrough
        case .getWeatherByZipCode(zipCode: _):
            fallthrough
        case .getWeatherByCoordinates:
            return "weather"
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .getWeatherByCityName(cityName: let cityName):
            return .requestParameters(bodyParameters: nil, urlParameters: ["q": cityName,
                                                                           "appid": APIKey
                ])
        case .getWeatherByZipCode(zipCode: let zipCode):
            return .requestParameters(bodyParameters: nil, urlParameters: ["zip": zipCode, "appid": APIKey])
        case .getWeatherByCoordinates:
            return .requestParameters(bodyParameters: nil, urlParameters: ["lat": 1, "lon": 2, "appid": APIKey])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
