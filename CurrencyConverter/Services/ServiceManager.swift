//
//  ServiceManager.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class ServiceManager {
    var networkService = NetworkService()
    var storageService = StorageService()
    
    func convertCurrency(requestData: CurrencyDataModel, completionHandler: @escaping (ResponseDataModel) -> ()) async {
        do {
            let response = try await networkService.getConvertedData(requestData: requestData)
            return completionHandler(response)
        } catch {
            NotificationCenter.default.post(name: .alertNotification, object: AlertDataModel(title: AlertConstants.error, message: error.localizedDescription))
        }
    }
    
    func getUserData() -> UserDataModel {
        return storageService.getData() ?? UserDataModel(accountBalances: UserDataConstants.initialAmount, apiUseCount: 0)
    }
    
    func saveUserData(userData: UserDataModel) {
        storageService.saveUserData(userData: userData)
    }
}
