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
	func update()
    
    /// Обновляем информацию на экране после подгрузки новых данных
    /// - Parameter indexPath: массив индексов станции для обновления коллекции.
    func insert(at indexPaths: [IndexPath])
}

/// Протокол презентера для отображения всех радиостанций.
protocol AllStationsPresenterProtocol: AnyObject {
    
    /// Получаем список загруженных станций
    var getStations: [AllStationViewModel] { get }
    
    /// Получаем последнюю выбранную станцию
    var lastStationId: Int { get }
    
    /// Уникальный идентификатор станции играющей в данный момент
    var playingStationId: UUID? { get }

	/// Активация презентера для обновления информации на экране.
	func activate()
	
	/// Загрузка радиостанций.
	func fetchStations()
    
    /// Обновляем последнюю выбранную станцию
    func updateLastStationId(_ stationId: Int)
    
    /// Сбрасываем последнюю выбранную станцию
    func resetLastStationId()
    
    /// Обновляем плейлист
    func setPlayerStations()

	/// Выбрана радиостанция.
	/// - Parameter indexPath: индекс радиостанции.
	func didStationSelected(at indexPath: IndexPath)
    
    /// Переход на детальный экран
    func showDetail(at indexPath: IndexPath)
	
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
	func showStationDetails(with station: RadioStation)
}
