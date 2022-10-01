//
//  CurrencySelectedFromList.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

extension HomeViewController : TappedOnCurrency {
    func tappedCurrency(_ currency: String, having amount: String) {
        if forSell {
            guard let availAmount = Double(amount), availAmount > 0 else {
                let alertController = self.showAlertWith(alertData: AlertDataModel(title: AlertConstants.error, message: AlertConstants.insufficientBalance))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            sellCurrency.setTitle(currency, for: .normal)
            convertCurrController.currencyData.fromCurrency = currency
            convertCurrController.availableBalance = amount
            currencyVM.currencyData.fromCurrency = currency
        } else {
            buyCurrency.setTitle(currency, for: .normal)
            convertCurrController.currencyData.toCurrency = currency
            currencyVM.currencyData.toCurrency = currency
            if StringUtilities.convertStringToDouble(data: currencyVM.currencyData.fromAmount) > 0.0 {
                typedAmount(amount: currencyVM.currencyData.fromAmount)
            }
        }
        mainContainerView.bringSubviewToFront(convertCurrController.view)
    }
}
