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
    var didLoadData: ((NewsProps) -> Void)? { get set }

}

final class NewsViewModel: NewsViewModelType {

    var didLoadData: ((NewsProps) -> Void)?

    private let coordinator: NewsCoordinatorType
    private var newsService: NewsServiceType
    private var favouritesService: FavouritesServiceType

    private var news: [NewsModel] = []
    private var selectedTab: NewsSegmentTab = .emailed
    
    init(_ coordinator: NewsCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        newsService = serviceHolder.get(by: NewsServiceType.self)
        favouritesService = serviceHolder.get(by: FavouritesServiceType.self)
        loadNews()
    }
    
    private func loadNews() {
        newsService.loadEmailed(completion: { result in
            switch result {
            case .success(let result):
                self.news = result
                self.updateProps()
            case .failure(let error):
                self.updateProps(error.localizedDescription)
            }
        }
        )
    }
    
    func updateProps(_ error: String? = nil) {
        handleError(error) {
            let props = NewsProps(
                state: .loaded,
                selectedTab: self.selectedTab,
                items: self.createItems()
            )
            self.didLoadData?(props)
        }
    }
    
    private func handleError(_ error: String? = nil, completion: (() -> Void)?) -> Void {
        if let error = error {
            let props = NewsProps(state: .failed(error), selectedTab: self.selectedTab, items: self.createItems())
            self.didLoadData?(props)
        } else {
            completion?()
        }
    }

    private func createItems() -> [NewsProps.Item] {
        let items = news.map { article -> NewsProps.Item in
            switch self.selectedTab{
            case .emailed:
                return .emailed(createCellProps(article))
            case .viewed:
                return .viewed(createCellProps(article))
            case .shared:
                return .shared(createCellProps(article))
            }
        }
        return items
    }
    
    
    private func createCellProps(_ newsModel: NewsModel) -> NewsTableViewCell.Props {
        let props = NewsTableViewCell.Props(
            title: newsModel.title ?? "",
            author: newsModel.byline ?? "",
            source: newsModel.source ?? "",
            date: Date.getFormattedDateString(string: newsModel.publishedDate ?? ""),
            description: newsModel.abstract ?? "",
            imageUrl: newsModel.uri,
            isFavorite: favouritesService.isFavourite(id: newsModel.id),
            type: self.selectedTab,
            onSelect: Command {
                if let id = newsModel.id {
                    self.coordinator.onNewsDetails(id: id)
                }
            }
        )
        return .initial
    }
}
