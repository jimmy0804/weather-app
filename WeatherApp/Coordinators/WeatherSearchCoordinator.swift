//
//  WeatherSearchCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

final class WeatherSearchCoordinator: Coordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController: WeatherSearchTableViewController = UIStoryboard(.search).instantiateViewController()
        let viewModel = WeatherSearchViewModel(delegate: viewController)
        viewController.coordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showWeatherDetail(with weatherSearch: WeatherSearch) {
        let weatherDetailCoordinator = WeatherDetailCoordinator(navigationController: navigationController, weatherSearch: weatherSearch)
        weatherDetailCoordinator.start()
    }
}
