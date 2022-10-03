//
//  CurrencyConversionErrorModels.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

enum CurrencyConversionErrorModels: String, Error {
    case immunityOfCommission = "No commission charge"
    case insufficientAmount = "Your current account balance is insufficient to do this operation with commission fee"
    
    func getRawValue() -> String {
        return self.rawValue
    }
}
