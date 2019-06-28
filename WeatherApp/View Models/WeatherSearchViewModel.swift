//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

//protocol WeatherSearchViewModelProtocal {
//    func
//}

struct WeatherSearchViewModel {
    
    // MARK: - Property

    var searchKeywords = ""
    var hasSearchKeywords: Bool {
        return !searchKeywords.isEmpty
    }
    
    var isAllowSearchByLocation = true
    
    var searchHistory = [Weather]()
    var hasSearchHistory: Bool {
        return !searchHistory.isEmpty
    }
    
    // MARK: - Init

    init() {
        
    }
}
