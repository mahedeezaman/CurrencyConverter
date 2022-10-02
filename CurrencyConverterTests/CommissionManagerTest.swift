//
//  CommissionManagerTest.swift
//  CurrencyConverterTests
//
//  Created by Mahedee Zaman on 02/10/2022.
//

import XCTest
@testable import CurrencyConverter

final class CommissionManagerTest: XCTestCase {
    var sut = CommissionManager()
    
    func getRequestedData() -> UserDataModel {
        return UserDataModel(accountBalances: UserDataConstants.initialAmount, apiUseCount: UserDataConstants.initialApiCallCount)
    }
    
    func getCurrencyData() -> CurrencyDataModel {
        return CurrencyDataModel(fromAmount: "123.128", fromCurrency: "EUR", toAmount: "", toCurrency: "JPY")
    }
    
    func test_checkTransactionValidity_before_five_transactions_no_charge() {
        sut.checkTransactionValidity(requestedData: getCurrencyData(), availabilityData: getRequestedData()) { response, error in
            XCTAssertEqual(response, 0.0)
            XCTAssertNil(error)
        }
    }
    
    func test_checkTransactionValidity_after_five_transactions_with_charge() {
        var requestedData = getRequestedData()
        let currency = getCurrencyData()
        requestedData.apiUseCount = 6
        
        let convertableAmount = StringUtilities.convertStringToDouble(data: currency.fromAmount)
        sut.checkTransactionValidity(requestedData: currency, availabilityData: requestedData) { response, error in
            XCTAssertEqual(response, StringUtilities.convertStringToDouble(data: StringUtilities.roundUpDoubleToString(data: convertableAmount * 0.7 / 100.0)))
            XCTAssertNil(error)
        }
    }
    
    func test_checkTransactionValidity_after_five_transactions_with_charge_throw_errors() {
        var requestedData = getRequestedData()
        let currency = getCurrencyData()
        requestedData.apiUseCount = 6
        requestedData.accountBalances[currency.fromCurrency] = currency.fromAmount
        
        sut.checkTransactionValidity(requestedData: currency, availabilityData: requestedData) { response, error in
            
            XCTAssertNil(response)
            XCTAssertEqual(error, .insufficientAmount)
        }
    }
}
