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
    func voteForStation(at: IndexPath?)
}

protocol PopularPresenterProtocol {
    init(router: PopularRouterProtocol)
    var getStations: [PopularViewModel] { get }
    
    func loadStations() async
    func setStations()
    func changeStation(_ stationId: Int)
    func toggleVoteState(for stationId: Int)
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
        get { stations }
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
        
        setStations()
        view?.didUpdateStations()
    }
}

// MARK: - Load Voted Stations
private extension PopularPresenter {
    func loadVotedStation(with stationUniqueId: UUID) {
        if let _ = storage.fetchStation(with: stationUniqueId) {
            votedStations.append(true)
        } else {
            votedStations.append(false)
        }
    }
}

// MARK: - Set Stations
extension PopularPresenter {
    func setStations() {
        let audioStations: [PlayerStation] = stations.map { station in
            PlayerStation(id: station.id, url: station.url)
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
    func toggleVoteState(for stationId: Int) {
        let voteChange = isStationVoted(stationId) ? 1 : -1
        updateVotes(for: stationId, voteChange: voteChange)
        
        /// save to storage
        let selectedStation = stations[stationId]
        storage.toggleFavorite(id: selectedStation.id, title: selectedStation.title, genre: selectedStation.subtitle)
    }
    
    func isStationVoted(_ stationId: Int) -> Bool {
        return votedStations[stationId]
    }
    
    private func updateVotes(for stationId: Int, voteChange: Int) {
        votedStations[stationId].toggle()
        var selectedStation = stations[stationId]
        
        // update votes on current station
        selectedStation = PopularViewModel(
            id: selectedStation.id,
            title: selectedStation.title,
            subtitle: selectedStation.subtitle,
            voteCount: selectedStation.voteCount + voteChange,
            url: selectedStation.url
        )
        
        // update array of popular stations
        stations[stationId] = selectedStation
    }
}
