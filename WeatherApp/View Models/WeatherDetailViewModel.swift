//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct WeatherDetailViewModel {
    
    // MARK: - Property
    
    let weatherSearch: WeatherSearch
    
    // MARK: - Dependency
    
    let networkRouter: NetworkRouter<WeatherApi>
    
    // MARK: - Init
    
    init(weatherSearch: WeatherSearch, networkRouter: NetworkRouter<WeatherApi> = NetworkRouter<WeatherApi>()) {
        self.weatherSearch = weatherSearch
        self.networkRouter = networkRouter
    }
    
    // MARK: - Search
    
    func getWeatherDetail() {
        switch weatherSearch.searchType {
        case .cityName(name: let name):
            searchWeather(byCityName: name)
        case .zipCode(code: let code):
            searchWeather(byZipCode: code)
        case .location(location: let location):
            break
        }
    }
    
    private func searchWeather(byCityName name: String) {
        networkRouter.request(type: Weather.self, route: .getWeatherByCityName(cityName: name)) { response in
            switch response {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func searchWeather(byZipCode code: String) {
        networkRouter.request(type: Weather.self, route: .getWeatherByZipCode(zipCode: code)) { response in
            switch response {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}
