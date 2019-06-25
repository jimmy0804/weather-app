//
//  MainTabBarViewController.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let weatherSearchCoordinator = WeatherSearchCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBarViewControllers()
    }
    
    // MARK: - Set up
    
    private func setUpTabBarViewControllers() {
        weatherSearchCoordinator.start()
        viewControllers = [weatherSearchCoordinator.navigationController]
    }
}
