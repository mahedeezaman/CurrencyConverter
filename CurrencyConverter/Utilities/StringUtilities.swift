//
//  StringUtilities.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class StringUtilities {
    
    static func TwoDecimalPointDouble(_ a: Double, maxDecimals max: Int = 2) -> Double {
        let stringArr = String(a).split(separator: ".")
        let decimals = Array(stringArr[1])
        var string = "\(stringArr[0])."

        var count = 0;
        for n in decimals {
            if count == max {
                if Int(String(n)) ?? 0 > 4 {
                    var lastDigit = Int(String(string.removeLast())) ?? 0
                    lastDigit += 1
                    string += "\(lastDigit)"
                }
                break
            }
            string += "\(n)"
            count += 1
        }
        
        return Double(string) ?? 0.0
    }
    
    static func convertStringToDouble(data: String?) -> Double {
        let doubleValue = Double(data ?? "0.0") ?? 0.0
        return StringUtilities.TwoDecimalPointDouble(doubleValue, maxDecimals: 2)
    }
    
    static func roundUpDoubleToString(data: Double) -> String {
        return String(format: "%.2f", round(100 * data) / 100)
    }
}
