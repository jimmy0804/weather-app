//
//  CLLocationManager+LocationManager.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManager {
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    func startUpdatingLocation()
    func requestWhenInUseAuthorization()
}

extension CLLocationManager: LocationManager {}
