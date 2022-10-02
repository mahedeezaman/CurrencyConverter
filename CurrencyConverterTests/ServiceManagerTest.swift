//
//  ServiceManagerTest.swift
//  CurrencyConverterTests
//
//  Created by Mahedee Zaman on 02/10/2022.
//

import XCTest
@testable import CurrencyConverter

final class ServiceManagerTest : XCTest {
    var sut = ServiceManager()
    
    func getDataModel() -> CurrencyDataModel {
        return CurrencyDataModel(fromAmount: "10", fromCurrency: "EUR", toAmount: "10", toCurrency: "USD")
    }
    
    func test_network_call_to_convert_data() async {
        do {
            let response = try await sut.networkService.getConvertedData(requestData: getDataModel())
            XCTAssertNotNil(response)
        } catch {
            XCTAssertThrowsError(ErrorModels.serverError)
        }
    }
    
    func test_network_call_with_no_amount() async {
        do {
            var data = getDataModel()
            data.fromAmount = ""
            let response = try await sut.networkService.getConvertedData(requestData: data)
            XCTAssertNil(response)
        } catch {
            XCTAssertThrowsError(ErrorModels.serverError)
        }
    }
    
    func test_network_call_with_no_currency() async {
        do {
            var data = getDataModel()
            data.fromCurrency = ""
            let response = try await sut.networkService.getConvertedData(requestData: data)
            XCTAssertNil(response)
        } catch {
            XCTAssertThrowsError(ErrorModels.serverError)
        }
    }
    
    func test_network_call_with_no_currencyTo() async {
        do {
            var data = getDataModel()
            data.toCurrency = ""
            let response = try await sut.networkService.getConvertedData(requestData: data)
            XCTAssertNil(response)
        } catch {
            XCTAssertThrowsError(ErrorModels.serverError)
        }
    }
    
    func test_storage_fetch() {
        XCTAssertNotNil(sut.getUserData())
    }
}
