//
//  ArticleDetailsViewModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 21.03.2021.
//

import Foundation
typealias ArticleProps = ArticleDetailsViewController.Props

protocol ArticleDetailsViewModelType {
    var didStateChanged: ((ArticleProps) -> Void)? { get set }
}

final class ArticleDetailsViewModel: ArticleDetailsViewModelType{
    var didStateChanged: ((ArticleProps) -> Void)?

    private let coordinator: ArticleDetailsCoordinatorType
    private var favouritesService: FavouritesServiceType
    
    private var newsModel: NewsModel

    init(_ coordinator: ArticleDetailsCoordinatorType, serviceHolder: ServiceHolder, article: NewsModel) {
        self.coordinator = coordinator
        favouritesService = serviceHolder.get(by: FavouritesServiceType.self)
        self.newsModel = article
        self.updateProps()
    }
    
    func updateProps() {
        let props = ArticleProps(
            url: newsModel.url ?? "",
            isFavourite: favouritesService.isFavourite(id: newsModel.id),
            onBack: Command {
                self.coordinator.dismiss()
            },
            onFavourite: Command {
                self.changeFavouritesState()
            }
        )
        DispatchQueue.main.async {
            self.didStateChanged?(props)
        }
    }
    
    func changeFavouritesState() {
        if let id = newsModel.id {
            if  favouritesService.isFavourite(id: id) {
                favouritesService.remove(id: id)
            } else {
                favouritesService.add(element: newsModel)
            }
        }
        updateProps()
    }
}
