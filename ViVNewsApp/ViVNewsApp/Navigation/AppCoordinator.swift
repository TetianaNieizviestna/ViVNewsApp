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

    private var tabBarCoordinator: TabBarCoordinator?

    init(window: UIWindow) {
        self.window = window
        
        startServices()
    }
    
    private func startServices() {
        serviceHolder = ServiceHolder()
        
        newsService = NewsService()
        
        serviceHolder.add(NewsServiceType.self, for: newsService)
    }
    
    func start() {
        tabBarCoordinator = TabBarCoordinator(window: window, serviceHolder: serviceHolder)
        tabBarCoordinator?.start()
    }
}
