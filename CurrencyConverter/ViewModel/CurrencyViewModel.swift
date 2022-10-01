//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    var currencyData = CurrencyDataModel()
    @Published var userData : UserDataModel
    
    var commissionManager : CommissionManager
    var dataManager : DataManager
    
    init() {
        let tempDataManager = DataManager()
        let tempCommissionManager = CommissionManager()
        
        self.commissionManager = tempCommissionManager
        self.dataManager = tempDataManager
        self.userData = tempDataManager.getUserData()
    }
    
    func sendConversionRequest() {
        if Double(userData.accountBalances[currencyData.fromCurrency]!)! < Double(currencyData.fromAmount)! {
            print(CurrencyConversionErrorModels.insufficientAmount.getRawValue())
            return
        }
        commissionManager.checkTransactionValidity(requestedData: currencyData, availabilityData: userData) { commissionAmount, error in
            if let error {
                print(error.getRawValue())
            } else if let commissionAmount {
                Task {
                    let afterConversion = await self.dataManager.convertCurrency(from: self.currencyData.fromCurrency, to: self.currencyData.toCurrency, of: StringUtilities.convertStringToDouble(data: self.currencyData.fromAmount), withCommission: commissionAmount)
                    DispatchQueue.main.async {
                        self.userData = afterConversion
                        print(self.userData)
                    }
                }
            }
        }
    }
}
