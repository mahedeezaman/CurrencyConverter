//
//  StorageService.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 02/10/2022.
//

import Foundation
import Realm
import RealmSwift

class StorageService {
    
    func getData() -> UserDataModel? {
        do {
            var userData = UserDataModel(accountBalances: [:], apiUseCount: 0)
            let dataBase = try Realm()
            
            if let retrievedData = dataBase.objects(UserDatabaseModel.self).first {
                userData.apiUseCount = retrievedData.apiUseCount
                for item in retrievedData.accountBalances {
                    userData.accountBalances[item.key] = item.value
                }
            }
            
            if userData.accountBalances.isEmpty {
                userData.accountBalances = UserDataConstants.initialAmount
                userData.apiUseCount = UserDataConstants.initialApiCallCount
                
                saveUserDataFirstTime(userData: userData)
            }
            return userData
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveUserDataFirstTime(userData: UserDataModel) {
        do {
            let object = UserDatabaseModel()
            let dataBase = try Realm()
            
            try? dataBase.write {
                object.apiUseCount = userData.apiUseCount
                for item in userData.accountBalances {
                    object.accountBalances[item.key] = item.value
                }
                
                dataBase.add(object)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveUserData(userData: UserDataModel) {
        do {
            let dataBase = try Realm()
            
            if let retrievedData = dataBase.objects(UserDatabaseModel.self).first {
                try? dataBase.write {
                    retrievedData.apiUseCount = userData.apiUseCount
                    for item in userData.accountBalances {
                        retrievedData.accountBalances[item.key] = item.value
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
