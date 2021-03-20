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
    
    var item: UITabBarItem {
        let item = UITabBarItem(title: displayTitle, image: icon, selectedImage: iconFill)
        
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Style.Color.tabBarItemSelected], for: .selected)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Style.Color.tabBarItem], for: .normal)
        
        UITabBar.appearance().tintColor = Style.Color.tabBarItem
        UITabBar.appearance().unselectedItemTintColor = Style.Color.tabBarItem

        return item
    }
    
    var index: Int {
        switch self {
        case .news:
            return 0
        case .favourites:
            return 1
        }
    }
    
    var controller: UIViewController? {
        var controller: UIViewController?
        switch self {
        case .news(let coordinator):
             controller = coordinator.controller
        case .favourites(let coordinator):
             controller = coordinator.controller
        }
        controller?.tabBarItem = item
        return controller
    }
    
    var icon: UIImage? {
        var image: UIImage?
        switch self {
        case .news:
            image = Style.Image.news
        case .favourites:
            image = Style.Image.favourite
        }
        return image?.withRenderingMode(.alwaysOriginal).withTintColor(Style.Color.tabBarItem)
    }
    
    var iconFill: UIImage? {
        var image: UIImage?
        switch self {
        case .news:
            image = Style.Image.newsSelected
        case .favourites:
            image = Style.Image.favouriteSelected
        }
        return image?.withRenderingMode(.alwaysOriginal).withTintColor(Style.Color.tabBarItemSelected)
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
