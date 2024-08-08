//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

final class PopularViewController: ViewController {
    // MARK: - Private Properties
    private let presenter: PopularPresenterProtocol
    private var popularView: PopularView!
    
    // MARK: - Init
    init(presenter: PopularPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        popularView = PopularView()
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setNotification()
        loadStations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if presenter.isStationsLoaded {
            presenter.setStations()
        }
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        popularView.radioCollection.dataSource = self
        popularView.radioCollection.delegate = self
    }
    
    // MARK: - Set Notification
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleIndexChange),
            name: .playerCurrentIndexDidChange,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleFavoritesChanged),
            name: .favoriteRemoved,
            object: nil
        )
    }
    
    // MARK: - Load Stations
    private func loadStations() {
        Task {
            await presenter.loadStations()
        }
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Notification handle
private extension PopularViewController {
    @objc func handleIndexChange(_ notification: Notification) {
        guard let stationId = notification.userInfo?[K.UserInfoKey.stationIndex] as? Int else {
            return
        }
        
        let indexPath = IndexPath(item: stationId, section: 0)
        popularView.radioCollection.selectItem(
            at: indexPath,
            animated: true,
            scrollPosition: .centeredVertically
        )
    }
    
    @objc func handleFavoritesChanged(_ notification: Notification) {
        guard let stationUniqueId = notification.userInfo?[K.UserInfoKey.removedStationIndex] as? UUID,
              let stationId = presenter.getStations.firstIndex(where: { $0.id == stationUniqueId }) else {
            return
        }
        
        let indexPath = IndexPath(item: stationId, section: 0)
        guard let cell = popularView.radioCollection.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return
        }
        
        cell.clearVoteImage()
    }
}

// MARK: - PopularView Delegate methods
extension PopularViewController: PopularViewProtocol {
    func didUpdateStations() {
        DispatchQueue.main.async {
            self.popularView.radioCollection.reloadData()
        }
    }
    
    func voteForStation(at indexPath: IndexPath?) {
        guard let indexPath else { return }
        
        let stationId = indexPath.row
        presenter.toggleVoteState(for: stationId)
        
        let isStationVoted = presenter.isStationVoted(stationId)
        updateStationVotes(at: indexPath, isStationVoted)
    }
    
    private func updateStationVotes(at indexPath: IndexPath, _ isStationVoted: Bool) {
        guard let cell = popularView.radioCollection.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return
        }
        cell.updateStationVotes(isStationVoted)
    }
}

// MARK: - RadioCollectionView DataSource methods
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let stationsCount = presenter.getStations.count
        return stationsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: K.popularRadioCell,
            for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let stationData = presenter.getStations[indexPath.row]
        let isStationVoted = presenter.isStationVoted(indexPath.row)
        
        cell.delegate = self
        cell.configure(with: stationData, isStationVoted, and: indexPath)
        return cell
    }
}

// MARK: - RadioCollectionView Delegate methods
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stationId = indexPath.row
        presenter.changeStation(stationId)
    }
}

// MARK: - RadioCollectionView FlowLayout Delegate methods
extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
        let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemSize, height: itemSize)
    }
}
