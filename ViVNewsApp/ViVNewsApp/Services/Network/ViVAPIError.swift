//
//  ViVAPIError.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//


import Foundation

struct ViVAPIError: Error, Decodable, LocalizedError {
    static let notMapError = ViVAPIError(
        message: "Server Error",
        code: 888
    )
    
    static let parseError = ViVAPIError(
        message: "Data error.",
        code: 888
    )
    
    static let someError = ViVAPIError(
        message: "Unknown Error",
        code: 999
    )
    
    static let urlError = ViVAPIError(
        message: "Uncorrect url path.",
        code: 999
    )
    
    let message: String
    let code: Int
    
    var errorDescription: String? {
        return message
    }
    
    var localizedDescription: String {
        return message
    }
    
    static func serverError(_ code: Int) -> ViVAPIError {
        return .init(message: "Server error: \(code)", code: code)
    }
}
