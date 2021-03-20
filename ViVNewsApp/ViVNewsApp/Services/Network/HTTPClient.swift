//
//  HTTPClient.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//


//import Foundation
//import Alamofire
//protocol URLHTTPTask {
//    func resume()
//    func cancel()
//}

//protocol URLHTTPSession {
//    @discardableResult
//    func send(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLHTTPTask
//}
//
//extension URLSession: URLHTTPSession {
//    @discardableResult
//    func send(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLHTTPTask {
//        let task = self.dataTask(with: request, completionHandler: completion)
//        return task
//    }
//}

//extension URLSessionDataTask: URLHTTPTask { }

//class HTTPClient {
//    private let session: URLHTTPSession
//
//    init(session: URLHTTPSession) {
//        self.session = session
//    }
//
//    func send<Request: HTTPRequest>(
//        _ request: Request,
//        requestBuilder: Request.URLRequestBuilder,
//        completion: @escaping (Result<(Data, HTTPURLResponse), HTTPRequestError>) -> Void
//    ) {
//        let urlRequest: URLRequest
//        do {
//            urlRequest = try requestBuilder()
//        } catch let error as HTTPRequestError {
//            completion(.failure(error))
//            return
//        } catch {
//            assertionFailure("Unexpected error from building an URLRequest from HTTPRequest")
//            completion(.failure(HTTPRequestError.requestError(error)))
//            return
//        }
        
//        let task = session.send(request: urlRequest) { data, urlResponse, error in
//            let result: Result<(Data, HTTPURLResponse), HTTPRequestError>
//            switch (data, urlResponse, error) {
//            case (_, _, let error?):
//                result = .failure(HTTPRequestError.requestError(error))
//            case let(data?, urlResponse as HTTPURLResponse, _):
//                result = .success((data, urlResponse))
//            default:
//                result = .failure(HTTPRequestError.nonHTTPResponse(urlResponse))
//            }
//            completion(result)
//        }
//        task.resume()
//    }
//}
