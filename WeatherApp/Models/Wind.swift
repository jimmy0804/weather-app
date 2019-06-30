//
//  Wind.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct Wind: Codable {
    var speed: Double
    var degree: Double
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}
