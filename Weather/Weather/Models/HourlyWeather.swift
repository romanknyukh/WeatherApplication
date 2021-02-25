//
//  HourlyWeather.swift
//  Weather
//
//  Created by Roman Kniukh on 25.02.21.
//

import Foundation

struct HourlyWeatherEntry {
    
    let date: Date
    let temperature: Double
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

struct HourlyWeather {

    let hourlyWeatherEntry: [HourlyWeatherEntry]

    init?(hourlyWEatherData: WeeklyWeatherData) {
        hourlyWeatherEntry = hourlyWEatherData.hourly.map {
            let timeInterval = Double($0.dt)
            return HourlyWeatherEntry(date: Date(timeIntervalSince1970: timeInterval),
                                      temperature: $0.temp,
                                      conditionCode: $0.weather.first!.id)
        }
    }
}
