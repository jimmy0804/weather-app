//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

public enum NetworkError: Error {
    case encodingFailed
    case missingURL
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noResponse
    case noData
    case unableToDecode
    case custom(description: String)
    case unknown
}
