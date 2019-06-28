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
    
    var isAllowSearchByLocation = true
    
    var searchHistory = [Weather]()
    var hasSearchHistory: Bool {
        return !searchHistory.isEmpty
    }

    weak var delegate: WeatherSearchViewModelProtocal?
    
    // MARK: - Dependency
    
    var locationManager: LocationManager
    
    // MARK: - Init

    init(delegate: WeatherSearchViewModelProtocal,
         locationManager: LocationManager = CLLocationManager()) {
        self.delegate = delegate
        self.locationManager = locationManager
    }
    
    // MARK: - Location
    
    func getCurrentLocationIfAvailable() {
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

        delegate?.didRecieveCurrentLocation(locationValue)
        manager.stopUpdatingLocation()
    }
}
