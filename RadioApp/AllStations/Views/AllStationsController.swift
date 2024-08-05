//
//  AllStationsController.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 05.08.2024.
//

import UIKit

final class AllStationsController: ViewController {
	
	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies
	
	// MARK: - Private properties
	
	// MARK: - Initialization
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	// MARK: - Public methods
	
	// MARK: - Private methods
}

// MARK: - Actions

private extension AllStationsController {
	
}

// MARK: - Setup UI

private extension AllStationsController {
	
	func setupUI() {
		view.backgroundColor = .systemCyan

		let stationsStub = [
			AllStations.Model.Station(
				tag: "POP",
				title: "Radio Record",
				votes: 315,
				isPlayingNow: true,
				isFavorite: true
			),
			AllStations.Model.Station(
				tag: "16bit",
				title: "Radio Gameplay",
				votes: 240,
				isPlayingNow: false,
				isFavorite: false
			),
			AllStations.Model.Station(
				tag: "Punk",
				title: "Russian Punk rock",
				votes: 200,
				isPlayingNow: false,
				isFavorite: false
			)
		]

		let index = 2
		let station = stationsStub[index]
		let stationView = StationView()

		stationView.title = station.tag
		stationView.subtitle = station.title
		stationView.numberOfVotes = station.votes
		stationView.status = station.isPlayingNow ? "Playing now" : nil
		stationView.isFavorite = station.isFavorite
		stationView.waveCirclesColor = StationView
			.ColorCircle(rawValue: (index % StationView.ColorCircle.allCases.count))
		stationView.layer.cornerRadius = 15
		stationView.translatesAutoresizingMaskIntoConstraints = false

		let theme = station.isPlayingNow ? StationView.Theme.pink : .base
		stationView.setTheme(theme)

		let stationCell = AllStationsCell()
		stationCell.translatesAutoresizingMaskIntoConstraints = false
		stationCell.configure(by: IndexPath(row: index, section: 0), with: station)

		view.addSubview(stationView)
		view.addSubview(stationCell)

		NSLayoutConstraint.activate([
			stationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stationView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			stationView.widthAnchor.constraint(equalToConstant: 293),
			stationView.heightAnchor.constraint(equalToConstant: 123),
			
			stationCell.topAnchor.constraint(equalTo: stationView.bottomAnchor, constant: 20),
			stationCell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			stationCell.widthAnchor.constraint(equalToConstant: 293),
			stationCell.heightAnchor.constraint(equalToConstant: 123)
		])

		addSubviews()
	}
}

// MARK: - Setting UI

private extension AllStationsController {
	
	func addSubviews() {
		
	}
}

// MARK: - Layout UI

private extension AllStationsController {
	
	func layout() {
		NSLayoutConstraint.activate([
			
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	NavigationController(rootViewController: AllStationsController())
}
