//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Roman Kniukh on 22.02.21.
//

import UIKit

class CurrentWeatherView: UIView {
    // MARK: - GUI Variables
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 100)
        return label
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
        self.addSubviews([self.locationLabel, self.descriptionLabel, self.temperatureLabel])

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            locationLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.temperatureLabel.topAnchor)
        ])
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Setter
    func set(location: String, descriptionOfWeather: String, currentTemperature: String) {
        self.locationLabel.text = location
        self.descriptionLabel.text = descriptionOfWeather
        self.temperatureLabel.text = currentTemperature
    }
}
