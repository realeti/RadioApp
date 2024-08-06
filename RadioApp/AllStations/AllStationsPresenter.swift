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

	// MARK: - Private properties

	private var stations: [Station] = []

	// MARK: - Initialization
	
	/// Инициализатор презентера.
	/// - Parameters:
	///   - router: роутер, для осуществления перехода на другие экраны.
	///   - view: view, на которой будет отображаться информация.
	///   - radioBrowser: сервис для работы с `API all.api.radio-browser`.
	init(router: AllStationsRouterProtocol, view: AllStationsControllerProtocol, radioBrowser: RadioBrowser) {
		self.router = router
		self.view = view
		self.radioBrowser = radioBrowser
	}
}

// MARK: - AllStationsPresenterProtocol

extension AllStationsPresenter: AllStationsPresenterProtocol {

	/// Активация презентера для обновления информации на экране.
	///
	/// Получает все возможные радиостанции из api и обновляет экран AllStations.
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
		AllStations.Model.Station(
			tag: data.tags.first ?? "nil",
			title: data.name.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .newlines),
			votes: data.votes,
			isPlayingNow: false,
			isFavorite: false
		)
	}
}
