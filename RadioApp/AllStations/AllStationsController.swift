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

	var presenter: AllStationsPresenterProtocol!

	// MARK: - Dependencies
	
	// MARK: - Private properties

	private lazy var collectionView = makeCollectionView()

	private var model = AllStations.Model(stations: [])

	// MARK: - Initialization
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		presenter.activate()
	}
	
	// MARK: - Public methods

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	// MARK: - Private methods
}

// MARK: - AllStationsControllerProtocol

extension AllStationsController: AllStationsControllerProtocol {

	func update(with model: AllStations.Model) {
		self.model = model
		collectionView.reloadData()
	}
}

// MARK: - Collection View Data Source

extension AllStationsController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		model.stations.count
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: AllStationsCell.reusableIdentifier,
			for: indexPath
		)
		guard let cell = cell as? AllStationsCell else { return UICollectionViewCell() }
		
		let station = model.stations[indexPath.row]
		cell.configure(by: indexPath, with: station)
		
		return cell
	}
}

// MARK: - Collection View Delegate

extension AllStationsController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// TODO: - реализовать событие перехода на другой экран
	}

	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		if model.stations.count - indexPath.row == 4 {
			presenter.activate()
		}
	}
}

// MARK: - Actions

private extension AllStationsController {
	
}

// MARK: - Setup UI

private extension AllStationsController {
	
	func setupUI() {
		view.backgroundColor = .darkBlueApp

		addSubviews()
	}

	func makeFlowLayout() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()

		layout.itemSize = CGSize(width: 291, height: 123)
		layout.minimumLineSpacing = 20

		return layout
	}

	func makeCollectionView() -> UICollectionView {
		let element = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())

		element.backgroundColor = .clear
		element.register(AllStationsCell.self, forCellWithReuseIdentifier: AllStationsCell.reusableIdentifier)
		element.dataSource = self
		element.delegate = self
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension AllStationsController {
	
	func addSubviews() {
		view.addSubview(collectionView)
	}
}

// MARK: - Layout UI

private extension AllStationsController {
	
	func layout() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
		])
	}
}

@available(iOS 17.0, *)
#Preview {
	let navigation = UINavigationController()
	let builder = AllStationsAssembly()
	let router = AllStationsRouter(builder: builder, navigation: navigation)
	router.showAllStations()
	return navigation
}
