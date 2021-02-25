//
//  DailyWeatherView.swift
//  Weather
//
//  Created by Roman Kniukh on 20.02.21.
//

import UIKit

class WeeklyWeatherView: UIView {
    // MARK: - Variables
    private  var edgeInsert = UIEdgeInsets(all: 16)
    
    // MARK: - GUI Variables
    private lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    private lazy var tempMaxLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .red
        label.textAlignment = .right
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var tempMinLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .blue
        label.textAlignment = .right
        label.tintColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
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
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.dayOfWeekLabel)
        self.stackView.addArrangedSubview(self.tempMaxLabel)
        self.stackView.addArrangedSubview(self.tempMinLabel)
        self.stackView.addArrangedSubview(self.iconOfWeather)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayOfWeekLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            dayOfWeekLabel.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            dayOfWeekLabel.trailingAnchor.constraint(equalTo: self.iconOfWeather.leadingAnchor)
        ])
        
        iconOfWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconOfWeather.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            iconOfWeather.leadingAnchor.constraint(equalTo: self.dayOfWeekLabel.leadingAnchor),
            iconOfWeather.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
//            iconOfWeather.trailingAnchor.constraint(equalTo: self.tempMaxLabel.leadingAnchor)
//                                        iconOfWeather.trailingAnchor.constraint(lessThanOrEqualTo: self.tempMaxLabel.leadingAnchor, constant: 5)
        ])
        
        tempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempMaxLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            tempMaxLabel.leadingAnchor.constraint(equalTo: self.iconOfWeather.trailingAnchor),
            tempMaxLabel.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            tempMaxLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.tempMinLabel.leadingAnchor, constant: 320),

        ])
        
        tempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tempMinLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor),
            tempMinLabel.leadingAnchor.constraint(equalTo: self.tempMaxLabel.trailingAnchor),
            tempMinLabel.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            tempMinLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -15),
        ])
    }
    
    // MARK: - Setter
    func set(dayOfWeek: String, tempMin: String, tempMax: String, icon: String) {
        self.dayOfWeekLabel.text = dayOfWeek
        self.tempMinLabel.text = tempMin
        self.tempMaxLabel.text = tempMax
        self.iconOfWeather.image = UIImage(systemName: icon)
    }
}
