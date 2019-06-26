//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct WeatherDetail: Codable {
    var temperture: Double
    var pressure: Double
    var humidity: Double
    var minTemperture: Double
    var maxTemperture: Double
    var seaLevelAtmosphericPressure: Double?
    var groundLevelAtmosphericPressure: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperture = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case minTemperture = "temp_min"
        case maxTemperture = "temp_max"
        case seaLevelAtmosphericPressure = "sea_level"
        case groundLevelAtmosphericPressure = "grnd_level"
    }
}
