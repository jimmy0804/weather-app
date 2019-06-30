//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherSearchViewModelProtocal: class {
    func didRecieveCurrentLocation(_ location: CLLocationCoordinate2D)
    func didFailGettingCurrentLocation()
}

class WeatherSearchViewModel: NSObject {
    
    // MARK: - Property

    var searchKeywords = ""
    var hasSearchKeywords: Bool {
        return !searchKeywords.isEmpty
    }
    
    var searchHistory = [WeatherSearch]()
    var hasSearchHistory: Bool {
        return !searchHistory.isEmpty
    }

    weak var delegate: WeatherSearchViewModelProtocal?
    
    // Make sure we only tell the delegate one time once the location is retrived.
    private var currentLocationRetrived = false
    
    // MARK: - Dependency
    
    var weatherHistoryPersistentManager: WeatherHistoryPersistentManager
    var locationManager: LocationManager
    
    // MARK: - Init

    init(delegate: WeatherSearchViewModelProtocal,
         weatherHistoryPersistentManager: WeatherHistoryPersistentManager = WeatherHistoryPersistentManager(),
         locationManager: LocationManager = CLLocationManager()) {
        self.delegate = delegate
        self.weatherHistoryPersistentManager = weatherHistoryPersistentManager
        self.locationManager = locationManager
    }
    
    // MARK: - Save / Load
    
    func loadWeatherHistory() {
        guard let history = weatherHistoryPersistentManager.loadHistory() else {
            return
        }

        searchHistory = history
    }
    
    func saveWeatherHistory(_ history: WeatherSearch) {
        searchHistory.insert(history, at: 0)
        weatherHistoryPersistentManager.saveHistory(searchHistory)
    }
    
    func removeWeatherHistory(atIndex index: Int) {
        searchHistory.remove(at: index)
        weatherHistoryPersistentManager.saveHistory(searchHistory)
    }
    
    // MARK: - Location
    
    func getCurrentLocationIfAvailable() {
        currentLocationRetrived = false
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherSearchViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            delegate?.didFailGettingCurrentLocation()
            manager.stopUpdatingLocation()
            return
        }
        
        if !currentLocationRetrived {
            delegate?.didRecieveCurrentLocation(locationValue)
        }

        currentLocationRetrived = true
        manager.stopUpdatingLocation()
    }
}
