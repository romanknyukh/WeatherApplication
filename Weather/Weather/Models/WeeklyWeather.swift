//
//  DailyWeather.swift
//  Weather
//
//  Created by Roman Kniukh on 20.02.21.
//

import Foundation

struct WeeklyWeatherEntry: Codable {
    let tempMax: Double
    let tempMin: Double
    let date: Date
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
}

class WeeklyWeather: NSObject, NSCoding {
    
    var weeklyWeatherEntry: [WeeklyWeatherEntry]
    
    init?(currentWeatherData: WeeklyWeatherData) {
        weeklyWeatherEntry = currentWeatherData.daily.map {
            let timeInterval = Double($0.dt)
            return WeeklyWeatherEntry(
                tempMax: $0.temp.day,
                tempMin: $0.temp.night,
                date: Date(timeIntervalSince1970: timeInterval),
                conditionCode: $0.weather.first!.id
            )
        }
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(self.weeklyWeatherEntry , forKey: "weeklyWeatherEntry")
    }
    
    required init?(coder: NSCoder) {
        self.weeklyWeatherEntry = coder.decodeObject(forKey: "weeklyWeatherEntry") as? [WeeklyWeatherEntry] ?? []
    }
}






