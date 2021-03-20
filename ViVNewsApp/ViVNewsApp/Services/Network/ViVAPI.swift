//
//  ViVAPI.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 20.03.2021.
//


import Foundation

//final class ViVAPI {
//    typealias Completion<Request: ViVAPIRequest> = (Result<Request.Response, Error>) -> Void
//
//    let refreshQueue = DispatchQueue(label: "com.org.com.refresh_queue", attributes: .concurrent)
//    private let client: HTTPClient
//    private var _isTokenRefreshing = false
//    private var isTokenRefreshing: Bool {
//        get { return refreshQueue.sync { _isTokenRefreshing } }
//        set { refreshQueue.async(flags: .barrier) { self._isTokenRefreshing = newValue } }
//    }
//
//    private var _savedRequests: [DispatchWorkItem] = []
//    private var savedRequests: [DispatchWorkItem] {
//        get { return refreshQueue.sync { _savedRequests } }
//        set { refreshQueue.async(flags: .barrier) { self._savedRequests = newValue } }
//    }
//
//    init() {//(session: URLHTTPSession = URLSession.shared) {
//        self.client = HTTPClient()// .init(session: session)
//    }
//
//    func send<Request: ViVAPIRequest>(
//        _ request: Request,
//        completion: @escaping Completion<Request>
//    ) {
//        client.send(
//            request,
//            requestBuilder: { try request.buildURLRequest() },
//            completion: { [weak self] result in
//                guard let `self` = self else { return }
//                completion(self.transformResult(request: request, result: result))
//            }
//        )
//    }
//
//    private func transformResult<Request: ViVAPIRequest>(
//        request: Request,
//        result: Result<(Data, HTTPURLResponse), HTTPRequestError>
//    ) -> Result<Request.Response, Error> {
//        switch result {
//        case let .success((data, response)):
//            switch response.statusCode {
//            case 200...399:
//                do {
//                    return .success(try request.response(data: data, urlResponse: response))
//                } catch {
//                    return .failure(ViVAPIError.serverError(response.statusCode))
//                }
//            case 400...:
//                do {
//                    return .failure(try request.failure(data: data, urlResponse: response))
//                } catch {
//                    return .failure(ViVAPIError.notMapError)
//                }
//            default:
//                return .failure(ViVAPIError.someError)
//            }
//        case .failure(let error):
//            switch error {
//            case .requestError(let error):
//                return .failure(error)
//            case
//                .invalidBaseURL,
//                .responseError,
//                .nonHTTPResponse:
//                return .failure(ViVAPIError.someError)
//            }
//        }
//    }
//
//    private func saveRequest(_ perform: @escaping () -> Void) {
//        savedRequests.append(DispatchWorkItem { perform() })
//    }
//
//    private func executeAllSavedRequests() {
//        savedRequests.forEach { $0.perform() }
//        savedRequests.removeAll()
//    }
//}
