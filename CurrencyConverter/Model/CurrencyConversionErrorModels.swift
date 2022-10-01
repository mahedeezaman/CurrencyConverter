//
//  CurrencyConversionErrorModels.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

enum CurrencyConversionErrorModels: String, Error {
    case fromCurrencyUnavailable = "The currency you are trying to convert from is not found"
    case toCurrencyUnavailable = "The currency you are trying to convert to is not found"
    case insufficientAmount = "Your current account balance is insufficient to do this operation with commission fee"
    
    func getRawValue() -> String {
        return self.rawValue
    }
}
