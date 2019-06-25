//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Property

    let window: UIWindow
    
    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Start

    func start() {
        let mainTabBarViewController: MainTabBarViewController = UIStoryboard(.main).instantiateViewController()

        window.rootViewController = mainTabBarViewController
        window.makeKeyAndVisible()
    }
}
