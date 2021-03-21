//
//  FavouritesService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

protocol FavouritesServiceType: Service {
    func getFavourites() -> [NewsModel]
    func add(element: NewsModel)
    func remove(id: Int)
    func isFavourite(id: Int?) -> Bool
}

class FavouritesService: FavouritesServiceType {
    private var news: [NewsModel] = []
    init() {
        news = getFavourites()
    }
    func getFavourites() -> [NewsModel] {
        CoreDataServices.read(NewsModelData.self, NewsModel.self) { array in
            if let array = array {
                self.news = array
            }
        }
        return news
    }
    
    func add(element: NewsModel) {
        CoreDataServices.create(element, NewsModelData.self)
        news = getFavourites()
    }
    
    func remove(id: Int) {
        if let newsModel = news.first(where: { $0.id == id }) {
            CoreDataServices.delete(newsModel, NewsModelData.self)
        }
        news = getFavourites()
    }
    
    func isFavourite(id: Int?) -> Bool {
        return news.contains { $0.id == id }
    }
}
