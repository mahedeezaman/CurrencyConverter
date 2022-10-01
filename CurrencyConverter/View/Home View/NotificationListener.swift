//
//  NotificationListener.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

extension HomeViewController {
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(sellValueNotificationListener(_:)), name: .sellValueNotification, object: nil)
    }
    
    @objc func sellValueNotificationListener(_ notification: Notification) {
        if let notificationData = notification.object as? String {
            convertCurrController.currencyData.toAmount = notificationData
            DispatchQueue.main.async {[weak self] in
                self?.buyAmount.text = notificationData
            }
        }
    }
}
