//
//  HourlyWeatherCell.swift
//  Weather
//
//  Created by Roman Kniukh on 25.02.21.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    // MARK: - Variables
    static var reuseIdentifier = "HourlyWeatherCell"
    
    // MARK: - GUI Variables
    private lazy var hourlyView = HourlyWeatherView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.contentView.addSubview(self.hourlyView)
        
        self.hourlyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hourlyView.topAnchor.constraint(equalTo: self.topAnchor),
            hourlyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hourlyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hourlyView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Setter
    func set(time: String, temperature: String, icon: String) {
        self.hourlyView.set(time: time, temperature: temperature, icon: icon)
    }
}
