//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

protocol WeatherDetailViewModelProtocal: class {
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, startsSearching search: WeatherSearch)
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFinishSearching search: WeatherSearch, withResult result: Weather)
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFailedSearching search: WeatherSearch, withReason reason: String)
}

struct WeatherDetailViewModel {
    
    // MARK: - Property
    
    let weatherSearch: WeatherSearch
    
    weak var delegate: WeatherDetailViewModelProtocal?
    
    // MARK: - Dependency
    
    let networkRouter: NetworkRouter<WeatherApi>
    
    // MARK: - Init
    
    init(weatherSearch: WeatherSearch,
         delegate: WeatherDetailViewModelProtocal,
         networkRouter: NetworkRouter<WeatherApi> = NetworkRouter<WeatherApi>()) {
        self.weatherSearch = weatherSearch
        self.delegate = delegate
        self.networkRouter = networkRouter
    }
    
    // MARK: - Search
    
    func getWeatherDetail() {
        switch weatherSearch.searchType {
        case .cityName(name: let name):
            searchWeather(byCityName: name)
        case .zipCode(code: let code):
            searchWeather(byZipCode: code)
        case .location(lat: let lat, lon: let lon):
            searchWeather(byLatitude: lat, longitude: lon)
        }
    }
    
    func cancelGetWeather() {
        networkRouter.cancel()
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
    
    private func searchWeather(byLatitude lat: Double, longitude lon: Double) {
        networkRouter.request(type: Weather.self, route: .getWeatherByCoordinates(lat: lat, lon: lon)) { response in
            switch response {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}
