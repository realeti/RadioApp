//
//  FavoritesPresenter.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterProtocol {
    
    weak var view: FavoritesControllerProtocol?
    private let router: FavoritesRouterProtocol
    
    init(router: FavoritesRouterProtocol) {
        self.router = router
    }
    
    func activate() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let stations):
                updateUI(with: stations)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUI(with stations: [StationEntity]) {
        let items = stations.map { stationEntity in
            FavStationModel(
                radioTitle: stationEntity.title ?? "",
                genre: stationEntity.genre ?? "",
                favoriteHandler: { [weak self] in
                    self?.removeFromFavorites(stationEntity)
                },
                didSelectHandler: {}
            )
        }
        /*let items: [FavStationModel] = [.init(radioTitle: "RadioL Legend", genre: "11", favoriteHandler: {}, didSelectHandler: { self.router.showDetails() })]*/
        view?.update(with: .init(items: items))
    }
    
    private func removeFromFavorites(_ stationEntity: StationEntity) {
        StorageManager.shared.deleteStation(stationEntity)
    }
}
