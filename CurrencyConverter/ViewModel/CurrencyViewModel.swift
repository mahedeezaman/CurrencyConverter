//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    var currencyData = CurrencyDataModel()
    var userData : UserDataModel
    
    var userDataRequest: UserDataModel?
    var commissionAmount: Double
    
    var commissionManager : CommissionManager
    var dataManager : DataManager
    
    init() {
        let tempDataManager = DataManager()
        let tempCommissionManager = CommissionManager()
        
        self.commissionManager = tempCommissionManager
        self.dataManager = tempDataManager
        self.userData = tempDataManager.getUserData()
        self.userDataRequest = tempDataManager.getUserData()
        self.commissionAmount = 0.0
    }
    
    func sendConversionRequest() {
        userData = dataManager.getUserData()
        userDataRequest = userData
        commissionManager.checkTransactionValidity(requestedData: currencyData, availabilityData: userData) { commissionAmount, error in
            if let error {
                NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: error.getRawValue()))
            } else if let commissionAmount {
                Task {
                    let afterConversion = await self.dataManager.convertCurrency(from: self.currencyData.fromCurrency, to: self.currencyData.toCurrency, of: StringUtilities.convertStringToDouble(data: self.currencyData.fromAmount), withCommission: commissionAmount)
                    self.userDataRequest = afterConversion
                    self.commissionAmount = commissionAmount
                    
                    let convertedTo = StringUtilities.convertStringToDouble(data: afterConversion.accountBalances[self.currencyData.toCurrency])
                    let previousTo = StringUtilities.convertStringToDouble(data: self.userData.accountBalances[self.currencyData.toCurrency])
                    self.userDataRequest?.accountBalances[self.currencyData.toCurrency] = "\(StringUtilities.roundUpDoubleToString(data: previousTo + convertedTo))"
                    
                    self.currencyData.toAmount = "\(convertedTo)"
                    NotificationCenter.default.post(name: .sellValueNotification, object: self.currencyData.toAmount)
                }
            }
        }
    }
    
    func confirmConversionRequest() {
        NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.success, message: AlertConstants.conversionSuccess(data: self.currencyData, commissionFee: self.commissionAmount)))
        
        if let userDataRequest {
            self.userData = userDataRequest
            dataManager.saveUserData(userData: userDataRequest)
        }
        self.currencyData = CurrencyDataModel()
        self.commissionAmount = 0.0
    }
}
