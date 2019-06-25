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
        let weatherSearchViewController: WeatherSearchViewController = UIStoryboard(.search).instantiateViewController()
        weatherSearchViewController.coordinator = self
        weatherSearchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        navigationController.pushViewController(weatherSearchViewController, animated: true)
    }
}
