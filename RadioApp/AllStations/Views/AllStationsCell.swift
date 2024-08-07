//
//  AllStationsCell.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 05.08.2024.
//

import UIKit

final class AllStationsCell: UICollectionViewCell {

	static let reusableIdentifier = String(describing: type(of: AllStationsCell.self))

	// MARK: - Outlets
	
	// MARK: - Public properties
	
	// MARK: - Dependencies
	
	// MARK: - Private properties

	private var stationView = StationView()

	// MARK: - Initialization

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func prepareForReuse() {
		super.prepareForReuse()
		stationView.delegate = nil
		stationView.indexPath = nil
		stationView.title = nil
		stationView.subtitle = nil
		stationView.status = nil
		stationView.numberOfVotes = nil
		stationView.isFavorite = nil
		stationView.waveCirclesColor = nil
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	// MARK: - Public methods

	func configure(by indexPath: IndexPath, with model: AllStations.Model.Station, and delegate: StationViewDelegate) {
		stationView.delegate = delegate
		stationView.indexPath = indexPath

		stationView.title = model.tag
		stationView.subtitle = model.title
		stationView.status = model.isPlayingNow ? "Playing now" : nil

		stationView.numberOfVotes = model.votes
		stationView.isFavorite = model.isFavorite

		let index = indexPath.row % StationView.ColorCircle.allCases.count
		stationView.waveCirclesColor = StationView.ColorCircle(rawValue: index)

		let theme = model.isPlayingNow ? StationView.Theme.pink : .base
		stationView.setTheme(theme)
	}

	// MARK: - Private methods
}

// MARK: - Actions

private extension AllStationsCell {
	
}

// MARK: - Setup UI

private extension AllStationsCell {
	
	func setupUI() {
		stationView.layer.cornerRadius = 15
		stationView.translatesAutoresizingMaskIntoConstraints = false
		addSubviews()
	}
}

// MARK: - Setting UI

private extension AllStationsCell {
	
	func addSubviews() {
		contentView.addSubview(stationView)
	}
}

// MARK: - Layout UI

private extension AllStationsCell {
	
	func layout() {
		NSLayoutConstraint.activate([
			stationView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			stationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
