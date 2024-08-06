//
//  StationDetailsPresenter.swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import Foundation

protocol StationDetailsPresenterProtocol {
    func viewDidLoad()
    func didTapPlayButton()
    func addStationToFavorites()
    func removeStationFromFavorites()
}

final class StationDetailsPresenter: StationDetailsPresenterProtocol {
    
    private weak var view: StationDetailsView?
    private let station: RadioStation
    private var isPlaying = false
    
    init(view: StationDetailsView, station: RadioStation) {
        self.view = view
        self.station = station
    }
    
    func viewDidLoad() {
        view?.displayStationDetails(station)
    }
    
    func didTapPlayButton() {
        if isPlaying {
            view?.stopEqualizerAnimation()
        } else {
            view?.startEqualizerAnimation()
        }
        
        isPlaying.toggle()
    }
    
    func addStationToFavorites() {
        print("Add to favorites")
    }
    
    func removeStationFromFavorites() {
        print("Remove from favorites")
    }
    
}
