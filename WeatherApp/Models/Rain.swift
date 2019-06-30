//
//  Rain.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct Rain {
    var volumnInOneHour = 0.0
    var volumnInThreeHour = 0.0
}

extension Rain: Codable {
    enum CodingKeys: String, CodingKey {
        case volumnInOneHour = "1h"
        case volumnInThreeHour = "3h"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        volumnInOneHour = try container.decodeIfPresent(Double.self, forKey: .volumnInOneHour) ?? 0.0
        volumnInThreeHour = try container.decodeIfPresent(Double.self, forKey: .volumnInThreeHour) ?? 0.0
    }
}
