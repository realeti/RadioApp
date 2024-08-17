//
//  SearchPresenter.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 10.08.2024.
//

import Foundation
import RadioBrowser

/// Презентер для экрана с  поиском радиостанций.
final class SearchPresenter {

	// MARK: - Dependencies

	private let router: AllStationsRouterProtocol
	private weak var view: AllStationsControllerProtocol!

	private let radioBrowser: RadioBrowser
	private let storageManager: StorageManager
	private let audioPlayer: AudioPlayerProtocol

	// MARK: - Private properties

	private var stations: [AllStationViewModel] = []
	private var searchText: String?
    
    // MARK: - Public properties
    
    var getStations: [AllStationViewModel] {
        get { stations }
    }
    
    var lastStationId: Int = K.invalidStationId

	// MARK: - Initialization

	/// Инициализатор презентера.
	/// - Parameters:
	///   - router: роутер, для осуществления перехода на другие экраны.
	///   - view: view, на которой будет отображаться информация.
	///   - radioBrowser: сервис для работы с `API all.api.radio-browser`.
	///   - storageManager: менеджер, управляющий хранилищем радиостанций.
	///   - audioPlayer: аудиоплеер.
	init(
		router: AllStationsRouterProtocol,
		view: AllStationsControllerProtocol,
		radioBrowser: RadioBrowser,
		storageManager: StorageManager,
		audioPlayer: AudioPlayerController
	) {
		self.router = router
		self.view = view
		self.radioBrowser = radioBrowser
		self.storageManager = storageManager
		self.audioPlayer = audioPlayer
	}
}

// MARK: - SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {

	/// Активация презентера для обновления информации на экране.
	///
	/// Обновляет экран по поиску радиостанций. Для подгрузки радиостанций используйте `fetchStations()`.
	func activate() {
		Task {
			await render()
		}
	}

	/// Загрузка радиостанций.
	///
	/// При вызове подгружает 20 станций и обновляет экран.
	func fetchStations() {
		Task {
			guard let searchText else { return }
			let result = await radioBrowser.searchStation(named: searchText, offset: stations.count)

			switch result {
			case .success(let data):
				stations += data.map({ makeStationModel(from: $0) })
				activate()
                setPlayerStations()
			case .failure(let error):
				print(error)
			}
		}
	}

	/// Поиск радиостанций по названию.
	///
	/// Получает первые 20 радиостанций из api и обновляет экран по поиску. Для подгрузки радиостанций используйте `fetchStations()`.
	func searchStations(with name: String) {
		Task {
			stations = []
			searchText = name
			fetchStations()
		}
	}

    /// Выбрана радиостанция.
    /// - Parameter indexPath: индекс радиостанции.
    ///
    /// Переход на экран с детальной информацией станции, которую выбрал пользователь.
    func showDetail(at indexPath: IndexPath) {
        let selectedStation = stations[indexPath.row]
        let radioStation = RadioStation(
            id: selectedStation.id,
            url: selectedStation.url,
            frequency: selectedStation.subtitle,
            name: selectedStation.title,
            imageName: selectedStation.imageURL
        )
        router.showStationDetails(with: radioStation)
    }
    
    /// Выбрана радиостанция
    /// - Parameter indexPath: индекс радиостанции
    ///
    /// Запуск плеера
    func didStationSelected(at indexPath: IndexPath) {
        let stationId = indexPath.row
        
        if stationId != lastStationId || lastStationId == K.invalidStationId {
            audioPlayer.playStation(at: stationId)
            updateLastStationId(stationId)
        }
    }

	/// Проголосовали за радиостанцию.
	/// - Parameter indexPath: индекс радиостанции.
	///
	/// Метод добавляет радиостанцию в избранное или удаляет от туда. Также голосует за выбранную радиостанцию, но только один раз.
    func didStationVoted(at indexPath: IndexPath) {
        Task {
            let station = stations[indexPath.row]

            let result = await radioBrowser.voteForStation(withId: station.id)
            switch result {
            case .success:
                let stationData = await getStation(withId: station.id)
                stations[indexPath.row] = stationData ?? station
            case .failure(let error):
                print(error)
            }

            favorite(station: station)
            await render()
        }
    }
}

// MARK: - Public methods

extension SearchPresenter {
    func updateLastStationId(_ stationId: Int) {
        lastStationId = stationId
    }
    
    func resetLastStationId() {
        lastStationId = K.invalidStationId
    }
}

// MARK: - Private methods

private extension SearchPresenter {

	@MainActor
	func render() {
		view.update()
	}
    
    func setPlayerStations() {
        let playList: [PlayerStation] = stations.map { station in
            PlayerStation(id: station.id, url: station.url)
        }
        let startIndex = lastStationId == K.invalidStationId ? 0 : lastStationId
        audioPlayer.setStations(playList, startIndex: startIndex)
    }

    func getStation(withId id: UUID) async -> AllStationViewModel? {
        let result = await radioBrowser.getStation(withId: id)
        switch result {
        case .success(let data):
            return data.map({ makeStationModel(from: $0) })
        case .failure(let error):
            print(error)
            return nil
        }
    }

    func favorite(station: AllStationViewModel) {
        storageManager.toggleFavorite(
            id: station.id,
            title: station.title.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines),
            genre: station.subtitle,
            url: station.url,
            favicon: station.imageURL
        )
    }

    func makeStationModel(from data: Station) -> AllStationViewModel {
        let station = storageManager.fetchStation(with: data.stationUUID)
        let stationNames = StationFormatter.formatNames(data)

        return AllStationViewModel(
            id: data.stationUUID,
            title: stationNames.title,
            subtitle: stationNames.subtitle,
            votes: data.votes,
            isFavorite: station != nil ? true : false,
            url: data.urlResolved,
            imageURL: data.favicon
        )
    }
}
