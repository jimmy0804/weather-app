//
//  Clouds.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct Clouds: Codable {
    var cloudiness = 0
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
