//
//  AppCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation
import UIKit

final class AppCoordinator {
    private var navigationController: UINavigationController?
    private let window: UIWindow
    
    private var serviceHolder: ServiceHolder!

    private var newsService: NewsService!
    private var favouritesService: FavouritesService!

    private var tabBarCoordinator: TabBarCoordinator?

    init(window: UIWindow) {
        self.window = window
        
        startServices()
    }
    
    private func startServices() {
        serviceHolder = ServiceHolder()
        
        newsService = NewsService()
        favouritesService = FavouritesService()
        
        serviceHolder.add(NewsServiceType.self, for: newsService)
        serviceHolder.add(FavouritesServiceType.self, for: favouritesService)
    }
    
    func start() {
        navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        tabBarCoordinator = TabBarCoordinator(window: window, serviceHolder: serviceHolder)
        let items: [TabItem] = [
            .news(NewsCoordinator(navigationController: navigationController, serviceHolder: serviceHolder)),
            .favourites(FavouritesCoordinator(navigationController: navigationController, serviceHolder: serviceHolder))
        ]
        tabBarCoordinator?.start(with: items)
    }
}
