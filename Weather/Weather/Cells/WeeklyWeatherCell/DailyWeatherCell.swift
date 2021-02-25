//
//  DailyWeatherCell.swift
//  Weather
//
//  Created by Roman Kniukh on 20.02.21.
//

import UIKit
import SnapKit

class WeeklyWeatherCell: UITableViewCell {
    // MARK: - Variabled
    var dailyWeatherEntry: WeeklyWeatherEntry!
    static let identifier = "DailyWeatherCell"
    
    // MARK: - GUI Variables
    private lazy var dailyWeatherView: WeeklyWeatherView = {
       let view = WeeklyWeatherView()
//        view.set(dayOfWeek: "\(dailyWeatherEntry.date)" ,
//                 tempMin: "\(dailyWeatherEntry.tempMin)",
//                 tempMax: "\(dailyWeatherEntry.tempMax)")
        
        return view
    }()
    
  // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.dailyWeatherView)
        dailyWeatherView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dailyWeatherView.topAnchor.constraint(equalTo: self.topAnchor),
            dailyWeatherView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dailyWeatherView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dailyWeatherView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setter
    func set(dayOfWeek: String, tempMin: String, tempMax: String) {
        self.dailyWeatherView.set(dayOfWeek: dayOfWeek, tempMin: tempMin, tempMax: tempMax)
    }
    
    func configure(with model: WeeklyWeatherEntry) {
        self.dailyWeatherView.set(dayOfWeek: "\(dailyWeatherEntry.date)", tempMin: "\(dailyWeatherEntry.tempMin)", tempMax: "\(dailyWeatherEntry.tempMax)")

    }
}
