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
        NotificationCenter.default.addObserver(self, selector: #selector(alertNotificationListener(_:)), name: .alertNotification, object: nil)
    }
    
    @objc func sellValueNotificationListener(_ notification: Notification) {
        if let notificationData = notification.object as? String {
            convertCurrController.currencyData.toAmount = notificationData
            DispatchQueue.main.async {
                self.buyAmount.text = notificationData
                self.stopProgressRing()
            }
        }
    }
    
    @objc func alertNotificationListener(_ notification: Notification) {
        if let notificationData = notification.object as? AlertDataModel {
            if notificationData.message == CurrencyConversionErrorModels.insufficientAmount.getRawValue() {
                DispatchQueue.main.async {
                    self.stopProgressRing()
                    if !(self.sellAmount.text?.isEmpty ?? true) {
                        self.sellAmount.text?.removeLast()
                        self.typedAmount(amount: self.sellAmount.text ?? "0.0")
                    }
                }
            }
            let alertController = showAlertWith(alertData: notificationData)
            self.present(alertController, animated: true)
        }
    }
}
