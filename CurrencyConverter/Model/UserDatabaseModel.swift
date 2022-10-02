//
//  UserDatabaseModel.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 02/10/2022.
//

import Foundation
import Realm
import RealmSwift

class UserDatabaseModel: Object {
    @Persisted var apiUseCount = 0
    @Persisted var accountBalances = Map<String, String>()
}
