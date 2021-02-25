//
//  DailyWeatherTableView.swift
//  Weather
//
//  Created by Roman Kniukh on 21.02.21.
//

import UIKit

class WeeklyWeatherTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(WeeklyWeatherCell.self, forCellReuseIdentifier: WeeklyWeatherCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
