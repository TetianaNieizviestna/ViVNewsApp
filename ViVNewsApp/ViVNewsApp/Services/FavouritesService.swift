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
     
    func getFavourites() -> [NewsModel] {
        // get from CoreData
//        news = getFromCoreData()
        return news
    }
    
    func add(element: NewsModel) {
        news.append(element)
        updateCoreData()
    }
    
    func remove(id: Int) {
        news.removeAll { $0.id == id }
        updateCoreData()
    }
    
    func isFavourite(id: Int?) -> Bool {
        return news.contains { $0.id == id }
    }
    
    private func updateCoreData() {
//        CoreDataHelper.saveToCoreData(news)
    }
}
