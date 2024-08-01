//
//  PopularPresenter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation

protocol PopularViewProtocol: AnyObject {
    func didUpdateStations()
    func voteForStation(at: IndexPath?)
}

protocol PopularPresenterProtocol {
    init(view: PopularViewProtocol, router: Router)
    var getStations: [PopularViewModel] { get }
    
    func loadStations()
    func toggleVoteState(for stationId: Int)
    func isStationVoted(_ stationId: Int) -> Bool
}

final class PopularPresenter: PopularPresenterProtocol {
    // MARK: - Private Properties
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
    func loadStations() {
        stations = getMockData()
        votedStations = Array(repeating: false, count: stations.count)
        
        view?.didUpdateStations()
    }
}

// MARK: - Votes for Station
extension PopularPresenter {
    func toggleVoteState(for stationId: Int) {
        votedStations[stationId].toggle()
        
        var selectedStation = stations[stationId]
        let voteChange = isStationVoted(stationId) ? 1 : -1
        
        selectedStation = PopularViewModel(
            title: selectedStation.title,
            subtitle: selectedStation.subtitle,
            countVotes: selectedStation.countVotes + voteChange
        )
        
        stations[stationId] = selectedStation
    }
    
    func isStationVoted(_ stationId: Int) -> Bool {
        return votedStations[stationId]
    }
}

// MARK: - Mock Data
private extension PopularPresenter {
    func getMockData() -> [PopularViewModel] {
        var stations: [PopularViewModel] = []
        
        let baseTitles = [
            "POP",
            "16bit",
            "Punk",
            "Dj Remix",
            "Adult",
            "Etnic",
        ]
        
        let baseSubtitles = [
            "Radio Record",
            "Radio Gameplay",
            "Russian Punk rock",
            "!REMIX!",
            "RUSSIAN WAVE",
            "beufm.kz"
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
                title: stationTitles[index],
                subtitle: stationSubtitles[index],
                countVotes: stationVotes[index]
            )
            stations.append(newStation)
        }
        
        return stations
    }
}
