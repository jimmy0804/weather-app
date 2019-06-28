//
//  URLParameterEncoder.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            
            for (key, parameter) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(parameter)")
                queryItems.append(queryItem)
            }
            
            urlComponents.queryItems = queryItems
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    private static func appendParameters(_ parameters: Parameters, to url: URL) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }

        var queryItems = [URLQueryItem]()
            
        for (key, parameter) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(parameter)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}
