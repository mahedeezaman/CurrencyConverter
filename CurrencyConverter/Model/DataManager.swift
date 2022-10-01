//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class DataManager {
    var userData : UserDataModel
    var serviceManager = ServiceManager()
    
    init() {
        userData = UserDataModel(accountBalances: UserDataConstants.initialAmount, apiUseCount: 0)
    }
    
    func getUserData() -> UserDataModel {
        return userData
    }
    
    func saveUserData(userData: UserDataModel) {
        self.userData = userData
    }
    
    func convertCurrency(from fromCurrency: String, to toCurrency: String, of amount: Double, withCommission: Double) async -> UserDataModel {
        
        let requestData = CurrencyDataModel(fromAmount: "\(amount)", fromCurrency: fromCurrency, toCurrency: toCurrency)
        var responseData = userData
        
        await serviceManager.convertCurrency(requestData: requestData) { response in
            let previousFrom = StringUtilities.convertStringToDouble(data: self.userData.accountBalances[fromCurrency])
            let previousTo = StringUtilities.convertStringToDouble(data: self.userData.accountBalances[toCurrency])
            let convertedAmount = StringUtilities.convertStringToDouble(data: response.amount)
            
            responseData.accountBalances[fromCurrency] = "\(StringUtilities.roundUpDoubleToTwoDecimalPlaces(data: previousFrom - amount - withCommission))"
            responseData.accountBalances[toCurrency] = "\(StringUtilities.roundUpDoubleToTwoDecimalPlaces(data: previousTo + convertedAmount))"
            responseData.apiUseCount += 1
        }
        
        return responseData
    }
}
