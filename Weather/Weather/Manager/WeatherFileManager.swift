//
//  FileManager.swift
//  Weather
//
//  Created by Roman Kniukh on 25.02.21.
//

import Foundation

class WeatherFileManager {
    // MARK: - Static properties
    static let shared = WeatherFileManager()
    
    // MARK: - Variables
    private var directoryURL: URL
    
    // MARK: - Init
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // MARK: - Methods
    @discardableResult
    func writeDataWithNSCodable(with path: String, model: [WeeklyWeatherEntry]?) -> Bool {
        let localPath = self.directoryURL.appendingPathComponent(path)

        guard let model = model else { return false }
        let encodedData = try? JSONEncoder().encode(model)
        do {
            try encodedData?.write(to: localPath)
            return true
        } catch {
            Swift.debugPrint("writing data error with Codable")
            return false
        }
    }

    func readDataWithCodable(with path: String) -> [WeeklyWeatherEntry]? {
        let localPath = self.directoryURL.appendingPathComponent(path)
        do {
            let data = try Data(contentsOf: localPath)
            return try? JSONDecoder().decode([WeeklyWeatherEntry].self, from: data)
        } catch {
            Swift.debugPrint("reading data error via Codable")
            return nil
        }
    }
    
}
