//
//  PopularPresenter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation
import RadioBrowser

protocol PopularViewProtocol: AnyObject, LoadingPresenting {
    func didUpdateStations()
    func insertStations(at indexPaths: [IndexPath])
    func voteForStation(at: IndexPath?)
}

protocol PopularPresenterProtocol {
    init(router: PopularRouterProtocol)
    var getStations: [PopularViewModel] { get }
    var lastStationId: Int { get }
    var isLoadingData: Bool { get }
    
    func loadStations()
    func setPlayerStations()
    func removeVoteStatus(_ stationId: Int)
    func changeStation(_ stationId: Int)
    func updateLastStationId(_ stationId: Int)
    func resetLastStationId()
    func toggleVoteState(for stationId: Int)
    func isStationVoted(_ stationId: Int) -> Bool
    func showDetail(_ stationId: Int)
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
    
    var lastStationId: Int = K.invalidStationId
    var isLoadingData = false
    
    // MARK: - Init
    init(router: PopularRouterProtocol) {
        self.router = router    }
}

// MARK: - Load Popular Stations
extension PopularPresenter {
    func loadStations() {
        guard !isLoadingData else { return }
        if stations.isEmpty {
            view?.showLoading()
        }
        isLoadingData = true
        
        Task {
            let result = await radioBrowser.getPopularStation(offset: stations.count)
            
            switch result {
            case .success(let fetchedStations):
                let newStations = fetchedStations.map { station in
                    createStationViewModel(from: station)
                }
                
                guard !newStations.isEmpty else {
                    isLoadingData = false
                    return
                }
                
                /// update array of stations
                stations.append(contentsOf: newStations)
                
                /// update array of stations in audio player
                setPlayerStations()
                
                /// update view
                await updateView(with: newStations)
            case .failure(let error):
                handleError(error)
            }
            isLoadingData = false
        }
    }
}

// MARK: - Update View
private extension PopularPresenter {
    @MainActor
    func updateView(with newStations: [PopularViewModel]) {
        view?.hideLoading()
        if stations.count == newStations.count {
            /// if stations load first
            view?.didUpdateStations()
        } else {
            /// if station load after scroll
            let startIndex = stations.count - newStations.count
            let endIndex = stations.count - 1
            let indexPaths = (startIndex...endIndex).map {
                IndexPath(item: $0, section: 0)
            }
            view?.insertStations(at: indexPaths)
        }
    }
}

// MARK: - Handle Error
private extension PopularPresenter {
    func handleError(_ error: Error) {
        print("Failed to load stations: \(error.localizedDescription)")
    }
}

// MARK: - Create Station View Model
private extension PopularPresenter {
    func createStationViewModel(from station: Station) -> PopularViewModel {
        let stationNames = StationFormatter.formatNames(station)
        
        /// set vote status for station
        loadVotedStation(with: station.stationUUID)
        
        return PopularViewModel(
            id: station.stationUUID,
            title: stationNames.title,
            subtitle: stationNames.subtitle,
            voteCount: station.votes,
            url: station.urlResolved,
            imageURL: station.favicon
        )
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

// MARK: - Set PlayList for Audio Player
extension PopularPresenter {
    func setPlayerStations() {
        let playList: [PlayerStation] = stations.map { station in
            PlayerStation(id: station.id, url: station.url)
        }
        let startIndex = lastStationId == K.invalidStationId ? 0 : lastStationId
        audioPlayer.setStations(playList, startIndex: startIndex)
    }
}

// MARK: - Change Station
extension PopularPresenter {
    func changeStation(_ stationId: Int) {
        if stationId != lastStationId || lastStationId == K.invalidStationId {
            audioPlayer.playStation(at: stationId)
            updateLastStationId(stationId)
        }
    }
}

// MARK: - Update LastStationId
extension PopularPresenter {
    func updateLastStationId(_ stationId: Int) {
        lastStationId = stationId
    }
}

// MARK: - Reset LastStationId
extension PopularPresenter {
    func resetLastStationId() {
        lastStationId = K.invalidStationId
    }
}

// MARK: - Votes for Station
extension PopularPresenter {
    func toggleVoteState(for stationId: Int) {
        let voteChange = isStationVoted(stationId) ? 1 : -1
        updateVotes(for: stationId, voteChange: voteChange)
        
        /// save to storage
        let selectedStation = stations[stationId]
        storage.toggleFavorite(
            id: selectedStation.id,
            title: selectedStation.title,
            genre: selectedStation.subtitle,
            url: selectedStation.url,
            favicon: selectedStation.imageURL
        )
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
            url: selectedStation.url,
            imageURL: selectedStation.imageURL
        )
        
        // update array of popular stations
        stations[stationId] = selectedStation
    }
}

// MARK: - Show Detail
extension PopularPresenter {
    func showDetail(_ stationId: Int) {
        let selectedStation = stations[stationId]
        let radioStation = RadioStation(
            id: selectedStation.id,
            url: selectedStation.url,
            frequency: selectedStation.subtitle,
            name: selectedStation.title,
            imageName: selectedStation.imageURL
        )
        router.showDetail(with: radioStation)
    }
}
