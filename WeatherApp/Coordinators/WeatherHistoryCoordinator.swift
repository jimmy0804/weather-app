//
//  WeatherHistoryCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

final class WeatherHistoryCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let weatherHistoryTableViewController: WeatherHistoryTableViewController = UIStoryboard(.history).instantiateViewController()
        weatherHistoryTableViewController.coordinator = self
        weatherHistoryTableViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        navigationController.pushViewController(weatherHistoryTableViewController, animated: true)
    }
}
