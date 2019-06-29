//
//  WeatherSearchType.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

enum WeatherSearchType {
    case cityName(name: String)
    case zipCode(code: String)
    case location(lat: Double, lon: Double)
}

extension WeatherSearchType: Codable {
    private enum CodingKeys: String, CodingKey {
        case base, cityNameParam, zipCodeParam, locationParams
    }
    
    private enum Base: String, Codable {
        case cityName
        case zipCode
        case location
    }
    
    private struct CityNameParam: Codable {
        let name: String
    }
    
    private struct ZipCodeParam: Codable {
        let code: String
    }
    
    private struct LocationParams: Codable {
        let lat: Double
        let lon: Double
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(Base.self, forKey: .base)
        
        switch base {
        case .cityName:
            let cityNameParam = try container.decode(CityNameParam.self, forKey: .cityNameParam)
            self = .cityName(name: cityNameParam.name)
        case .zipCode:
            let zipCodeParam = try container.decode(ZipCodeParam.self, forKey: .zipCodeParam)
            self = .zipCode(code: zipCodeParam.code)
        case .location:
            let locationParams = try container.decode(LocationParams.self, forKey: .locationParams)
            self = .location(lat: locationParams.lat, lon: locationParams.lon)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .cityName(name: let name):
            try container.encode(Base.cityName, forKey: .base)
            try container.encode(CityNameParam(name: name), forKey: .cityNameParam)
        case .zipCode(code: let code):
            try container.encode(Base.zipCode, forKey: .base)
            try container.encode(ZipCodeParam(code: code), forKey: .zipCodeParam)
        case .location(lat: let lat, lon: let lon):
            try container.encode(Base.location, forKey: .base)
            try container.encode(LocationParams(lat: lat, lon: lon), forKey: .locationParams)
        }
    }
}
