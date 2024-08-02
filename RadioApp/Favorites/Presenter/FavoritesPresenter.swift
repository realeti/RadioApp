//
//  FavoritesPresenter.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var view: FavoritesControllerProtocol?
    var router: FavoritesRouterProtocol?
    
    func activate() {
       // fetch items
        updateUI()
    }
    
    private func updateUI() {
        view?.update(with: .init(items: [
            .init(
                radioTitle: "radioTitle",
                genre: "genre",
                favoriteHandler: { [weak self] in
                    self?.removeFromFavorites()
                },
                didSelectHandler: {}
            )
        ]))
    }
    
    private func removeFromFavorites() {
        
    }
}
