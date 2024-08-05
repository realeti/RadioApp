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

		let station = stationsStub[1]
		let cell = StationView()

		cell.title = station.tag
		cell.subtitle = station.title
		cell.numberOfVotes = station.votes
		cell.status = station.isPlayingNow ? "Playing now" : nil
		cell.isFavorite = station.isFavorite
		cell.waveCirclesColor = StationView.ColorCircle(rawValue: (0 % StationView.ColorCircle.allCases.count))
		cell.layer.cornerRadius = 15
		cell.translatesAutoresizingMaskIntoConstraints = false

		let theme = station.isPlayingNow ? StationView.Theme.pink : .base
		cell.setTheme(theme)

		view.addSubview(cell)

		NSLayoutConstraint.activate([
			cell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			cell.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			cell.widthAnchor.constraint(equalToConstant: 293),
			cell.heightAnchor.constraint(equalToConstant: 123)
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
