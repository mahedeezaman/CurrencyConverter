//
//  AlertConstants.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 30/09/2022.
//

import Foundation

struct AlertConstants {
    static var success = "Success"
    static var error = "Error"
    static var submit = "Submit"
    static var insufficientBalance = "You have insufficient balance in your account to perform this action"
    static var amountCantBeZero = "Requested amount can not be 0.0"
    static var selectToConvertFrom = "Please select a currency to convert from"
    static var selectToConvertTo = "Please select a currency to convert to"
    static func conversionSuccess(data: CurrencyDataModel, commissionFee: Double) -> String {
        if commissionFee > 0.0 {
            return "Congratulations! You have successfully converted \(data.fromAmount) \(data.fromCurrency) to \(data.toAmount) \(data.toCurrency). Commission Fee -\(commissionFee) \(data.fromCurrency)"
        } else {
            return "Congratulations! You have successfully converted \(data.fromAmount) \(data.fromCurrency) to \(data.toAmount) \(data.toCurrency)."
        }
    }
}
