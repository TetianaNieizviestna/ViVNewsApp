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
    
    func refresh()
    func selectSegmentTab(index: Int) 
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
        switch selectedTab {
        case .emailed:
            newsService.loadEmailed { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.updateProps()
                case .failure(let error):
                    self.updateProps(error.localizedDescription)
                }
            }
        case .shared:
            newsService.loadShared { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.updateProps()
                case .failure(let error):
                    self.updateProps(error.localizedDescription)
                }
            }
            
        case .viewed:
            newsService.loadViewed { result in
                switch result {
                case .success(let result):
                    self.news = result
                    self.updateProps()
                case .failure(let error):
                    self.updateProps(error.localizedDescription)
                }
            }
        }
    }
    
    func refresh() {
        loadNews()
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
            type: self.selectedTab,
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
    
    func selectSegmentTab(index: Int) {
        selectedTab = NewsSegmentTab(rawValue: index) ?? .emailed
        loadNews()
    }
}
