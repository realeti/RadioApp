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

	private var stations: [Station] = []
    private var lastStationId: Int = 0
	private var searchText: String?
    
    // MARK: - Public properties
    
    var getStations: [Station] {
        get { stations }
    }

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
				stations += data
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
        router.showStationDetails(with: stations[indexPath.row])
    }
    
    /// Выбрана радиостанция
    /// - Parameter indexPath: индекс радиостанции
    ///
    /// Запуск плеера
    func didStationSelected(at indexPath: IndexPath) {
        let stationId = indexPath.row
        
        if stationId != lastStationId {
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

			let result = await radioBrowser.voteForStation(withId: station.stationUUID)
			switch result {
			case .success:
				let stationData = await getStation(withId: station.stationUUID)
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
}

// MARK: - Private methods

private extension SearchPresenter {

	@MainActor
	func render() {
		view.update(with: mapStationsData())
	}
    
    func setPlayerStations() {
        let playList: [PlayerStation] = stations.map { station in
            PlayerStation(id: station.stationUUID, url: station.url)
        }
        audioPlayer.setStations(playList, startIndex: lastStationId)
    }

	func getStation(withId id: UUID) async -> Station? {
		let result = await radioBrowser.getStation(withId: id)
		switch result {
		case .success(let data):
			return data
		case .failure(let error):
			print(error)
			return nil
		}
	}

	func favorite(station: Station) {
		storageManager.toggleFavorite(
			id: station.stationUUID,
			title: station.name.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines),
			genre: station.tags.first ?? "",
            url: station.url,
            favicon: station.favicon
		)
	}

	func mapStationsData() -> AllStations.Model {
		let radioStations = stations.map { makeStationModel(from: $0) }
		let indexPlayingNow = IndexPath(row: audioPlayer.currentIndex, section: 0)
		return AllStations.Model(stations: radioStations, indexPlayingNow: indexPlayingNow)
	}

	func makeStationModel(from data: Station) -> AllStations.Model.Station {
		let station = storageManager.fetchStation(with: data.stationUUID)

		var tag = data.tags.first ?? "Not known".localized
		tag = tag.isEmpty ? "Not known".localized : tag

		var title = data.name.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines)
		title = title.isEmpty ? "Not known".localized : title

		return AllStations.Model.Station(
			tag: tag,
			title: title,
			votes: data.votes,
			isPlayingNow: data.stationUUID == audioPlayer.currentUUID,
			isFavorite: station != nil ? true : false
		)
	}
}
