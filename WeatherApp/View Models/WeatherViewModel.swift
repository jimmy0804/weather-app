//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/29/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    
    // MARK: - Property

    let weather: Weather
    
    var cityName: String {
        return "\(weather.cityName) (\(weather.extraInfo?.country ?? ""))"
    }
    
    var temperature: String {
        return "\(weather.detail.temperture)°"
    }
    
    var sunrise: String {
        if let sunriseTimeStampe = weather.extraInfo?.sunrise {
            return "\(formatTimeStampToHours(sunriseTimeStampe))"
        }
        return ""
    }
    
    var sunset: String {
        if let sunsetTimeStampe = weather.extraInfo?.sunset {
            return "\(formatTimeStampToHours(sunsetTimeStampe))"
        }
        return ""
    }
    
    var humidity: String {
        return "\(weather.detail.humidity)%"
    }
    
    var windInfo: String {
        return "\(weather.wind.degree)° \(weather.wind.speed) m/s"
    }
    
    var pressureInfo: String {
        return "\(weather.detail.pressure) hPa"
    }
    
    // MARK: - Init

    init(weather: Weather) {
        self.weather = weather
    }
    
    // MARK: - Date Formatter
    
    private func formatTimeStampToHours(_ timeStamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}
