//
//  CommissionOfFirstFiveTransaction.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 03/10/2022.
//

import Foundation

class CommissionOfFirstFiveTransaction : CommissionProtocol {
    func chargedAmount(requestedData: CurrencyDataModel, availabilityData: UserDataModel) -> Result<Double, CurrencyConversionErrorModels> {
        if availabilityData.apiUseCount < 5 {
            return .failure(.immunityOfCommission)
        }
        return .success(0.0)
    }
}
