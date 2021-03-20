//
//  NewsCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

protocol NewsCoordinatorType {
    func onNewsDetails()
}

final class NewsCoordinator: NewsCoordinatorType {
    weak var controller: NewsViewController? = Storyboard.news.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = true
        self.serviceHolder = serviceHolder
        controller?.viewModel = NewsViewModel(self, serviceHolder: self.serviceHolder)
    }
    
    func start() {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    func onNewsDetails() {
        
    }
}
