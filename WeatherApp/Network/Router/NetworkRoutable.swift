//
//  NetworkRoutable.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/26/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation


protocol NetworkRoutable: class {
    associatedtype Service: ServiceType
    func request<T>(type: T.Type, route: Service, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
    func cancel()
}
