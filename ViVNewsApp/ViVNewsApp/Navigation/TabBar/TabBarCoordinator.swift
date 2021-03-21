//
//  TabBarCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

final class TabBarCoordinator {
    private let window: UIWindow
    private var rootController: UITabBarController?
    private var serviceHolder: ServiceHolder
    
    init(window: UIWindow, serviceHolder: ServiceHolder) {
        self.window = window
        self.serviceHolder = serviceHolder
    }
    
    func start(with items: [TabItem]) {
        let controller = UITabBarController()
        controller.viewControllers = items.compactMap { $0.controller }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()

        self.rootController = controller
    }
}
