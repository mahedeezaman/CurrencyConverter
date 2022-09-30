//
//  APIConstants.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 30/09/2022.
//

import Foundation

struct APIConstants {
    static func converterApiEndPoint(requestData: CurrencyDataModel) -> String {
        return "http://api.evp.lt/currency/commercial/exchange/\(requestData.fromAmount)-\(requestData.fromCurrency)/\(requestData.toCurrency)/latest"
    }
}
