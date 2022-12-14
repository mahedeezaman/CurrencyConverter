//
//  CurrencySelectedFromList.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

extension HomeViewController : TappedOnCurrency {
    func resetAmount() {
        convertCurrController.currencyData.fromAmount = ""
        convertCurrController.currencyData.toAmount = ""
        currencyVM.currencyData.fromAmount = ""
        currencyVM.currencyData.toAmount = ""
        DispatchQueue.main.async {[weak self] in
            self?.buyAmount.text = ""
            self?.sellAmount.text = ""
        }
    }
    
    func tappedCurrency(_ currency: String, having amount: String) {
        if forSell {
            if AlertViewModel.tappedCurrencyValidator(amount: amount) {
                sellCurrency.setTitle(currency, for: .normal)
                resetAmount()
                convertCurrController.currencyData.fromCurrency = currency
                convertCurrController.availableBalance = amount
                currencyVM.currencyData.fromCurrency = currency
            }
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
