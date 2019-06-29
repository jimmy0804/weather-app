//
//  FileManager.swift
//  WeatherApp
//
//  Created by Ho Ting Jimmy Yeung on 6/28/19.
//  Copyright © 2019 Jimmy Yeung. All rights reserved.
//

import Foundation

class FilesManager {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    // MARK: - Dependency

    let fileManager: FileManager

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }

        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }

        do {
            try data.write(to: url)
        } catch {
            print(error)
            throw Error.writtingFailed
        }
    }
    
    func read(fileNamed: String) throws -> Data {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
    
        guard fileManager.fileExists(atPath: url.absoluteString) else {
            throw Error.fileNotExists
        }

        do {
            return try Data(contentsOf: url)
        } catch {
            print(error)
            throw Error.readingFailed
        }
    }
    
    // MARK: - Helper

    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        return url.appendingPathComponent(fileName)
    }
}
