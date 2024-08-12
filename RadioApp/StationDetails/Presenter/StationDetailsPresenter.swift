//
//  StationDetailsPresenter.swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import Foundation

protocol StationDetailsPresenterProtocol {
    func viewDidLoad()
    func toggleFavorite()
    func getPlayerVolume() -> Float
    func updatePlayerVolume(_ volume: Float)
}

final class StationDetailsPresenter: StationDetailsPresenterProtocol {
    private let audioPlayer = AudioPlayerController.shared
    private weak var view: StationDetailsView?
    private let station: RadioStation
    private var isPlaying = false
    
    init(view: StationDetailsView, station: RadioStation) {
        self.view = view
        self.station = station
        if audioPlayer.currentId != station.id {
            audioPlayer.setStations([PlayerStation.init(id: station.id, url: station.url)])
            audioPlayer.playNext()
        }
        setNotification()
        if audioPlayer.isPlaying {
            self.view?.startEqualizerAnimation()
        }
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func viewDidLoad() {
        view?.displayStationDetails(station)
        loadFavStation(with: station.id)
    }
    
    func toggleFavorite() {
        StorageManager.shared.toggleFavorite(id: station.id, title: station.frequency, genre: station.name, url: station.url, favicon: station.url)
        loadFavStation(with: station.id)
    }
    
    
    func loadFavStation(with stationUniqueId: UUID) {
        if let _ = StorageManager.shared.fetchStation(with: stationUniqueId) {
            view?.updateFavButton(isFav: true)
        } else {
            view?.updateFavButton(isFav: false)
        }
    }
    
    func getPlayerVolume() -> Float {
        audioPlayer.volume
    }
    
    func updatePlayerVolume(_ volume: Float) {
        audioPlayer.volume = volume
    }
    // MARK: - Set Notification
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePlayerStatusChange),
            name: .playerStatusDidChange,
            object: nil
        )
    }
    
    @objc func handlePlayerStatusChange(_ notification: Notification) {
        if let isPlaying = notification.userInfo?[K.UserInfoKey.isPlaying] as? Bool {
            if isPlaying {
                view?.startEqualizerAnimation()
            } else {
                view?.stopEqualizerAnimation()
            }
        }
    }
    
}
