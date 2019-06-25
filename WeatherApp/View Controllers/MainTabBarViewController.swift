//
//  MainTabBarViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    let weatherSearchCoordinator = WeatherSearchCoordinator(navigationController: UINavigationController())
    let weatherHistoryCoordinator = WeatherHistoryCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBarViewControllers()
    }
    
    // MARK: - Set up
    
    private func setUpTabBarViewControllers() {
        weatherSearchCoordinator.start()
        weatherHistoryCoordinator.start()

        viewControllers = [
            weatherSearchCoordinator.navigationController,
            weatherHistoryCoordinator.navigationController
        ]
    }
}
