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
    case getWeatherByCoordinates(lat: Double, lon: Double)
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
                                                                           "units": "metric",
                                                                           "appid": APIKey])
        case .getWeatherByZipCode(zipCode: let zipCode):
            return .requestParameters(bodyParameters: nil, urlParameters: ["zip": zipCode,
                                                                           "units": "metric",
                                                                           "appid": APIKey])
        case .getWeatherByCoordinates(lat: let lat, lon: let lon):
            return .requestParameters(bodyParameters: nil, urlParameters: ["lat": lat,
                                                                           "lon": lon,
                                                                           "units": "metric",
                                                                           "appid": APIKey])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
