//
//  APIRequest.swift
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
            return "unknown"
        case .emailed:
            return "emailed"
        case .shared:
            return "shared"
        case .viewed:
            return "viewed"
        }
    }
}

final class Network {
    static func getUrlComponents(path: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.nytimes.com/svc/mostpopular/v2/"
        urlComponents.path = path
        guard let url = urlComponents.url else { return nil }
        
        return url
    }
}

//
//protocol ViVAPIRequest: HTTPRequest {
//    var apiPath: ApiPath { get }
//}
//
//extension ViVAPIRequest {
//    var path: String { return apiPath.string }
//    var acceptType: AcceptType? {
//        return .json
//    }
//}
//
//extension ViVAPIRequest {
//    var baseURL: URL { return URL(string: "")! }
//}
//
//extension ViVAPIRequest where Response: DecodableResponse {
//    func response(data: Data, urlResponse: HTTPURLResponse) throws -> Response {
//        return try Response.decode(data: data, urlResponse: urlResponse)
//    }
//}
//
//protocol DecodableResponse {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> Self
//}
//
//extension DecodableResponse where Self: Decodable {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> Self {
//        return try JSONDecoder().decode(Self.self, from: data)
//    }
//}
//
//extension ViVAPIRequest where Failure: DecodableFailure {
//    func failure(data: Data, urlResponse: HTTPURLResponse) throws -> Failure {
//        return try Failure.decode(data: data, urlResponse: urlResponse)
//    }
//}
//
//protocol DecodableFailure {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> Self
//}
//
//extension DecodableFailure where Self: Decodable {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> Self {
//        return try JSONDecoder().decode(Self.self, from: data)
//    }
//}
//
//extension Array: DecodableResponse where Element: Decodable {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> [Element] {
//        return try JSONDecoder().decode([Element].self, from: data)
//    }
//}
//
//extension Result: DecodableResponse where Success: DecodableResponse, Failure: DecodableResponse {
//    static func decode(data: Data, urlResponse: URLResponse) throws -> Result<Success, Failure> {
//        let successParsingError: Error
//        do {
//            let success = try Success.decode(data: data, urlResponse: urlResponse)
//            return .success(success)
//        } catch {
//            successParsingError = error
//        }
//        do {
//            let failure = try Failure.decode(data: data, urlResponse: urlResponse)
//            return .failure(failure)
//        } catch {
//            throw successParsingError
//        }
//    }
//}
