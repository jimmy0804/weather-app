//
//  JSONParameterEncoder.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
