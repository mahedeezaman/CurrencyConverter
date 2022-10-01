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
    
    var userDataRequest: UserDataModel
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
        userDataRequest = userData
        commissionManager.checkTransactionValidity(requestedData: currencyData, availabilityData: userData) { commissionAmount, error in
            if let error {
                NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: error.getRawValue()))
            } else if let commissionAmount {
                Task {
                    let afterConversion = await self.dataManager.convertCurrency(from: self.currencyData.fromCurrency, to: self.currencyData.toCurrency, of: StringUtilities.convertStringToDouble(data: self.currencyData.fromAmount), withCommission: commissionAmount)
                    self.userDataRequest = afterConversion
                    self.commissionAmount = commissionAmount
                    NotificationCenter.default.post(name: .sellValueNotification, object: afterConversion.accountBalances[self.currencyData.toCurrency])
                }
            }
        }
    }
    
    func confirmConversionRequest() {
        self.userData = self.userDataRequest
        self.currencyData = CurrencyDataModel()
        self.commissionAmount = 0.0
        NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.success, message: AlertConstants.conversionSuccess(data: self.currencyData, commissionFee: self.commissionAmount)))
    }
}
