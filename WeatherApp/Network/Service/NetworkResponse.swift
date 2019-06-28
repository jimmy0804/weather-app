//
//  NetworkResponse.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

public enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
