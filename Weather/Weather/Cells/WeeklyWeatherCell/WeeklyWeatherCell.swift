//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Roman Kniukh on 20.02.21.
//

import UIKit


class WeeklyWeatherCell: UITableViewCell {
    // MARK: - Variabled
    static let identifier = "WeeklyWeatherCell"
    
    // MARK: - GUI Variables
    private lazy var weeklyWeatherView = WeeklyWeatherView()
    
  // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.weeklyWeatherView)
        weeklyWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weeklyWeatherView.topAnchor.constraint(equalTo: self.topAnchor),
            weeklyWeatherView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weeklyWeatherView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weeklyWeatherView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setter
    func set(dayOfWeek: String, tempMin: String, tempMax: String, icon: String) {
        self.weeklyWeatherView.set(dayOfWeek: dayOfWeek, tempMin: tempMin, tempMax: tempMax, icon: icon)
    }
    
//    func configure(with model: WeeklyWeatherEntry) {
//        self.weeklyWeatherView.set(dayOfWeek: "\(weeklyWeatherEntry.date)", tempMin: "\(Int(weeklyWeatherEntry.tempMin))", tempMax: "\(Int(weeklyWeatherEntry.tempMax))", icon: model.systemIconNameString)
//
//    }
}
