//
//  PopularPresenter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation
import RadioBrowser

protocol PopularViewProtocol: AnyObject {
    func didUpdateStations()
    //func didUpdateVotedStation()
    func voteForStation(at: IndexPath?, stationUniqueID: UUID?)
}

protocol PopularPresenterProtocol {
    init(router: PopularRouterProtocol)
    var getStations: [PopularViewModel] { get }
    
    func loadStations() async
    func changeStation(_ stationId: Int)
    func toggleVoteState(for stationId: Int, stationUniqueID: UUID)
    func isStationVoted(_ stationId: Int) -> Bool
}

final class PopularPresenter: PopularPresenterProtocol {
    // MARK: - Private Properties
    private let radioBrowser = RadioBrowser.default
    private let storage = StorageManager.shared
    private let audioPlayer = AudioPlayerController.shared
    
    private var stations: [PopularViewModel] = []
    private var mockStations: [PopularViewModel] = []
    private var votedStations: [Bool] = []
    
    weak var view: PopularViewProtocol?
    private let router: PopularRouterProtocol
    
    // MARK: - Public Properties
    var getStations: [PopularViewModel] {
        get {
            return stations
        }
    }
    
    // MARK: - Init
    init(router: PopularRouterProtocol) {
        self.router = router
    }
}

// MARK: - Load Popular Stations
extension PopularPresenter {
    func loadStations() async {
        let result = await radioBrowser.getPopularStation()
        
        switch result {
        case .success(let fetctedStations):
            stations = fetctedStations.map({ station in
                let title: String
                let subtitle: String
                
                if let tag = station.tags.first, !tag.isEmpty {
                    title = tag
                    subtitle = station.name
                } else {
                    title = station.name
                    subtitle = ""
                }
                
                loadVotedStation(with: station.stationUUID)
                
                return PopularViewModel(
                    id: station.stationUUID,
                    title: title,
                    subtitle: subtitle,
                    voteCount: station.votes,
                    url: station.urlResolved
                )
            })
        case .failure(let error):
            print(error)
        }
        
        setAudioPlayerStations()
        view?.didUpdateStations()
    }
}

// MARK: - Load Voted Stations
private extension PopularPresenter {
    func loadVotedStation(with stationUniqueID: UUID) {
        if let _ = storage.fetchStation(with: stationUniqueID) {
            votedStations.append(true)
        } else {
            votedStations.append(false)
        }
        
        //view?.didUpdateVotedStation()
    }
}

// MARK: - Set AudioPlayer Stations
private extension PopularPresenter {
    func setAudioPlayerStations() {
        let audioStations: [AudioStation] = stations.map { station in
            AudioStation(id: station.id, url: station.url)
        }
        audioPlayer.setStations(audioStations)
    }
}

// MARK: - Change Station
extension PopularPresenter {
    func changeStation(_ stationId: Int) {
        let currentStationId = audioPlayer.currentIndex
        
        if stationId != currentStationId {
            audioPlayer.playStation(at: stationId)
        }
    }
}

// MARK: - Votes for Station
extension PopularPresenter {
    func toggleVoteState(for stationId: Int, stationUniqueID: UUID) {
        votedStations[stationId].toggle()
        
        var selectedStation = stations[stationId]
        let voteChange = isStationVoted(stationId) ? 1 : -1
        
        selectedStation = PopularViewModel(
            id: stationUniqueID,
            title: selectedStation.title,
            subtitle: selectedStation.subtitle,
            voteCount: selectedStation.voteCount + voteChange,
            url: selectedStation.url
        )
        
        stations[stationId] = selectedStation
        storage.toggleFavorite(id: stationUniqueID, title: selectedStation.title, genre: selectedStation.subtitle)
    }
    
    func isStationVoted(_ stationId: Int) -> Bool {
        return votedStations[stationId]
    }
}
