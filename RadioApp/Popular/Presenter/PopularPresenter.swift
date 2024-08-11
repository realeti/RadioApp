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
    func insertItems(at indexPaths: [IndexPath])
    func voteForStation(at: IndexPath?)
}

protocol PopularPresenterProtocol {
    init(router: PopularRouterProtocol)
    var getStations: [PopularViewModel] { get }
    var isLoadingData: Bool { get }
    var isDataLoaded: Bool { get }
    
    func loadStations() async
    func setStations()
    func removeVoteStatus(_ stationId: Int)
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
    
    var isLoadingData = false
    var isDataLoaded = false
    
    // MARK: - Init
    init(router: PopularRouterProtocol) {
        self.router = router
    }
}

// MARK: - Load Popular Stations
extension PopularPresenter {
    func loadStations() async {
        guard !isLoadingData else { return }
        isLoadingData = true
        
        let result = await radioBrowser.getPopularStation(offset: stations.count)
        
        switch result {
        case .success(let fetctedStations):
            let newStations = fetctedStations.map({ station in
                /// format station names
                let stationNames = formatStationNames(station)
                
                /// update vote status for station
                loadVotedStation(with: station.stationUUID)
                
                return PopularViewModel(
                    id: station.stationUUID,
                    title: stationNames.title,
                    subtitle: stationNames.subtitle,
                    voteCount: station.votes,
                    url: station.urlResolved
                )
            })
            
            if stations.isEmpty {
                /// if stations loaded first time
                stations.append(contentsOf: newStations)
                view?.didUpdateStations()
            } else {
                /// if stations loaded after scroll
                let startIndex = stations.count
                let endIndex = startIndex + newStations.count - 1
                let indexPaths = (startIndex...endIndex).map { IndexPath(item: $0, section: 0) }
                stations.append(contentsOf: newStations)
                view?.insertItems(at: indexPaths)
            }
            
            /// update array of stations in audio player
            setStations()
        case .failure(let error):
            print(error)
        }
        
        isDataLoaded = true
        isLoadingData = false
    }
}

// MARK: - Format Station Names
private extension PopularPresenter {
    func formatStationNames(_ station: Station) -> (title: String, subtitle: String) {
        let title: String
        let subtitle: String
        
        if let tag = station.tags.first, !tag.isEmpty {
            title = tag
            subtitle = station.name
        } else {
            title = station.name
            subtitle = ""
        }
        
        return (title: title, subtitle: subtitle)
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

// MARK: - Remove Vote Status
extension PopularPresenter {
    func removeVoteStatus(_ stationId: Int) {
        votedStations[stationId] = false
    }
}

// MARK: - Set Stations for Audio Player
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
