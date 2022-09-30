//
//  ViewBorderAndCornerCreator.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 30/09/2022.
//

import UIKit

func createRoundedBorder<T: UIView>(of view: T, with color: CGColor = ColorConstants.homeViewContainersColor.cgColor, cornerRadius: CGFloat = Constants.cornerRadius, width: CGFloat){
    view.layer.borderColor = color
    view.layer.borderWidth = width
    view.layer.cornerRadius = cornerRadius
}
