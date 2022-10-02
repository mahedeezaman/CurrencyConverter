//
//  AmountEnteredToConvert.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

extension HomeViewController: AmountEntered {
    func resetAll() {
        convertCurrController.currencyData = CurrencyDataModel()
        currencyVM.currencyData = CurrencyDataModel()
        DispatchQueue.main.async {[weak self] in
            self?.sellAmount.text = ""
            self?.buyAmount.text = ""
            self?.buyCurrency.setTitle("...", for: .normal)
            self?.sellCurrency.setTitle("...", for: .normal)
        }
    }
    
    func typedAmount(amount: String) {
        if amount == AlertConstants.submit {
            currencyVM.confirmConversionRequest()
            resetAll()
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
