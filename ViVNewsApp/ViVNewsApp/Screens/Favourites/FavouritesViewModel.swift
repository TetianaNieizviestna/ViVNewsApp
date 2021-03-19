//
//  FavouritesViewModel.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import Foundation

protocol FavouritesViewModelType {}

class FavouritesViewModel: FavouritesViewModelType{
    private let coordinator: FavouritesCoordinatorType
    private var favouritesService: FavouritesServiceType

    init(_ coordinator: FavouritesCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        favouritesService = serviceHolder.get(by: FavouritesServiceType.self)
    }
}
