//
//  FavouritesCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

protocol FavouritesCoordinatorType {
    func onNewsDetails()
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
    
    func onNewsDetails() {
//        let coordinator = ArticleCoordinator()
//        coordinator.start()
    }
}
