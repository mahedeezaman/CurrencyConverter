//
//  UISegmentedControlExtensions.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 27/09/2022.
//

import UIKit

extension UISegmentedControl {
    func setupSegmentedControl() {
        self.selectedSegmentTintColor = ColorConstants.homeViewContainersColor
        self.layer.cornerRadius = 15
        self.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        self.layer.borderWidth = 5
        self.layer.masksToBounds = true
        
        self.setTitleTextAttributes([.foregroundColor: ColorConstants.homeViewTextColors, .font : UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        self.setTitleTextAttributes([.foregroundColor: UIColor.white, .font : UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .selected)
    }
}
