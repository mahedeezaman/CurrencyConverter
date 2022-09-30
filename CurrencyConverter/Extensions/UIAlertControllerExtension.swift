//
//  UIAlertControllerExtension.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 30/09/2022.
//

import UIKit

extension UIAlertController {
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }

    func setTitleFontAndColor(font: UIFont? = .systemFont(ofSize: 18, weight: .bold), color: UIColor? = .white) {
        guard let title = self.title else { return }
        
        let attributeString = NSMutableAttributedString(string: title)
        if let titleFont = font, let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont, NSAttributedString.Key.foregroundColor : titleColor],
                                          range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")
    }

    func setMessageFontAndColor(font: UIFont? = .systemFont(ofSize: 16, weight: .light), color: UIColor? = .white) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        
        if let messageFont = font, let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont, NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }

    func setTint(color: UIColor = .white) {
        self.view.tintColor = color
    }
}
