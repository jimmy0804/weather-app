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
    }
}
