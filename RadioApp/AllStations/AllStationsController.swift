//
//  AllStationsController.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 05.08.2024.
//

import UIKit

final class AllStationsController: ViewController {

	// MARK: - Dependencies

	var presenter: AllStationsPresenterProtocol!
	var searchPresenter: SearchPresenter!

	// MARK: - Private properties

	private lazy var mainStack = makeStackView()
	private lazy var titleLabel = makeLabel()
	private lazy var searchTextField = makeTextField()
	private lazy var searchImageView = makeImageView()
	private lazy var activateSearchButton = makeButton()

	private lazy var collectionView = makeCollectionView()

	private var model = AllStations.Model(stations: [], indexPlayingNow: IndexPath(row: 0, section: 0))
	private var isActiveSearch: Bool = false {
		didSet {
			let image = isActiveSearch ? UIImage.closeSearch : .goSearch
			activateSearchButton.setImage(image, for: .normal)
			titleLabel.isHidden = isActiveSearch
		}
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		showLoading()
		if isActiveSearch {
			searchPresenter.activate()
		} else {
			presenter.activate()
		}
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: - UITextFieldDelegate

extension AllStationsController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let text = textField.text, !text.isEmpty {
			showLoading()
			searchPresenter.searchStations(with: text)
			textField.resignFirstResponder()
			collectionView.setContentOffset(CGPoint(x:0 ,y:0), animated: true)
		}
		return true
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		isActiveSearch = true
		searchPresenter.activate()
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		isActiveSearch = true
	}
}

// MARK: - AllStationsControllerProtocol

extension AllStationsController: AllStationsControllerProtocol {

	func update(with model: AllStations.Model) {
		self.model = model
		collectionView.reloadData()
		hideLoading()
		collectionView.scrollToItem(at: model.indexPlayingNow, at: .centeredVertically, animated: true)
	}
}

// MARK: - StationViewDelegate

extension AllStationsController: StationViewDelegate {

	func vote(at indexPath: IndexPath) {
		if isActiveSearch {
			searchPresenter.didStationVoted(at: indexPath)
		} else {
			presenter.didStationVoted(at: indexPath)
		}
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
		cell.configure(by: indexPath, with: station, and: self)
		
		return cell
	}
}

// MARK: - Collection View Delegate

extension AllStationsController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if isActiveSearch {
			searchPresenter.didStationSelected(at: indexPath)
		} else {
			presenter.didStationSelected(at: indexPath)
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		willDisplay cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		guard model.stations.count - indexPath.row == 4 else { return }
		if isActiveSearch {
			searchPresenter.fetchStations()
		} else {
			presenter.fetchStations()
		}
	}
}

// MARK: - Actions

private extension AllStationsController {

	var activateSearchHandler: UIActionHandler {
		{ [weak self] _ in
			guard let self else { return }
			if isActiveSearch {
				searchTextField.text = ""
				searchTextField.resignFirstResponder()
				presenter.activate()
			} else {
				searchPresenter.activate()
				searchTextField.becomeFirstResponder()
			}
			isActiveSearch.toggle()
		}
	}

	@objc
	func handleIndexChange(_ notification: Notification) {
		/*if isActiveSearch {
			searchPresenter.activate()
		} else {
			presenter.activate()
		}*/
	}
}

// MARK: - Setup UI

private extension AllStationsController {
	
	func setupUI() {
		view.backgroundColor = .darkBlueApp

		addSubviews()
		addActions()

		setupNotification()
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

	func makeStackView() -> UIStackView {
		let element = UIStackView()

		element.axis = .vertical
		element.alignment = .center
		element.spacing = 15
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeLabel() -> UILabel {
		let element = UILabel()

		element.text = "All Stations".localized
		element.font = .systemFont(ofSize: 30, weight: .light)
		element.textColor = .white
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeTextField() -> UITextField {
		let element = UITextField()

		element.backgroundColor = .searchApp
		element.layer.cornerRadius = 15
		element.textColor = .white
		element.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: element.frame.height))
		element.leftViewMode = .always
		element.rightView = activateSearchButton
		element.rightViewMode = .always
		element.attributedPlaceholder = NSAttributedString(
			string: "Search radio station",
			attributes: [.foregroundColor: UIColor.white]
		)
		element.returnKeyType = .search
		element.delegate = self
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeImageView() -> UIImageView {
		let element = UIImageView()

		element.image = .searchApp
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}

	func makeButton() -> UIButton {
		let element = UIButton()

		element.setImage(.goSearch, for: .normal)
		element.translatesAutoresizingMaskIntoConstraints = false

		return element
	}
}

// MARK: - Setting UI

private extension AllStationsController {
	
	func addSubviews() {
		view.addSubview(mainStack)

		mainStack.addArrangedSubview(titleLabel)
		mainStack.addArrangedSubview(searchTextField)
		mainStack.addArrangedSubview(collectionView)

		searchTextField.addSubview(searchImageView)
	}

	func addActions() {
		activateSearchButton.addAction(UIAction(handler: activateSearchHandler), for: .touchUpInside)
	}

	private func setupNotification() {
		NotificationCenter.default.addObserver(
			self, selector: #selector(handleIndexChange),
			name: .playerCurrentIndexDidChange,
			object: nil
		)
	}
}

// MARK: - Layout UI

private extension AllStationsController {

	func layout() {
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
			mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),

			titleLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 44.18),

			searchTextField.heightAnchor.constraint(equalToConstant: 56),
			searchTextField.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
			
			searchImageView.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
			searchImageView.leadingAnchor.constraint(equalTo: searchTextField.layoutMarginsGuide.leadingAnchor),
			
			activateSearchButton.heightAnchor.constraint(equalToConstant: 32),
			activateSearchButton.widthAnchor.constraint(equalToConstant: 50),

			collectionView.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
			collectionView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor)
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
