//
//  NewsService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation
import Alamofire

typealias NewsEmailedResponse = ((Result<[NewsModel]>) -> Void)?

typealias OneNewsModelCompletionType = ((Result<NewsResponseModel>) -> Void)?

protocol NewsServiceType: Service {
    func loadEmailed(completion: NewsEmailedResponse)
    func loadShared(completion: NewsEmailedResponse)
    func loadViewed(completion: NewsEmailedResponse)
}

class NewsService: NewsServiceType {
    private var newsModels: [NewsModel] = []

    func loadEmailed(completion: NewsEmailedResponse) {
        let period = 30
        
        guard let url = URL(string: "\(ApiPath.emailed.string)/\(period).json?api-key=\(Defines.API.apiKey)") else {
            completion?(.failure(ViVAPIError.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        Alamofire.request(request).validate().responseJSON { (response) in
            guard let httpResponse = response.response else {
                completion?(.failure(ViVAPIError.notMapError))
                return
            }
            let httpStatusCode = httpResponse.statusCode
            let acceptebleStatusCodes = IndexSet(integersIn: 200...300)
            if let error = response.error, !acceptebleStatusCodes.contains(httpStatusCode) {
                completion?(.failure(error))
            } else if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(NewsResponseModel.self, from: data)
                    self.newsModels = result.results
                    completion?(.success(self.newsModels))
                } catch {
                    completion?(.failure(error))
                }
            } else {
                completion?(.failure(ViVAPIError.notMapError))
            }
        }
    }
    
    func loadShared(completion: NewsEmailedResponse) {
    }
    
    func loadViewed(completion: NewsEmailedResponse) {
    }
}
