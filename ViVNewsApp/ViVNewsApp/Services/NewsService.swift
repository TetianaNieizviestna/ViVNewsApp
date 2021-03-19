//
//  NewsService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation
import Alamofire

typealias NewsResponse = ((Result<[NewsModel]>) -> Void)?

typealias OneNewsModelCompletionType = ((Result<NewsModel>) -> Void)?

protocol NewsServiceType: Service {
    var news: [NewsModel] { get set }

    func loadNews(completion: NewsResponse)
}

class NewsService: NewsServiceType {
    var news: [NewsModel]
        
    init() {
        news = []
    }
    
    func loadNews(completion: NewsResponse) {
        print("loadMessages")
//        let url = networkService.getUrlComponents(path: "/api/message/byjob/\(jobId)")
//        let request = networkService.getDefaultRequest(url: url)
//
//        //        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
//        Alamofire.request(request).validate().responseJSON { (response) in
//            guard let httpResponse = response.response else {
//                if !NetworkService.isConnectedToInternet {
//                    completion?(.failure(AppError.noInternetConnection))
//                } else {
//                    completion?(.failure(AppError.serverError))
//                }
//                return
//            }
//            let httpStatusCode = httpResponse.statusCode
//            let acceptebleStatusCodes = IndexSet(integersIn: 200...300)
//            if let error = response.error, !acceptebleStatusCodes.contains(httpStatusCode) {
//                print("Load messages request error: \(error.localizedDescription)")
//                completion?(.failure(AppError.server(httpStatusCode)))
//            } else if let data = response.data {
//                do {
//                    let messagesResult = try JSONDecoder().decode([MessageModel].self, from: data)
//                    completion?(.success(messagesResult))
//                } catch {
//                    completion?(.failure(AppError.serverError))
//                }
//            } else {
//                print(AppError.dataError.localizedDescription)
//                if !NetworkService.isConnectedToInternet {
//                    completion?(.failure(AppError.noInternetConnection))
//                } else {
//                    completion?(.failure(AppError.dataError))
//                }
//            }
//
//        }
    }
}
