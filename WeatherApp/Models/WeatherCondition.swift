//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct WeatherCondition: Codable {
    var id: Int
    var condition = ""
    var description = ""
    var icon = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case condition = "main"
        case description = "description"
        case icon
    }
}
