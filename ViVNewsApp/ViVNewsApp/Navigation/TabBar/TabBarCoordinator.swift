//
//  TabBarCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

protocol TabBarItemCoordinatorType {
    var controller: UINavigationController { get }
}

final class TabBarCoordinator: NSObject {
    private let window: UIWindow
    private var rootController: UITabBarController?
    private var serviceHolder: ServiceHolder
    var items: [TabItem] = []
    
    init(window: UIWindow, serviceHolder: ServiceHolder) {
        self.window = window
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        let tabController = UITabBarController()

        let news = NewsTabCoordinator(serviceHolder: serviceHolder)
        let favs = FavouritesTabCoordinator(serviceHolder: serviceHolder)
        
        items = [
            .news(news),
            .favourites(favs)
        ]
        news.start()
        favs.start()

        tabController.viewControllers = items.compactMap { $0.controller }
        tabController.delegate = self
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()

        self.rootController = tabController
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case getTabCoordinatorRootNavigation(index: 0):
            newsStart()
            return true
        case getTabCoordinatorRootNavigation(index: 1):
            favsStart()
            return true
        default:
            return true
        }
    }
    
    private func newsStart() {
        let coordinator: NewsTabCoordinator? = getTabCoordinator(index: 0)
        coordinator?.start()
    }
    
    private func favsStart() {
        let coordinator: FavouritesTabCoordinator? = getTabCoordinator(index: 1)
        coordinator?.start()
    }

}

// MARK: - TabBarCoordinator {
extension TabBarCoordinator {
    
    func getTabCoordinator<T>(index: Int) -> T? {
        let tabIndex = index
        if tabIndex < items.count {
            return items[tabIndex] as? T
        }
        return nil
    }
    
    func selectTab(index: Int) {
        let tabIndex = index
        rootController?.selectedIndex = tabIndex
        let root = getTabCoordinatorRootNavigation(index: index)
        root?.popViewController(animated: true)
    }
    
    private func getTabCoordinatorRootNavigation(index: Int) -> UINavigationController? {
        let tabIndex = index
        if tabIndex < items.count {
            let tabItem = items[tabIndex]
            return tabItem.controller
        }
        return nil
    }
    
}
