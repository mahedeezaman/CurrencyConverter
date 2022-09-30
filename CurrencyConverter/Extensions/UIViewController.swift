//
//  UIViewControllerExtensions.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 27/09/2022.
//

import UIKit

fileprivate var fullScreenProgressRing: UIView?

extension UIViewController {
    func startProgressRing() {
        let fullScreenProgressRing = UIView(frame: self.view.bounds)
        fullScreenProgressRing.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = fullScreenProgressRing.center
        indicator.color = .white
        indicator.startAnimating()
        fullScreenProgressRing.addSubview(indicator)
        self.view.addSubview(fullScreenProgressRing)
    }
    
    func stopProgressRing() {
        fullScreenProgressRing?.removeFromSuperview()
        fullScreenProgressRing = nil
    }
    
    func showAlertWith(title: String, and message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        alertController.setBackgroundColor(color: ColorConstants.homeViewBackground)
        alertController.setTitleFontAndColor()
        alertController.setMessageFontAndColor()
        alertController.setTint()
        
        return alertController
    }
}
