//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/25/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Property

    let window: UIWindow
    
    var childCoordinators = [Coordinator]()
    let navController = UINavigationController()
    
    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Start

    func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()

        let child = WeatherSearchCoordinator(navigationController: navController)
        childCoordinators.append(child)
        child.start()
    }
}
