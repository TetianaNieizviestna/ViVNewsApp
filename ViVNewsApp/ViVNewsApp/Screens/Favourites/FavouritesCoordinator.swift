//
//  FavouritesCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

protocol FavouritesTabCoordinatorType {}

class FavouritesTabCoordinator: NSObject, FavouritesTabCoordinatorType, TabBarItemCoordinatorType {
    
    let controller = UINavigationController()

    private var serviceHolder: ServiceHolder
    private var favouritesCoordinator: FavouritesCoordinator?
    
    init(serviceHolder: ServiceHolder) {
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        controller.navigationBar.isTranslucent = false
        controller.navigationBar.isHidden = true

        favouritesCoordinator = FavouritesCoordinator(navigationController: controller, serviceHolder: serviceHolder)
        favouritesCoordinator?.start()
    }
}


protocol FavouritesCoordinatorType {
    func onNewsDetails(article: NewsModel)
}

final class FavouritesCoordinator: FavouritesCoordinatorType {
    weak var controller: FavouritesViewController? = Storyboard.favourites.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = true
        self.serviceHolder = serviceHolder
        controller?.viewModel = FavouritesViewModel(self, serviceHolder: self.serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    func onNewsDetails(article: NewsModel) {
        let coordinator = ArticleDetailsCoordinator(navigationController: navigationController, serviceHolder: serviceHolder, article: article)
        coordinator.start()
    }
}
