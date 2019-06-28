//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

//protocol WeatherSearchViewModelProtocal {
//    func
//}

struct WeatherSearchViewModel {
    
    // MARK: - Property

    var searchKeywords = ""
    var hasSearchKeywords: Bool {
        return !searchKeywords.isEmpty
    }
    
    var searchHistory = [Weather]()
    
    // MARK: - Dependency

    let networkRouter: NetworkRouter<WeatherApi>
    
    // MARK: - Init

    init(networkRouter: NetworkRouter<WeatherApi> = NetworkRouter<WeatherApi>()) {
        self.networkRouter = networkRouter
    }
    
    // MARK: - Search
    
//    func searchWeatherByCityName() {
//        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: searchKeywords)) { response in
//            switch response {
//            case .success(let weather):
//            case .failure(let error):
//
//            }
//        }
//    }
//
//    func searchWeatherByZipCode() {
//
//    }
}
