//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Property
    
    weak var coordinator: WeatherDetailCoordinator?
    var viewModel: WeatherDetailViewModel?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.getWeatherDetail()
        definesPresentationContext = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        viewModel?.cancelGetWeather()
    }
}

// MARK: - WeatherDetailViewModelProtocal

extension WeatherDetailViewController: WeatherDetailViewModelProtocal {
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, startsSearching search: WeatherSearch) {
        
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFinishSearching search: WeatherSearch, withResult result: Weather) {
        
    }
    
    func weatherDetailViewModel(_ viewModel: WeatherDetailViewModel, didFailedSearching search: WeatherSearch, withReason reason: String) {
        
    }
}
