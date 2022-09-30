//
//  alertCreator.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 30/09/2022.
//

import UIKit

func showAlertWith(title: String, and message: String) -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
    alertController.setBackgroundColor(color: ColorConstants.homeViewBackground)
    alertController.setTitleFontAndColor()
    alertController.setMessageFontAndColor()
    alertController.setTint()
    
    return alertController
}
