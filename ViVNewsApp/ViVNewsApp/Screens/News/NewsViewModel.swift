//
//  NewsViewModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation
protocol NewsViewModelType {
//    var props: MainProps { get set }
}

final class NewsViewModel: NewsViewModelType {
    
    private let coordinator: NewsCoordinatorType
    private var newsService: NewsServiceType

    init(_ coordinator: NewsCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        newsService = serviceHolder.get(by: NewsServiceType.self)

    }
}
