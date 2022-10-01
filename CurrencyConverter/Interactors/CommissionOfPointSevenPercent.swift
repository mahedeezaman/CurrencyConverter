//
//  CommissionOfPointSevenPercent.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class CommissionOfPointSevenPercent: CommissionProtocol {
    func chargedAmount(requestedData: CurrencyDataModel, availabilityData: UserDataModel) -> Result<Double, CurrencyConversionErrorModels> {
        if availabilityData.apiUseCount < 5 {
            return .success(0.00)
        }
        
        let availAmount = StringUtilities.convertStringToDouble(data: availabilityData.accountBalances[requestedData.fromCurrency])
        let convertableAmount = StringUtilities.convertStringToDouble(data: requestedData.fromAmount)
        let percentage = StringUtilities.convertStringToDouble(data: StringUtilities.roundUpDoubleToTwoDecimalPlaces(data: availAmount * 0.7 / 100.0))
        
        if availAmount - convertableAmount - percentage >= 0.0 {
            return .success(StringUtilities.convertStringToDouble(data: StringUtilities.roundUpDoubleToTwoDecimalPlaces(data: convertableAmount * 0.7 / 100.0)))
        } else {
            return .failure(.insufficientAmount)
        }
    }
}
