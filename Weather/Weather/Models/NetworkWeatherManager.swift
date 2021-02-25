//
//  NetworkWeatherManager.swift
//  Weather
//
//  Created by Roman Kniukh on 20.02.21.
//

import Foundation
import CoreLocation

struct NetworkWeatherManager {
    var onCompletionWeeklyWeather: ((WeeklyWeather) -> Void)?
    var onCompletionCurrentWeather: ((CurrentWeather) -> Void)?
    var onCompletionHourlyWeather: ((HourlyWeather) -> Void)?
    
    
    func fetchWeeklyAndCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let weeklyWeather = self.parseJSON(withData: data, to: WeeklyWeather.self) as? WeeklyWeather {
                    self.onCompletionWeeklyWeather?(weeklyWeather)
                }
                if let currentWeather = self.parseJSON(withData: data, to: CurrentWeather.self) as? CurrentWeather {
                    self.onCompletionCurrentWeather?(currentWeather)
                }
                if let hourlyWeather = self.parseJSON(withData: data, to: HourlyWeather.self) as? HourlyWeather {
                    self.onCompletionHourlyWeather?(hourlyWeather)
                }
            }
        }
        task.resume()
    }
        
    func parseJSON(withData data: Data, to type: Any.Type) -> Any? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(WeeklyWeatherData.self, from: data)
            if type == CurrentWeather.self {
                guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                    return nil
                }
                return currentWeather
            } else if type == WeeklyWeather.self {
                guard let weeklyWeather = WeeklyWeather(currentWeatherData: currentWeatherData) else {
                    return nil
                }
                return weeklyWeather
            }
            else if type == HourlyWeather.self {
                guard let hourlylyWeather = HourlyWeather(hourlyWEatherData: currentWeatherData) else {
                    return nil
            }
                return hourlylyWeather
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
