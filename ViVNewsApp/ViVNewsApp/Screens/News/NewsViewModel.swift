//
//  NewsViewModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

typealias NewsProps = NewsViewController.Props

enum NewsSegmentTab: Int {
    case emailed = 0
    case shared
    case viewed
    
    static let all: [NewsSegmentTab] = [.emailed, .shared, .viewed]
}

protocol NewsViewModelType {
    var didStateChanged: ((NewsProps) -> Void)? { get set }
    
    func refresh()
    func selectSegmentTab(index: Int) 
}

final class NewsViewModel: NewsViewModelType {
    var didStateChanged: ((NewsProps) -> Void)?

    private let coordinator: NewsCoordinatorType
    private var newsService: NewsServiceType

    private var news: [NewsModel] = []
    private var favouriteNews: [NewsModel] = []

    private var selectedTab: NewsSegmentTab = .emailed
    private var screenState: NewsProps.ScreenState = .initial
    
    init(_ coordinator: NewsCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        newsService = serviceHolder.get(by: NewsServiceType.self)
        loadNews()
    }
    
    private func setScreenState(_ state: NewsProps.ScreenState) {
        screenState = state
        updateProps()
    }
    
    
    private func loadFavourites() {
        FavouritesService.getFavourites { (favourites) in
            self.favouriteNews = favourites
            self.setScreenState(.loaded)
        }
    }
    
    private func loadNews() {
        self.setScreenState(.loading)
        
        switch selectedTab {
        case .emailed:
            newsService.loadEmailed { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.loadFavourites()
                case .failure(let error):
                    self.setScreenState(.failed(error.localizedDescription))
                }
            }
        case .shared:
            newsService.loadShared { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.loadFavourites()
                case .failure(let error):
                    self.setScreenState(.failed(error.localizedDescription))
                }
            }
        case .viewed:
            newsService.loadViewed { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.loadFavourites()
                case .failure(let error):
                    self.setScreenState(.failed(error.localizedDescription))
                }
            }
        }
    }
    
    func refresh() {
        loadNews()
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
            isFavorite: self.isFavourite(id: newsModel.id),
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
    
    func selectSegmentTab(index: Int) {
        selectedTab = NewsSegmentTab(rawValue: index) ?? .emailed
        loadNews()
    }
    
    private func isFavourite(id: Int?) -> Bool {
        return favouriteNews.contains { $0.id == id }
    }
    
    func updateProps() {
        let props = NewsProps(
            state: self.screenState,
            selectedTab: self.selectedTab,
            onRefresh: Command {
                self.refresh()
            },
            items: self.createItems()
        )
        DispatchQueue.main.async {
            self.didStateChanged?(props)
        }
    }
}
