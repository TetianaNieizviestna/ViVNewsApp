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
    
    func changeFavouritesState()
}

final class ArticleDetailsViewModel: ArticleDetailsViewModelType{
    var didStateChanged: ((ArticleProps) -> Void)?

    private let coordinator: ArticleDetailsCoordinatorType
    private var favouritesService: FavouritesServiceType
    
    private var newsModel: NewsModel
    private var screenState: ArticleProps.ScreenState = .initial

    init(_ coordinator: ArticleDetailsCoordinatorType, serviceHolder: ServiceHolder, article: NewsModel) {
        self.coordinator = coordinator
        favouritesService = serviceHolder.get(by: FavouritesServiceType.self)
        self.newsModel = article
    }
    
    private func setScreenState(_ state: ArticleProps.ScreenState) {
        screenState = state
        updateProps()
    }
    
    func updateProps() {
        let props = ArticleProps(
            state: self.screenState,
            url: newsModel.url ?? "",
            onBack: Command {
                self.coordinator.dissmiss()
            },
            onFavourite: Command {
                self.changeFavouritesState()
            }
        )
        self.didStateChanged?(props)
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
