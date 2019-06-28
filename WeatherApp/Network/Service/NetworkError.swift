//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

public enum NetworkError: String, Error {
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noResponse = "The request has no response."
    case noData = "Response returned no data to decode."
    case unableToDecode = "Could not decode the response."
    case unknown = "Unknown error."
}
