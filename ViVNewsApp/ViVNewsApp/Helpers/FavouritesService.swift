//
//  FavouritesService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

class FavouritesService {
    
    static func getFavourites() -> [NewsModel] {
        //        var newsList: [NewsModel] = []
        //        CoreDataServices.read(NewsModelData.self, NewsModel.self) { array in
        //            if let news = array {
        //                newsList = news
        //            }
        //        }
        //        return newsList
        return UserDefaultsService.getFavourites()
    }
    
    static func add(element: NewsModel) {
        //        CoreDataServices.create(element, NewsModelData.self)
        //        news.append(element)
        //        readAll()
        
        var news = UserDefaultsService.getFavourites()
        news.append(element)
        UserDefaultsService.saveFavourites(newsModels: news)
    }
    
    static func remove(id: Int) {
        //        if let newsModel = news.first(where: { $0.id == id }) {
        //            CoreDataServices.delete(newsModel, NewsModelData.self)
        //
        //            readAll()
        //        }
        var news = UserDefaultsService.getFavourites()
        if let newsModel = news.firstIndex(where: { $0.id == id }) {
            news.remove(at: newsModel)
            UserDefaultsService.saveFavourites(newsModels: news)
        }
    }
    
    static func isFavourite(id: Int?) -> Bool {
        let news = UserDefaultsService.getFavourites()
        return news.contains { $0.id == id }
    }
}
