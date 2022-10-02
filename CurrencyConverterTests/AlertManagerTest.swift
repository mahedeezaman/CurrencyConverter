//
//  AlertManagerTest.swift
//  CurrencyConverterTests
//
//  Created by Mahedee Zaman on 03/10/2022.
//

import XCTest
@testable import CurrencyConverter

final class AlertManagerTest: XCTestCase {
    func getData() -> CurrencyDataModel {
        return CurrencyDataModel(fromAmount: "340.51", fromCurrency: "EUR", toAmount: "48177", toCurrency: "JPY")
    }
    
    func test_submitButtonValidator_with_no_error() {
        XCTAssertTrue(AlertViewModel.submitButtonValidator(currencyData: getData()))
    }
    
    func test_submitButtonValidator_with_no_sellAmount() {
        var data = getData()
        data.fromAmount = ""
        
        XCTAssertFalse(AlertViewModel.submitButtonValidator(currencyData: data))
    }
    
    func test_submitButtonValidator_with_no_buyAmount() {
        var data = getData()
        data.toAmount = ""
        
        XCTAssertFalse(AlertViewModel.submitButtonValidator(currencyData: data))
    }
    
    func test_dialpadTappedValidator_with_no_error() {
        XCTAssertTrue(AlertViewModel.dialpadTappedValidator(currencyData: getData()))
    }
    
    func test_dialpadTappedValidator_with_no_sellCurrency() {
        var data = getData()
        data.fromCurrency = ""
        
        XCTAssertFalse(AlertViewModel.dialpadTappedValidator(currencyData: data))
    }
    
    func test_dialpadTappedValidator_with_no_buyCurrency() {
        var data = getData()
        data.toCurrency = ""
        
        XCTAssertFalse(AlertViewModel.dialpadTappedValidator(currencyData: data))
    }
    
    func test_tappedCurrencyValidator_with_no_error() {
        XCTAssertTrue(AlertViewModel.tappedCurrencyValidator(amount: "12"))
    }
    
    func test_tappedCurrencyValidator_with_no_error_and_decimal_points() {
        XCTAssertTrue(AlertViewModel.tappedCurrencyValidator(amount: "12.12"))
    }
    
    func test_tappedCurrencyValidator_with_no_error_and_decimal_points_and_no_solid_value() {
        XCTAssertTrue(AlertViewModel.tappedCurrencyValidator(amount: "0.12"))
    }
    
    func test_tappedCurrencyValidator_with_error() {
        XCTAssertFalse(AlertViewModel.tappedCurrencyValidator(amount: ""))
    }
}
