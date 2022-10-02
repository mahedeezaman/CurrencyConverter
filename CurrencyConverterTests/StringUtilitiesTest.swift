//
//  StringUtilitiesTest.swift
//  CurrencyConverterTests
//
//  Created by Mahedee Zaman on 02/10/2022.
//

import XCTest
@testable import CurrencyConverter

final class StringUtilitiesTest: XCTestCase {
    func test_TwoDecimalPointDouble_for_two_decimals() {
        let value = StringUtilities.TwoDecimalPointDouble(12.123999, maxDecimals: 2)
        XCTAssertEqual(value, 12.12)
    }
    
    func test_TwoDecimalPointDouble_for_three_decimals() {
        let value = StringUtilities.TwoDecimalPointDouble(12.123999, maxDecimals: 3)
        XCTAssertEqual(value, 12.124)
    }
    
    func test_TwoDecimalPointDouble_for_only_decimals() {
        let value = StringUtilities.TwoDecimalPointDouble(0.128999, maxDecimals: 2)
        XCTAssertEqual(value, 0.13)
    }
    
    func test_TwoDecimalPointDouble_for_no_decimals() {
        let value = StringUtilities.TwoDecimalPointDouble(123, maxDecimals: 2)
        XCTAssertEqual(value, 123)
    }
    
    func test_TwoDecimalPointDouble_for_one_decimals() {
        let value = StringUtilities.TwoDecimalPointDouble(123.5, maxDecimals: 2)
        XCTAssertEqual(value, 123.5)
    }
    
    func test_convertStringToDouble_with_double_and_decimals() {
        let value = StringUtilities.convertStringToDouble(data: "123.123")
        XCTAssertEqual(value, 123.12)
    }
    
    func test_convertStringToDouble_with_double_and_more_decimals() {
        let value = StringUtilities.convertStringToDouble(data: "123.129")
        XCTAssertEqual(value, 123.13)
    }
    
    func test_convertStringToDouble_with_strings() {
        let value = StringUtilities.convertStringToDouble(data: "asd")
        XCTAssertEqual(value, 0.0)
    }
    
    func test_roundUpDoubleToString_with_decimal_data() {
        let value = StringUtilities.roundUpDoubleToString(data: 123.234564)
        XCTAssertEqual(value, "123.23")
    }
    
    func test_roundUpDoubleToString_with_decimal_data_upgradation() {
        let value = StringUtilities.roundUpDoubleToString(data: 123.239564)
        XCTAssertEqual(value, "123.24")
    }
    
    func test_roundUpDoubleToString_with_decimal_data_upgradation_and_no_solid_value() {
        let value = StringUtilities.roundUpDoubleToString(data: 0.239564)
        XCTAssertEqual(value, "0.24")
    }
    
    func test_roundUpDoubleToString_with_decimal_data_and_no_solid_value() {
        let value = StringUtilities.roundUpDoubleToString(data: 0.002)
        XCTAssertEqual(value, "0.00")
    }
}
