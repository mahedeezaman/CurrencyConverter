//
//  CommissionManager.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

protocol CommissionProtocol {
    func chargedAmount(requestedData: CurrencyDataModel, availabilityData: UserDataModel) -> Result<Double, CurrencyConversionErrorModels>
}

class CommissionManager {
    private var commissionProtocols = [CommissionProtocol]()
    
    private func validityChecker(requestedData: CurrencyDataModel, availabilityData: UserDataModel, commissionProtocol: CommissionProtocol, completionHandler: @escaping (Double?, CurrencyConversionErrorModels?) -> ()) {
        
        let commission = commissionProtocol.chargedAmount(requestedData: requestedData, availabilityData: availabilityData)
        
        switch commission {
        case .success(let amount):
            return completionHandler(amount, nil)
        case .failure(let failed):
            return completionHandler(nil, failed)
        }
    }
    
    func checkTransactionValidity(requestedData: CurrencyDataModel, availabilityData: UserDataModel, completionHandler: @escaping (Double?, CurrencyConversionErrorModels?) -> ()){
        
        var totalCommission = 0.0
        var validationError : CurrencyConversionErrorModels? = nil
        
        commissionProtocols.removeAll()
        commissionProtocols.append(CommissionOfPointSevenPercent())
        
        for commissions in commissionProtocols {
            validityChecker(requestedData: requestedData, availabilityData: availabilityData, commissionProtocol: commissions) { amount, error in
                if (error != nil) {
                    validationError = error
                } else if let amount {
                    totalCommission += amount
                }
            }
        }
        
        guard validationError == nil else {
            return completionHandler(nil, validationError)
        }
        
        return completionHandler(totalCommission, nil)
    }
}
