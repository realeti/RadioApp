//
//  AllStationsPresenter.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 02.08.2024.
//

import Foundation
import RadioBrowser

/// Презентер для экрана с полным списком радиостанций.
final class AllStationsPresenter {

	// MARK: - Dependencies

	private let router: AllStationsRouterProtocol
	private weak var view: AllStationsControllerProtocol!

	private let radioBrowser: RadioBrowser
	private let storageManager: StorageManager

	// MARK: - Private properties

	private var stations: [Station] = []

	// MARK: - Initialization
	
	/// Инициализатор презентера.
	/// - Parameters:
	///   - router: роутер, для осуществления перехода на другие экраны.
	///   - view: view, на которой будет отображаться информация.
	///   - radioBrowser: сервис для работы с `API all.api.radio-browser`.
	///   - storageManager: менеджер, управляющий хранилищем радиостанций.
	init(
		router: AllStationsRouterProtocol,
		view: AllStationsControllerProtocol,
		radioBrowser: RadioBrowser,
		storageManager: StorageManager
	) {
		self.router = router
		self.view = view
		self.radioBrowser = radioBrowser
		self.storageManager = storageManager
	}
}

// MARK: - AllStationsPresenterProtocol

extension AllStationsPresenter: AllStationsPresenterProtocol {

	/// Активация презентера для обновления информации на экране.
	///
	/// Получает первые 20 радиостанций из api и обновляет экран AllStations. При повторном вызове подгружает еще 20 радиостанций и т.д.
	func activate() {
		Task {
			let result = await radioBrowser.getAllStations(offset: stations.count)

			switch result {
			case .success(let data):
				stations += data
				await render()
			case .failure(let error):
				print(error)
			}
		}
	}

	/// Выбрана радиостанция.
	/// - Parameter indexPath: индекс радиостанции.
	///
	/// Переход на экран с детальной информацией станции, которую выбрал пользователь.
	func didStationSelected(at indexPath: IndexPath) {
		router.showStationDetails(with: stations[indexPath.row])
	}
	
	/// Проголосовали за радиостанцию.
	/// - Parameter indexPath: индекс радиостанции.
	///
	/// Метод добавляет радиостанцию в избранное или удаляет от туда. Также голосует за выбранную радиостанцию, но только один раз.
	@MainActor
	func didStationVoted(at indexPath: IndexPath) {
		let station = stations[indexPath.row]
		storageManager.toggleFavorite(
			id: station.stationUUID,
			title: station.name.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines),
			genre: station.tags.first ?? ""
		)
		render()
	}
}

// MARK: - Private methods

private extension AllStationsPresenter {

	@MainActor
	func render() {
		view.update(with: mapStationsData())
	}

	func mapStationsData() -> AllStations.Model {
		let radioStations = stations.map { makeStationModel(from: $0) }
		return AllStations.Model(stations: radioStations)
	}
	
	func makeStationModel(from data: Station) -> AllStations.Model.Station {
		let station = storageManager.fetchStation(with: data.stationUUID)

		return AllStations.Model.Station(
			tag: data.tags.first ?? "nil",
			title: data.name.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines),
			votes: data.votes,
			isPlayingNow: false,
			isFavorite: station != nil ? true : false
		)
	}
}
