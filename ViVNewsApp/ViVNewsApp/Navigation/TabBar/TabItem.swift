//
//  TabItem.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

enum TabItem: Equatable {
    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        return lhs.index == rhs.index
    }
    
    case news(NewsCoordinator)
    case favourites(FavouritesCoordinator)
    
    var index: Int {
        switch self {
        case .news:
            return 0
        case .favourites:
            return 1
        }
    }
    
    var controller: UIViewController? {
        switch self {
        case .news(let coordinator):
           return coordinator.controller
        case .favourites(let coordinator):
            return coordinator.controller
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .news:
            return UIImage()
        case .favourites:
            return UIImage()
        }
    }
    
    var displayTitle: String {
        switch self {
        case .news:
            return "News"
        case .favourites:
            return "Favourites"
        }
    }
}
