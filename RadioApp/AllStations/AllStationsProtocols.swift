//
//  AllStationsProtocols.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 31.07.2024.
//

import Foundation
import RadioBrowser

/// Протокол экрана для отображения всех радиостанций.
protocol AllStationsControllerProtocol: AnyObject {

	/// Обновление информации на экране.
	/// - Parameter model: модель с информацией для обновления на экране.
	func update(with model: AllStations.Model)
}

/// Протокол презентера для отображения всех радиостанций.
protocol AllStationsPresenterProtocol: AnyObject {

	/// Активация презентера для обновления информации на экране.
	func activate()
	
	/// Загрузка радиостанций.
	func fetchStations()

	/// Выбрана радиостанция.
	/// - Parameter indexPath: индекс радиостанции.
	func didStationSelected(at indexPath: IndexPath)
	
	/// Проголосовали за радиостанцию.
	/// - Parameter indexPath: индекс радиостанции.
	func didStationVoted(at indexPath: IndexPath)
}

protocol SearchPresenterProtocol: AllStationsPresenterProtocol {

	/// Поиск радиостанций по названию.
	func searchStations(with name: String)
}

/// Протокол роутера для перехода с экрана, отображающего все радиостанции, на другие экраны.
protocol AllStationsRouterProtocol {
	
	/// Показывает экран со всеми радиостанциями.
	func showAllStations()

	/// Переход на экран с детальной информацией о радиостанции.
	/// - Parameter data: данные о радиостанции.
	func showStationDetails(with stationData: Station)
}
