//
//  UIViewControllerExtensions.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 27/09/2022.
//

import UIKit

extension UIViewController {
    func startProgressRing() {
        let fullScreenProgressRing = UIView(frame: self.view.bounds)
        fullScreenProgressRing.tag = 154441
        fullScreenProgressRing.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = fullScreenProgressRing.center
        indicator.color = .white
        indicator.startAnimating()
        fullScreenProgressRing.addSubview(indicator)
        self.view.addSubview(fullScreenProgressRing)
    }
    
    func stopProgressRing() {
        if let viewWithTag = self.view.viewWithTag(154441) {
            DispatchQueue.main.async {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    func showAlertWith(alertData: AlertDataModel) -> UIAlertController {
        let alertController = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        alertController.setBackgroundColor(color: ColorConstants.homeViewBackground)
        alertController.setTitleFontAndColor()
        alertController.setMessageFontAndColor()
        alertController.setTint()
        
        return alertController
    }
}
