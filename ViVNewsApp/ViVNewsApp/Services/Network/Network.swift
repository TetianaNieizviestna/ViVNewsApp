//
//  Network.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//

import Foundation

enum ApiPath {
    case unknown
    case shared
    case viewed
    case emailed

    var string: String {
        switch self {
        case .unknown:
            return "\(Defines.API.baseUrl)unknown"
        case .emailed:
            return "\(Defines.API.baseUrl)emailed"
        case .shared:
            return "\(Defines.API.baseUrl)shared"
        case .viewed:
            return "\(Defines.API.baseUrl)viewed"
        }
    }
}
