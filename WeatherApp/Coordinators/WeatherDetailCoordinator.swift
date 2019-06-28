//
//  WeatherDetailCoordinator.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import UIKit
import DeckTransition

final class WeatherDetailCoordinator: Coordinator {

    var navigationController: UINavigationController
    var weatherSearch: WeatherSearch
    
    init(navigationController: UINavigationController, weatherSearch: WeatherSearch) {
        self.navigationController = navigationController
        self.weatherSearch = weatherSearch
    }

    func start() {
        let viewModel = WeatherDetailViewModel(weatherSearch: weatherSearch)
        let viewController: WeatherDetailViewController = UIStoryboard(.detail).instantiateViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = self
        
        let transitionDelegate = DeckTransitioningDelegate()
        viewController.transitioningDelegate = transitionDelegate
        viewController.modalPresentationStyle = .custom
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
