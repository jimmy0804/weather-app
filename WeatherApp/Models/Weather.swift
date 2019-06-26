//
//  Weather.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var cityName: String
    var conditions = [WeatherCondition]()
    var detail: WeatherDetail
    var wind: Wind
    var geoLocation: GeoLocation
    var clouds: Clouds
    var rain: Rain?
    var snow: Snow?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityName = "name"
        case conditions = "weather"
        case detail = "main"
        case wind
        case geoLocation = "coord"
        case clouds
        case rain
        case snow
    }
}
