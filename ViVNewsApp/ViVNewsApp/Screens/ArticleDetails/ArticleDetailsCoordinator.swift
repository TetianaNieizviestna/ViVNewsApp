//
//  ArticleDetailsCoordinator.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import UIKit

protocol ArticleDetailsCoordinatorType {
    func dismiss()
}

final class ArticleDetailsCoordinator: ArticleDetailsCoordinatorType {
    weak var controller: ArticleDetailsViewController? = Storyboard.articleDetails.instantiateViewController()
    private let navigationController: UINavigationController?
    private var serviceHolder: ServiceHolder!
    
    private var article: NewsModel
    
    init(navigationController: UINavigationController?, serviceHolder: ServiceHolder, article: NewsModel) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.isTranslucent = true
        self.serviceHolder = serviceHolder
        self.article = article
        controller?.viewModel = ArticleDetailsViewModel(self, serviceHolder: self.serviceHolder, article: article)
    }
    
    func start(with delegate: ArticleScreenDelegate?) {
        if let controller = controller {
            controller.modalTransitionStyle = .coverVertical
            controller.modalPresentationStyle = .overFullScreen
            controller.delegate = delegate
            navigationController?.present(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        self.controller?.dismiss(animated: false) 
    }
}
