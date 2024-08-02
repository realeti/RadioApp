//
//  AllStationsPresenter.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 02.08.2024.
//

import Foundation

/// Презентер для экрана с полным списком радиостанций.
final class AllStationsPresenter {

	// TODO: - данные, полученные из сети
	// private let stations: StationData
	private let stationsStub = [
		AllStations.Model.Station(tag: "POP", title: "Radio Record", votes: 315, isPlayingNow: true),
		AllStations.Model.Station(tag: "16bit", title: "Radio Gameplay", votes: 240, isPlayingNow: false),
		AllStations.Model.Station(tag: "Punk", title: "Russian Punk rock", votes: 200, isPlayingNow: false)
	]
	
	// MARK: - Dependencies

	private let router: AllStationsRouterProtocol
	private weak var view: AllStationsControllerProtocol!
	
	// MARK: - Initialization
	
	/// Инициализатор презентера.
	/// - Parameters:
	///   - router: роутер, для осуществления перехода на другие экраны.
	///   - view: view, на которой будет отображаться информация.
	init(router: AllStationsRouterProtocol, view: AllStationsControllerProtocol) {
		self.router = router
		self.view = view
	}
}

// MARK: - AllStationsPresenterProtocol

extension AllStationsPresenter: AllStationsPresenterProtocol {

	/// Активация презентера для обновления информации на экране.
	///
	/// Получает все возможные радиостанции из api и обновляет экран AllStations.
	func activate() {
		// TODO: - получить данные по радиостанциям
		view.update(with: AllStations.Model(stations: mapStationsData()))
	}

	/// Выбрана радиостанция.
	/// - Parameter indexPath: индекс радиостанции.
	///
	/// Переход на экран с детальной информацией станции, которую выбрал пользователь.
	func didStationSelected(at indexPath: IndexPath) {
		router.showStationDetails(with: stationsStub[indexPath.row])
	}
}

// MARK: - Private methods

private extension AllStationsPresenter {

	func mapStationsData() -> [AllStations.Model.Station] {
		// TODO: - мапинг полученных данных радиостанций
		// stations.map { AllStations.Model.Station(...) }
		stationsStub
	}
}
