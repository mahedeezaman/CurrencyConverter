//
//  AmountEnteredToConvert.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

extension HomeViewController: AmountEntered {
    func typedAmount(amount: String) {
        if amount == AlertConstants.submit {
            currencyVM.sendConversionRequest()
            sellAmount.text = ""
        } else {
            currencyVM.currencyData.fromAmount = amount
            sellAmount.text = currencyVM.currencyData.fromAmount
        }
    }
}
