//
//  ArticleDetailsCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import UIKit

protocol ArticleDetailsCoordinatorType {}

final class ArticleDetailsCoordinator: ArticleDetailsCoordinatorType {
    weak var controller: ArticleDetailsViewController? = Storyboard.articleDetails.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder, article: NewsModel) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = true
        self.serviceHolder = serviceHolder
        controller?.viewModel = ArticleDetailsViewModel(self, serviceHolder: self.serviceHolder, article: article)
    }
    
    func start() {
        if let controller = controller {
//            navigationController?.pushViewController(controller, animated: false)
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .overFullScreen
            navigationController?.present(controller, animated: true)
        }
    }
}
