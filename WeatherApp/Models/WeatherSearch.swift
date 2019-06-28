//
//  WeatherSearch.swift
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

struct WeatherSearch {
    var searchType: WeatherSearchType
}
