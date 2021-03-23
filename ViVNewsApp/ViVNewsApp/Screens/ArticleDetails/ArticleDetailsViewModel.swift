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
    private var favourites: [NewsModel] = []
    private var newsModel: NewsModel

    init(_ coordinator: ArticleDetailsCoordinatorType, serviceHolder: ServiceHolder, article: NewsModel) {
        self.coordinator = coordinator
        self.newsModel = article
        self.loadFavourites()
    }
    
    private func loadFavourites() {
        FavouritesService.getFavourites {
            self.favourites = $0
            self.updateProps()
        }
    }
    
    func updateProps() {
        let props = ArticleProps(
            url: newsModel.url ?? "",
            isFavourite: self.isFavourite(id: newsModel.id),
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
    
    private func isFavourite(id: Int?) -> Bool {
        return favourites.contains { $0.id == id }
    }
    
    func changeFavouritesState() {
        if let id = newsModel.id {
            if self.isFavourite(id: id) {
                FavouritesService.remove(id: id)
            } else {
                FavouritesService.add(element: newsModel)
            }
        }
        loadFavourites()
    }
}
