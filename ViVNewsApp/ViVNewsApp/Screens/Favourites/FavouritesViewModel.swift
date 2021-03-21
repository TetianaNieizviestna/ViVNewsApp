//
//  FavouritesViewModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

typealias FavouritesProps = FavouritesViewController.Props

protocol FavouritesViewModelType {
    var didStateChanged: ((FavouritesProps) -> Void)? { get set }
}

final class FavouritesViewModel: FavouritesViewModelType{
    var didStateChanged: ((FavouritesProps) -> Void)?

    private let coordinator: FavouritesCoordinatorType
    private var favouritesService: FavouritesServiceType
    
    private var news: [NewsModel] = []
    private var screenState: FavouritesProps.ScreenState = .initial

    init(_ coordinator: FavouritesCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        favouritesService = serviceHolder.get(by: FavouritesServiceType.self)
        loadNews()
    }
    
    private func setScreenState(_ state: FavouritesProps.ScreenState) {
        screenState = state
        updateProps()
    }
    
    private func loadNews() {
        self.news = favouritesService.getFavourites()
    }
    
    func updateProps() {
        let props = FavouritesProps(
            state: self.screenState,
            items: self.createItems()
        )
        self.didStateChanged?(props)
    }

    private func createItems() -> [NewsTableViewCell.Props] {
        return news.map { self.createCellProps($0) }
    }
    
    private func createCellProps(_ newsModel: NewsModel) -> NewsTableViewCell.Props {
        return .init(
            title: newsModel.title ?? "",
            author: newsModel.byline ?? "",
            source: newsModel.source ?? "",
            date: Date.getFormattedDateString(string: newsModel.publishedDate ?? ""),
            description: newsModel.abstract ?? "",
            imageUrl: getImage(from: newsModel),
            isFavorite: favouritesService.isFavourite(id: newsModel.id),
            onSelect: Command {
                if let id = newsModel.id {
                    self.coordinator.onNewsDetails(id: id)
                }
            }
        )
    }
    
    private func getImage(from model: NewsModel) -> String? {
        if let firstImageMedia = model.media?.first(where: { $0.type == "image" }),
           let firstImage = firstImageMedia.mediaMetadata?[0] {
            return firstImage.url
        }
        return nil
    }
    
}
