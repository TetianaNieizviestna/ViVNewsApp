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
    
    private var news: [NewsModel] = []
    
    init(_ coordinator: FavouritesCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        loadNews()
    }
    
    private func loadNews() {
        news = FavouritesService.getFavourites()
        updateProps()
        print("Loading")
    }
    
    func updateProps() {
        let props = FavouritesProps(
            onRefresh: Command {
                self.loadNews()
            },
            items: self.createItems()
        )
        DispatchQueue.main.async {
            self.didStateChanged?(props)
        }
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
            isFavorite: FavouritesService.isFavourite(id: newsModel.id),
            onSelect: Command {
                self.coordinator.onNewsDetails(article: newsModel)
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
