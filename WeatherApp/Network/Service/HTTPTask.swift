//
//  HTTPTask.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters)
    
    case requestParametersWithHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
