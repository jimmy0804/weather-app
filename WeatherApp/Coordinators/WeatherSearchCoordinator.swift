//
//  WeatherSearchCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

final class WeatherSearchCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = WeatherSearchViewModel()
        let weatherSearchTableViewController: WeatherSearchTableViewController = UIStoryboard(.search).instantiateViewController()
        weatherSearchTableViewController.coordinator = self
        weatherSearchTableViewController.viewModel = viewModel
        navigationController.pushViewController(weatherSearchTableViewController, animated: true)
    }
}
