//
//  HttpErrorModels.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

enum ErrorModels: Error {
    case noInternet
    case parsingError
    case apiError
    case serverError
}
