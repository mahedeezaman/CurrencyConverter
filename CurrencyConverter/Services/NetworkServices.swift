//
//  NetworkServices.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 01/10/2022.
//

import Foundation

class NetworkService {
    private func performRequestOperation<T: Codable> (urlRequest: URLRequest, responseType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw ErrorModels.apiError
        }
        
        return try JSONDecoder().decode(responseType.self, from: data)
    }
    
    func getConvertedData(requestData: CurrencyDataModel) async throws -> ResponseDataModel {
        if let url = URL(string: APIConstants.converterApiEndPoint(requestData: requestData)) {
            let responseData = try await performRequestOperation(urlRequest: URLRequest(url: url), responseType: ResponseDataModel.self)
            return responseData
        } else {
            throw ErrorModels.serverError
        }
    }
}
