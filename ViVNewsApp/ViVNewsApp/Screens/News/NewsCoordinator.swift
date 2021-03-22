//
//  NewsCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

protocol NewsTabCoordinatorType {}

class NewsTabCoordinator: NSObject, NewsTabCoordinatorType, TabBarItemCoordinatorType {
    
    let controller = UINavigationController()

    private var serviceHolder: ServiceHolder
    private var newsCoordinator: NewsCoordinator?
    
    init(serviceHolder: ServiceHolder) {
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        controller.navigationBar.isTranslucent = false
        
        newsCoordinator = NewsCoordinator(navigationController: controller, serviceHolder: serviceHolder)
        newsCoordinator?.start()
    }
}

protocol NewsCoordinatorType {
    func onNewsDetails(article: NewsModel)
}

final class NewsCoordinator: NewsCoordinatorType {
    weak var controller: NewsViewController? = Storyboard.news.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.isHidden = true
        self.serviceHolder = serviceHolder
        controller?.viewModel = NewsViewModel(self, serviceHolder: self.serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    func onNewsDetails(article: NewsModel) {
        let coordinator = ArticleDetailsCoordinator(navigationController: navigationController, serviceHolder: serviceHolder, article: article)
        coordinator.start(with: controller)
    }
}

