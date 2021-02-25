//
//  UIView+Ex.swift
//  Weather
//
//  Created by Roman Kniukh on 19.02.21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
