//
//  FavouritesService.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

// TODO: Add CoreData to save Favourites

protocol FavouritesServiceType: Service {
    func getFavourites() -> [NewsModel]
    func add(news: NewsModel)
    func remove(news: NewsModel)
}

class FavouritesService: FavouritesServiceType {
    func getFavourites() -> [NewsModel] {
        // get from CoreData
        return []
    }
    
    func add(news: NewsModel) {
        
    }
    
    func remove(news: NewsModel) {
        
    }
}
