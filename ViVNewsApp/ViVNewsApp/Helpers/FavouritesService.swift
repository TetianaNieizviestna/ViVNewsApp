//
//  FavouritesService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

class FavouritesService {
    
    static func getFavourites(completion: (([NewsModel]) -> Void)?) {
        CoreDataServices.read(NewsModelData.self, NewsModel.self) { array in
            if let news = array {
                completion?(news)
            }
        }
    }
    
    static func add(element: NewsModel) {
        CoreDataServices.create(element, NewsModelData.self)
    }
    
    static func remove(id: Int) {
        FavouritesService.getFavourites(completion: { news in
            if let newsModel = news.first(where: { $0.id == id }) {
                CoreDataServices.delete(newsModel, NewsModelData.self)
            }
        })
    }
}
