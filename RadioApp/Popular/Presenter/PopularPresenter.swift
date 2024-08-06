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
    init(view: PopularViewProtocol, router: Router)
    var getStations: [PopularViewModel] { get }
    
    func loadStations() async
    //func loadVotedStation()
    func changeStation(_ stationId: Int)
    func toggleVoteState(for stationId: Int, stationUniqueID: UUID)
    func isStationVoted(_ stationId: Int) -> Bool
}

final class PopularPresenter: PopularPresenterProtocol {
    // MARK: - Private Properties
    private let radioBrowser = RadioBrowser.default
    private let storage = StorageManager.shared
    
    private var stations: [PopularViewModel] = []
    private var mockStations: [PopularViewModel] = []
    private var votedStations: [Bool] = []
    
    private weak var view: PopularViewProtocol?
    private let router: Router
    
    // MARK: - Public Properties
    var getStations: [PopularViewModel] {
        get {
            return stations
        }
    }
    
    // MARK: - Init
    init(view: PopularViewProtocol, router: Router) {
        self.view = view
        self.router = router
    }
}

// MARK: - Load Popular Stations
extension PopularPresenter {
    func loadStations() async {
        //stations = getMockData()
        //votedStations = Array(repeating: false, count: stations.count)
        
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
                    voteCount: station.votes
                )
            })
        case .failure(let error):
            print(error)
        }
        
        //loadVotedStation()
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

// MARK: - Change Station
extension PopularPresenter {
    func changeStation(_ stationId: Int) {
        /// set new station for auido player
        print("change station (item id #\(stationId))")
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
            voteCount: selectedStation.voteCount + voteChange
        )
        
        stations[stationId] = selectedStation
        storage.toggleFavorite(id: stationUniqueID, title: selectedStation.title, genre: selectedStation.subtitle)
    }
    
    func isStationVoted(_ stationId: Int) -> Bool {
        return votedStations[stationId]
    }
}

// MARK: - Mock Data
/*private extension PopularPresenter {
    func getMockData() -> [PopularViewModel] {
        var stations: [PopularViewModel] = []
        
        let baseTitles = [
            "POP".localized,
            "16bit".localized,
            "Punk".localized,
            "Dj Remix".localized,
            "Adult".localized,
            "Etnic".localized,
        ]
        
        let baseSubtitles = [
            "Radio Record".localized,
            "Radio Gameplay".localized,
            "Russian Punk rock".localized,
            "!REMIX!".localized,
            "RUSSIAN WAVE".localized,
            "beufm.kz".localized
        ]
        
        let baseVotes = [
            315,
            240,
            200,
            54,
            315,
            74
        ]
        
        let stationTitles = Array(repeating: baseTitles, count: 2).flatMap { $0 }
        let stationSubtitles = Array(repeating: baseSubtitles, count: 2).flatMap { $0 }
        let stationVotes = Array(repeating: baseVotes, count: 2).flatMap { $0 }
        
        for index in 0..<stationTitles.count {
            let newStation = PopularViewModel(
                id: UUID(),
                title: stationTitles[index],
                subtitle: stationSubtitles[index],
                voteCount: stationVotes[index]
            )
            stations.append(newStation)
        }
        
        return stations
    }
}*/
