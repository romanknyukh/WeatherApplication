//
//  HourlyWeatherView.swift
//  Weather
//
//  Created by Roman Kniukh on 25.02.21.
//

import UIKit

class HourlyWeatherView: UIView {
// MARK: - GUI Variables
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private lazy var iconOfWeather: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        
        return image
    }()

// MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([self.timeLabel, self.temperatureLabel, self.iconOfWeather])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.iconOfWeather.topAnchor)
        ])
        
        iconOfWeather.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconOfWeather.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor),
            iconOfWeather.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconOfWeather.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iconOfWeather.bottomAnchor.constraint(equalTo: self.temperatureLabel.topAnchor)
        ])
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: self.iconOfWeather.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Setter
    func set(time: String, temperature: String, icon: String) {
        self.timeLabel.text = time
        self.temperatureLabel.text = temperature
        self.iconOfWeather.image = UIImage(systemName: icon)
    }
}
