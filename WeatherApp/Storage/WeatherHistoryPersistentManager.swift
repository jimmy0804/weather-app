//
//  WeatherHistoryPersistentManager.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/29/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

struct WeatherHistoryPersistentManager {

    private let filesManager: FilesManager
    private let weatherHistoryFileName = "weather_history"

    init(filesManager: FilesManager = FilesManager()) {
        self.filesManager = filesManager
    }
    
    func saveHistory(_ history: [WeatherSearch]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(history)
            try filesManager.save(fileNamed: weatherHistoryFileName, data: data)
        } catch {
            print(error)
        }
    }
    
    func loadHistory() -> [WeatherSearch]? {
        let decoder = JSONDecoder()
        do {
            let data = try filesManager.read(fileNamed: weatherHistoryFileName)
            let weatherHistory = try decoder.decode([WeatherSearch].self, from: data)
            return weatherHistory
        } catch {
            print(error)
        }

        return nil
    }
}
