//
//  Rain.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct Rain: Codable {
    var volumnInOneHour: Double
    var volumnInThreeHour: Double
    
    enum CodingKeys: String, CodingKey {
        case volumnInOneHour = "1h"
        case volumnInThreeHour = "3h"
    }
}
