//
//  CurrentWeather.swift
//  Weather
//
//  Created by Roman Kniukh on 22.02.21.
//

import Foundation

struct CurrentWeather {
    
    let location: String
    let temperature: Double
    let description: String
    let humidity: Int
    let feelLike: Double
    let visibility: Int
    let pressure: Int
    let windSpeed: Double
    let sunrise: Date
    let sunset: Date
    
    init?(currentWeatherData: WeeklyWeatherData) {
        let sunriseTime = Double(currentWeatherData.current.sunrise ?? 0)
        let sunsetTime = Double(currentWeatherData.current.sunset ?? 0)
            
        location = currentWeatherData.timezone
        temperature = currentWeatherData.current.temp
        description = currentWeatherData.current.weather.first!.weatherDescription.rawValue
        humidity = currentWeatherData.current.humidity
        feelLike = currentWeatherData.current.feelsLike
        visibility = currentWeatherData.current.visibility
        pressure = currentWeatherData.current.pressure
        windSpeed = currentWeatherData.current.windSpeed
        sunrise = Date(timeIntervalSince1970: sunriseTime)
        sunset = Date(timeIntervalSince1970: sunsetTime)
    }
}

