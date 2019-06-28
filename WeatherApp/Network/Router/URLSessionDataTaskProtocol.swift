//
//  URLSessionDataTaskProtocol.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
