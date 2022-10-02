//
//  AlertViewModel.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 03/10/2022.
//

import Foundation

class AlertViewModel {
    static func submitButtonValidator(currencyData: CurrencyDataModel) -> Bool {
        guard StringUtilities.convertStringToDouble(data: currencyData.fromAmount) > 0.0 else {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: AlertConstants.amountCantBeZero))
            return false
        }
        
        guard StringUtilities.convertStringToDouble(data: currencyData.toAmount) > 0.0 else {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: AlertConstants.convertedAmountCantBeZero))
            return false
        }
        
        return true
    }
    
    static func dialpadTappedValidator(currencyData: CurrencyDataModel) -> Bool {
        guard !currencyData.fromCurrency.isEmpty else {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: AlertConstants.selectToConvertFrom))
            return false
        }
        
        guard !currencyData.toCurrency.isEmpty else {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: AlertConstants.selectToConvertTo))
            return false
        }
        
        return true
    }
    
    static func tappedCurrencyValidator(amount: String) -> Bool {
        guard let availAmount = Double(amount), availAmount > 0 else {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: AlertConstants.insufficientBalance))
            return false
        }
        
        return true
    }
}
