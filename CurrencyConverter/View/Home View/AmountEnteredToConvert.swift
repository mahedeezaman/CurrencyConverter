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
            currencyVM.confirmConversionRequest()
            sellAmount.text = ""
            buyAmount.text = ""
            buyCurrency.setTitle("...", for: .normal)
            sellCurrency.setTitle("...", for: .normal)
        } else {
            currencyVM.currencyData.fromAmount = amount
            sellAmount.text = amount
            debounceTimer?.invalidate()
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {[weak self] _ in
                self?.startProgressRing()
                self?.currencyVM.sendConversionRequest()
            })
        }
    }
}
